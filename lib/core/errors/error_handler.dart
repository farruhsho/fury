import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'exceptions.dart';
import 'failures.dart';

/// Global error handler for converting exceptions to failures
class ErrorHandler {
  /// Convert exception to Failure
  static Failure handleException(dynamic error) {
    if (error is ServerException) {
      return Failure.server(
        message: error.message,
        statusCode: error.statusCode,
      );
    } else if (error is CacheException) {
      return Failure.cache(message: error.message);
    } else if (error is NetworkException) {
      return Failure.network(message: error.message);
    } else if (error is AuthException) {
      return Failure.auth(
        message: error.message,
        code: error.code,
      );
    } else if (error is ValidationException) {
      return Failure.validation(
        message: error.message,
        errors: error.errors,
      );
    } else if (error is PermissionException) {
      return Failure.permission(
        message: error.message,
        permission: error.permission,
      );
    } else if (error is FileException) {
      return Failure.file(
        message: error.message,
        filePath: error.filePath,
      );
    } else if (error is EncryptionException) {
      return Failure.encryption(message: error.message);
    } else if (error is DioException) {
      return _handleDioError(error);
    } else if (error is firebase_auth.FirebaseAuthException) {
      return _handleFirebaseAuthError(error);
    } else if (error is SocketException) {
      return const Failure.network(
        message: 'No internet connection. Please check your network.',
      );
    } else {
      return Failure.unknown(
        message: error.toString(),
      );
    }
  }
  
  /// Handle Dio errors
  static Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure.network(
          message: 'Connection timeout. Please try again.',
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message'] ?? 
                       error.response?.statusMessage ?? 
                       'Server error occurred';
        return Failure.server(
          message: message,
          statusCode: statusCode,
        );
      case DioExceptionType.cancel:
        return const Failure.unknown(
          message: 'Request was cancelled',
        );
      case DioExceptionType.connectionError:
        return const Failure.network(
          message: 'No internet connection',
        );
      default:
        return Failure.unknown(
          message: error.message ?? 'Unknown error occurred',
        );
    }
  }
  
  /// Handle Firebase Auth errors
  static Failure _handleFirebaseAuthError(firebase_auth.FirebaseAuthException error) {
    String message;
    
    switch (error.code) {
      case 'user-not-found':
        message = 'No user found with this phone number';
        break;
      case 'wrong-password':
        message = 'Invalid verification code';
        break;
      case 'invalid-verification-code':
        message = 'Invalid verification code';
        break;
      case 'invalid-verification-id':
        message = 'Invalid verification ID';
        break;
      case 'session-expired':
        message = 'Verification session expired. Please try again';
        break;
      case 'quota-exceeded':
        message = 'SMS quota exceeded. Please try again later';
        break;
      case 'invalid-phone-number':
        message = 'Invalid phone number format';
        break;
      case 'missing-phone-number':
        message = 'Phone number is required';
        break;
      case 'network-request-failed':
        message = 'Network error. Please check your connection';
        break;
      case 'too-many-requests':
        message = 'Too many requests. Please try again later';
        break;
      default:
        message = error.message ?? 'Authentication error occurred';
    }
    
    return Failure.auth(
      message: message,
      code: error.code,
    );
  }
  
  /// Get user-friendly error message
  static String getUserMessage(Failure failure) {
    return failure.when(
      server: (message, statusCode) {
        if (statusCode == 401) {
          return 'Session expired. Please login again';
        } else if (statusCode == 403) {
          return 'You don\'t have permission to perform this action';
        } else if (statusCode == 404) {
          return 'Resource not found';
        } else if (statusCode != null && statusCode >= 500) {
          return 'Server error. Please try again later';
        }
        return message;
      },
      cache: (message) => 'Local storage error: $message',
      network: (message) => message,
      auth: (message, _) => message,
      validation: (message, _) => message,
      permission: (message, permission) => message,
      file: (message, _) => message,
      encryption: (message) => 'Encryption error: $message',
      unknown: (message) => 'An unexpected error occurred',
    );
  }
}
