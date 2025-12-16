import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/call_entity.dart';

/// Service for persisting call logs to Firestore
class CallLogsService {
  final _firestore = FirebaseFirestore.instance;

  /// Save a call log entry when call ends
  Future<void> saveCallLog({
    required String callId,
    required String chatId,
    required String recipientId,
    required String recipientName,
    String? recipientAvatarUrl,
    required CallType callType,
    required CallStatus status,
    required DateTime startTime,
    required DateTime endTime,
    required int durationSeconds,
    CallEndReason? endReason,
  }) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final callLog = {
      'callId': callId,
      'chatId': chatId,
      'recipientId': recipientId,
      'recipientName': recipientName,
      'recipientAvatarUrl': recipientAvatarUrl,
      'callType': callType.name,
      'status': status.name,
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'durationSeconds': durationSeconds,
      'endReason': endReason?.name,
      'isOutgoing': true,
      'createdAt': FieldValue.serverTimestamp(),
    };

    // Save to user's call logs
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('call_logs')
        .doc(callId)
        .set(callLog);

    // Also save to recipient's call logs
    await _firestore
        .collection('users')
        .doc(recipientId)
        .collection('call_logs')
        .doc(callId)
        .set({
      ...callLog,
      'recipientId': userId,
      'recipientName': FirebaseAuth.instance.currentUser?.displayName ?? 'Unknown',
      'recipientAvatarUrl': FirebaseAuth.instance.currentUser?.photoURL,
      'isOutgoing': false,
    });

    debugPrint('📞 [CALL_LOGS] Saved call log: $callId');
  }

  /// Get user's call history
  Stream<List<CallLogEntry>> getCallLogs() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('call_logs')
        .orderBy('startTime', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return CallLogEntry(
                callId: data['callId'] as String,
                chatId: data['chatId'] as String,
                recipientId: data['recipientId'] as String,
                recipientName: data['recipientName'] as String,
                recipientAvatarUrl: data['recipientAvatarUrl'] as String?,
                callType: CallType.values.byName(data['callType'] as String),
                status: CallStatus.values.byName(data['status'] as String),
                startTime: (data['startTime'] as Timestamp).toDate(),
                endTime: (data['endTime'] as Timestamp).toDate(),
                durationSeconds: data['durationSeconds'] as int,
                isOutgoing: data['isOutgoing'] as bool? ?? true,
              );
            }).toList());
  }

  /// Delete a call log entry
  Future<void> deleteCallLog(String callId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('call_logs')
        .doc(callId)
        .delete();
  }

  /// Clear all call logs
  Future<void> clearAllCallLogs() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final logs = await _firestore
        .collection('users')
        .doc(userId)
        .collection('call_logs')
        .get();

    final batch = _firestore.batch();
    for (final doc in logs.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}

/// Call log entry model
class CallLogEntry {
  final String callId;
  final String chatId;
  final String recipientId;
  final String recipientName;
  final String? recipientAvatarUrl;
  final CallType callType;
  final CallStatus status;
  final DateTime startTime;
  final DateTime endTime;
  final int durationSeconds;
  final bool isOutgoing;

  CallLogEntry({
    required this.callId,
    required this.chatId,
    required this.recipientId,
    required this.recipientName,
    this.recipientAvatarUrl,
    required this.callType,
    required this.status,
    required this.startTime,
    required this.endTime,
    required this.durationSeconds,
    required this.isOutgoing,
  });

  bool get isMissed => status == CallStatus.declined || 
                        status == CallStatus.failed ||
                        (status == CallStatus.ended && durationSeconds == 0);

  String get formattedDuration {
    final minutes = durationSeconds ~/ 60;
    final seconds = durationSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
