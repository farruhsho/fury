import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Use case for registering with email and password
class RegisterWithEmailUseCase {
  final AuthRepository repository;

  RegisterWithEmailUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
    required String username,
    String? displayName,
  }) async {
    return await repository.registerWithEmail(
      email: email,
      password: password,
      username: username,
      displayName: displayName,
    );
  }
}
