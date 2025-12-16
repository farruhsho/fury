import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Model for a device session
class DeviceSession {
  final String id;
  final String deviceName;
  final String platform;
  final String? location;
  final DateTime lastActive;
  final bool isCurrent;

  DeviceSession({
    required this.id,
    required this.deviceName,
    required this.platform,
    this.location,
    required this.lastActive,
    this.isCurrent = false,
  });

  factory DeviceSession.fromFirestore(DocumentSnapshot doc, String currentSessionId) {
    final data = doc.data() as Map<String, dynamic>;
    return DeviceSession(
      id: doc.id,
      deviceName: data['deviceName'] ?? 'Unknown Device',
      platform: data['platform'] ?? 'Unknown',
      location: data['location'],
      lastActive: (data['lastActive'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isCurrent: doc.id == currentSessionId,
    );
  }
}

/// Service for managing device sessions
class DeviceSessionService {
  static final DeviceSessionService _instance = DeviceSessionService._internal();
  factory DeviceSessionService() => _instance;
  DeviceSessionService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  static const String _sessionIdKey = 'current_session_id';

  /// Register current device session
  Future<String> registerSession({
    required String deviceName,
    required String platform,
    String? location,
  }) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) throw Exception('User not authenticated');

    final sessionRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('sessions')
        .doc();

    await sessionRef.set({
      'deviceName': deviceName,
      'platform': platform,
      'location': location,
      'lastActive': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    await _secureStorage.write(key: _sessionIdKey, value: sessionRef.id);
    return sessionRef.id;
  }

  /// Get current session ID
  Future<String?> getCurrentSessionId() async {
    return await _secureStorage.read(key: _sessionIdKey);
  }

  /// Update last active timestamp for current session
  Future<void> updateLastActive() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final sessionId = await getCurrentSessionId();
    if (userId == null || sessionId == null) return;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('sessions')
        .doc(sessionId)
        .update({
      'lastActive': FieldValue.serverTimestamp(),
    });
  }

  /// Get all active sessions
  Future<List<DeviceSession>> getActiveSessions() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final currentSessionId = await getCurrentSessionId();
    if (userId == null) return [];

    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('sessions')
        .orderBy('lastActive', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => DeviceSession.fromFirestore(doc, currentSessionId ?? ''))
        .toList();
  }

  /// Terminate a specific session
  Future<void> terminateSession(String sessionId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('sessions')
        .doc(sessionId)
        .delete();
  }

  /// Terminate all other sessions (keep current)
  Future<void> terminateOtherSessions() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final currentSessionId = await getCurrentSessionId();
    if (userId == null) return;

    final sessions = await _firestore
        .collection('users')
        .doc(userId)
        .collection('sessions')
        .get();

    final batch = _firestore.batch();
    for (final doc in sessions.docs) {
      if (doc.id != currentSessionId) {
        batch.delete(doc.reference);
      }
    }
    await batch.commit();
  }

  /// Terminate all sessions (including current - for logout from all)
  Future<void> terminateAllSessions() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final sessions = await _firestore
        .collection('users')
        .doc(userId)
        .collection('sessions')
        .get();

    final batch = _firestore.batch();
    for (final doc in sessions.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();

    await _secureStorage.delete(key: _sessionIdKey);
  }

  /// Clear local session on logout
  Future<void> clearLocalSession() async {
    await _secureStorage.delete(key: _sessionIdKey);
  }
}
