import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

/// Service for managing message expiry (delete for everyone timer)
class MessageExpiryService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  /// Maximum time to delete for everyone (default: 48 hours)
  static const Duration deleteForEveryoneLimit = Duration(hours: 48);

  MessageExpiryService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Check if message can be deleted for everyone
  bool canDeleteForEveryone({
    required String senderId,
    required DateTime createdAt,
  }) {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return false;

    // Only sender can delete for everyone
    if (senderId != userId) return false;

    // Check time limit
    final elapsed = DateTime.now().difference(createdAt);
    return elapsed <= deleteForEveryoneLimit;
  }

  /// Get remaining time to delete for everyone
  Duration? getRemainingDeleteTime(DateTime createdAt) {
    final elapsed = DateTime.now().difference(createdAt);
    final remaining = deleteForEveryoneLimit - elapsed;
    
    if (remaining.isNegative) return null;
    return remaining;
  }

  /// Delete message for everyone
  Future<void> deleteForEveryone({
    required String chatId,
    required String messageId,
    required DateTime createdAt,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('Not authenticated');

    // Verify time limit
    if (!canDeleteForEveryone(senderId: userId, createdAt: createdAt)) {
      throw Exception('Cannot delete for everyone - time limit exceeded');
    }

    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .update({
      'isDeleted': true,
      'text': 'This message was deleted',
      'deletedAt': FieldValue.serverTimestamp(),
      'deletedBy': userId,
      'attachments': [],
    });

    print('🗑️ [DELETE] Message deleted for everyone: $messageId');
  }

  /// Delete message for me only
  Future<void> deleteForMe({
    required String chatId,
    required String messageId,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('Not authenticated');

    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .update({
      'deletedFor': FieldValue.arrayUnion([userId]),
    });

    print('🗑️ [DELETE] Message deleted for me: $messageId');
  }

  /// Schedule message auto-deletion (self-destructing messages)
  Future<void> scheduleAutoDelete({
    required String chatId,
    required String messageId,
    required Duration delay,
  }) async {
    final expiresAt = DateTime.now().add(delay);

    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .update({
      'expiresAt': expiresAt.toIso8601String(),
      'isExpiring': true,
    });

    print('⏱️ [DELETE] Message scheduled for deletion in ${delay.inMinutes} minutes');
  }
}

/// Dialog for choosing delete options
enum DeleteOption {
  deleteForMe,
  deleteForEveryone,
}

extension DeleteOptionExtension on DeleteOption {
  String get label {
    switch (this) {
      case DeleteOption.deleteForMe:
        return 'Delete for me';
      case DeleteOption.deleteForEveryone:
        return 'Delete for everyone';
    }
  }
}
