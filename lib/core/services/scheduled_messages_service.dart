import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// Service for scheduling messages to be sent at a later time
class ScheduledMessagesService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  Timer? _checkTimer;
  
  ScheduledMessagesService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Schedule a message to be sent at a specific time
  Future<String> scheduleMessage({
    required String chatId,
    required String text,
    required DateTime scheduledTime,
    String? replyToId,
    List<Map<String, dynamic>>? attachments,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('Not authenticated');

    if (scheduledTime.isBefore(DateTime.now())) {
      throw Exception('Scheduled time must be in the future');
    }

    final docRef = await _firestore
        .collection('users')
        .doc(userId)
        .collection('scheduled_messages')
        .add({
      'chatId': chatId,
      'text': text,
      'scheduledTime': scheduledTime.toIso8601String(),
      'replyToId': replyToId,
      'attachments': attachments ?? [],
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });

    debugPrint('⏰ [SCHEDULED] Message scheduled: ${docRef.id} at $scheduledTime');
    return docRef.id;
  }

  /// Get all scheduled messages for current user
  Stream<List<ScheduledMessage>> getScheduledMessages() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('scheduled_messages')
        .where('status', isEqualTo: 'pending')
        .orderBy('scheduledTime')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ScheduledMessage.fromFirestore(doc))
            .toList());
  }

  /// Cancel a scheduled message
  Future<void> cancelScheduledMessage(String messageId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('scheduled_messages')
        .doc(messageId)
        .update({
      'status': 'cancelled',
      'cancelledAt': FieldValue.serverTimestamp(),
    });

    debugPrint('⏰ [SCHEDULED] Message cancelled: $messageId');
  }

  /// Reschedule a message
  Future<void> rescheduleMessage(String messageId, DateTime newTime) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    if (newTime.isBefore(DateTime.now())) {
      throw Exception('Scheduled time must be in the future');
    }

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('scheduled_messages')
        .doc(messageId)
        .update({
      'scheduledTime': newTime.toIso8601String(),
    });

    debugPrint('⏰ [SCHEDULED] Message rescheduled: $messageId to $newTime');
  }

  /// Edit scheduled message text
  Future<void> editScheduledMessage(String messageId, String newText) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('scheduled_messages')
        .doc(messageId)
        .update({
      'text': newText,
    });
  }

  /// Start checking for due messages (call this on app start)
  void startScheduledMessageChecker(Function(ScheduledMessage) onSendMessage) {
    _checkTimer?.cancel();
    
    // Check every minute for due messages
    _checkTimer = Timer.periodic(const Duration(minutes: 1), (_) async {
      await _checkAndSendDueMessages(onSendMessage);
    });
    
    // Also check immediately
    _checkAndSendDueMessages(onSendMessage);
  }

  Future<void> _checkAndSendDueMessages(Function(ScheduledMessage) onSendMessage) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final now = DateTime.now();
    
    try {
      final dueMessages = await _firestore
          .collection('users')
          .doc(userId)
          .collection('scheduled_messages')
          .where('status', isEqualTo: 'pending')
          .get();

      for (final doc in dueMessages.docs) {
        final message = ScheduledMessage.fromFirestore(doc);
        
        if (message.scheduledTime.isBefore(now)) {
          // Mark as sent
          await doc.reference.update({
            'status': 'sent',
            'sentAt': FieldValue.serverTimestamp(),
          });
          
          // Trigger send callback
          onSendMessage(message);
          
          debugPrint('⏰ [SCHEDULED] Sending scheduled message: ${message.id}');
        }
      }
    } catch (e) {
      debugPrint('⚠️ [SCHEDULED] Error checking messages: $e');
    }
  }

  void stopScheduledMessageChecker() {
    _checkTimer?.cancel();
    _checkTimer = null;
  }

  void dispose() {
    stopScheduledMessageChecker();
  }
}

class ScheduledMessage {
  final String id;
  final String chatId;
  final String text;
  final DateTime scheduledTime;
  final String? replyToId;
  final List<Map<String, dynamic>> attachments;
  final String status;
  final DateTime createdAt;

  ScheduledMessage({
    required this.id,
    required this.chatId,
    required this.text,
    required this.scheduledTime,
    this.replyToId,
    required this.attachments,
    required this.status,
    required this.createdAt,
  });

  factory ScheduledMessage.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ScheduledMessage(
      id: doc.id,
      chatId: data['chatId'] as String,
      text: data['text'] as String,
      scheduledTime: DateTime.parse(data['scheduledTime'] as String),
      replyToId: data['replyToId'] as String?,
      attachments: List<Map<String, dynamic>>.from(data['attachments'] ?? []),
      status: data['status'] as String,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  bool get isPending => status == 'pending';
  bool get isSent => status == 'sent';
  bool get isCancelled => status == 'cancelled';

  Duration get timeUntilSend => scheduledTime.difference(DateTime.now());
}
