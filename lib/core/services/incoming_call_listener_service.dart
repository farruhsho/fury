import 'dart:async';
import 'dart:io' show Platform;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Conditional import for just_audio - not supported on Windows desktop
import 'package:just_audio/just_audio.dart' if (dart.library.io) 'package:just_audio/just_audio.dart';

/// Service for listening to incoming calls in real-time without Cloud Functions
class IncomingCallListenerService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final FlutterLocalNotificationsPlugin _notifications;
  
  // Audio player only works on mobile platforms, not on Windows desktop
  AudioPlayer? _ringtonePlayer;
  bool _isAudioSupported = false;
  
  StreamSubscription? _callSubscription;
  bool _isInitialized = false;
  
  // Track call IDs that we answered locally (to ignore removed events)
  final Set<String> _answeredCallIds = {};
  
  // Callback when incoming call is detected
  Function(IncomingCall call)? onIncomingCall;
  Function(String callId)? onCallEnded;
  Function(String callId)? onCallAnswered;

  IncomingCallListenerService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
    FlutterLocalNotificationsPlugin? notifications,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance,
        _notifications = notifications ?? FlutterLocalNotificationsPlugin() {
    // Initialize audio player only on supported platforms (not Windows desktop)
    _initializeAudioPlayer();
  }
  
  void _initializeAudioPlayer() {
    try {
      // just_audio supports Android, iOS, macOS, and web
      // It does NOT support Windows desktop
      if (kIsWeb || !_isWindowsDesktop) {
        _ringtonePlayer = AudioPlayer();
        _isAudioSupported = true;
        debugPrint('🔊 [CALL LISTENER] Audio player initialized');
      } else {
        debugPrint('⚠️ [CALL LISTENER] Audio not supported on this platform');
      }
    } catch (e) {
      debugPrint('⚠️ [CALL LISTENER] Failed to initialize audio player: $e');
      _isAudioSupported = false;
    }
  }
  
  bool get _isWindowsDesktop {
    if (kIsWeb) return false;
    try {
      return Platform.isWindows;
    } catch (e) {
      return false;
    }
  }

  /// Initialize and start listening for incoming calls
  Future<void> initialize({
    Function(IncomingCall call)? onIncomingCall,
    Function(String callId)? onCallEnded,
    Function(String callId)? onCallAnswered,
  }) async {
    if (_isInitialized) return;
    
    this.onIncomingCall = onIncomingCall;
    this.onCallEnded = onCallEnded;
    this.onCallAnswered = onCallAnswered;

    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      debugPrint('⚠️ [CALL LISTENER] No user logged in');
      return;
    }

    _isInitialized = true;
    
    // Clean up any stale call notifications from previous sessions
    await cleanupStaleNotifications();
    
    // Listen for calls where current user is a participant and status is 'ringing'
    _callSubscription = _firestore
        .collection('calls')
        .where('participantIds', arrayContains: userId)
        .where('status', isEqualTo: 'ringing')
        .snapshots()
        .listen(_handleCallsSnapshot);

    debugPrint('✅ [CALL LISTENER] Started listening for incoming calls');
  }
  
  /// Clean up any stale call notifications from previous app sessions
  /// This ensures old notifications don't linger after app restart
  Future<void> cleanupStaleNotifications() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    
    try {
      // Find and clean up any stale ringing calls
      final staleCalls = await _firestore
          .collection('calls')
          .where('participantIds', arrayContains: userId)
          .where('status', isEqualTo: 'ringing')
          .get();
      
      for (final doc in staleCalls.docs) {
        final data = doc.data();
        final createdAt = (data['createdAt'] as Timestamp?)?.toDate();
        if (createdAt != null) {
          final age = DateTime.now().difference(createdAt);
          if (age.inSeconds > 30) {
            // Cancel any lingering notification
            await _cancelCallNotification(doc.id);
            
            // Mark as missed in Firestore
            await doc.reference.update({
              'status': 'missed',
              'endedAt': FieldValue.serverTimestamp(),
            });
            
            debugPrint('🧹 [CALL LISTENER] Cleaned up stale call: ${doc.id}');
          }
        }
      }
      
      // Also cancel all call channel notifications to be safe
      // This handles cases where the notification ID doesn't match
      debugPrint('🧹 [CALL LISTENER] Stale notification cleanup complete');
    } catch (e) {
      debugPrint('⚠️ [CALL LISTENER] Error cleaning up stale notifications: $e');
    }
  }

  void _handleCallsSnapshot(QuerySnapshot snapshot) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    for (final change in snapshot.docChanges) {
      final data = change.doc.data() as Map<String, dynamic>?;
      if (data == null) continue;

      final callId = change.doc.id;
      final callerId = data['callerId'] as String?;
      
      // Skip if I'm the caller
      if (callerId == userId) continue;

      switch (change.type) {
        case DocumentChangeType.added:
          // New incoming call
          final call = IncomingCall.fromFirestore(callId, data);
          
          // Ignore old calls (older than 30 seconds) - they are stale
          final age = DateTime.now().difference(call.createdAt);
          if (age.inSeconds > 30) {
            debugPrint('📞 [CALL LISTENER] Ignoring stale call from ${call.callerName} (${age.inSeconds}s old)');
            // Auto-expire the stale call
            await _firestore.collection('calls').doc(callId).update({
              'status': 'missed',
              'endedAt': FieldValue.serverTimestamp(),
            });
            continue;
          }
          
          debugPrint('📞 [CALL LISTENER] Incoming call from ${call.callerName}');
          
          // Play ringtone - use system sound via notification
          // Disabled custom ringtone - using notification sound instead
          
          // Show notification
          await _showCallNotification(call);
          
          // Trigger callback
          onIncomingCall?.call(call);
          break;
          
        case DocumentChangeType.modified:
          final status = data['status'] as String?;
          if (status == 'ended' || status == 'declined' || status == 'missed') {
            await _stopRingtone();
            await _cancelCallNotification(callId);
            onCallEnded?.call(callId);
          } else if (status == 'active') {
            await _stopRingtone();
            onCallAnswered?.call(callId);
          }
          break;
          
        case DocumentChangeType.removed:
          // Only trigger onCallEnded if we didn't answer this call ourselves
          if (!_answeredCallIds.contains(callId)) {
            await _stopRingtone();
            await _cancelCallNotification(callId);
            onCallEnded?.call(callId);
          } else {
            // We answered this call - document was removed from query
            // because status changed to 'active', not because call ended
            debugPrint('📞 [CALL LISTENER] Ignoring removed event for answered call: $callId');
          }
          break;
      }
    }
  }

  Future<void> _stopRingtone() async {
    if (!_isAudioSupported || _ringtonePlayer == null) return;
    try {
      await _ringtonePlayer!.stop();
    } catch (e) {
      debugPrint('⚠️ [CALL LISTENER] Could not stop ringtone: $e');
    }
  }

  Future<void> _showCallNotification(IncomingCall call) async {
    try {
      final androidDetails = AndroidNotificationDetails(
        'calls_channel',
        'Incoming Calls',
        channelDescription: 'Notifications for incoming voice and video calls',
        importance: Importance.max,
        priority: Priority.max,
        fullScreenIntent: true,
        category: AndroidNotificationCategory.call,
        visibility: NotificationVisibility.public,
        ongoing: true,
        autoCancel: false,
        playSound: true,
        // Enable vibration with repeating pattern
        enableVibration: !kIsWeb && !_isWindowsDesktop,
        vibrationPattern: (kIsWeb || _isWindowsDesktop) ? null : Int64List.fromList([0, 1000, 500, 1000, 500, 1000]),
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      final details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.show(
        call.id.hashCode,
        call.isVideo ? '📹 Video Call' : '📞 Voice Call',
        '${call.callerName} is calling...',
        details,
        payload: 'call:${call.id}',
      );
    } catch (e) {
      debugPrint('⚠️ [CALL LISTENER] Could not show notification: $e');
    }
  }

  Future<void> _cancelCallNotification(String callId) async {
    try {
      await _notifications.cancel(callId.hashCode);
    } catch (e) {
      debugPrint('⚠️ [CALL LISTENER] Could not cancel notification: $e');
    }
  }

  /// Mark a call as answered locally (to ignore removed events)
  void markCallAsAnswered(String callId) {
    _answeredCallIds.add(callId);
  }
  
  /// Cancel notification and stop ringtone without updating Firestore
  Future<void> cancelNotificationAndRingtone(String callId) async {
    await _stopRingtone();
    await _cancelCallNotification(callId);
  }

  /// Answer an incoming call (legacy - kept for backward compatibility)
  /// Note: Prefer using markCallAsAnswered + cancelNotificationAndRingtone
  /// and letting CallBloc handle Firestore updates via signaling
  Future<void> answerCall(String callId) async {
    // Track that we're answering this call
    _answeredCallIds.add(callId);
    
    await _stopRingtone();
    await _cancelCallNotification(callId);
    
    // Note: CallBloc.answerCall handles setting status to 'connecting' 
    // and sending the answer SDP through signalingDatasource
  }

  /// Decline an incoming call
  Future<void> declineCall(String callId) async {
    _answeredCallIds.remove(callId);
    await _stopRingtone();
    await _cancelCallNotification(callId);
    
    await _firestore.collection('calls').doc(callId).update({
      'status': 'declined',
      'endedAt': FieldValue.serverTimestamp(),
    });
  }

  /// End an active call
  Future<void> endCall(String callId) async {
    _answeredCallIds.remove(callId);
    
    await _firestore.collection('calls').doc(callId).update({
      'status': 'ended',
      'endedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Dispose and clean up
  Future<void> dispose() async {
    await _callSubscription?.cancel();
    await _stopRingtone();
    if (_isAudioSupported && _ringtonePlayer != null) {
      try {
        await _ringtonePlayer!.dispose();
      } catch (e) {
        debugPrint('⚠️ [CALL LISTENER] Error disposing audio player: $e');
      }
    }
    _answeredCallIds.clear();
    _isInitialized = false;
  }
}

class IncomingCall {
  final String id;
  final String callerId;
  final String callerName;
  final String? callerAvatar;
  final bool isVideo;
  final DateTime createdAt;
  final List<String> participantIds;

  IncomingCall({
    required this.id,
    required this.callerId,
    required this.callerName,
    this.callerAvatar,
    this.isVideo = false,
    required this.createdAt,
    required this.participantIds,
  });

  factory IncomingCall.fromFirestore(String id, Map<String, dynamic> data) {
    final type = data['type'] as String? ?? 'voice';
    return IncomingCall(
      id: id,
      callerId: data['callerId'] as String,
      callerName: data['callerName'] as String? ?? 'Unknown',
      callerAvatar: data['callerAvatarUrl'] as String?,
      isVideo: type == 'video' || type == 'groupVideo',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      participantIds: List<String>.from(data['participantIds'] ?? []),
    );
  }
}
