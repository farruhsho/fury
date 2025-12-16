import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Service for listening to new messages in real-time and showing notifications
class MessageNotificationListenerService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final FlutterLocalNotificationsPlugin _notifications;
  
  final Map<String, StreamSubscription> _chatSubscriptions = {};
  bool _isInitialized = false;
  String? _currentlyOpenChatId; // Don't notify for currently open chat

  MessageNotificationListenerService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
    FlutterLocalNotificationsPlugin? notifications,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance,
        _notifications = notifications ?? FlutterLocalNotificationsPlugin();

  /// Set which chat is currently open (don't show notifications for it)
  void setCurrentlyOpenChat(String? chatId) {
    _currentlyOpenChatId = chatId;
    debugPrint('📨 [MESSAGE LISTENER] Currently open chat: $chatId');
  }

  /// Initialize and start listening for new messages
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    _isInitialized = true;

    // Get all chats where user is a participant
    _firestore
        .collection('chats')
        .where('participantIds', arrayContains: userId)
        .snapshots()
        .listen((snapshot) {
      for (final doc in snapshot.docs) {
        final chatId = doc.id;
        if (!_chatSubscriptions.containsKey(chatId)) {
          _subscribeToChat(chatId);
        }
      }
    });

    debugPrint('✅ [MESSAGE LISTENER] Started listening for new messages');
  }

  void _subscribeToChat(String chatId) {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    // Listen to newest messages only
    final subscription = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .snapshots()
        .listen((snapshot) async {
      if (snapshot.docChanges.isEmpty) return;

      for (final change in snapshot.docChanges) {
        if (change.type != DocumentChangeType.added) continue;
        
        final data = change.doc.data();
        if (data == null) continue;
        
        final senderId = data['senderId'] as String?;
        final createdAt = data['createdAt'] as Timestamp?;
        
        // Skip own messages
        if (senderId == userId) continue;
        
        // Skip if this chat is currently open
        if (chatId == _currentlyOpenChatId) continue;
        
        // Skip old messages (more than 5 seconds old)
        if (createdAt != null) {
          final messageTime = createdAt.toDate();
          if (DateTime.now().difference(messageTime).inSeconds > 5) continue;
        }
        
        // Get sender info
        final senderDoc = await _firestore
            .collection('users')
            .doc(senderId)
            .get();
        final senderName = senderDoc.data()?['displayName'] as String? ?? 'Unknown';
        
        // Determine message preview
        String preview = data['text'] as String? ?? '';
        final type = data['type'] as String? ?? 'text';
        
        if (type == 'image') preview = '📸 Photo';
        else if (type == 'video') preview = '🎥 Video';
        else if (type == 'audio' || type == 'voice') preview = '🎧 Voice message';
        else if (type == 'document') preview = '📄 Document';
        else if (type == 'location') preview = '📍 Location';
        else if (type == 'sticker') preview = '🎨 Sticker';
        
        await _showMessageNotification(
          chatId: chatId,
          messageId: change.doc.id,
          senderName: senderName,
          preview: preview,
        );
      }
    });

    _chatSubscriptions[chatId] = subscription;
  }

  Future<void> _showMessageNotification({
    required String chatId,
    required String messageId,
    required String senderName,
    required String preview,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'messages_channel',
      'Messages',
      channelDescription: 'New message notifications',
      importance: Importance.high,
      priority: Priority.high,
      category: AndroidNotificationCategory.message,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      messageId.hashCode,
      senderName,
      preview,
      details,
      payload: 'chat:$chatId',
    );

    debugPrint('🔔 [MESSAGE LISTENER] Notification shown: $senderName - $preview');
  }

  /// Clear all subscriptions for a specific chat
  void unsubscribeFromChat(String chatId) {
    _chatSubscriptions[chatId]?.cancel();
    _chatSubscriptions.remove(chatId);
  }

  /// Dispose and clean up all subscriptions
  Future<void> dispose() async {
    for (final subscription in _chatSubscriptions.values) {
      await subscription.cancel();
    }
    _chatSubscriptions.clear();
    _isInitialized = false;
  }
}
