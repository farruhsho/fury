import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Service for handling missed call notifications
/// 
/// This service monitors incoming calls and sends local notifications
/// when a call is missed (unanswered, declined, or timed out).
class MissedCallNotificationService {
  static final MissedCallNotificationService _instance = 
      MissedCallNotificationService._internal();
  
  factory MissedCallNotificationService() => _instance;
  
  MissedCallNotificationService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterLocalNotificationsPlugin _notifications = 
      FlutterLocalNotificationsPlugin();
  
  StreamSubscription? _callSubscription;
  bool _isInitialized = false;
  
  /// Initialize the missed call notification service
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      // Initialize local notifications
      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );
      
      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );
      
      await _notifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );
      
      _isInitialized = true;
      debugPrint('📞 [MISSED_CALL] Notification service initialized');
    } catch (e) {
      debugPrint('❌ [MISSED_CALL] Failed to initialize: $e');
    }
  }
  
  /// Start listening for missed calls
  void startListening() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;
    
    _callSubscription?.cancel();
    
    // Listen for calls where we are the recipient
    _callSubscription = _firestore
        .collection('calls')
        .where('recipientId', isEqualTo: currentUser.uid)
        .where('status', whereIn: ['missed', 'declined', 'timeout'])
        .where('notificationSent', isEqualTo: false)
        .snapshots()
        .listen(_onMissedCallsUpdate);
    
    debugPrint('📞 [MISSED_CALL] Started listening for missed calls');
  }
  
  /// Stop listening for missed calls
  void stopListening() {
    _callSubscription?.cancel();
    _callSubscription = null;
    debugPrint('📞 [MISSED_CALL] Stopped listening');
  }
  
  /// Handle missed calls update
  Future<void> _onMissedCallsUpdate(QuerySnapshot snapshot) async {
    for (final doc in snapshot.docChanges) {
      if (doc.type == DocumentChangeType.added) {
        final data = doc.doc.data() as Map<String, dynamic>?;
        if (data == null) continue;
        
        final callerId = data['callerId'] as String?;
        final callerName = data['callerName'] as String? ?? 'Unknown';
        final callType = data['type'] as String? ?? 'voice';
        final timestamp = (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now();
        
        await _showMissedCallNotification(
          callId: doc.doc.id,
          callerName: callerName,
          callType: callType,
          timestamp: timestamp,
        );
        
        // Mark notification as sent
        await doc.doc.reference.update({'notificationSent': true});
      }
    }
  }
  
  /// Show a missed call notification
  Future<void> _showMissedCallNotification({
    required String callId,
    required String callerName,
    required String callType,
    required DateTime timestamp,
  }) async {
    final isVideo = callType.contains('video');
    final title = 'Missed ${isVideo ? 'Video' : 'Voice'} Call';
    final body = 'You missed a call from $callerName';
    
    const androidDetails = AndroidNotificationDetails(
      'missed_calls',
      'Missed Calls',
      channelDescription: 'Notifications for missed calls',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      category: AndroidNotificationCategory.call,
      actions: [
        AndroidNotificationAction(
          'call_back',
          'Call Back',
          showsUserInterface: true,
        ),
        AndroidNotificationAction(
          'message',
          'Message',
          showsUserInterface: true,
        ),
      ],
    );
    
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    
    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _notifications.show(
      callId.hashCode,
      title,
      body,
      notificationDetails,
      payload: callId,
    );
    
    debugPrint('📞 [MISSED_CALL] Notification shown for: $callerName');
  }
  
  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    final callId = response.payload;
    final actionId = response.actionId;
    
    debugPrint('📞 [MISSED_CALL] Notification tapped: $callId, action: $actionId');
    
    // TODO: Implement navigation to call back or message screen
    // This would typically use a navigation service or event bus
  }
  
  /// Get recent missed calls
  Future<List<Map<String, dynamic>>> getRecentMissedCalls({
    int limit = 20,
  }) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return [];
    
    try {
      final snapshot = await _firestore
          .collection('calls')
          .where('recipientId', isEqualTo: currentUser.uid)
          .where('status', whereIn: ['missed', 'declined', 'timeout'])
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();
      
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          ...data,
        };
      }).toList();
    } catch (e) {
      debugPrint('❌ [MISSED_CALL] Failed to get missed calls: $e');
      return [];
    }
  }
  
  /// Get count of unread missed calls
  Future<int> getUnreadMissedCallCount() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return 0;
    
    try {
      final snapshot = await _firestore
          .collection('calls')
          .where('recipientId', isEqualTo: currentUser.uid)
          .where('status', whereIn: ['missed', 'declined', 'timeout'])
          .where('isRead', isEqualTo: false)
          .count()
          .get();
      
      return snapshot.count ?? 0;
    } catch (e) {
      debugPrint('❌ [MISSED_CALL] Failed to get count: $e');
      return 0;
    }
  }
  
  /// Mark a missed call as read
  Future<void> markAsRead(String callId) async {
    try {
      await _firestore.collection('calls').doc(callId).update({
        'isRead': true,
        'readAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('❌ [MISSED_CALL] Failed to mark as read: $e');
    }
  }
  
  /// Mark all missed calls as read
  Future<void> markAllAsRead() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;
    
    try {
      final batch = _firestore.batch();
      final snapshot = await _firestore
          .collection('calls')
          .where('recipientId', isEqualTo: currentUser.uid)
          .where('status', whereIn: ['missed', 'declined', 'timeout'])
          .where('isRead', isEqualTo: false)
          .get();
      
      for (final doc in snapshot.docs) {
        batch.update(doc.reference, {
          'isRead': true,
          'readAt': FieldValue.serverTimestamp(),
        });
      }
      
      await batch.commit();
      debugPrint('📞 [MISSED_CALL] Marked ${snapshot.docs.length} calls as read');
    } catch (e) {
      debugPrint('❌ [MISSED_CALL] Failed to mark all as read: $e');
    }
  }
  
  /// Dispose the service
  void dispose() {
    stopListening();
    _isInitialized = false;
  }
}
