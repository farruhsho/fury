import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// Service for sending typing status to Firestore
class TypingStatusService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  Timer? _debounceTimer;
  Timer? _stopTypingTimer;

  TypingStatusService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Call this when user types in message input
  void onTyping(String chatId) {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    // Cancel previous timers
    _debounceTimer?.cancel();
    _stopTypingTimer?.cancel();

    // Debounce to avoid too many writes
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _setTyping(chatId, userId, true);
    });

    // Auto-stop typing after 3 seconds of no input
    _stopTypingTimer = Timer(const Duration(seconds: 3), () {
      _setTyping(chatId, userId, false);
    });
  }

  /// Call this when user sends message or leaves chat
  void stopTyping(String chatId) {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    _debounceTimer?.cancel();
    _stopTypingTimer?.cancel();

    _setTyping(chatId, userId, false);
  }

  Future<void> _setTyping(String chatId, String userId, bool isTyping) async {
    try {
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('typing')
          .doc(userId)
          .set({
        'isTyping': isTyping,
        'timestamp': FieldValue.serverTimestamp(),
      });

      debugPrint('✍️ [TYPING] ${isTyping ? "Started" : "Stopped"} typing in $chatId');
    } catch (e) {
      debugPrint('⚠️ [TYPING] Error setting typing status: $e');
    }
  }

  void dispose() {
    _debounceTimer?.cancel();
    _stopTypingTimer?.cancel();
  }
}
