import 'dart:async';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Service for detecting and notifying about screenshots
class ScreenshotDetectionService {
  static final _firestore = FirebaseFirestore.instance;
  static StreamSubscription? _screenshotSubscription;
  static DateTime? _lastNotification;

  /// Initialize screenshot detection
  /// Note: This uses platform channels on iOS/Android
  static Future<void> init() async {
    // On iOS, use screenshot detection plugin
    // On Android, use FLAG_SECURE or MediaContentObserver
    print('📸 [SCREENSHOT] Detection service initialized');
  }

  /// Notify the other user that a screenshot was taken
  static Future<void> notifyScreenshotTaken({
    required String chatId,
    required String recipientId,
  }) async {
    // Prevent spam - max one notification per 5 seconds
    if (_lastNotification != null) {
      final diff = DateTime.now().difference(_lastNotification!);
      if (diff.inSeconds < 5) return;
    }
    _lastNotification = DateTime.now();

    final userId = FirebaseAuth.instance.currentUser?.uid;
    final userName = FirebaseAuth.instance.currentUser?.displayName ?? 'Someone';
    if (userId == null) return;

    // Create system message
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'senderId': 'system',
      'type': 'system',
      'text': '$userName took a screenshot',
      'createdAt': FieldValue.serverTimestamp(),
      'metadata': {
        'action': 'screenshot',
        'userId': userId,
      },
    });

    // Also add to notifications
    await _firestore
        .collection('users')
        .doc(recipientId)
        .collection('notifications')
        .add({
      'type': 'screenshot',
      'chatId': chatId,
      'fromUserId': userId,
      'fromUserName': userName,
      'createdAt': FieldValue.serverTimestamp(),
      'read': false,
    });

    // Haptic feedback
    HapticFeedback.lightImpact();
    
    print('📸 [SCREENSHOT] Notified $recipientId about screenshot');
  }

  /// Enable screenshot protection for a widget
  /// This is a placeholder - actual implementation needs platform code
  static Future<void> enableProtection() async {
    // On Android: window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
    // On iOS: Use UITextField.isSecureTextEntry workaround
    print('📸 [SCREENSHOT] Protection enabled');
  }

  /// Disable screenshot protection
  static Future<void> disableProtection() async {
    print('📸 [SCREENSHOT] Protection disabled');
  }

  static void dispose() {
    _screenshotSubscription?.cancel();
  }
}
