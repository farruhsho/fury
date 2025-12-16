import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/chat_repository.dart';

class ReactToMessageUseCase {
  final ChatRepository repository;

  ReactToMessageUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String chatId,
    required String messageId,
    required String emoji,
  }) async {
    return await repository.reactToMessage(
      chatId: chatId,
      messageId: messageId,
      emoji: emoji,
    );
  }
}
