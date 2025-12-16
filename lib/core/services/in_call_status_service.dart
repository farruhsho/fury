import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

/// Service for managing in-call status
/// Shows "In call..." status to other users when user is in a call
class InCallStatusService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  
  Timer? _heartbeatTimer;
  String? _currentCallId;

  InCallStatusService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Set user as in call
  Future<void> setInCall({
    required String callId,
    required bool isVideo,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    _currentCallId = callId;

    await _firestore.collection('users').doc(userId).update({
      'inCall': true,
      'currentCallId': callId,
      'callType': isVideo ? 'video' : 'voice',
      'callStartedAt': FieldValue.serverTimestamp(),
    });

    // Start heartbeat to keep status alive
    _startHeartbeat();
    
    print('📞 [IN_CALL_STATUS] User set as in call: $callId');
  }

  /// Set user as not in call
  Future<void> setNotInCall() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    _stopHeartbeat();
    _currentCallId = null;

    await _firestore.collection('users').doc(userId).update({
      'inCall': false,
      'currentCallId': FieldValue.delete(),
      'callType': FieldValue.delete(),
      'callStartedAt': FieldValue.delete(),
    });

    print('📞 [IN_CALL_STATUS] User set as not in call');
  }

  /// Check if a user is currently in a call
  Future<bool> isUserInCall(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (!doc.exists) return false;
    
    final data = doc.data();
    return data?['inCall'] == true;
  }

  /// Listen to user's call status
  Stream<CallStatusInfo?> listenToUserCallStatus(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) return null;
      
      final data = snapshot.data();
      if (data?['inCall'] != true) return null;
      
      return CallStatusInfo(
        isInCall: true,
        callId: data?['currentCallId'] as String?,
        callType: data?['callType'] as String?,
        startedAt: (data?['callStartedAt'] as Timestamp?)?.toDate(),
      );
    });
  }

  /// Check if user can receive a call (not already in call)
  Future<bool> canReceiveCall(String userId) async {
    return !(await isUserInCall(userId));
  }

  void _startHeartbeat() {
    _stopHeartbeat();
    
    // Send heartbeat every 30 seconds to indicate user is still in call
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (_) async {
      final userId = _auth.currentUser?.uid;
      if (userId == null || _currentCallId == null) {
        _stopHeartbeat();
        return;
      }

      try {
        await _firestore.collection('users').doc(userId).update({
          'callHeartbeat': FieldValue.serverTimestamp(),
        });
      } catch (e) {
        print('⚠️ [IN_CALL_STATUS] Heartbeat failed: $e');
      }
    });
  }

  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  void dispose() {
    _stopHeartbeat();
  }
}

class CallStatusInfo {
  final bool isInCall;
  final String? callId;
  final String? callType;
  final DateTime? startedAt;

  CallStatusInfo({
    required this.isInCall,
    this.callId,
    this.callType,
    this.startedAt,
  });

  String get statusText {
    if (!isInCall) return '';
    return callType == 'video' ? 'In video call...' : 'In voice call...';
  }

  Duration? get callDuration {
    if (startedAt == null) return null;
    return DateTime.now().difference(startedAt!);
  }
}
