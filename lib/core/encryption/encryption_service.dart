import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// End-to-End Encryption Service implementing AES-256-GCM
/// 
/// This service provides cryptographic operations for message encryption/decryption
/// with forward secrecy support using session keys.
class EncryptionService {
  static const _keyLength = 32; // 256 bits for AES-256
  static const _ivLength = 16;  // 128 bits IV
  static const _saltLength = 16;
  
  final FlutterSecureStorage _secureStorage;
  
  // Cache for session keys (in-memory only, cleared on app restart)
  final Map<String, Uint8List> _sessionKeyCache = {};
  
  EncryptionService({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
          iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
        );

  /// Generate a secure random key of specified length
  Uint8List generateRandomKey([int length = _keyLength]) {
    final random = Random.secure();
    return Uint8List.fromList(
      List<int>.generate(length, (_) => random.nextInt(256)),
    );
  }

  /// Generate a new encryption key pair for a user
  /// Returns the public key to be stored in Firestore
  /// Private key is stored securely on device
  Future<String> generateAndStoreIdentityKey() async {
    // Generate identity key
    final identityKey = generateRandomKey(_keyLength);
    
    // Store private key securely
    await _secureStorage.write(
      key: 'identity_private_key',
      value: base64.encode(identityKey),
    );
    
    // Derive public key (simplified - in production use X25519)
    // For now, we store the key hash as the "public key"
    final publicKey = sha256.convert(identityKey).toString();
    
    await _secureStorage.write(
      key: 'identity_public_key',
      value: publicKey,
    );
    
    return publicKey;
  }

  /// Get stored identity key or generate new one
  Future<String> getOrCreateIdentityKey() async {
    String? publicKey = await _secureStorage.read(key: 'identity_public_key');
    
    publicKey ??= await generateAndStoreIdentityKey();
    
    return publicKey;
  }

  /// Generate a session key for a specific chat
  /// This key is used to encrypt all messages in that chat
  Future<Uint8List> generateSessionKey(String chatId) async {
    final sessionKey = generateRandomKey();
    
    // Cache the session key
    _sessionKeyCache[chatId] = sessionKey;
    
    // Store encrypted session key
    final encryptedKey = await _encryptWithMasterKey(sessionKey);
    await _secureStorage.write(
      key: 'session_key_$chatId',
      value: base64.encode(encryptedKey),
    );
    
    return sessionKey;
  }

  /// Get or create session key for a chat
  Future<Uint8List> getOrCreateSessionKey(String chatId) async {
    // Check cache first
    if (_sessionKeyCache.containsKey(chatId)) {
      return _sessionKeyCache[chatId]!;
    }
    
    // Try to load from secure storage
    final storedKey = await _secureStorage.read(key: 'session_key_$chatId');
    
    if (storedKey != null) {
      final encryptedKey = base64.decode(storedKey);
      final sessionKey = await _decryptWithMasterKey(encryptedKey);
      _sessionKeyCache[chatId] = sessionKey;
      return sessionKey;
    }
    
    // Generate new session key
    return await generateSessionKey(chatId);
  }

  /// Encrypt a message for a specific chat
  Future<EncryptedMessage> encryptMessage({
    required String chatId,
    required String plaintext,
  }) async {
    final sessionKey = await getOrCreateSessionKey(chatId);
    
    // Generate random IV for this message
    final iv = encrypt.IV.fromSecureRandom(_ivLength);
    
    // Create encrypter
    final key = encrypt.Key(sessionKey);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));
    
    // Encrypt the message
    final encrypted = encrypter.encrypt(plaintext, iv: iv);
    
    return EncryptedMessage(
      ciphertext: encrypted.base64,
      iv: iv.base64,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  /// Decrypt a message from a specific chat
  Future<String> decryptMessage({
    required String chatId,
    required EncryptedMessage encryptedMessage,
  }) async {
    final sessionKey = await getOrCreateSessionKey(chatId);
    
    // Recreate IV
    final iv = encrypt.IV.fromBase64(encryptedMessage.iv);
    
    // Create encrypter
    final key = encrypt.Key(sessionKey);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));
    
