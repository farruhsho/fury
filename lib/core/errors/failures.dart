import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Base failure class using Freezed for immutability
@freezed
class Failure with _$Failure {
  const factory Failure.server({
    required String message,
    int? statusCode,
  }) = ServerFailure;
  
  const factory Failure.cache({
    required String message,
  }) = CacheFailure;
  
  const factory Failure.network({
    required String message,
  }) = NetworkFailure;
  
  const factory Failure.auth({
    required String message,
    String? code,
  }) = AuthFailure;
  
  const factory Failure.validation({
    required String message,
    Map<String, dynamic>? errors,
  }) = ValidationFailure;
  
  const factory Failure.permission({
    required String message,
    required String permission,
  }) = PermissionFailure;
  
  const factory Failure.file({
    required String message,
    String? filePath,
  }) = FileFailure;
  
  const factory Failure.encryption({
    required String message,
  }) = EncryptionFailure;
  
  const factory Failure.unknown({
    required String message,
  }) = UnknownFailure;
}

extension FailureX on Failure {
  String get errorMessage {
    return when(
      server: (message, _) => message,
      cache: (message) => message,
      network: (message) => message,
      auth: (message, _) => message,
      validation: (message, _) => message,
      permission: (message, _) => message,
      file: (message, _) => message,
      encryption: (message) => message,
      unknown: (message) => message,
    );
  }
}
