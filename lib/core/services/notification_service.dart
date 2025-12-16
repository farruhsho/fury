import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Notification service for handling push notifications
class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = 
      FlutterLocalNotificationsPlugin();
  
  /// Flag to track if local notifications are supported on this platform
  bool _isLocalNotificationsSupported = false;
  
  static const AndroidNotificationChannel _messageChannel = AndroidNotificationChannel(
    'messages_channel',
    'Messages',
    description: 'Notifications for new messages',
    importance: Importance.high,
    playSound: true,
  );
  
  static const AndroidNotificationChannel _callChannel = AndroidNotificationChannel(
    'calls_channel',
    'Calls',
    description: 'Notifications for incoming calls',
    importance: Importance.max,
    playSound: true,
  );
  
  /// Initialize notification service
  Future<void> init() async {
    // Request permission
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
    
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
    
    // Local notifications are only supported on mobile platforms
    // Not supported on Windows desktop
    try {
      if (!kIsWeb && _isWindowsDesktop) {
        debugPrint('⚠️ [NOTIFICATIONS] Local notifications not supported on Windows');
        _isLocalNotificationsSupported = false;
      } else {
        await _localNotifications.initialize(
          initSettings,
          onDidReceiveNotificationResponse: _onNotificationTapped,
        );
        _isLocalNotificationsSupported = true;
        debugPrint('✅ [NOTIFICATIONS] Local notifications initialized');
      }
    } catch (e) {
      debugPrint('⚠️ [NOTIFICATIONS] Failed to initialize local notifications: $e');
      _isLocalNotificationsSupported = false;
    }
    
    // Create notification channels for Android
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_messageChannel);
    
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_callChannel);
    
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    
    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    
    // Handle notification opened app
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
    
    // Get and store initial FCM token
    await _updateFcmTokenInFirestore();
    
    // Listen for token refresh
    _firebaseMessaging.onTokenRefresh.listen((token) {
      debugPrint('FCM Token refreshed');
      _updateFcmTokenInFirestore();
    });
  }
  
  /// Update FCM token in user's Firestore document
  Future<void> _updateFcmTokenInFirestore() async {
    try {
      final token = await _firebaseMessaging.getToken();
      if (token != null) {
        // Import and call auth datasource
        // This is done lazily to avoid circular dependency
        final firestore = FirebaseFirestore.instance;
        final auth = FirebaseAuth.instance;
        final currentUser = auth.currentUser;
        
        if (currentUser != null) {
          await firestore.collection('users').doc(currentUser.uid).update({
            'fcmToken': token,
            'fcmTokenUpdatedAt': FieldValue.serverTimestamp(),
          });
          debugPrint('FCM token updated in Firestore');
        }
      }
    } catch (e) {
      debugPrint('Error updating FCM token: $e');
    }
  }
  
  /// Get FCM token
  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }
  
  /// Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }
  
  /// Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
  
  /// Handle foreground messages
  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('Foreground message: ${message.messageId}');

    final notification = message.notification;
    // Android-specific notification data can be accessed if needed
    // final android = message.notification?.android;

    if (notification != null) {
      _showLocalNotification(
        id: message.hashCode,
        title: notification.title ?? 'New Message',
        body: notification.body ?? '',
        payload: message.data.toString(),
        channelId: _messageChannel.id,
      );
    }
  }
  
  /// Handle notification tapped
  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Notification tapped: ${response.payload}');
    // TODO: Navigate to appropriate screen based on payload
  }
  
  /// Handle message opened app
  void _handleMessageOpenedApp(RemoteMessage message) {
    debugPrint('Message opened app: ${message.messageId}');
    // TODO: Navigate to appropriate screen based on message data
  }
  
  /// Show local notification
  Future<void> _showLocalNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    required String channelId,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelId == _messageChannel.id ? 'Messages' : 'Calls',
      channelDescription: channelId == _messageChannel.id 
          ? 'Notifications for new messages'
          : 'Notifications for incoming calls',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
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
    
    await _localNotifications.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }
  
  /// Check if running on Windows desktop
  bool get _isWindowsDesktop {
    if (kIsWeb) return false;
    try {
      return Platform.isWindows;
    } catch (e) {
      return false;
    }
  }
  
  /// Show message notification
  Future<void> showMessageNotification({
    required String chatId,
    required String senderId,
    required String senderName,
    required String message,
  }) async {
    await _showLocalNotification(
      id: chatId.hashCode,
      title: senderName,
      body: message,
      payload: 'chat:$chatId',
      channelId: _messageChannel.id,
    );
  }
  
  /// Show call notification
  Future<void> showCallNotification({
    required String callId,
    required String callerName,
    required bool isVideo,
  }) async {
    if (!_isLocalNotificationsSupported) {
      debugPrint('⚠️ [NOTIFICATIONS] Cannot show call notification - not supported on this platform');
      return;
    }
    try {
      await _showLocalNotification(
        id: callId.hashCode,
        title: 'Incoming ${isVideo ? 'Video' : 'Voice'} Call',
        body: callerName.isNotEmpty ? callerName : 'Unknown Caller',
        payload: 'call:$callId',
        channelId: _callChannel.id,
      );
    } catch (e) {
      debugPrint('⚠️ [NOTIFICATIONS] Error showing call notification: $e');
    }
  }

  /// Cancel notification
  Future<void> cancelNotification(int id) async {
    await _localNotifications.cancel(id);
  }
  
  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _localNotifications.cancelAll();
  }
}

/// Background message handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('🌙 [BACKGROUND] Handling a background message: ${message.messageId}');
  
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  debugPrint("🌙 [BACKGROUND] Data: ${message.data}");
  
  // Handle call notifications in background/terminated state
  if (message.data['type'] == 'call') {
    final callId = message.data['callId'];
    final callerName = message.data['callerName'];
    final isVideo = message.data['isVideo'] == 'true';
    
    if (callId != null && callerName != null) {
      debugPrint("🌙 [BACKGROUND] Showing incoming call notification");
      
      // Initialize notification service just for this notification
      final notificationService = NotificationService();
      await notificationService.init();
      
      await notificationService.showCallNotification(
        callId: callId,
        callerName: callerName,
        isVideo: isVideo,
      );
    }
  }
}
