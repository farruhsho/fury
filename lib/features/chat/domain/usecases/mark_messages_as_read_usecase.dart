import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/chat_repository.dart';

class MarkMessagesAsReadUseCase {
  final ChatRepository repository;

  MarkMessagesAsReadUseCase(this.repository);

  Future<Either<Failure, void>> call(String chatId) async {
    return await repository.markMessagesAsRead(chatId);
  }
}
