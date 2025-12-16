import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/auth_local_datasource.dart';

/// Implementation of AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final AuthLocalDatasource localDatasource;

  AuthRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  // ===== Email/Password Authentication =====

  @override
  Future<Either<Failure, UserEntity>> registerWithEmail({
    required String email,
    required String password,
    required String username,
    String? displayName,
  }) async {
    try {
      final userModel = await remoteDatasource.registerWithEmail(
        email: email,
        password: password,
        username: username,
        displayName: displayName,
      );

      // Cache user locally
      await localDatasource.cacheUser(userModel);

      // Convert to entity
      return Right(_userModelToEntity(userModel));
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await remoteDatasource.signInWithEmail(
        email: email,
        password: password,
      );

      // Cache user locally
      await localDatasource.cacheUser(userModel);

      // Convert to entity
      return Right(_userModelToEntity(userModel));
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  // ===== Google Sign-In =====

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final userModel = await remoteDatasource.signInWithGoogle();

      // Cache user locally
      await localDatasource.cacheUser(userModel);

      // Convert to entity
      return Right(_userModelToEntity(userModel));
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  // ===== Phone Authentication =====

  @override
  Future<Either<Failure, String>> sendOTP(String phoneNumber) async {
    try {
      final verificationId = await remoteDatasource.sendOTP(phoneNumber);
      return Right(verificationId);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }
  
  @override
  Future<Either<Failure, UserEntity>> verifyOTP({
    required String phoneNumber,
    required String verificationId,
    required String code,
  }) async {
    try {
      final userModel = await remoteDatasource.verifyOTP(
        phoneNumber: phoneNumber,
        verificationId: verificationId,
        code: code,
      );
      
      // Cache user locally
      await localDatasource.cacheUser(userModel);
      
      // Convert to entity
      final userEntity = UserEntity(
        id: userModel.id,
        phoneNumber: userModel.phoneNumber,
        username: userModel.username,
        displayName: userModel.displayName,
        bio: userModel.bio,
        avatarUrl: userModel.avatarUrl,
        isOnline: userModel.isOnline,
        lastSeen: userModel.lastSeen,
      );
      
      return Right(userEntity);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }
  
  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      print('📦 [REPOSITORY] Getting current user...');
      final userModel = await remoteDatasource.getCurrentUser();
      
      if (userModel == null) {
        print('ℹ️ [REPOSITORY] No user model returned - user is unauthenticated');
        return const Right(null);
      }
      
      print('✅ [REPOSITORY] User model retrieved, converting to entity');
      final userEntity = UserEntity(
        id: userModel.id,
        phoneNumber: userModel.phoneNumber,
        username: userModel.username,
        displayName: userModel.displayName,
        bio: userModel.bio,
        avatarUrl: userModel.avatarUrl,
        isOnline: userModel.isOnline,
        lastSeen: userModel.lastSeen,
      );
      
      return Right(userEntity);
    } catch (e) {
      // IMPORTANT: Treat any error as "unauthenticated" instead of blocking the app
      // This prevents the app from hanging on connection errors
      print('⚠️ [REPOSITORY] Error getting current user: $e');
      print('ℹ️ [REPOSITORY] Treating as unauthenticated (returning null)');
      return const Right(null);
    }
  }
  
  @override
  Future<Either<Failure, UserEntity>> updateProfile({
    String? displayName,
    String? username,
    String? bio,
    String? avatarUrl,
  }) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      
      if (currentUser == null) {
        return const Left(Failure.auth(message: 'No user signed in'));
      }
      
      final userModel = await remoteDatasource.updateProfile(
        userId: currentUser.uid,
        displayName: displayName,
        username: username,
        bio: bio,
        avatarUrl: avatarUrl,
      );
      
      final userEntity = UserEntity(
        id: userModel.id,
        phoneNumber: userModel.phoneNumber,
        username: userModel.username,
        displayName: userModel.displayName,
        bio: userModel.bio,
        avatarUrl: userModel.avatarUrl,
        isOnline: userModel.isOnline,
        lastSeen: userModel.lastSeen,
      );
      
      return Right(userEntity);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }
  
  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDatasource.signOut();
      await localDatasource.clearCachedUser();
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }
  
  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await remoteDatasource.deleteAccount();
      await localDatasource.clearCachedUser();
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }
  
  @override
  Future<bool> isAuthenticated() async {
    return FirebaseAuth.instance.currentUser != null;
  }
  
  @override
  Future<Either<Failure, List<UserEntity>>> searchUsers(String query) async {
    try {
      print('📦 [REPOSITORY] Searching users with query: $query');
      final userModels = await remoteDatasource.searchUsers(query);
      
      final userEntities = userModels.map((model) => UserEntity(
        id: model.id,
        email: model.email,
        phoneNumber: model.phoneNumber,
        username: model.username,
        displayName: model.displayName,
        bio: model.bio,
        avatarUrl: model.avatarUrl,
        isOnline: model.isOnline,
        lastSeen: model.lastSeen,
      )).toList();
      
      print('✅ [REPOSITORY] Returning ${userEntities.length} users');
      return Right(userEntities);
    } catch (e) {
      print('❌ [REPOSITORY] Error searching users: $e');
      return Left(ErrorHandler.handleException(e));
    }
  }

  // ===== Helper Methods =====

  /// Convert UserModel to UserEntity
  UserEntity _userModelToEntity(userModel) {
    return UserEntity(
      id: userModel.id,
      email: userModel.email,
      phoneNumber: userModel.phoneNumber,
      username: userModel.username,
      displayName: userModel.displayName,
      bio: userModel.bio,
      avatarUrl: userModel.avatarUrl,
      isOnline: userModel.isOnline,
      lastSeen: userModel.lastSeen,
    );
  }
}
