import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/contact_repository.dart';

class AddContactUseCase {
  final ContactRepository repository;

  AddContactUseCase(this.repository);

  Future<Either<Failure, void>> call(String userId) async {
    return await repository.addContact(userId);
  }
}
