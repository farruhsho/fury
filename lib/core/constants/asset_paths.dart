/// Asset paths for images, icons, animations, and sounds
abstract class AssetPaths {
  // Images
  static const String imagesPath = 'assets/images';
  static const String logo = '$imagesPath/logo.png';
  static const String logoWhite = '$imagesPath/logo_white.png';
  static const String onboarding1 = '$imagesPath/onboarding_1.png';
  static const String onboarding2 = '$imagesPath/onboarding_2.png';
  static const String onboarding3 = '$imagesPath/onboarding_3.png';
  static const String emptyChats = '$imagesPath/empty_chats.png';
  static const String emptyContacts = '$imagesPath/empty_contacts.png';
  static const String defaultAvatar = '$imagesPath/default_avatar.png';
  static const String defaultGroupAvatar = '$imagesPath/default_group_avatar.png';
  
  // Icons
  static const String iconsPath = 'assets/icons';
  static const String iconCamera = '$iconsPath/camera.svg';
  static const String iconGallery = '$iconsPath/gallery.svg';
  static const String iconDocument = '$iconsPath/document.svg';
  static const String iconLocation = '$iconsPath/location.svg';
  static const String iconContact = '$iconsPath/contact.svg';
  static const String iconAudio = '$iconsPath/audio.svg';
  
  // Animations
  static const String animationsPath = 'assets/animations';
  static const String loadingAnimation = '$animationsPath/loading.json';
  static const String sendingAnimation = '$animationsPath/sending.json';
  static const String typingAnimation = '$animationsPath/typing.json';
  static const String recordingAnimation = '$animationsPath/recording.json';
  static const String successAnimation = '$animationsPath/success.json';
  static const String errorAnimation = '$animationsPath/error.json';
  
  // Sounds
  static const String soundsPath = 'assets/sounds';
  static const String messageSent = '$soundsPath/message_sent.mp3';
  static const String messageReceived = '$soundsPath/message_received.mp3';
  static const String notificationSound = '$soundsPath/notification.mp3';
  static const String callRingtone = '$soundsPath/call_ringtone.mp3';
  static const String callBusy = '$soundsPath/call_busy.mp3';
  static const String callEnded = '$soundsPath/call_ended.mp3';
  static const String recordingStart = '$soundsPath/recording_start.mp3';
  static const String recordingStop = '$soundsPath/recording_stop.mp3';
}
