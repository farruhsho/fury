import 'package:dartz/dartz.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/contact_entity.dart';
import '../../domain/repositories/contact_repository.dart';
import '../datasources/contact_remote_datasource.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactRemoteDatasource remoteDatasource;

  ContactRepositoryImpl({required this.remoteDatasource});

  @override
  Stream<Either<Failure, List<ContactEntity>>> getContacts() {
    return remoteDatasource.getContacts().map<Either<Failure, List<ContactEntity>>>((models) {
      try {
        final entities = models
            .map((model) => ContactEntity(
                  id: model.id,
                  userId: model.userId,
                  displayName: model.displayName,
                  phoneNumber: model.phoneNumber,
                  username: model.username,
                  avatarUrl: model.avatarUrl,
                  bio: model.bio,
                  isOnline: model.isOnline,
                  lastSeen: model.lastSeen,
                  isBlocked: model.isBlocked,
                  addedAt: model.addedAt,
                ))
            .toList();
        return Right(entities);
      } catch (e) {
        return Left(ErrorHandler.handleException(e));
      }
    }).handleError((error) {
      return Stream.value(Left(ErrorHandler.handleException(error)));
    });
  }

  @override
  Future<Either<Failure, List<ContactEntity>>> searchUsers(String query) async {
    try {
      final models = await remoteDatasource.searchUsers(query);
      final entities = models
          .map((model) => ContactEntity(
                id: model.id,
                userId: model.userId,
                displayName: model.displayName,
                phoneNumber: model.phoneNumber,
                username: model.username,
                avatarUrl: model.avatarUrl,
                bio: model.bio,
                isOnline: model.isOnline,
                lastSeen: model.lastSeen,
                isBlocked: model.isBlocked,
                addedAt: model.addedAt,
              ))
          .toList();
      return Right(entities);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> addContact(String userId) async {
    try {
      await remoteDatasource.addContact(userId);
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> removeContact(String contactId) async {
    try {
      await remoteDatasource.removeContact(contactId);
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> blockContact(String contactId) async {
    try {
      await remoteDatasource.blockContact(contactId);
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> unblockContact(String contactId) async {
    try {
      await remoteDatasource.unblockContact(contactId);
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<ContactEntity>>> getBlockedContacts() async {
    try {
      final models = await remoteDatasource.getBlockedContacts();
      final entities = models
          .map((model) => ContactEntity(
                id: model.id,
                userId: model.userId,
                displayName: model.displayName,
                phoneNumber: model.phoneNumber,
                username: model.username,
                avatarUrl: model.avatarUrl,
                bio: model.bio,
                isOnline: model.isOnline,
                lastSeen: model.lastSeen,
                isBlocked: model.isBlocked,
                addedAt: model.addedAt,
              ))
          .toList();
      return Right(entities);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<ContactEntity>>> syncPhoneContacts(
    List<String> phoneNumbers,
  ) async {
    try {
      final models = await remoteDatasource.syncPhoneContacts(phoneNumbers);
      final entities = models
          .map((model) => ContactEntity(
                id: model.id,
                userId: model.userId,
                displayName: model.displayName,
                phoneNumber: model.phoneNumber,
                username: model.username,
                avatarUrl: model.avatarUrl,
                bio: model.bio,
                isOnline: model.isOnline,
                lastSeen: model.lastSeen,
                isBlocked: model.isBlocked,
                addedAt: model.addedAt,
              ))
          .toList();
      return Right(entities);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }
}
