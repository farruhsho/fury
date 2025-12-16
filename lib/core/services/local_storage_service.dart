import 'package:hive_flutter/hive_flutter.dart';
import '../constants/storage_keys.dart';

/// Local storage service using Hive
class LocalStorageService {
  static const String _messagesBox = 'messages';
  static const String _chatsBox = 'chats';
  static const String _usersBox = 'users';
  static const String _settingsBox = 'settings';
  
  late Box<dynamic> _messagesBoxInstance;
  late Box<dynamic> _chatsBoxInstance;
  late Box<dynamic> _usersBoxInstance;
  late Box<dynamic> _settingsBoxInstance;
  
  /// Initialize all boxes
  Future<void> init() async {
    _messagesBoxInstance = await Hive.openBox(_messagesBox);
    _chatsBoxInstance = await Hive.openBox(_chatsBox);
    _usersBoxInstance = await Hive.openBox(_usersBox);
    _settingsBoxInstance = await Hive.openBox(_settingsBox);
  }
  
  // Messages
  Future<void> saveMessage(String chatId, String messageId, Map<String, dynamic> message) async {
    final key = '${chatId}_$messageId';
    await _messagesBoxInstance.put(key, message);
  }
  
  Map<String, dynamic>? getMessage(String chatId, String messageId) {
    final key = '${chatId}_$messageId';
    return _messagesBoxInstance.get(key) as Map<String, dynamic>?;
  }
  
  List<Map<String, dynamic>> getMessages(String chatId) {
    final messages = <Map<String, dynamic>>[];
    for (final key in _messagesBoxInstance.keys) {
      if (key.toString().startsWith('${chatId}_')) {
        final message = _messagesBoxInstance.get(key);
        if (message != null) {
          messages.add(Map<String, dynamic>.from(message as Map));
        }
      }
    }
    return messages;
  }
  
  Future<void> deleteMessage(String chatId, String messageId) async {
    final key = '${chatId}_$messageId';
    await _messagesBoxInstance.delete(key);
  }
  
  Future<void> clearMessages(String chatId) async {
    final keysToDelete = <dynamic>[];
    for (final key in _messagesBoxInstance.keys) {
      if (key.toString().startsWith('${chatId}_')) {
        keysToDelete.add(key);
      }
    }
    await _messagesBoxInstance.deleteAll(keysToDelete);
  }
  
  // Chats
  Future<void> saveChat(String chatId, Map<String, dynamic> chat) async {
    await _chatsBoxInstance.put(chatId, chat);
  }
  
  Map<String, dynamic>? getChat(String chatId) {
    return _chatsBoxInstance.get(chatId) as Map<String, dynamic>?;
  }
  
  List<Map<String, dynamic>> getAllChats() {
    return _chatsBoxInstance.values
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
  }
  
  Future<void> deleteChat(String chatId) async {
    await _chatsBoxInstance.delete(chatId);
    await clearMessages(chatId);
  }
  
  // Users
  Future<void> saveUser(String userId, Map<String, dynamic> user) async {
    await _usersBoxInstance.put(userId, user);
  }
  
  Map<String, dynamic>? getUser(String userId) {
    return _usersBoxInstance.get(userId) as Map<String, dynamic>?;
  }
  
  // Settings
  Future<void> saveSetting(String key, dynamic value) async {
    await _settingsBoxInstance.put(key, value);
  }
  
  T? getSetting<T>(String key) {
    return _settingsBoxInstance.get(key) as T?;
  }
  
  Future<void> deleteSetting(String key) async {
    await _settingsBoxInstance.delete(key);
  }
  
  // Theme
  Future<void> saveThemeMode(String mode) async {
    await saveSetting(StorageKeys.themeMode, mode);
  }
  
  String? getThemeMode() {
    return getSetting<String>(StorageKeys.themeMode);
  }
  
  // Language
  Future<void> saveLanguage(String language) async {
    await saveSetting(StorageKeys.language, language);
  }
  
  String? getLanguage() {
    return getSetting<String>(StorageKeys.language);
  }
  
  // Clear all data
  Future<void> clearAll() async {
    await _messagesBoxInstance.clear();
    await _chatsBoxInstance.clear();
    await _usersBoxInstance.clear();
    await _settingsBoxInstance.clear();
  }
  
  // Close all boxes
  Future<void> close() async {
    await _messagesBoxInstance.close();
    await _chatsBoxInstance.close();
    await _usersBoxInstance.close();
    await _settingsBoxInstance.close();
  }
}
