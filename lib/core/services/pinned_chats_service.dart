import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Service for managing pinned chats
class PinnedChatsService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  static const int maxPinnedChats = 5;

  PinnedChatsService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Pin a chat
  Future<bool> pinChat(String chatId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return false;

    final pinnedChats = await getPinnedChats();
    
    // Check limit
    if (pinnedChats.length >= maxPinnedChats) {
      return false; // Can't pin more than limit
    }

    // Already pinned
    if (pinnedChats.contains(chatId)) return true;

    await _firestore.collection('users').doc(userId).update({
      'pinnedChats': FieldValue.arrayUnion([chatId]),
      'pinnedChatOrder.$chatId': FieldValue.serverTimestamp(),
    });

    print('📌 [PINNED] Chat pinned: $chatId');
    return true;
  }

  /// Unpin a chat
  Future<void> unpinChat(String chatId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore.collection('users').doc(userId).update({
      'pinnedChats': FieldValue.arrayRemove([chatId]),
      'pinnedChatOrder.$chatId': FieldValue.delete(),
    });

    print('📌 [PINNED] Chat unpinned: $chatId');
  }

  /// Check if chat is pinned
  Future<bool> isPinned(String chatId) async {
    final pinnedChats = await getPinnedChats();
    return pinnedChats.contains(chatId);
  }

  /// Get list of pinned chat IDs
  Future<List<String>> getPinnedChats() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];

    final doc = await _firestore.collection('users').doc(userId).get();
    if (!doc.exists) return [];

    final data = doc.data();
    return List<String>.from(data?['pinnedChats'] ?? []);
  }

  /// Listen to pinned chats
  Stream<List<String>> listenToPinnedChats() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) return <String>[];
      return List<String>.from(snapshot.data()?['pinnedChats'] ?? []);
    });
  }

  /// Toggle pin status
  Future<bool> togglePin(String chatId) async {
    final isPinnedNow = await isPinned(chatId);
    
    if (isPinnedNow) {
      await unpinChat(chatId);
      return false;
    } else {
      return await pinChat(chatId);
    }
  }

  /// Reorder pinned chats
  Future<void> reorderPinnedChats(List<String> newOrder) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore.collection('users').doc(userId).update({
      'pinnedChats': newOrder,
    });
  }
}
