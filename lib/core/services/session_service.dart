import 'dart:io' show Platform;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// Service for managing user sessions across devices
/// Note: For full device info, add device_info_plus to pubspec.yaml
class SessionService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  
  String? _currentSessionId;
  
  SessionService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;
  
  /// Register current device session when user logs in
  Future<void> registerSession() async {
    final user = _auth.currentUser;
    if (user == null) return;
    
    try {
      final deviceId = _getDeviceId();
      final deviceName = _getDeviceName();
      final platform = _getPlatform();
      
      _currentSessionId = deviceId;
      
      final sessionRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('sessions')
          .doc(deviceId);
      
      await sessionRef.set({
        'deviceId': deviceId,
        'deviceName': deviceName,
        'platform': platform,
        'lastActive': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
        'ipAddress': null, // Would need server-side function to capture
      }, SetOptions(merge: true));
      
      debugPrint('✅ [SESSION] Registered session: $deviceName ($platform)');
    } catch (e) {
      debugPrint('⚠️ [SESSION] Failed to register session: $e');
    }
  }
  
  /// Update last active timestamp for current session
  Future<void> updateLastActive() async {
    final user = _auth.currentUser;
    if (user == null || _currentSessionId == null) return;
    
    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('sessions')
          .doc(_currentSessionId)
          .update({
        'lastActive': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('⚠️ [SESSION] Failed to update last active: $e');
    }
  }
  
  /// Remove current session on logout
  Future<void> removeSession() async {
    final user = _auth.currentUser;
    if (user == null || _currentSessionId == null) return;
    
    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('sessions')
          .doc(_currentSessionId)
          .delete();
      
      debugPrint('✅ [SESSION] Removed session: $_currentSessionId');
      _currentSessionId = null;
    } catch (e) {
      debugPrint('⚠️ [SESSION] Failed to remove session: $e');
    }
  }
  
  String _getDeviceId() {
    // Simple fallback without device_info_plus
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final platform = _getPlatform();
    return '${platform}_$timestamp';
  }
  
  String _getDeviceName() {
    if (kIsWeb) return 'Web Browser';
    if (Platform.isAndroid) return 'Android Device';
    if (Platform.isIOS) return 'iOS Device';
    if (Platform.isWindows) return 'Windows PC';
    if (Platform.isMacOS) return 'Mac';
    if (Platform.isLinux) return 'Linux PC';
    return 'Unknown Device';
  }
  
  String _getPlatform() {
    if (kIsWeb) return 'web';
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    if (Platform.isWindows) return 'windows';
    if (Platform.isMacOS) return 'macos';
    if (Platform.isLinux) return 'linux';
    return 'unknown';
  }
}
