/// Storage keys for local and secure storage
abstract class StorageKeys {
  // Authentication
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String userPhone = 'user_phone';
  
  // User Preferences
  static const String themeMode = 'theme_mode';
  static const String language = 'language';
  static const String notificationsEnabled = 'notifications_enabled';
  static const String soundEnabled = 'sound_enabled';
  static const String vibrationEnabled = 'vibration_enabled';
  
  // Chat Settings
  static const String enterToSend = 'enter_to_send';
  static const String showPreview = 'show_preview';
  static const String autoDownloadImages = 'auto_download_images';
  static const String autoDownloadVideos = 'auto_download_videos';
  static const String autoDownloadDocuments = 'auto_download_documents';
  
  // Privacy Settings
  static const String lastSeenPrivacy = 'last_seen_privacy';
  static const String profilePhotoPrivacy = 'profile_photo_privacy';
  static const String aboutPrivacy = 'about_privacy';
  static const String readReceipts = 'read_receipts';
  
  // Cache
  static const String cachedUser = 'cached_user';
  static const String cachedChats = 'cached_chats';
  static const String cachedMessages = 'cached_messages';
  
  // Encryption
  static const String privateKey = 'private_key';
  static const String publicKey = 'public_key';
  static const String encryptionSalt = 'encryption_salt';
  
  // Device
  static const String deviceId = 'device_id';
  static const String fcmToken = 'fcm_token';
  static const String voipToken = 'voip_token';
  
  // Onboarding
  static const String hasSeenOnboarding = 'has_seen_onboarding';
  static const String isFirstLaunch = 'is_first_launch';
}
