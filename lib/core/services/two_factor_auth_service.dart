import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Two-Factor Authentication Service using TOTP (Time-based One-Time Password)
class TwoFactorAuthService {
  static final TwoFactorAuthService _instance = TwoFactorAuthService._internal();
  factory TwoFactorAuthService() => _instance;
  TwoFactorAuthService._internal();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  static const String _totpSecretKey = '2fa_totp_secret';
  static const String _twoFactorEnabledKey = '2fa_enabled';
  static const String _backupCodesKey = '2fa_backup_codes';
  static const int _codeLength = 6;
  static const int _timeStep = 30; // seconds

  /// Generate a new TOTP secret
  String generateSecret([int length = 32]) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
    final random = Random.secure();
    return List.generate(length, (_) => chars[random.nextInt(chars.length)]).join();
  }

  /// Generate TOTP URI for QR code
  String generateTotpUri({
    required String secret,
    required String accountName,
    String issuer = 'Fury Chat',
  }) {
    final encodedAccount = Uri.encodeComponent(accountName);
    final encodedIssuer = Uri.encodeComponent(issuer);
    return 'otpauth://totp/$encodedIssuer:$encodedAccount?secret=$secret&issuer=$encodedIssuer&digits=$_codeLength&period=$_timeStep';
  }

  /// Generate current TOTP code
  String generateCode(String secret, {DateTime? time}) {
    final now = time ?? DateTime.now();
    final timeCounter = now.millisecondsSinceEpoch ~/ 1000 ~/ _timeStep;
    
    final key = _base32Decode(secret);
    final message = _intToBytes(timeCounter);
    
    final hmac = Hmac(sha1, key);
    final hash = hmac.convert(message).bytes;
    
    final offset = hash.last & 0x0f;
    final binary = ((hash[offset] & 0x7f) << 24) |
        ((hash[offset + 1] & 0xff) << 16) |
        ((hash[offset + 2] & 0xff) << 8) |
        (hash[offset + 3] & 0xff);
    
    final otp = binary % 1000000;
    return otp.toString().padLeft(_codeLength, '0');
  }

  /// Verify TOTP code
  bool verifyCode(String secret, String code, {int windowSize = 1}) {
    final now = DateTime.now();
    
    // Check current time and adjacent windows for clock skew tolerance
    for (int i = -windowSize; i <= windowSize; i++) {
      final time = now.add(Duration(seconds: i * _timeStep));
      final expectedCode = generateCode(secret, time: time);
      if (expectedCode == code) return true;
    }
    return false;
  }

  /// Generate backup codes
  List<String> generateBackupCodes([int count = 10]) {
    final random = Random.secure();
    return List.generate(count, (_) {
      return List.generate(8, (_) => random.nextInt(10)).join();
    });
  }

  /// Store 2FA secret securely
  Future<void> storeSecret(String secret) async {
    await _secureStorage.write(key: _totpSecretKey, value: secret);
  }

  /// Get stored 2FA secret
  Future<String?> getStoredSecret() async {
    return await _secureStorage.read(key: _totpSecretKey);
  }

  /// Enable 2FA
  Future<void> enable2FA(String secret, List<String> backupCodes) async {
    await storeSecret(secret);
    await _secureStorage.write(key: _twoFactorEnabledKey, value: 'true');
    await _secureStorage.write(key: _backupCodesKey, value: jsonEncode(backupCodes));
  }

  /// Disable 2FA
  Future<void> disable2FA() async {
    await _secureStorage.delete(key: _totpSecretKey);
    await _secureStorage.write(key: _twoFactorEnabledKey, value: 'false');
    await _secureStorage.delete(key: _backupCodesKey);
  }

  /// Check if 2FA is enabled
  Future<bool> isEnabled() async {
    final value = await _secureStorage.read(key: _twoFactorEnabledKey);
    return value == 'true';
  }

  /// Get backup codes
  Future<List<String>> getBackupCodes() async {
    final value = await _secureStorage.read(key: _backupCodesKey);
    if (value == null) return [];
    return List<String>.from(jsonDecode(value));
  }

  /// Verify using backup code (one-time use)
  Future<bool> verifyBackupCode(String code) async {
    final codes = await getBackupCodes();
    if (codes.contains(code)) {
      codes.remove(code);
      await _secureStorage.write(key: _backupCodesKey, value: jsonEncode(codes));
      return true;
    }
    return false;
  }

  /// Verify auth (either TOTP or backup code)
  Future<bool> verify(String code) async {
    final secret = await getStoredSecret();
    if (secret == null) return false;
    
    // Try TOTP first
    if (verifyCode(secret, code)) return true;
    
    // Try backup code
    return await verifyBackupCode(code);
  }

  // Base32 decode helper
  List<int> _base32Decode(String input) {
    const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
    final normalized = input.toUpperCase().replaceAll(RegExp(r'[^A-Z2-7]'), '');
    
    int bits = 0;
    int value = 0;
    final result = <int>[];
    
    for (int i = 0; i < normalized.length; i++) {
      value = (value << 5) | alphabet.indexOf(normalized[i]);
      bits += 5;
      
      if (bits >= 8) {
        bits -= 8;
        result.add((value >> bits) & 0xff);
      }
    }
    
    return result;
  }

  // Int to bytes helper
  List<int> _intToBytes(int value) {
    final bytes = List<int>.filled(8, 0);
    for (int i = 7; i >= 0; i--) {
      bytes[i] = value & 0xff;
      value >>= 8;
    }
    return bytes;
  }
}
