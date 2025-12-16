import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

/// Supported languages
enum AppLanguage {
  en('en', 'English', '🇺🇸'),
  ru('ru', 'Русский', '🇷🇺'),
  uz('uz', "O'zbek", '🇺🇿');

  final String code;
  final String name;
  final String flag;

  const AppLanguage(this.code, this.name, this.flag);

  static AppLanguage fromCode(String code) {
    return AppLanguage.values.firstWhere(
      (lang) => lang.code == code,
      orElse: () => AppLanguage.en,
    );
  }
}

/// Locale provider for managing app language
class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  LocalStorageService? _storageService;
  bool _isInitialized = false;

  Locale get locale => _locale;
  
  AppLanguage get currentLanguage => AppLanguage.fromCode(_locale.languageCode);

  LocaleProvider() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    try {
      _storageService = LocalStorageService();
      await _storageService!.init();
      _isInitialized = true;

      final savedLanguage = _storageService!.getLanguage();
      if (savedLanguage != null) {
        _locale = Locale(savedLanguage);
        notifyListeners();
      }
    } catch (e) {
      // Use default English
      _locale = const Locale('en');
    }
  }

  Future<void> setLanguage(AppLanguage language) async {
    _locale = Locale(language.code);
    notifyListeners();

    if (_isInitialized && _storageService != null) {
      try {
        await _storageService!.saveLanguage(language.code);
      } catch (e) {
        // Ignore storage errors
      }
    }
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();

    if (_isInitialized && _storageService != null) {
      try {
        await _storageService!.saveLanguage(locale.languageCode);
      } catch (e) {
        // Ignore storage errors
      }
    }
  }
}

