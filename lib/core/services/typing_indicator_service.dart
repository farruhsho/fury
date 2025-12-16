import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

/// Service for managing typing indicators in chats
class TypingIndicatorService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final Map<String, Timer?> _typingTimers = {};

  TypingIndicatorService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Start typing in a chat
  Future<void> startTyping(String chatId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    // Cancel existing timer for this chat
    _typingTimers[chatId]?.cancel();

    // Set typing status
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('typing')
        .doc(userId)
        .set({
      'isTyping': true,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Auto-stop typing after 3 seconds of inactivity
    _typingTimers[chatId] = Timer(const Duration(seconds: 3), () {
      stopTyping(chatId);
    });
  }

  /// Stop typing in a chat
  Future<void> stopTyping(String chatId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    // Cancel timer
    _typingTimers[chatId]?.cancel();
    _typingTimers.remove(chatId);

    // Remove typing status
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('typing')
        .doc(userId)
        .delete();
  }

  /// Listen to typing users in a chat
  Stream<List<String>> listenToTypingUsers(String chatId) {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('typing')
        .snapshots()
        .map((snapshot) {
      final typingUsers = <String>[];
      for (final doc in snapshot.docs) {
        // Exclude current user
        if (doc.id != userId) {
          final data = doc.data();
          if (data['isTyping'] == true) {
            typingUsers.add(doc.id);
          }
        }
      }
      return typingUsers;
    });
  }

  /// Get typing indicator text
  String getTypingText(List<String> typingUserIds, Map<String, String> userNames) {
    if (typingUserIds.isEmpty) return '';
    
    if (typingUserIds.length == 1) {
      final name = userNames[typingUserIds.first] ?? 'Someone';
      return '$name is typing...';
    } else if (typingUserIds.length == 2) {
      final name1 = userNames[typingUserIds[0]] ?? 'Someone';
      final name2 = userNames[typingUserIds[1]] ?? 'Someone';
      return '$name1 and $name2 are typing...';
    } else {
      return 'Several people are typing...';
    }
  }

  /// Dispose all timers
  void dispose() {
    for (final timer in _typingTimers.values) {
      timer?.cancel();
    }
    _typingTimers.clear();
  }
}
