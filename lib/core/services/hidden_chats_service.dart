import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Service for managing hidden/archived chats
class HiddenChatsService {
  static final HiddenChatsService _instance = HiddenChatsService._internal();
  factory HiddenChatsService() => _instance;
  HiddenChatsService._internal();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _hiddenChatsPinKey = 'hidden_chats_pin';
  static const String _hiddenChatsKey = 'hidden_chat_ids';

  /// Set PIN for hidden chats folder
  Future<void> setPin(String pin) async {
    await _secureStorage.write(key: _hiddenChatsPinKey, value: pin);
  }

  /// Verify hidden chats PIN
  Future<bool> verifyPin(String pin) async {
    final storedPin = await _secureStorage.read(key: _hiddenChatsPinKey);
    return storedPin == pin;
  }

  /// Check if hidden chats PIN is set
  Future<bool> hasPinSet() async {
    final pin = await _secureStorage.read(key: _hiddenChatsPinKey);
    return pin != null && pin.isNotEmpty;
  }

  /// Remove PIN for hidden chats
  Future<void> removePin() async {
    await _secureStorage.delete(key: _hiddenChatsPinKey);
  }

  /// Hide a chat
  Future<void> hideChat(String chatId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('settings')
        .doc('hidden_chats')
        .set({
      'chatIds': FieldValue.arrayUnion([chatId]),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  /// Unhide a chat
  Future<void> unhideChat(String chatId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('settings')
        .doc('hidden_chats')
        .update({
      'chatIds': FieldValue.arrayRemove([chatId]),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Get list of hidden chat IDs
  Future<List<String>> getHiddenChatIds() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return [];

    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('settings')
        .doc('hidden_chats')
        .get();

    if (!doc.exists) return [];
    final data = doc.data();
    return List<String>.from(data?['chatIds'] ?? []);
  }

  /// Check if a chat is hidden
  Future<bool> isChatHidden(String chatId) async {
    final hiddenIds = await getHiddenChatIds();
    return hiddenIds.contains(chatId);
  }

  /// Get hidden chats stream
  Stream<List<String>> getHiddenChatsStream() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('settings')
        .doc('hidden_chats')
        .snapshots()
        .map((doc) {
      if (!doc.exists) return <String>[];
      final data = doc.data();
      return List<String>.from(data?['chatIds'] ?? []);
    });
  }
}
