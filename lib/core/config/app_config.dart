import 'package:flutter/foundation.dart';

/// Application configuration
///
/// This file contains configuration settings for the app including
/// development mode, API endpoints, feature flags, and mock data.
class AppConfig {
  // ========================================
  // Environment Settings
  // ========================================

  /// Development mode flag
  ///
  /// When true:
  /// - Shows debug information
  /// - Enables additional logging
  /// - Uses local/test data where possible
  ///
  /// Set to false for production builds
  static const bool isDevelopmentMode = true;

  /// Enable mock authentication
  ///
  /// When true, bypasses Firebase Phone Auth and uses mock credentials.
  /// When false, uses real Firebase Phone Auth (including test numbers)
  ///
  /// Set to FALSE to use Firebase (even in development mode)
  static const bool useMockAuth = false; // ИЗМЕНЕНО: теперь использует Firebase

  // ========================================
  // Mock Credentials (for development)
  // ========================================

  /// Mock phone numbers that will work with mock auth
  static const List<String> mockPhoneNumbers = [
    '+1234567890',
    '+9876543210',
    '+1111111111',
    '+79991234567', // Russian format
    '+998901234567', // Uzbek format
  ];

  /// Mock OTP code that will work for all mock phone numbers
  static const String mockOTPCode = '123456';

  /// Mock user data
  static const Map<String, dynamic> mockUserData = {
    'userId': 'mock-user-id-123',
    'phoneNumber': '+1234567890',
    'displayName': 'Test User',
    'username': 'testuser',
    'bio': 'This is a test user account',
    'avatarUrl': null,
    'isOnline': true,
    'createdAt': '2024-01-01T00:00:00Z',
  };

  // ========================================
  // Firebase Settings
  // ========================================

  /// Use Firebase authentication
  ///
  /// Set to true to use real Firebase Phone Auth
  /// Set to false to use mock auth (for development)
  static const bool useFirebaseAuth = !useMockAuth;

  /// Firebase emulator settings (for local development)
  static const bool useFirebaseEmulator = false;
  static const String firestoreEmulatorHost = 'localhost';
  static const int firestoreEmulatorPort = 8080;
  static const String authEmulatorHost = 'localhost';
  static const int authEmulatorPort = 9099;

  // ========================================
  // API Configuration
  // ========================================

  /// Base API URL (if using REST API in addition to Firebase)
  static const String apiBaseUrl = isDevelopmentMode
      ? 'http://localhost:3000/api'
      : 'https://api.furychat.com/api';

  /// API timeout in seconds
  static const int apiTimeoutSeconds = 30;

  // ========================================
  // GraphQL Configuration (if used)
  // ========================================

  /// GraphQL endpoint URL
  static const String graphqlEndpoint = isDevelopmentMode
      ? 'http://localhost:4000/graphql'
      : 'https://graphql.furychat.com/graphql';

  /// WebSocket endpoint for GraphQL subscriptions
  static const String graphqlWsEndpoint = isDevelopmentMode
      ? 'ws://localhost:4000/graphql'
      : 'wss://graphql.furychat.com/graphql';

  // ========================================
  // Feature Flags
  // ========================================

  /// Enable/disable specific features
  static const bool enableStories = false; // Not implemented yet
  static const bool enableVoiceCalls = false; // Not implemented yet
  static const bool enableVideoCalls = false; // Not implemented yet
  static const bool enableGroupCalls = false; // Not implemented yet
  static const bool enableChannels = true;
  static const bool enableGroupChats = true;
  static const bool enableFileSharing = true;
  static const bool enableVoiceMessages = false; // Windows compatibility
  static const bool enableImageCropper = false; // Windows compatibility

  // ========================================
  // App Settings
  // ========================================

  /// App name
  static const String appName = 'Fury Chat';

  /// App version (should match pubspec.yaml)
  static const String appVersion = '1.0.0';

  /// App build number
  static const int buildNumber = 1;

  /// Support email
  static const String supportEmail = 'support@furychat.com';

  // ========================================
  // Storage Settings
  // ========================================

  /// Maximum file upload size in bytes (10 MB)
  static const int maxFileUploadSize = 10 * 1024 * 1024;

  /// Maximum image upload size in bytes (5 MB)
  static const int maxImageUploadSize = 5 * 1024 * 1024;

  /// Supported image formats
  static const List<String> supportedImageFormats = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'webp',
  ];

  /// Supported video formats
  static const List<String> supportedVideoFormats = [
    'mp4',
    'mov',
    'avi',
    'mkv',
  ];

  // ========================================
  // Cache Settings
  // ========================================

  /// Cache duration for images (in days)
  static const int imageCacheDurationDays = 7;

  /// Maximum cache size in bytes (100 MB)
  static const int maxCacheSizeBytes = 100 * 1024 * 1024;

  // ========================================
  // Notification Settings
  // ========================================

  /// Enable push notifications
  static const bool enablePushNotifications = true;

  /// Enable local notifications
  static const bool enableLocalNotifications = true;

  // ========================================
  // Logging Settings
  // ========================================

  /// Enable verbose logging
  static const bool enableVerboseLogging = isDevelopmentMode;

  /// Enable Firebase Analytics
  static const bool enableAnalytics = !isDevelopmentMode;

  /// Enable Firebase Crashlytics
  static const bool enableCrashlytics = !isDevelopmentMode;

  // ========================================
  // Helper Methods
  // ========================================

  /// Check if a phone number is a mock number
  static bool isMockPhoneNumber(String phoneNumber) {
    return mockPhoneNumbers.contains(phoneNumber);
  }

  /// Get environment name
  static String get environmentName =>
      isDevelopmentMode ? 'Development' : 'Production';

  /// Print current configuration (for debugging)
  static void printConfig() {
    if (!enableVerboseLogging) return;

    debugPrint('');
    debugPrint('╔════════════════════════════════════════╗');
    debugPrint('║     Fury Chat Configuration           ║');
    debugPrint('╚════════════════════════════════════════╝');
    debugPrint('');
    debugPrint('Environment: $environmentName');
    debugPrint('Development Mode: $isDevelopmentMode');
    debugPrint('Mock Auth: $useMockAuth');
    debugPrint('Firebase Auth: $useFirebaseAuth');
    debugPrint('Firebase Emulator: $useFirebaseEmulator');
    debugPrint('');
    debugPrint('Features:');
    debugPrint('  - Stories: $enableStories');
    debugPrint('  - Voice Calls: $enableVoiceCalls');
    debugPrint('  - Video Calls: $enableVideoCalls');
    debugPrint('  - Group Calls: $enableGroupCalls');
    debugPrint('  - Channels: $enableChannels');
    debugPrint('  - Group Chats: $enableGroupChats');
    debugPrint('  - File Sharing: $enableFileSharing');
    debugPrint('  - Voice Messages: $enableVoiceMessages');
    debugPrint('');
    debugPrint('API:');
    debugPrint('  - Base URL: $apiBaseUrl');
    debugPrint('  - GraphQL: $graphqlEndpoint');
    debugPrint('  - Timeout: ${apiTimeoutSeconds}s');
    debugPrint('');
    debugPrint('Logging:');
    debugPrint('  - Verbose: $enableVerboseLogging');
    debugPrint('  - Analytics: $enableAnalytics');
    debugPrint('  - Crashlytics: $enableCrashlytics');
    debugPrint('');
    debugPrint('═══════════════════════════════════════════');
    debugPrint('');
  }
}