/// App localizations - all translatable strings
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('en'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Translations map
  static final Map<String, Map<String, String>> _translations = {
    'en': {
      // Common
      'app_name': 'Fury Messenger',
      'ok': 'OK',
      'cancel': 'Cancel',
      'save': 'Save',
      'delete': 'Delete',
      'edit': 'Edit',
      'retry': 'Retry',
      'loading': 'Loading...',
      'error': 'Error',
      'success': 'Success',
      'search': 'Search',
      'close': 'Close',
      
      // Auth
      'login': 'Login',
      'logout': 'Log Out',
      'logout_confirm': 'Are you sure you want to log out?',
      'register': 'Register',
      'email': 'Email',
      'password': 'Password',
      'forgot_password': 'Forgot Password?',
      'sign_in_with_google': 'Sign in with Google',
      'create_account': 'Create Account',
      'already_have_account': 'Already have an account?',
      'dont_have_account': "Don't have an account?",
      
      // Chat
      'chats': 'Chats',
      'chat': 'Chat',
      'no_chats': 'No chats yet',
      'start_conversation': 'Start a conversation',
      'search_users': 'Search Users',
      'type_message': 'Type a message',
      'no_messages': 'No messages yet',
      'send_first_message': 'Send a message to start the conversation',
      'online': 'Online',
      'offline': 'Offline',
      'last_seen': 'Last seen',
      'typing': 'typing...',
      'delivered': 'Delivered',
      'read': 'Read',
      'sending': 'Sending...',
      'message_deleted': 'This message was deleted',
      'reply': 'Reply',
      'forward': 'Forward',
      'copy': 'Copy',
      'pin': 'Pin',
      'unpin': 'Unpin',
      
      // Calls
      'video_call': 'Video Call',
      'voice_call': 'Voice Call',
      'calling': 'Calling...',
      'connecting': 'Connecting...',
      'ringing': 'Ringing...',
      'connected': 'Connected',
      'call_ended': 'Call ended',
      'end_call': 'End Call',
      
      // Settings
      'settings': 'Settings',
      'account': 'Account',
      'privacy_security': 'Privacy and Security',
      'notifications': 'Notifications',
      'storage_data': 'Storage and Data',
      'app_settings': 'App Settings',
      'language': 'Language',
      'theme': 'Theme',
      'dark_mode': 'Dark Mode',
      'light_mode': 'Light Mode',
      'system_theme': 'System',
      'chat_settings': 'Chat Settings',
      'help': 'Help',
      'help_center': 'Help Center',
      'terms_privacy': 'Terms and Privacy Policy',
      'about': 'About',
      
      // Privacy
      'last_seen_privacy': 'Last Seen',
      'read_receipts': 'Read Receipts',
      'online_status': 'Online Status',
      'profile_photo': 'Profile Photo',
      'screenshot_notify': 'Screenshot Notifications',
      'blocked_users': 'Blocked Users',
      'everyone': 'Everyone',
      'contacts': 'My Contacts',
      'nobody': 'Nobody',
      
      // Profile
      'profile': 'Profile',
      'edit_profile': 'Edit Profile',
      'display_name': 'Display Name',
      'username': 'Username',
      'status': 'Status',
      'set_status': 'Set status',
      'available': 'Available',
      'busy': 'Busy',
      'away': 'Away',
      'do_not_disturb': 'Do not disturb',
      
      // Groups
      'create_group': 'Create Group',
      'group_name': 'Group Name',
      'add_participants': 'Add Participants',
      'group_info': 'Group Info',
      'leave_group': 'Leave Group',
      'admin': 'Admin',
      'members': 'Members',
      
      // Attachments
      'camera': 'Camera',
      'gallery': 'Gallery',
      'document': 'Document',
      'location': 'Location',
      'contact': 'Contact',
      'audio': 'Audio',
      
      // Notifications
      'message_notifications': 'Message Notifications',
      'group_notifications': 'Group Notifications',
      'call_notifications': 'Call Notifications',
      'vibration': 'Vibration',
      'sound': 'Sound',
      
      // Storage
      'clear_cache': 'Clear Cache',
      'cache_cleared': 'Cache cleared',
      'storage_usage': 'Storage Usage',
      'media_auto_download': 'Media Auto-Download',
      
      // Errors
      'error_loading': 'Failed to load',
      'error_sending': 'Failed to send',
      'error_connection': 'Connection error',
      'error_auth': 'Authentication error',
      'not_authenticated': 'Not authenticated',
      'chat_not_found': 'Chat not found',
    },
    
    'ru': {
      // Common
      'app_name': 'Fury Messenger',
      'ok': 'ОК',
      'cancel': 'Отмена',
      'save': 'Сохранить',
      'delete': 'Удалить',
      'edit': 'Редактировать',
      'retry': 'Повторить',
      'loading': 'Загрузка...',
      'error': 'Ошибка',
      'success': 'Успешно',
      'search': 'Поиск',
      'close': 'Закрыть',
      
      // Auth
      'login': 'Вход',
      'logout': 'Выйти',
      'logout_confirm': 'Вы уверены, что хотите выйти?',
      'register': 'Регистрация',
      'email': 'Электронная почта',
      'password': 'Пароль',
      'forgot_password': 'Забыли пароль?',
      'sign_in_with_google': 'Войти через Google',
      'create_account': 'Создать аккаунт',
      'already_have_account': 'Уже есть аккаунт?',
      'dont_have_account': 'Нет аккаунта?',
      
      // Chat
      'chats': 'Чаты',
      'chat': 'Чат',
      'no_chats': 'Нет чатов',
      'start_conversation': 'Начать разговор',
      'search_users': 'Поиск пользователей',
      'type_message': 'Введите сообщение',
      'no_messages': 'Нет сообщений',
      'send_first_message': 'Отправьте сообщение, чтобы начать разговор',
      'online': 'В сети',
      'offline': 'Не в сети',
      'last_seen': 'Был(а) в сети',
      'typing': 'печатает...',
      'delivered': 'Доставлено',
      'read': 'Прочитано',
      'sending': 'Отправка...',
      'message_deleted': 'Сообщение удалено',
      'reply': 'Ответить',
      'forward': 'Переслать',
      'copy': 'Копировать',
      'pin': 'Закрепить',
      'unpin': 'Открепить',
      
      // Calls
      'video_call': 'Видеозвонок',
      'voice_call': 'Голосовой звонок',
      'calling': 'Вызов...',
      'connecting': 'Подключение...',
      'ringing': 'Звонок...',
      'connected': 'Подключено',
      'call_ended': 'Звонок завершен',
      'end_call': 'Завершить',
      
      // Settings
      'settings': 'Настройки',
      'account': 'Аккаунт',
      'privacy_security': 'Конфиденциальность',
      'notifications': 'Уведомления',
      'storage_data': 'Данные и память',
      'app_settings': 'Настройки приложения',
      'language': 'Язык',
      'theme': 'Тема',
      'dark_mode': 'Тёмная тема',
      'light_mode': 'Светлая тема',
      'system_theme': 'Системная',
      'chat_settings': 'Настройки чата',
      'help': 'Помощь',
      'help_center': 'Центр помощи',
      'terms_privacy': 'Условия и политика',
      'about': 'О приложении',
      
      // Privacy
      'last_seen_privacy': 'Время последнего входа',
      'read_receipts': 'Отметки о прочтении',
      'online_status': 'Статус онлайн',
      'profile_photo': 'Фото профиля',
      'screenshot_notify': 'Уведомления о скриншотах',
      'blocked_users': 'Заблокированные',
      'everyone': 'Все',
      'contacts': 'Мои контакты',
      'nobody': 'Никто',
      
      // Profile
      'profile': 'Профиль',
      'edit_profile': 'Редактировать профиль',
      'display_name': 'Имя',
      'username': 'Имя пользователя',
      'status': 'Статус',
      'set_status': 'Установить статус',
      'available': 'Доступен',
      'busy': 'Занят',
      'away': 'Отошёл',
      'do_not_disturb': 'Не беспокоить',
      
      // Groups
      'create_group': 'Создать группу',
      'group_name': 'Название группы',
      'add_participants': 'Добавить участников',
      'group_info': 'Информация о группе',
      'leave_group': 'Покинуть группу',
      'admin': 'Админ',
      'members': 'Участники',
      
      // Attachments
      'camera': 'Камера',
      'gallery': 'Галерея',
      'document': 'Документ',
      'location': 'Местоположение',
      'contact': 'Контакт',
      'audio': 'Аудио',
      
      // Notifications
      'message_notifications': 'Уведомления о сообщениях',
      'group_notifications': 'Уведомления групп',
      'call_notifications': 'Уведомления о звонках',
      'vibration': 'Вибрация',
      'sound': 'Звук',
      
      // Storage
      'clear_cache': 'Очистить кэш',
      'cache_cleared': 'Кэш очищен',
      'storage_usage': 'Использование памяти',
      'media_auto_download': 'Автозагрузка медиа',
      
      // Errors
      'error_loading': 'Ошибка загрузки',
      'error_sending': 'Ошибка отправки',
      'error_connection': 'Ошибка соединения',
      'error_auth': 'Ошибка аутентификации',
      'not_authenticated': 'Не авторизован',
      'chat_not_found': 'Чат не найден',
    },
    
    'uz': {
      // Common
      'app_name': 'Fury Messenger',
      'ok': 'OK',
      'cancel': 'Bekor qilish',
      'save': 'Saqlash',
      'delete': "O'chirish",
      'edit': 'Tahrirlash',
      'retry': 'Qayta urinish',
      'loading': 'Yuklanmoqda...',
      'error': 'Xato',
      'success': 'Muvaffaqiyat',
      'search': 'Qidirish',
      'close': 'Yopish',
      
      // Auth
      'login': 'Kirish',
      'logout': 'Chiqish',
      'logout_confirm': 'Chiqishni xohlaysizmi?',
      'register': "Ro'yxatdan o'tish",
      'email': 'Email',
      'password': 'Parol',
      'forgot_password': 'Parolni unutdingizmi?',
      'sign_in_with_google': 'Google orqali kirish',
      'create_account': 'Hisob yaratish',
      'already_have_account': 'Hisobingiz bormi?',
      'dont_have_account': 'Hisobingiz yoʻqmi?',
      
      // Chat
      'chats': 'Chatlar',
      'chat': 'Chat',
      'no_chats': 'Chatlar yoʻq',
      'start_conversation': 'Suhbat boshlash',
      'search_users': 'Foydalanuvchilarni qidirish',
      'type_message': 'Xabar yozing',
      'no_messages': 'Xabarlar yoʻq',
      'send_first_message': 'Suhbatni boshlash uchun xabar yuboring',
      'online': 'Onlayn',
      'offline': 'Oflayn',
      'last_seen': 'Oxirgi marta',
      'typing': 'yozmoqda...',
      'delivered': 'Yetkazildi',
      'read': "O'qildi",
      'sending': 'Yuborilmoqda...',
      'message_deleted': "Xabar o'chirildi",
      'reply': 'Javob berish',
      'forward': 'Yuborish',
      'copy': 'Nusxalash',
      'pin': 'Biriktirish',
      'unpin': 'Ajratish',
      
      // Calls
      'video_call': 'Video qoʻngʻiroq',
      'voice_call': 'Ovozli qoʻngʻiroq',
      'calling': 'Qoʻngʻiroq...',
      'connecting': 'Ulanmoqda...',
      'ringing': 'Jiringlamoqda...',
      'connected': 'Ulandi',
      'call_ended': 'Qoʻngʻiroq tugadi',
      'end_call': 'Tugatish',
      
      // Settings
      'settings': 'Sozlamalar',
      'account': 'Hisob',
      'privacy_security': 'Maxfiylik',
      'notifications': 'Bildirishnomalar',
      'storage_data': "Ma'lumotlar",
      'app_settings': 'Ilova sozlamalari',
      'language': 'Til',
      'theme': 'Mavzu',
      'dark_mode': 'Tungi rejim',
      'light_mode': 'Kunduzgi rejim',
      'system_theme': 'Tizim',
      'chat_settings': 'Chat sozlamalari',
      'help': 'Yordam',
      'help_center': 'Yordam markazi',
      'terms_privacy': 'Shartlar va maxfiylik',
      'about': 'Haqida',
      
      // Privacy
      'last_seen_privacy': 'Oxirgi faollik',
      'read_receipts': "O'qish belgilari",
      'online_status': 'Onlayn holati',
      'profile_photo': 'Profil rasmi',
      'screenshot_notify': 'Skrinshot bildirishi',
      'blocked_users': 'Bloklangan',
      'everyone': 'Hamma',
      'contacts': 'Kontaktlarim',
      'nobody': 'Hech kim',
      
      // Profile
      'profile': 'Profil',
      'edit_profile': 'Profilni tahrirlash',
      'display_name': 'Ism',
      'username': 'Foydalanuvchi nomi',
      'status': 'Holat',
      'set_status': 'Holatni belgilash',
      'available': 'Mavjud',
      'busy': 'Band',
      'away': 'Uzoqda',
      'do_not_disturb': 'Bezovta qilmang',
      
      // Groups
      'create_group': 'Guruh yaratish',
      'group_name': 'Guruh nomi',
      'add_participants': "A'zolarni qo'shish",
      'group_info': "Guruh haqida",
      'leave_group': 'Guruhdan chiqish',
      'admin': 'Admin',
      'members': "A'zolar",
      
      // Attachments
      'camera': 'Kamera',
      'gallery': 'Galereya',
      'document': 'Hujjat',
      'location': 'Joylashuv',
      'contact': 'Kontakt',
      'audio': 'Audio',
      
      // Notifications
      'message_notifications': 'Xabar bildirishi',
      'group_notifications': 'Guruh bildirishi',
      'call_notifications': "Qo'ng'iroq bildirishi",
      'vibration': 'Tebranish',
      'sound': 'Tovush',
      
      // Storage
      'clear_cache': 'Keshni tozalash',
      'cache_cleared': 'Kesh tozalandi',
      'storage_usage': "Xotira ishlatilishi",
      'media_auto_download': 'Avtomatik yuklash',
      
      // Errors
      'error_loading': 'Yuklash xatosi',
      'error_sending': 'Yuborish xatosi',
      'error_connection': "Ulanish xatosi",
      'error_auth': 'Autentifikatsiya xatosi',
      'not_authenticated': 'Kiritmagan',
      'chat_not_found': 'Chat topilmadi',
    },
  };

  String _translate(String key) {
    return _translations[locale.languageCode]?[key] ??
        _translations['en']?[key] ??
        key;
  }

  // Getters for all translations
  String get appName => _translate('app_name');
  String get ok => _translate('ok');
  String get cancel => _translate('cancel');
  String get save => _translate('save');
  String get delete => _translate('delete');
  String get edit => _translate('edit');
  String get retry => _translate('retry');
  String get loading => _translate('loading');
  String get error => _translate('error');
  String get success => _translate('success');
  String get search => _translate('search');
  String get close => _translate('close');
  
  // Auth
  String get login => _translate('login');
  String get logout => _translate('logout');
  String get logoutConfirm => _translate('logout_confirm');
  String get register => _translate('register');
  String get email => _translate('email');
  String get password => _translate('password');
  String get forgotPassword => _translate('forgot_password');
  String get signInWithGoogle => _translate('sign_in_with_google');
  String get createAccount => _translate('create_account');
  String get alreadyHaveAccount => _translate('already_have_account');
  String get dontHaveAccount => _translate('dont_have_account');
  
  // Chat
  String get chats => _translate('chats');
  String get chat => _translate('chat');
  String get noChats => _translate('no_chats');
  String get startConversation => _translate('start_conversation');
  String get searchUsers => _translate('search_users');
  String get typeMessage => _translate('type_message');
  String get noMessages => _translate('no_messages');
  String get sendFirstMessage => _translate('send_first_message');
  String get online => _translate('online');
  String get offline => _translate('offline');
  String get lastSeen => _translate('last_seen');
  String get typing => _translate('typing');
  String get delivered => _translate('delivered');
  String get read => _translate('read');
  String get sending => _translate('sending');
  String get messageDeleted => _translate('message_deleted');
  String get reply => _translate('reply');
  String get forward => _translate('forward');
  String get copy => _translate('copy');
  String get pin => _translate('pin');
  String get unpin => _translate('unpin');
  
  // Settings
  String get settings => _translate('settings');
  String get account => _translate('account');
  String get privacySecurity => _translate('privacy_security');
  String get notifications => _translate('notifications');
  String get storageData => _translate('storage_data');
  String get appSettings => _translate('app_settings');
  String get language => _translate('language');
  String get theme => _translate('theme');
  String get darkMode => _translate('dark_mode');
  String get lightMode => _translate('light_mode');
  String get systemTheme => _translate('system_theme');
  String get chatSettings => _translate('chat_settings');
  String get help => _translate('help');
  String get helpCenter => _translate('help_center');
  String get termsPrivacy => _translate('terms_privacy');
  String get about => _translate('about');
  
  // Profile
  String get profile => _translate('profile');
  String get editProfile => _translate('edit_profile');
  String get displayName => _translate('display_name');
  String get username => _translate('username');
  String get status => _translate('status');
  String get setStatus => _translate('set_status');
  
  // Errors
  String get errorLoading => _translate('error_loading');
  String get errorSending => _translate('error_sending');
  String get errorConnection => _translate('error_connection');
  String get errorAuth => _translate('error_auth');
  String get notAuthenticated => _translate('not_authenticated');
  String get chatNotFound => _translate('chat_not_found');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ru', 'uz'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

/// Extension for easy access to translations
extension LocalizationsExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
