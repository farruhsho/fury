import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String chatId,
    required String text,
    String? replyToId,
  }) async {
    return await repository.sendMessage(
      chatId: chatId,
      text: text,
      replyToId: replyToId,
    );
  }
}
