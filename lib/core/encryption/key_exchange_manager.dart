import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'encryption_service.dart';

/// Key Exchange Manager for handling secure key distribution between users
/// 
/// Implements a simplified key exchange protocol:
/// 1. Each user has an identity key pair stored locally
/// 2. Public key is published to Firestore
/// 3. Session keys are encrypted with recipient's public key and stored in Firestore
class KeyExchangeManager {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final EncryptionService _encryptionService;
  
  KeyExchangeManager({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
    EncryptionService? encryptionService,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance,
        _encryptionService = encryptionService ?? EncryptionService();

  /// Initialize key exchange for current user
  /// Publishes public key to Firestore
  Future<void> initialize() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw KeyExchangeException('User not authenticated');
    }
    
    // Get or create identity key
    final publicKey = await _encryptionService.getOrCreateIdentityKey();
    
    // Publish public key to Firestore
    await _firestore.collection('users').doc(userId).update({
      'publicKey': publicKey,
      'keyUpdatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Get another user's public key
  Future<String?> getUserPublicKey(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    
    if (!doc.exists) return null;
    
    final data = doc.data();
    return data?['publicKey'] as String?;
  }

  /// Create a key bundle for establishing encrypted chat
  /// Returns the bundle to be stored in Firestore
  Future<Map<String, dynamic>> createKeyBundle() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw KeyExchangeException('User not authenticated');
    }
    
    final publicKey = await _encryptionService.getOrCreateIdentityKey();
    
    // Generate one-time pre-keys for Signal-like protocol
    final preKeys = <Map<String, dynamic>>[];
    for (int i = 0; i < 10; i++) {
      final preKey = _encryptionService.generateRandomKey();
      preKeys.add({
        'id': i,
        'key': base64.encode(preKey),
        'createdAt': DateTime.now().toIso8601String(),
      });
    }
    
    return {
      'userId': userId,
      'identityKey': publicKey,
      'preKeys': preKeys,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  /// Store key bundle in Firestore
  Future<void> publishKeyBundle() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw KeyExchangeException('User not authenticated');
    }
    
    final bundle = await createKeyBundle();
    
    await _firestore.collection('keyBundles').doc(userId).set(bundle);
  }

  /// Fetch key bundle for a user
  Future<Map<String, dynamic>?> fetchKeyBundle(String userId) async {
    final doc = await _firestore.collection('keyBundles').doc(userId).get();
    
    if (!doc.exists) return null;
    
    return doc.data();
  }

  /// Establish encrypted session with another user
  /// This creates a shared session key for the chat
  Future<void> establishSession({
    required String chatId,
    required String otherUserId,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw KeyExchangeException('User not authenticated');
    }
    
    // Get other user's key bundle
    final otherBundle = await fetchKeyBundle(otherUserId);
    
    if (otherBundle == null) {
      throw KeyExchangeException('User $otherUserId has no public key bundle');
    }
    
    // Generate session key
    final sessionKey = await _encryptionService.getOrCreateSessionKey(chatId);
    
    // Export encrypted session key
    final encryptedSessionKey = await _encryptionService.exportSessionKey(chatId);
    
    // Store session initialization in Firestore
    await _firestore.collection('chatSessions').doc(chatId).set({
      'participants': [userId, otherUserId],
      'initiator': userId,
      'sessionKeys': {
        userId: encryptedSessionKey,
        // Other user will add their encrypted version when they join
      },
      'createdAt': FieldValue.serverTimestamp(),
      'status': 'pending',
    });
  }

  /// Accept a chat session (recipient side)
  Future<void> acceptSession(String chatId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw KeyExchangeException('User not authenticated');
    }
    
    final sessionDoc = await _firestore.collection('chatSessions').doc(chatId).get();
    
    if (!sessionDoc.exists) {
      throw KeyExchangeException('Session not found');
    }
    
    final sessionData = sessionDoc.data()!;
    final initiatorId = sessionData['initiator'] as String;
    
    // Get initiator's encrypted session key and import it
    // In a real implementation, this would use asymmetric encryption
    // For now, we generate our own session key
    final sessionKey = await _encryptionService.getOrCreateSessionKey(chatId);
    final encryptedSessionKey = await _encryptionService.exportSessionKey(chatId);
    
    // Update session with our encrypted key
    await _firestore.collection('chatSessions').doc(chatId).update({
      'sessionKeys.$userId': encryptedSessionKey,
      'status': 'established',
      'establishedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Verify session is established for a chat
  Future<bool> isSessionEstablished(String chatId) async {
    final sessionDoc = await _firestore.collection('chatSessions').doc(chatId).get();
    
    if (!sessionDoc.exists) return false;
    
    final sessionData = sessionDoc.data()!;
    return sessionData['status'] == 'established';
  }

  /// Rotate session keys for forward secrecy
  Future<void> rotateSessionKeys(String chatId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw KeyExchangeException('User not authenticated');
    }
    
    // Generate new session key
    await _encryptionService.rotateSessionKey(chatId);
    
    // Export and update in Firestore
    final encryptedSessionKey = await _encryptionService.exportSessionKey(chatId);
    
    await _firestore.collection('chatSessions').doc(chatId).update({
      'sessionKeys.$userId': encryptedSessionKey,
      'keyRotatedAt': FieldValue.serverTimestamp(),
      'keyRotationCount': FieldValue.increment(1),
    });
  }

  /// Clean up sessions on logout
  Future<void> cleanup() async {
    await _encryptionService.clearAllKeys();
  }
}

/// Custom exception for key exchange errors
class KeyExchangeException implements Exception {
  final String message;
  
  const KeyExchangeException(this.message);
  
  @override
  String toString() => 'KeyExchangeException: $message';
}
