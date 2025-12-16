import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/contact_entity.dart';

abstract class ContactRepository {
  /// Get all contacts
  Stream<Either<Failure, List<ContactEntity>>> getContacts();

  /// Search users by phone number or username
  Future<Either<Failure, List<ContactEntity>>> searchUsers(String query);

  /// Add a contact
  Future<Either<Failure, void>> addContact(String userId);

  /// Remove a contact
  Future<Either<Failure, void>> removeContact(String contactId);

  /// Block a contact
  Future<Either<Failure, void>> blockContact(String contactId);

  /// Unblock a contact
  Future<Either<Failure, void>> unblockContact(String contactId);

  /// Get blocked contacts
  Future<Either<Failure, List<ContactEntity>>> getBlockedContacts();

  /// Sync contacts from phone
  Future<Either<Failure, List<ContactEntity>>> syncPhoneContacts(
    List<String> phoneNumbers,
  );
}
