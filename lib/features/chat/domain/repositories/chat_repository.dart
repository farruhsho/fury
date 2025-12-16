import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/chat_entity.dart';
import '../entities/message_entity.dart';
import 'dart:io';

abstract class ChatRepository {
  /// Get list of chats
  Stream<Either<Failure, List<ChatEntity>>> getChats();

  /// Get messages for a specific chat
  Stream<Either<Failure, List<MessageEntity>>> getMessages(String chatId);

  /// Send a text message
  Future<Either<Failure, void>> sendMessage({
    required String chatId,
    required String text,
    String? replyToId,
  });

  /// Send an attachment message
  Future<Either<Failure, void>> sendAttachmentMessage({
    required String chatId,
    required File file,
    required AttachmentType type,
    String? replyToId,
  });

  /// Create a new chat (private or group)
  Future<Either<Failure, String>> createChat({
    required List<String> participantIds,
    required ChatType type,
    String? groupName,
  });

  /// Mark messages as read
  Future<Either<Failure, void>> markMessagesAsRead(String chatId);

  /// Edit a message
  Future<Either<Failure, void>> editMessage({
    required String chatId,
    required String messageId,
    required String newText,
  });

  /// Delete a message
  Future<Either<Failure, void>> deleteMessage({
    required String chatId,
    required String messageId,
    bool deleteForEveryone = false,
  });

  /// React to a message
  Future<Either<Failure, void>> reactToMessage({
    required String chatId,
    required String messageId,
    required String emoji,
  });

  /// Search messages in a chat
  Future<Either<Failure, List<MessageEntity>>> searchMessages({
    required String chatId,
    required String query,
  });

  /// Retry sending a failed message
  Future<void> retryMessage(String messageId);
}
