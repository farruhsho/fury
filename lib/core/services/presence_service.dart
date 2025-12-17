import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

/// Enhanced Presence Service with app lifecycle management
class PresenceService with WidgetsBindingObserver {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  Timer? _heartbeatTimer;
  bool _isInitialized = false;
  StreamSubscription<User?>? _authSubscription;

  PresenceService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Initialize presence tracking with app lifecycle
  Future<void> initialize() async {
    if (_isInitialized) return;
    _isInitialized = true;

    // Register lifecycle observer
    WidgetsBinding.instance.addObserver(this);

    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      await setOnline();
      _startHeartbeat();
    }

    // Listen to auth state changes
    _authSubscription = _auth.authStateChanges().listen((user) async {
      if (user == null) {
        await setOffline();
        _stopHeartbeat();
      } else {
        await setOnline();
        _startHeartbeat();
      }
    });

    debugPrint('✅ [PRESENCE] Service initialized');
  }

  /// Handle app lifecycle changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint('📱 [PRESENCE] App resumed - setting online');
        setOnline();
        _startHeartbeat();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        debugPrint('📱 [PRESENCE] App paused/inactive - setting offline');
        setOffline();
        _stopHeartbeat();
        break;
    }
  }

  /// Start heartbeat to keep online status fresh
  void _startHeartbeat() {
    _stopHeartbeat();
    // Update every 30 seconds
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      updateLastSeen();
    });
  }

  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  /// Set user status to online
  Future<void> setOnline() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    try {
      await _firestore.collection('users').doc(userId).update({
        'isOnline': true,
        'lastSeen': FieldValue.serverTimestamp(),
      });
      debugPrint('🟢 [PRESENCE] User set to ONLINE');
    } catch (e) {
      debugPrint('⚠️ [PRESENCE] Error setting online: $e');
    }
  }

  /// Set user status to offline
  Future<void> setOffline() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    try {
      await _firestore.collection('users').doc(userId).update({
        'isOnline': false,
        'lastSeen': FieldValue.serverTimestamp(),
      });
      debugPrint('🔴 [PRESENCE] User set to OFFLINE');
    } catch (e) {
      debugPrint('⚠️ [PRESENCE] Error setting offline: $e');
    }
  }

  /// Update last seen timestamp
  Future<void> updateLastSeen() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    try {
      await _firestore.collection('users').doc(userId).update({
        'lastSeen': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('⚠️ [PRESENCE] Error updating last seen: $e');
    }
  }

  /// Listen to user's online status (real-time)
  Stream<UserPresence> listenToUserPresence(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) {
        return UserPresence(isOnline: false, lastSeen: null);
      }
      final data = snapshot.data();
      return UserPresence(
        isOnline: data?['isOnline'] as bool? ?? false,
        lastSeen: (data?['lastSeen'] as Timestamp?)?.toDate(),
      );
    });
  }

  /// Check if user is online (one-time check)
  Future<bool> isUserOnline(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (!doc.exists) return false;
    return doc.data()?['isOnline'] as bool? ?? false;
  }

  /// Get user's last seen time
  Future<DateTime?> getLastSeen(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (!doc.exists) return null;

    final data = doc.data();
    final lastSeen = data?['lastSeen'];
    if (lastSeen == null) return null;

    return (lastSeen as Timestamp).toDate();
  }

  /// Dispose and clean up
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    await _authSubscription?.cancel();
    _stopHeartbeat();
    await setOffline();
    _isInitialized = false;
  }
}

/// User presence data
class UserPresence {
  final bool isOnline;
  final DateTime? lastSeen;

  UserPresence({
    required this.isOnline,
    this.lastSeen,
  });

  String get statusText {
    if (isOnline) return 'Online';
    if (lastSeen == null) return 'Offline';
    
    final now = DateTime.now();
    final diff = now.difference(lastSeen!);
    
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return 'Last seen ${diff.inMinutes}m ago';
    if (diff.inHours < 24) return 'Last seen ${diff.inHours}h ago';
    if (diff.inDays < 7) return 'Last seen ${diff.inDays}d ago';
    return 'Last seen a while ago';
  }
}
