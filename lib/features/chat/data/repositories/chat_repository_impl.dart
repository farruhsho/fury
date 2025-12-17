import 'package:dartz/dartz.dart';
import 'dart:async';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart' hide MessageType, MessageStatus, AttachmentType;
import '../../domain/entities/message_entity.dart' as entity show MessageType, MessageStatus, AttachmentType;
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasource.dart';
import '../../data/models/chat_model.dart';
import '../../data/models/message_model.dart' as model show MessageType, MessageStatus, AttachmentType;
import '../../data/models/message_model.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../../core/services/offline_queue_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDatasource remoteDatasource;
  final OfflineQueueService offlineQueueService;

  ChatRepositoryImpl({
    required this.remoteDatasource,
    required this.offlineQueueService,
  });

  @override
  Stream<Either<Failure, List<ChatEntity>>> getChats() {
    print('💬 [REPOSITORY] Getting chats stream...');
    return remoteDatasource.getChats().map<Either<Failure, List<ChatEntity>>>((models) {
      try {
        print('💬 [REPOSITORY] Received ${models.length} chat models');
        final entities = models.map((model) => _mapChatToEntity(model)).toList();
        print('💬 [REPOSITORY] Mapped to ${entities.length} chat entities');
        return Right(entities);
      } catch (e) {
        print('❌ [REPOSITORY] Error mapping chats: $e');
        return Left(ErrorHandler.handleException(e));
      }
    }).handleError((error) {
      print('❌ [REPOSITORY] Chat stream error: $error');
      return Stream.value(Left(ErrorHandler.handleException(error)));
    });
  }

  @override
  Stream<Either<Failure, List<MessageEntity>>> getMessages(String chatId) {
    print('📥 [REPOSITORY] Getting messages stream for chat: $chatId');
    
    // Create a controller to merge streams
    // We can't use rxdart, so we manually combine the latest values
    final controller = StreamController<Either<Failure, List<MessageEntity>>>();
    
    List<MessageEntity> lastRemoteMessages = [];
    List<MessageEntity> lastOfflineMessages = [];
    bool hasRemoteData = false;
    
    // subscription management handled by the controller's onCancel
    StreamSubscription? remoteSub;
    StreamSubscription? offlineSub;
    
    void emitCombined() {
      // Filter offline messages for this chat
      final relevantOfflineMessages = lastOfflineMessages
          .where((m) => m.chatId == chatId)
          .toList();
          
      // Combine and sort
      final allMessages = [...relevantOfflineMessages, ...lastRemoteMessages];
      allMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Descending
      
      controller.add(Right(allMessages));
    }
    
    controller.onListen = () {
      // 1. Listen to Remote Messages
      remoteSub = remoteDatasource.getMessages(chatId).listen(
        (models) {
          try {
            final currentUserId = FirebaseAuth.instance.currentUser?.uid;
            
            // Filter messages deleted by current user
            final filteredModels = models.where((m) {
              if (currentUserId == null) return true;
              return !m.deletedBy.contains(currentUserId);
            }).toList();
            
            lastRemoteMessages = filteredModels.map((model) => _mapMessageToEntity(model)).toList();
            hasRemoteData = true;
            emitCombined();
          } catch (e) {
            print('❌ [REPOSITORY] Error mapping messages: $e');
            controller.add(Left(ErrorHandler.handleException(e)));
          }
        },
        onError: (error) {
          print('❌ [REPOSITORY] Stream error: $error');
          controller.add(Left(ErrorHandler.handleException(error)));
        },
      );
      
      // 2. Listen to Offline Queue
      offlineSub = offlineQueueService.queueStream.listen(
        (queueItems) {
          try {
            lastOfflineMessages = queueItems.map((item) => _mapQueueItemToEntity(item)).toList();
            // Emit even if we don't have remote data yet (show pending immediately)
            emitCombined();
          } catch (e) {
            print('❌ [REPOSITORY] Error mapping offline messages: $e');
          }
        },
      );
    };
    
    controller.onCancel = () {
      remoteSub?.cancel();
      offlineSub?.cancel();
      controller.close();
    };
    
    return controller.stream;
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required String chatId,
    required String text,
    String? replyToId,
  }) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return const Left(Failure.auth(message: 'User not authenticated'));
      }

      // Check connectivity
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        await offlineQueueService.addMessage(
          chatId: chatId,
          text: text,
          senderId: currentUser.uid,
          replyToId: replyToId,
        );
        return const Right(null);
      }

      final message = MessageModel(
        id: const Uuid().v4(),
        chatId: chatId,
        senderId: currentUser.uid,
        type: MessageType.text,
        text: text,
        createdAt: DateTime.now(),
        replyTo: replyToId != null ? null : null, // Reply handling deferred
        status: MessageStatus.sending,
      );

      await remoteDatasource.sendMessage(
        chatId: chatId,
        message: message,
      );
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> sendAttachmentMessage({
    required String chatId,
    required File file,
    required entity.AttachmentType type,
    String? replyToId,
  }) async {
    try {
      await remoteDatasource.sendAttachmentMessage(
        chatId: chatId,
        file: file,
        type: model.AttachmentType.values[type.index],
        replyToId: replyToId,
      );
      return const Right(null);
    } catch (e) {
      // Check connectivity or if error is network related
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        try {
          await offlineQueueService.addAttachmentMessage(
            chatId: chatId,
            filePath: file.path,
            attachmentType: type,
            replyToId: replyToId,
          );
          return const Right(null); // Optimistic success
        } catch (queueError) {
          return Left(ErrorHandler.handleException(queueError));
        }
      }
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, String>> createChat({
    required List<String> participantIds,
    required ChatType type,
    String? groupName,
  }) async {
    try {
      final chatId = await remoteDatasource.createChat(
        participantIds: participantIds,
        type: type,
        groupName: groupName,
      );
      return Right(chatId);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> markMessagesAsRead(String chatId) async {
    try {
      await remoteDatasource.markMessagesAsRead(chatId);
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  // Mappers
  ChatEntity _mapChatToEntity(ChatModel model) {
    // Get current user ID
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    
    // Determine the chat name
    String? chatName;
    String? chatImageUrl;
    
    if (model.type == ChatType.private && currentUserId != null) {
      // For private chats, get the other participant's info
      if (model.participants.isNotEmpty) {
        final otherParticipantEntry = model.participants.entries.firstWhere(
          (entry) => entry.key != currentUserId,
          orElse: () => model.participants.entries.first,
        );
        chatName = otherParticipantEntry.value.displayName;
        chatImageUrl = otherParticipantEntry.value.avatarUrl;
        print('💬 [REPOSITORY] Private chat ${model.id}: name="$chatName"');
      } else {
        print('⚠️ [REPOSITORY] Private chat ${model.id} has no participants data');
      }
    } else {
      // For group chats, use group info first, then fall back to direct name field
      chatName = model.groupInfo?.name ?? model.name;
      chatImageUrl = model.groupInfo?.avatarUrl ?? model.avatarUrl;
      print('💬 [REPOSITORY] Group chat ${model.id}: name="$chatName"');
    }
    
    // Get unread count for current user
    final unreadCount = currentUserId != null 
        ? (model.unreadCounts[currentUserId] ?? 0) 
        : 0;
    
    return ChatEntity(
      id: model.id,
      type: model.type,
      participantIds: model.participantIds,
      participants: model.participants.map((key, value) => MapEntry(key, _mapParticipantToEntity(value))),
      lastMessage: model.lastMessage != null ? _mapMessageToEntity(model.lastMessage!) : null,
      unreadCount: unreadCount,
      name: chatName,
      imageUrl: chatImageUrl,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  ChatParticipantEntity _mapParticipantToEntity(ParticipantInfo model) {
    return ChatParticipantEntity(
      userId: model.userId,
      displayName: model.displayName,
      avatarUrl: model.avatarUrl,
      isOnline: model.isOnline,
      lastSeen: model.lastSeen,
    );
  }

  MessageEntity _mapMessageToEntity(MessageModel model) {
    return MessageEntity(
      id: model.id,
      chatId: model.chatId,
      senderId: model.senderId,
      type: _mapMessageType(model.type),
      text: model.text,
      attachments: model.attachments?.map((e) => _mapAttachmentToEntity(e)).toList(),
      replyTo: model.replyTo != null ? _mapMessageToEntity(model.replyTo!) : null,
      forwardedFrom: model.forwardedFrom,
      reactions: model.reactions.map((e) => _mapReactionToEntity(e)).toList(),
      status: _mapMessageStatus(model.status),
      isPinned: model.isPinned,
      createdAt: model.createdAt,
      editedAt: model.editedAt,
      deletedAt: model.deletedAt,
    );
  }

  AttachmentEntity _mapAttachmentToEntity(AttachmentModel model) {
    return AttachmentEntity(
      id: model.id,
      url: model.url,
      type: _mapAttachmentType(model.type),
      thumbnailUrl: model.thumbnailUrl,
      fileName: model.fileName,
      size: model.size,
    );
  }

  ReactionEntity _mapReactionToEntity(ReactionModel model) {
    return ReactionEntity(
      emoji: model.emoji,
      userId: model.userId,
      createdAt: model.createdAt,
    );
  }

  @override
  Future<Either<Failure, void>> editMessage({
    required String chatId,
    required String messageId,
    required String newText,
  }) async {
    try {
      await remoteDatasource.editMessage(
        chatId: chatId,
        messageId: messageId,
        newText: newText,
      );
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessage({
    required String chatId,
    required String messageId,
    bool deleteForEveryone = false,
  }) async {
    try {
      if (deleteForEveryone) {
        await remoteDatasource.deleteMessage(
          chatId: chatId,
          messageId: messageId,
          deleteForEveryone: true,
        );
      } else {
        // Delete for me - add user ID to deletedBy
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          await FirebaseFirestore.instance
              .collection('chats')
              .doc(chatId)
              .collection('messages')
              .doc(messageId)
              .update({
            'deletedBy': FieldValue.arrayUnion([userId]),
          });
        }
      }
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> reactToMessage({
    required String chatId,
    required String messageId,
    required String emoji,
  }) async {
    try {
      await remoteDatasource.reactToMessage(
        chatId: chatId,
        messageId: messageId,
        emoji: emoji,
      );
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> searchMessages({
    required String chatId,
    required String query,
  }) async {
    try {
      final messages = await remoteDatasource.searchMessages(
        chatId: chatId,
        query: query,
      );
      final entities = messages.map((model) => _mapMessageToEntity(model)).toList();
      return Right(entities);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<void> retryMessage(String messageId) async {
    await offlineQueueService.retryMessage(messageId);
  }

  // Mappers
  MessageEntity _mapQueueItemToEntity(Map<String, dynamic> item) {
    final statusStr = item['status'] as String? ?? 'sending';
    final status = statusStr == 'failed' 
        ? entity.MessageStatus.failed 
        : entity.MessageStatus.sending;
        
    final typeStr = item['type'] as String;
    entity.MessageType type = entity.MessageType.text;
    List<AttachmentEntity>? attachments;
    
    if (typeStr == 'attachment') {
      final typeIndex = item['attachmentTypeIndex'] as int;
      final attType = entity.AttachmentType.values[typeIndex];
      // Map attType to message type
      switch (attType) {
        case entity.AttachmentType.image: type = entity.MessageType.image; break;
        case entity.AttachmentType.video: type = entity.MessageType.video; break;
        case entity.AttachmentType.audio: type = entity.MessageType.audio; break;
        case entity.AttachmentType.document: type = entity.MessageType.document; break;
      }
      
      attachments = [
        AttachmentEntity(
          id: const Uuid().v4(),
          url: '', // Local file, no URL
          type: attType,
          thumbnailUrl: null,
          fileName: item['id'], // Placeholder
          size: 0,
        )
      ];
    }
    
    return MessageEntity(
      id: item['id'],
      chatId: item['chatId'],
      senderId: item['senderId'] ?? FirebaseAuth.instance.currentUser?.uid ?? '',
      type: type,
      text: item['text'],
      attachments: attachments,
      replyTo: null, // Basic support for now
      status: status,
      createdAt: DateTime.parse(item['timestamp']),
      isPinned: false,
      reactions: [],
    );
  }
  entity.MessageType _mapMessageType(model.MessageType type) {
    return entity.MessageType.values[type.index];
  }

  entity.MessageStatus _mapMessageStatus(model.MessageStatus status) {
    return entity.MessageStatus.values[status.index];
  }

  entity.AttachmentType _mapAttachmentType(model.AttachmentType type) {
    return entity.AttachmentType.values[type.index];
  }
}
