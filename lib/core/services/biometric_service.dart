import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service for biometric authentication (Face ID / Fingerprint)
class BiometricService {
  static final BiometricService _instance = BiometricService._internal();
  factory BiometricService() => _instance;
  BiometricService._internal();

  final LocalAuthentication _localAuth = LocalAuthentication();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  static const String _biometricEnabledKey = 'biometric_enabled';
  static const String _appLockEnabledKey = 'app_lock_enabled';
  static const String _chatLockPinKey = 'chat_lock_pin';

  /// Check if device supports biometrics
  Future<bool> isBiometricAvailable() async {
    // Biometrics not available on web platform
    if (kIsWeb) {
      return false;
    }
    try {
      return await _localAuth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  /// Get list of available biometric types
  Future<List<BiometricType>> getAvailableBiometrics() async {
    // Biometrics not available on web platform
    if (kIsWeb) {
      return [];
    }
    try {
      return await _localAuth.getAvailableBiometrics();
    } on PlatformException {
      return [];
    }
  }

  /// Authenticate using biometrics
  Future<bool> authenticate({
    String reason = 'Please authenticate to continue',
  }) async {
    // Biometrics not available on web platform
    if (kIsWeb) {
      return false;
    }
    try {
      final isAvailable = await isBiometricAvailable();
      if (!isAvailable) return false;

      return await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false, // Allow PIN/password fallback
        ),
      );
    } on PlatformException catch (e) {
      print('❌ [BIOMETRIC] Authentication error: ${e.message}');
      return false;
    }
  }

  /// Check if biometric lock is enabled
  Future<bool> isBiometricLockEnabled() async {
    final value = await _secureStorage.read(key: _biometricEnabledKey);
    return value == 'true';
  }

  /// Enable/disable biometric lock
  Future<void> setBiometricLockEnabled(bool enabled) async {
    await _secureStorage.write(
      key: _biometricEnabledKey,
      value: enabled.toString(),
    );
  }

  /// Check if app lock is enabled
  Future<bool> isAppLockEnabled() async {
    final value = await _secureStorage.read(key: _appLockEnabledKey);
    return value == 'true';
  }

  /// Enable/disable app lock
  Future<void> setAppLockEnabled(bool enabled) async {
    await _secureStorage.write(
      key: _appLockEnabledKey,
      value: enabled.toString(),
    );
  }

  /// Set PIN for chat lock
  Future<void> setChatLockPin(String pin) async {
    await _secureStorage.write(key: _chatLockPinKey, value: pin);
  }

  /// Verify chat lock PIN
  Future<bool> verifyChatLockPin(String pin) async {
    final storedPin = await _secureStorage.read(key: _chatLockPinKey);
    return storedPin == pin;
  }

  /// Check if chat lock PIN is set
  Future<bool> hasChatLockPin() async {
    final pin = await _secureStorage.read(key: _chatLockPinKey);
    return pin != null && pin.isNotEmpty;
  }

  /// Clear chat lock PIN
  Future<void> clearChatLockPin() async {
    await _secureStorage.delete(key: _chatLockPinKey);
  }

  /// Get biometric type as user-friendly string
  String getBiometricTypeName(List<BiometricType> types) {
    if (types.contains(BiometricType.face)) {
      return 'Face ID';
    } else if (types.contains(BiometricType.fingerprint)) {
      return 'Fingerprint';
    } else if (types.contains(BiometricType.iris)) {
      return 'Iris';
    }
    return 'Biometric';
  }
}