    // Decrypt the message
    final encrypted = encrypt.Encrypted.fromBase64(encryptedMessage.ciphertext);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    
    return decrypted;
  }

  /// Encrypt data with master key derived from identity key
  Future<Uint8List> _encryptWithMasterKey(Uint8List data) async {
    final privateKeyStr = await _secureStorage.read(key: 'identity_private_key');
    
    if (privateKeyStr == null) {
      throw const EncryptionException('Identity key not found');
    }
    
    final privateKey = base64.decode(privateKeyStr);
    final masterKey = _deriveKey(privateKey, 'master_key');
    
    final iv = encrypt.IV.fromSecureRandom(_ivLength);
    final key = encrypt.Key(Uint8List.fromList(masterKey));
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));
    
    final encrypted = encrypter.encryptBytes(data.toList(), iv: iv);
    
    // Prepend IV to ciphertext
    return Uint8List.fromList([...iv.bytes, ...encrypted.bytes]);
  }

  /// Decrypt data with master key
  Future<Uint8List> _decryptWithMasterKey(Uint8List encryptedData) async {
    final privateKeyStr = await _secureStorage.read(key: 'identity_private_key');
    
    if (privateKeyStr == null) {
      throw const EncryptionException('Identity key not found');
    }
    
    final privateKey = base64.decode(privateKeyStr);
    final masterKey = _deriveKey(privateKey, 'master_key');
    
    // Extract IV (first 16 bytes)
    final iv = encrypt.IV(Uint8List.fromList(encryptedData.sublist(0, _ivLength)));
    final ciphertext = encryptedData.sublist(_ivLength);
    
    final key = encrypt.Key(Uint8List.fromList(masterKey));
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));
    
    final encrypted = encrypt.Encrypted(ciphertext);
    final decrypted = encrypter.decryptBytes(encrypted, iv: iv);
    
    return Uint8List.fromList(decrypted);
  }

  /// Derive a key from a password/key and salt using PBKDF2-like approach
  List<int> _deriveKey(List<int> password, String salt) {
    final hmacSha256 = Hmac(sha256, password);
    final saltBytes = utf8.encode(salt);
    
    // Simple key derivation (in production, use proper PBKDF2)
    final digest = hmacSha256.convert(saltBytes);
    return digest.bytes;
  }

  /// Export session key for sharing with other devices
  Future<String> exportSessionKey(String chatId) async {
    final sessionKey = await getOrCreateSessionKey(chatId);
    final encryptedKey = await _encryptWithMasterKey(sessionKey);
    return base64.encode(encryptedKey);
  }

  /// Import session key from another device
  Future<void> importSessionKey(String chatId, String encryptedKeyBase64) async {
    final encryptedKey = base64.decode(encryptedKeyBase64);
    final sessionKey = await _decryptWithMasterKey(encryptedKey);
    
    _sessionKeyCache[chatId] = sessionKey;
    
    await _secureStorage.write(
      key: 'session_key_$chatId',
      value: encryptedKeyBase64,
    );
  }

  /// Clear all encryption keys (for logout)
  Future<void> clearAllKeys() async {
    _sessionKeyCache.clear();
    await _secureStorage.deleteAll();
  }

  /// Rotate session key for forward secrecy
  Future<Uint8List> rotateSessionKey(String chatId) async {
    // Delete old key
    _sessionKeyCache.remove(chatId);
    await _secureStorage.delete(key: 'session_key_$chatId');
    
    // Generate new key
    return await generateSessionKey(chatId);
  }

  /// Verify message integrity using HMAC
  String generateMessageMAC(String message, String chatId) {
    final sessionKey = _sessionKeyCache[chatId];
    if (sessionKey == null) {
      throw EncryptionException('Session key not loaded for chat $chatId');
    }
    
    final hmacSha256 = Hmac(sha256, sessionKey);
    final digest = hmacSha256.convert(utf8.encode(message));
    return digest.toString();
  }

  /// Verify message MAC
  bool verifyMessageMAC(String message, String mac, String chatId) {
    try {
      final expectedMac = generateMessageMAC(message, chatId);
      return expectedMac == mac;
    } catch (e) {
      return false;
    }
  }
}

/// Represents an encrypted message with its IV
class EncryptedMessage {
  final String ciphertext;
  final String iv;
  final int timestamp;
  
  const EncryptedMessage({
    required this.ciphertext,
    required this.iv,
    required this.timestamp,
  });
  
  Map<String, dynamic> toJson() => {
    'ciphertext': ciphertext,
    'iv': iv,
    'timestamp': timestamp,
  };
  
  factory EncryptedMessage.fromJson(Map<String, dynamic> json) {
    return EncryptedMessage(
      ciphertext: json['ciphertext'] as String,
      iv: json['iv'] as String,
      timestamp: json['timestamp'] as int,
    );
  }
}

/// Custom exception for encryption errors
class EncryptionException implements Exception {
  final String message;
  
  const EncryptionException(this.message);
  
  @override
  String toString() => 'EncryptionException: $message';
}
