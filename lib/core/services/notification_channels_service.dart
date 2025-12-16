import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

/// Service for managing Android notification channels
class NotificationChannelsService {
  final FlutterLocalNotificationsPlugin _notifications;

  NotificationChannelsService({
    FlutterLocalNotificationsPlugin? notifications,
  }) : _notifications = notifications ?? FlutterLocalNotificationsPlugin();

  /// Initialize all notification channels
  Future<void> initializeChannels() async {
    final androidPlugin = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin == null) return;

    // Create all channels
    await Future.wait([
      androidPlugin.createNotificationChannel(messagesChannel),
      androidPlugin.createNotificationChannel(callsChannel),
      androidPlugin.createNotificationChannel(missedCallsChannel),
      androidPlugin.createNotificationChannel(groupMessagesChannel),
      androidPlugin.createNotificationChannel(mediaChannel),
      androidPlugin.createNotificationChannel(systemChannel),
    ]);

    debugPrint('📢 [CHANNELS] All notification channels initialized');
  }

  /// Messages channel (high priority)
  static const AndroidNotificationChannel messagesChannel = AndroidNotificationChannel(
    'messages_channel',
    'Messages',
    description: 'Notifications for new messages',
    importance: Importance.high,
    playSound: true,
    enableVibration: true,
    showBadge: true,
  );

  /// Calls channel (max priority for incoming calls)
  static const AndroidNotificationChannel callsChannel = AndroidNotificationChannel(
    'calls_channel',
    'Incoming Calls',
    description: 'Notifications for incoming voice and video calls',
    importance: Importance.max,
    playSound: true,
    enableVibration: true,
    showBadge: true,
    sound: RawResourceAndroidNotificationSound('ringtone'),
  );

  /// Missed calls channel
  static const AndroidNotificationChannel missedCallsChannel = AndroidNotificationChannel(
    'missed_calls_channel',
    'Missed Calls',
    description: 'Notifications for missed calls',
    importance: Importance.high,
    playSound: true,
    showBadge: true,
  );

  /// Group messages channel
  static const AndroidNotificationChannel groupMessagesChannel = AndroidNotificationChannel(
    'group_messages_channel',
    'Group Messages',
    description: 'Notifications for group chat messages',
    importance: Importance.high,
    playSound: true,
    enableVibration: true,
    showBadge: true,
  );

  /// Media downloads channel (low priority)
  static const AndroidNotificationChannel mediaChannel = AndroidNotificationChannel(
    'media_channel',
    'Media Downloads',
    description: 'Notifications for media downloads and uploads',
    importance: Importance.low,
    playSound: false,
    showBadge: false,
  );

  /// System notifications channel
  static const AndroidNotificationChannel systemChannel = AndroidNotificationChannel(
    'system_channel',
    'System',
    description: 'System notifications and updates',
    importance: Importance.defaultImportance,
    playSound: false,
    showBadge: false,
  );

  /// Get channel ID for message type
  static String getChannelIdForMessage({
    required bool isGroup,
    required String messageType,
  }) {
    if (isGroup) return groupMessagesChannel.id;
    if (messageType == 'call') return callsChannel.id;
    return messagesChannel.id;
  }
}
