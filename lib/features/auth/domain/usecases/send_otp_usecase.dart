import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

/// Use case for sending OTP
class SendOTPUseCase {
  final AuthRepository repository;
  
  SendOTPUseCase(this.repository);
  
  Future<Either<Failure, String>> call(String phoneNumber) async {
    return await repository.sendOTP(phoneNumber);
  }
}
