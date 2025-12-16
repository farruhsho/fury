import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/storage_keys.dart';

/// Secure storage service for sensitive data
class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );
  
  // Authentication tokens
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: StorageKeys.accessToken, value: token);
  }
  
  Future<String?> getAccessToken() async {
    return await _storage.read(key: StorageKeys.accessToken);
  }
  
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: StorageKeys.refreshToken, value: token);
  }
  
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: StorageKeys.refreshToken);
  }
  
  Future<void> deleteTokens() async {
    await _storage.delete(key: StorageKeys.accessToken);
    await _storage.delete(key: StorageKeys.refreshToken);
  }
  
  // User ID
  Future<void> saveUserId(String userId) async {
    await _storage.write(key: StorageKeys.userId, value: userId);
  }
  
  Future<String?> getUserId() async {
    return await _storage.read(key: StorageKeys.userId);
  }
  
  // Encryption keys
  Future<void> savePrivateKey(String key) async {
    await _storage.write(key: StorageKeys.privateKey, value: key);
  }
  
  Future<String?> getPrivateKey() async {
    return await _storage.read(key: StorageKeys.privateKey);
  }
  
  Future<void> savePublicKey(String key) async {
    await _storage.write(key: StorageKeys.publicKey, value: key);
  }
  
  Future<String?> getPublicKey() async {
    return await _storage.read(key: StorageKeys.publicKey);
  }
  
  Future<void> saveEncryptionSalt(String salt) async {
    await _storage.write(key: StorageKeys.encryptionSalt, value: salt);
  }
  
  Future<String?> getEncryptionSalt() async {
    return await _storage.read(key: StorageKeys.encryptionSalt);
  }
  
  // Device tokens
  Future<void> saveFcmToken(String token) async {
    await _storage.write(key: StorageKeys.fcmToken, value: token);
  }
  
  Future<String?> getFcmToken() async {
    return await _storage.read(key: StorageKeys.fcmToken);
  }
  
  Future<void> saveVoipToken(String token) async {
    await _storage.write(key: StorageKeys.voipToken, value: token);
  }
  
  Future<String?> getVoipToken() async {
    return await _storage.read(key: StorageKeys.voipToken);
  }
  
  // Generic methods
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
  
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }
  
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
  
  Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }
  
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
  
  // Check if key exists
  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }
}
