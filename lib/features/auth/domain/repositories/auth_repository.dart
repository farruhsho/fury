import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

/// Authentication repository interface
abstract class AuthRepository {
  // ===== Email/Password Authentication =====

  /// Register with email and password
  Future<Either<Failure, UserEntity>> registerWithEmail({
    required String email,
    required String password,
    required String username,
    String? displayName,
  });

  /// Sign in with email and password
  Future<Either<Failure, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  });

  // ===== Google Sign-In =====

  /// Sign in with Google
  Future<Either<Failure, UserEntity>> signInWithGoogle();

  // ===== Phone Authentication (for future) =====

  /// Send OTP to phone number
  Future<Either<Failure, String>> sendOTP(String phoneNumber);

  /// Verify OTP code
  Future<Either<Failure, UserEntity>> verifyOTP({
    required String phoneNumber,
    required String verificationId,
    required String code,
  });

  // ===== User Management =====

  /// Get current user
  Future<Either<Failure, UserEntity?>> getCurrentUser();

  /// Update user profile
  Future<Either<Failure, UserEntity>> updateProfile({
    String? displayName,
    String? username,
    String? bio,
    String? avatarUrl,
  });

  /// Sign out
  Future<Either<Failure, void>> signOut();

  /// Delete account
  Future<Either<Failure, void>> deleteAccount();

  /// Check if user is authenticated
  Future<bool> isAuthenticated();
  
  /// Search users by username
  Future<Either<Failure, List<UserEntity>>> searchUsers(String query);
}
