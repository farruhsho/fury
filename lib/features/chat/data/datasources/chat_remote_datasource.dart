import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/errors/exceptions.dart';
import '../../data/models/chat_model.dart';
import '../../data/models/message_model.dart';
import '../../domain/entities/chat_entity.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;
import '../../../../core/services/file_upload_service.dart';

class ChatRemoteDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final FileUploadService _fileUploadService;

  ChatRemoteDatasource({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
    FileUploadService? fileUploadService,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance,
        _fileUploadService = fileUploadService ?? FileUploadService();

  Stream<List<ChatModel>> getChats() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw const AuthException(message: 'User not authenticated');

    print('🔥 [DATASOURCE] Getting chats for user: $userId');
    
    // Simple query without compound index requirement
    // We filter client-side to avoid needing a composite index
    return _firestore
        .collection('chats')
        .orderBy('updatedAt', descending: true)
        .limit(100)
        .snapshots()
        .map((snapshot) {
      print('🔥 [DATASOURCE] Received ${snapshot.docs.length} total chat documents');
      
      // Filter for chats where user is a participant
      final userChats = snapshot.docs.where((doc) {
        final data = doc.data();
        final participantIds = data['participantIds'] as List<dynamic>?;
        return participantIds?.contains(userId) ?? false;
      }).toList();
      
      print('🔥 [DATASOURCE] Filtered to ${userChats.length} chats for current user');
      
      final chats = userChats.map((doc) {
        try {
          return ChatModel.fromFirestore(doc);
        } catch (e, stackTrace) {
          print('🔥 [DATASOURCE] Error parsing chat ${doc.id}: $e');
          print('🔥 [DATASOURCE] Stack: $stackTrace');
          rethrow;
        }
      }).toList();
      print('🔥 [DATASOURCE] Successfully parsed ${chats.length} chats');
      return chats;
    }).handleError((error, stackTrace) {
      print('❌ [DATASOURCE] Chat stream error: $error');
      print('❌ [DATASOURCE] Stack: $stackTrace');
      throw error;
    });
  }

  Stream<List<MessageModel>> getMessages(String chatId) {
    print('🔥 [DATASOURCE] Setting up messages stream for chat: $chatId');
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      print('🔥 [DATASOURCE] Received ${snapshot.docs.length} documents from Firestore');
      final messages = snapshot.docs.map((doc) {
        try {
          return MessageModel.fromFirestore(doc);
        } catch (e) {
          print('🔥 [DATASOURCE] Error parsing message ${doc.id}: $e');
          rethrow;
        }
      }).toList();
      print('🔥 [DATASOURCE] Parsed ${messages.length} messages');
      return messages;
    });
  }

  Future<void> sendMessage({
    required String chatId,
    required MessageModel message,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw const AuthException(message: 'User not authenticated');

    print('📤 [DATASOURCE] Sending message ${message.id} to chat $chatId');
    
    // Create message with 'sent' status for Firestore
    final messageToSend = message.copyWith(status: MessageStatus.sent);
    
    final batch = _firestore.batch();

    // Add message to messages subcollection
    final messageRef = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(message.id);
    
    batch.set(messageRef, messageToSend.toJson());

    // Update chat document with last message and updated time
    final chatRef = _firestore.collection('chats').doc(chatId);
    batch.update(chatRef, {
      'lastMessage': messageToSend.toJson(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    await batch.commit();
    print('✅ [DATASOURCE] Message sent successfully');
  }

  Future<void> sendAttachmentMessage({
    required String chatId,
    required File file,
    required AttachmentType type,
    String? replyToId,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw const AuthException(message: 'User not authenticated');

    // Upload file
    String downloadUrl;
    switch (type) {
      case AttachmentType.image:
        downloadUrl = await _fileUploadService.uploadImage(file: file);
        break;
      case AttachmentType.video:
        downloadUrl = await _fileUploadService.uploadVideo(file: file);
        break;
      case AttachmentType.audio:
        downloadUrl = await _fileUploadService.uploadAudio(file: file);
        break;
      case AttachmentType.document:
        downloadUrl = await _fileUploadService.uploadDocument(file: file);
        break;
    }

    // Create message
    final messageId = const Uuid().v4();
    final message = MessageModel(
      id: messageId,
      chatId: chatId,
      senderId: userId,
      type: _mapAttachmentTypeToMessageType(type),
      createdAt: DateTime.now(),
      attachments: [
        AttachmentModel(
          id: const Uuid().v4(),
          url: downloadUrl,
          localPath: file.path,
          type: type,
          mimeType: 'application/octet-stream', // TODO: Get real mime type
          size: await file.length(),
          fileName: path.basename(file.path),
          uploadStatus: UploadStatus.completed,
        ),
      ],
      replyTo: null, // TODO: Handle replyToId
    );

    await sendMessage(chatId: chatId, message: message);
  }

  MessageType _mapAttachmentTypeToMessageType(AttachmentType type) {
    switch (type) {
      case AttachmentType.image:
        return MessageType.image;
      case AttachmentType.video:
        return MessageType.video;
      case AttachmentType.audio:
        return MessageType.audio;
      case AttachmentType.document:
        return MessageType.document;
    }
  }

  Future<String> createChat({
    required List<String> participantIds,
    required ChatType type,
    String? groupName,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw const AuthException(message: 'User not authenticated');

    if (!participantIds.contains(userId)) {
      participantIds.add(userId);
    }

    // Check if private chat already exists
    if (type == ChatType.private) {
      final querySnapshot = await _firestore
          .collection('chats')
          .where('type', isEqualTo: 'private')
          .where('participantIds', arrayContains: userId)
          .get();

      for (final doc in querySnapshot.docs) {
        final data = doc.data();
        final ids = List<String>.from(data['participantIds']);
        if (ids.length == 2 && ids.contains(participantIds.firstWhere((id) => id != userId))) {
          return doc.id;
        }
      }
    }

    // Fetch participant data from users collection
    final participantsMap = <String, Map<String, dynamic>>{};
    for (final participantId in participantIds) {
      try {
        final userDoc = await _firestore.collection('users').doc(participantId).get();
        if (userDoc.exists) {
          final userData = userDoc.data()!;
          participantsMap[participantId] = {
            'userId': participantId,
            'displayName': userData['displayName'] ?? userData['username'] ?? 'Unknown',
            'avatarUrl': userData['avatarUrl'],
            'isOnline': userData['isOnline'] ?? false,
            'lastSeen': userData['lastSeen'],
          };
        }
      } catch (e) {
        print('Error fetching user $participantId: $e');
        // Add minimal data if fetch fails
        participantsMap[participantId] = {
          'userId': participantId,
          'displayName': 'User',
          'avatarUrl': null,
          'isOnline': false,
          'lastSeen': null,
        };
      }
    }

    // Create new chat
    final chatRef = _firestore.collection('chats').doc();
    final chatData = {
      'id': chatRef.id,
      'type': type == ChatType.private ? 'private' : type == ChatType.group ? 'group' : 'channel',
      'participantIds': participantIds,
      'participants': participantsMap,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'unreadCount': 0,
    };

    if (groupName != null) {
      chatData['name'] = groupName;
      chatData['groupInfo'] = {
        'name': groupName,
        'createdBy': userId,
        'createdAt': FieldValue.serverTimestamp(),
      };
    }

    await chatRef.set(chatData);
    return chatRef.id;
  }

  Future<void> markMessagesAsRead(String chatId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw const AuthException(message: 'User not authenticated');

    // Update unread count for current user to 0
    await _firestore.collection('chats').doc(chatId).update({
      'unreadCounts.$userId': 0,
    });
    
    // Get unread messages (not sent by current user, not yet read by current user)
    final messagesSnapshot = await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where('senderId', isNotEqualTo: userId)
        .orderBy('senderId')
        .orderBy('createdAt', descending: true)
        .limit(50)
        .get();
    
    if (messagesSnapshot.docs.isEmpty) return;
    
    // Use batched writes for efficiency
    final batch = _firestore.batch();
    final now = DateTime.now().toIso8601String();
    
    for (final doc in messagesSnapshot.docs) {
      final data = doc.data();
      final readBy = Map<String, dynamic>.from(data['readBy'] ?? {});
      
      // Skip if already read by this user
      if (readBy.containsKey(userId)) continue;
      
      // Update readBy and status
      batch.update(doc.reference, {
        'readBy.$userId': now,
        'status': 'read',
      });
    }
    
    await batch.commit();
    print('✅ [DATASOURCE] Marked ${messagesSnapshot.docs.length} messages as read');
  }

  Future<void> editMessage({
    required String chatId,
    required String messageId,
    required String newText,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw const AuthException(message: 'User not authenticated');

    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .update({
      'text': newText,
      'isEdited': true,
      'editedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteMessage({
    required String chatId,
    required String messageId,
    required bool deleteForEveryone,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw const AuthException(message: 'User not authenticated');

    if (deleteForEveryone) {
      // Delete for everyone
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(messageId)
          .update({
        'isDeleted': true,
        'text': 'This message was deleted',
        'deletedAt': FieldValue.serverTimestamp(),
      });
    } else {
      // Delete for me only
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(messageId)
          .update({
        'deletedBy': FieldValue.arrayUnion([userId]),
      });
    }
  }

  Future<void> reactToMessage({
    required String chatId,
    required String messageId,
    required String emoji,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw const AuthException(message: 'User not authenticated');

    final messageRef = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId);

    final doc = await messageRef.get();
    if (!doc.exists) throw const ServerException(message: 'Message not found');

    final data = doc.data()!;
    final reactions = List<Map<String, dynamic>>.from(data['reactions'] ?? []);

    // Check if user already reacted with this emoji
    final existingIndex = reactions.indexWhere(
      (r) => r['userId'] == userId && r['emoji'] == emoji,
    );

    if (existingIndex != -1) {
      // Remove reaction
      reactions.removeAt(existingIndex);
    } else {
      // Add reaction
      reactions.add({
        'userId': userId,
        'emoji': emoji,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    await messageRef.update({'reactions': reactions});
  }

  Future<List<MessageModel>> searchMessages({
    required String chatId,
    required String query,
  }) async {
    final snapshot = await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where('text', isGreaterThanOrEqualTo: query)
        .where('text', isLessThanOrEqualTo: '$query\uf8ff')
        .limit(50)
        .get();

    return snapshot.docs.map((doc) => MessageModel.fromFirestore(doc)).toList();
  }
}

