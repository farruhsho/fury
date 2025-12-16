import '../../../../core/services/secure_storage_service.dart';
import '../models/user_model.dart';

/// Local datasource for authentication
class AuthLocalDatasource {
  final SecureStorageService _secureStorage;

  AuthLocalDatasource(this._secureStorage);
  
  /// Cache user
  Future<void> cacheUser(UserModel user) async {
    await _secureStorage.write('cached_user', user.toJson().toString());
  }
  
  /// Get cached user
  Future<UserModel?> getCachedUser() async {
    final userJson = await _secureStorage.read('cached_user');
    if (userJson == null) return null;
    
    // Parse JSON string back to UserModel
    // Note: In production, use proper JSON parsing
    return null; // TODO: Implement proper JSON parsing
  }
  
  /// Clear cached user
  Future<void> clearCachedUser() async {
    await _secureStorage.delete('cached_user');
  }
}
