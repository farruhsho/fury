import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/chat_repository.dart';

class RetryMessageUseCase {
  final ChatRepository repository;

  RetryMessageUseCase(this.repository);

  Future<Either<Failure, void>> call(String messageId) async {
    try {
      await repository.retryMessage(messageId);
      return const Right(null);
    } catch (e) {
      return Left(Failure.server(message: e.toString()));
    }
  }
}
