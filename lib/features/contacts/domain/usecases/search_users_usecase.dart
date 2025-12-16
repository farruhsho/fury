import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/contact_entity.dart';
import '../repositories/contact_repository.dart';

class SearchUsersUseCase {
  final ContactRepository repository;

  SearchUsersUseCase(this.repository);

  Future<Either<Failure, List<ContactEntity>>> call(String query) async {
    return await repository.searchUsers(query);
  }
}
