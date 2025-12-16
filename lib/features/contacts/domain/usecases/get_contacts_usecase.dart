import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/contact_entity.dart';
import '../repositories/contact_repository.dart';

class GetContactsUseCase {
  final ContactRepository repository;

  GetContactsUseCase(this.repository);

  Stream<Either<Failure, List<ContactEntity>>> call() {
    return repository.getContacts();
  }
}
