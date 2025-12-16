import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Use case for verifying OTP
class VerifyOTPUseCase {
  final AuthRepository repository;
  
  VerifyOTPUseCase(this.repository);
  
  Future<Either<Failure, UserEntity>> call({
    required String phoneNumber,
    required String verificationId,
    required String code,
  }) async {
    return await repository.verifyOTP(
      phoneNumber: phoneNumber,
      verificationId: verificationId,
      code: code,
    );
  }
}
