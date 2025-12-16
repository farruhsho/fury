import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/chat_entity.dart';
import '../repositories/chat_repository.dart';

class GetChatsUseCase {
  final ChatRepository repository;

  GetChatsUseCase(this.repository);

  Stream<Either<Failure, List<ChatEntity>>> call() {
    return repository.getChats();
  }
}
