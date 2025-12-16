import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/chat_repository.dart';

class DeleteMessageUseCase {
  final ChatRepository repository;

  DeleteMessageUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String chatId,
    required String messageId,
    bool deleteForEveryone = false,
  }) async {
    return await repository.deleteMessage(
      chatId: chatId,
      messageId: messageId,
      deleteForEveryone: deleteForEveryone,
    );
  }
}
