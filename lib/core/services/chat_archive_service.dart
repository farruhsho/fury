import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// Service for archiving and unarchiving chats
class ChatArchiveService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ChatArchiveService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Archive a chat
  Future<void> archiveChat(String chatId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore.collection('users').doc(userId).update({
      'archivedChats': FieldValue.arrayUnion([chatId]),
      'archiveTimestamps.$chatId': DateTime.now().toIso8601String(),
    });

    debugPrint('📦 [ARCHIVE] Chat archived: $chatId');
  }

  /// Unarchive a chat
  Future<void> unarchiveChat(String chatId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore.collection('users').doc(userId).update({
      'archivedChats': FieldValue.arrayRemove([chatId]),
      'archiveTimestamps.$chatId': FieldValue.delete(),
    });

    debugPrint('📦 [ARCHIVE] Chat unarchived: $chatId');
  }

  /// Check if chat is archived
  Future<bool> isArchived(String chatId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return false;

    final doc = await _firestore.collection('users').doc(userId).get();
    if (!doc.exists) return false;

    final archivedChats = List<String>.from(doc.data()?['archivedChats'] ?? []);
    return archivedChats.contains(chatId);
  }

  /// Get list of archived chat IDs
  Future<List<String>> getArchivedChats() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];

    final doc = await _firestore.collection('users').doc(userId).get();
    if (!doc.exists) return [];

    return List<String>.from(doc.data()?['archivedChats'] ?? []);
  }

  /// Listen to archived chats
  Stream<List<String>> listenToArchivedChats() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) return <String>[];
      return List<String>.from(snapshot.data()?['archivedChats'] ?? []);
    });
  }

  /// Toggle archive status
  Future<bool> toggleArchive(String chatId) async {
    final isArchivedNow = await isArchived(chatId);
    
    if (isArchivedNow) {
      await unarchiveChat(chatId);
      return false;
    } else {
      await archiveChat(chatId);
      return true;
    }
  }

  /// Get archive count
  Future<int> getArchiveCount() async {
    final archived = await getArchivedChats();
    return archived.length;
  }
}
