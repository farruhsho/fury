import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Service for managing starred/bookmarked messages
class StarredMessagesService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  StarredMessagesService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Star a message
  Future<void> starMessage({
    required String chatId,
    required String messageId,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('starred_messages')
        .doc(messageId)
        .set({
      'messageId': messageId,
      'chatId': chatId,
      'starredAt': FieldValue.serverTimestamp(),
    });

    print('⭐ [STARRED] Message starred: $messageId');
  }

  /// Unstar a message
  Future<void> unstarMessage(String messageId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('starred_messages')
        .doc(messageId)
        .delete();

    print('⭐ [STARRED] Message unstarred: $messageId');
  }

  /// Check if message is starred
  Future<bool> isStarred(String messageId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return false;

    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('starred_messages')
        .doc(messageId)
        .get();

    return doc.exists;
  }

  /// Listen to starred messages
  Stream<List<StarredMessageRef>> getStarredMessages() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('starred_messages')
        .orderBy('starredAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return StarredMessageRef(
          messageId: data['messageId'] as String,
          chatId: data['chatId'] as String,
          starredAt: (data['starredAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        );
      }).toList();
    });
  }

  /// Get starred messages with full message data
  Future<List<Map<String, dynamic>>> getStarredMessagesWithData() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];

    final starredSnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('starred_messages')
        .orderBy('starredAt', descending: true)
        .limit(100)
        .get();

    final result = <Map<String, dynamic>>[];

    for (final doc in starredSnapshot.docs) {
      final data = doc.data();
      final chatId = data['chatId'] as String;
      final messageId = data['messageId'] as String;

      try {
        final messageDoc = await _firestore
            .collection('chats')
            .doc(chatId)
            .collection('messages')
            .doc(messageId)
            .get();

        if (messageDoc.exists) {
          result.add({
            'starredRef': data,
            'message': messageDoc.data(),
          });
        }
      } catch (e) {
        print('⚠️ [STARRED] Error fetching message: $e');
      }
    }

    return result;
  }

  /// Toggle star status
  Future<bool> toggleStar({
    required String chatId,
    required String messageId,
  }) async {
    final isCurrentlyStarred = await isStarred(messageId);
    
    if (isCurrentlyStarred) {
      await unstarMessage(messageId);
      return false;
    } else {
      await starMessage(chatId: chatId, messageId: messageId);
      return true;
    }
  }
}

class StarredMessageRef {
  final String messageId;
  final String chatId;
  final DateTime starredAt;

  StarredMessageRef({
    required this.messageId,
    required this.chatId,
    required this.starredAt,
  });
}
