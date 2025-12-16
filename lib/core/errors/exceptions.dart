/// Custom exceptions for the application
class ServerException implements Exception {
  final String message;
  final int? statusCode;
  
  const ServerException({
    required this.message,
    this.statusCode,
  });
  
  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

class CacheException implements Exception {
  final String message;
  
  const CacheException({required this.message});
  
  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String message;
  
  const NetworkException({required this.message});
  
  @override
  String toString() => 'NetworkException: $message';
}

class AuthException implements Exception {
  final String message;
  final String? code;
  
  const AuthException({
    required this.message,
    this.code,
  });
  
  @override
  String toString() => 'AuthException: $message (Code: $code)';
}

class ValidationException implements Exception {
  final String message;
  final Map<String, dynamic>? errors;
  
  const ValidationException({
    required this.message,
    this.errors,
  });
  
  @override
  String toString() => 'ValidationException: $message';
}

class PermissionException implements Exception {
  final String message;
  final String permission;
  
  const PermissionException({
    required this.message,
    required this.permission,
  });
  
  @override
  String toString() => 'PermissionException: $message (Permission: $permission)';
}

class FileException implements Exception {
  final String message;
  final String? filePath;
  
  const FileException({
    required this.message,
    this.filePath,
  });
  
  @override
  String toString() => 'FileException: $message';
}

class EncryptionException implements Exception {
  final String message;
  
  const EncryptionException({required this.message});
  
  @override
  String toString() => 'EncryptionException: $message';
}
