/// Application-wide constants
abstract class AppConstants {
  // App Info
  static const String appName = 'Fury Chat';
  static const String appVersion = '1.0.0';
  
  // Supported Languages
  static const List<String> supportedLanguages = ['en', 'ru', 'uz'];
  static const String defaultLanguage = 'en';
  
  // Message Limits
  static const int maxMessageLength = 4096;
  static const int maxCaptionLength = 1024;
  static const int maxBioLength = 140;
  static const int maxGroupNameLength = 256;
  static const int maxGroupDescriptionLength = 512;
  
  // Group Limits
  static const int maxGroupMembers = 256;
  static const int maxChannelMembers = 100000;
  
  // Voice Message
  static const int maxVoiceDuration = 300; // 5 minutes in seconds
  static const int minVoiceDuration = 1; // 1 second
  
  // Story
  static const int storyDuration = 24; // hours
  static const int maxStoryDuration = 60; // seconds
  
  // Cache
  static const int maxCachedMessages = 1000;
  static const int maxCachedImages = 100;
  
  // Typing Indicator
  static const Duration typingTimeout = Duration(seconds: 5);
  
  // Online Status
  static const Duration onlineTimeout = Duration(seconds: 30);
  
  // Message Status Update Delay
  static const Duration statusUpdateDelay = Duration(milliseconds: 500);
  
  // Debounce Durations
  static const Duration searchDebounce = Duration(milliseconds: 300);
  static const Duration typingDebounce = Duration(milliseconds: 500);
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
}
