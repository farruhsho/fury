import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/chat_entity.dart';
import '../repositories/chat_repository.dart';

class CreateChatUseCase {
  final ChatRepository repository;

  CreateChatUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required List<String> participantIds,
    required ChatType type,
    String? groupName,
  }) async {
    return await repository.createChat(
      participantIds: participantIds,
      type: type,
      groupName: groupName,
    );
  }
}
