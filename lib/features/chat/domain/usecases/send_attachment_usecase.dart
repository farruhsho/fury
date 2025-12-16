import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/chat_repository.dart';
import '../entities/message_entity.dart'; // For AttachmentType

class SendAttachmentUseCase {
  final ChatRepository repository;

  SendAttachmentUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String chatId,
    required File file,
    required AttachmentType type,
    String? replyToId,
  }) async {
    return await repository.sendAttachmentMessage(
      chatId: chatId,
      file: file,
      type: type,
      replyToId: replyToId,
    );
  }
}
