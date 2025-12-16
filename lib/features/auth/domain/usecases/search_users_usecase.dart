import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Use case for searching users by username
class SearchUsersUseCase {
  final AuthRepository repository;

  SearchUsersUseCase(this.repository);

  Future<Either<Failure, List<UserEntity>>> call(String query) async {
    return await repository.searchUsers(query);
  }
}
