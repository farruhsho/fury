import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// Service for organizing chats into folders/labels
class ChatFoldersService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  // Default system folders
  static const List<ChatFolder> defaultFolders = [
    ChatFolder(id: 'all', name: 'All Chats', icon: 'chat', isSystem: true, order: 0),
    ChatFolder(id: 'unread', name: 'Unread', icon: 'mark_chat_unread', isSystem: true, order: 1),
    ChatFolder(id: 'groups', name: 'Groups', icon: 'group', isSystem: true, order: 2),
    ChatFolder(id: 'channels', name: 'Channels', icon: 'campaign', isSystem: true, order: 3),
    ChatFolder(id: 'bots', name: 'Bots', icon: 'smart_toy', isSystem: true, order: 4),
  ];

  ChatFoldersService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Get all folders for current user
  Stream<List<ChatFolder>> getFolders() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value(defaultFolders);

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('chat_folders')
        .orderBy('order')
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return defaultFolders;
      }
      return snapshot.docs.map((doc) => ChatFolder.fromFirestore(doc)).toList();
    });
  }

  /// Create a new folder
  Future<String> createFolder({
    required String name,
    String icon = 'folder',
    String? color,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('Not authenticated');

    // Get current max order
    final existing = await _firestore
        .collection('users')
        .doc(userId)
        .collection('chat_folders')
        .orderBy('order', descending: true)
        .limit(1)
        .get();

    final maxOrder = existing.docs.isEmpty 
        ? defaultFolders.length 
        : (existing.docs.first.data()['order'] as int) + 1;

    final docRef = await _firestore
        .collection('users')
        .doc(userId)
        .collection('chat_folders')
        .add({
      'name': name,
      'icon': icon,
      'color': color,
      'isSystem': false,
      'order': maxOrder,
      'chatIds': [],
      'createdAt': FieldValue.serverTimestamp(),
    });

    debugPrint('📁 [FOLDERS] Created folder: ${docRef.id} - $name');
    return docRef.id;
  }

  /// Add chat to folder
  Future<void> addChatToFolder(String folderId, String chatId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('chat_folders')
        .doc(folderId)
        .update({
      'chatIds': FieldValue.arrayUnion([chatId]),
    });

    debugPrint('📁 [FOLDERS] Added chat $chatId to folder $folderId');
  }

  /// Remove chat from folder
  Future<void> removeChatFromFolder(String folderId, String chatId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('chat_folders')
        .doc(folderId)
        .update({
      'chatIds': FieldValue.arrayRemove([chatId]),
    });
  }

  /// Delete a folder
  Future<void> deleteFolder(String folderId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('chat_folders')
        .doc(folderId)
        .delete();

    debugPrint('📁 [FOLDERS] Deleted folder: $folderId');
  }

  /// Rename folder
  Future<void> renameFolder(String folderId, String newName) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('chat_folders')
        .doc(folderId)
        .update({'name': newName});
  }

  /// Reorder folders
  Future<void> reorderFolders(List<String> folderIds) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final batch = _firestore.batch();
    
    for (int i = 0; i < folderIds.length; i++) {
      final docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('chat_folders')
          .doc(folderIds[i]);
      batch.update(docRef, {'order': i});
    }

    await batch.commit();
  }

  /// Get chats in a specific folder
  Future<List<String>> getChatsInFolder(String folderId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];

    // Handle system folders
    if (folderId == 'all') {
      return []; // Return all chats
    }

    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('chat_folders')
        .doc(folderId)
        .get();

    if (!doc.exists) return [];
    return List<String>.from(doc.data()?['chatIds'] ?? []);
  }

  /// Initialize default folders for new user
  Future<void> initializeDefaultFolders() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final existing = await _firestore
        .collection('users')
        .doc(userId)
        .collection('chat_folders')
        .get();

    if (existing.docs.isNotEmpty) return; // Already initialized

    final batch = _firestore.batch();
    
    for (final folder in defaultFolders) {
      final docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('chat_folders')
          .doc(folder.id);
      
      batch.set(docRef, {
        'name': folder.name,
        'icon': folder.icon,
        'isSystem': folder.isSystem,
        'order': folder.order,
        'chatIds': [],
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    await batch.commit();
    debugPrint('📁 [FOLDERS] Initialized default folders');
  }
}

class ChatFolder {
  final String id;
  final String name;
  final String icon;
  final String? color;
  final bool isSystem;
  final int order;
  final List<String> chatIds;

  const ChatFolder({
    required this.id,
    required this.name,
    this.icon = 'folder',
    this.color,
    this.isSystem = false,
    this.order = 0,
    this.chatIds = const [],
  });

  factory ChatFolder.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatFolder(
      id: doc.id,
      name: data['name'] as String,
      icon: data['icon'] as String? ?? 'folder',
      color: data['color'] as String?,
      isSystem: data['isSystem'] as bool? ?? false,
      order: data['order'] as int? ?? 0,
      chatIds: List<String>.from(data['chatIds'] ?? []),
    );
  }

  int get chatCount => chatIds.length;
}
