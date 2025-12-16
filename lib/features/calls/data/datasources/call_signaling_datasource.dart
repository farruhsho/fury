import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/call_entity.dart';

/// Remote datasource for call signaling through Firestore
class CallSignalingDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  
  static const String _callsCollection = 'calls';
  static const String _iceCandidatesCollection = 'iceCandidates';

  CallSignalingDatasource({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  String get _currentUserId {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('User not authenticated');
    return userId;
  }

  /// Generate a new call ID locally
  String generateCallId() => const Uuid().v4();

  /// Create a new call document
  Future<String> createCall({
    String? callId,
    required String chatId,
    required String recipientId,
    required CallType type,
    required String offer,
    required String callerName,
    required String recipientName,
    String? callerAvatarUrl,
    String? recipientAvatarUrl,
  }) async {
    final id = callId ?? const Uuid().v4();
    
    final callData = {
      'id': id,
      'chatId': chatId,
      'callerId': _currentUserId,
      'callerName': callerName,
      'callerAvatarUrl': callerAvatarUrl,
      'recipientId': recipientId,
      'recipientName': recipientName,
      'recipientAvatarUrl': recipientAvatarUrl,
      'participantIds': [_currentUserId, recipientId],
      'type': type.name,
      'status': CallStatus.ringing.name,
      'createdAt': FieldValue.serverTimestamp(),
      'offer': offer,
      'duration': 0,
    };
    
    await _firestore.collection(_callsCollection).doc(id).set(callData);
    
    // Store pending call notification data for recipient
    // This will be picked up by Cloud Functions or client-side listener
    await _firestore.collection('pending_calls').doc(id).set({
      'callId': id,
      'recipientId': recipientId,
      'callerName': callerName,
      'callerAvatarUrl': callerAvatarUrl,
      'type': type.name,
      'createdAt': FieldValue.serverTimestamp(),
      'status': 'pending',
    });
    
    return id;
  }

  /// Update call with answer SDP
  Future<void> answerCall({
    required String callId,
    required String answer,
  }) async {
    await _firestore.collection(_callsCollection).doc(callId).update({
      'answer': answer,
      'status': CallStatus.connecting.name,
      'answeredAt': FieldValue.serverTimestamp(),
    });
  }

  /// Update call with offer SDP (used when offer is created after call record)
  Future<void> updateCallOffer({
    required String callId,
    required String offer,
  }) async {
    await _firestore.collection(_callsCollection).doc(callId).update({
      'offer': offer,
    });
  }

  /// Update call status
  Future<void> updateCallStatus({
    required String callId,
    required CallStatus status,
    CallEndReason? endReason,
  }) async {
    final updateData = <String, dynamic>{
      'status': status.name,
    };
    
    if (status == CallStatus.connected) {
      // Nothing extra needed
    } else if (status == CallStatus.ended) {
      updateData['endedAt'] = FieldValue.serverTimestamp();
      if (endReason != null) {
        updateData['endReason'] = endReason.name;
      }
    }
    
    await _firestore.collection(_callsCollection).doc(callId).update(updateData);
  }

  /// Add ICE candidate
  Future<void> addIceCandidate({
    required String callId,
    required IceCandidateEntity candidate,
    required bool isFromCaller,
  }) async {
    await _firestore
        .collection(_callsCollection)
        .doc(callId)
        .collection(_iceCandidatesCollection)
        .add({
      'candidate': candidate.candidate,
      'sdpMid': candidate.sdpMid,
      'sdpMLineIndex': candidate.sdpMLineIndex,
      'isFromCaller': isFromCaller,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Listen to incoming calls for current user
  Stream<QuerySnapshot<Map<String, dynamic>>> listenToIncomingCalls() {
    return _firestore
        .collection(_callsCollection)
        .where('participantIds', arrayContains: _currentUserId)
        .where('status', isEqualTo: CallStatus.ringing.name)
        .where('callerId', isNotEqualTo: _currentUserId)
        .orderBy('callerId')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .snapshots();
  }

  /// Listen to call document updates
  Stream<DocumentSnapshot<Map<String, dynamic>>> listenToCall(String callId) {
    return _firestore.collection(_callsCollection).doc(callId).snapshots();
  }

  /// Listen to ICE candidates
  Stream<QuerySnapshot<Map<String, dynamic>>> listenToIceCandidates({
    required String callId,
    required bool forCaller,
  }) {
    return _firestore
        .collection(_callsCollection)
        .doc(callId)
        .collection(_iceCandidatesCollection)
        .where('isFromCaller', isEqualTo: !forCaller) // Get candidates from other side
        .orderBy('createdAt')
        .snapshots();
  }

  /// Get call by ID
  Future<Map<String, dynamic>?> getCall(String callId) async {
    final doc = await _firestore.collection(_callsCollection).doc(callId).get();
    return doc.data();
  }

  /// Get call history
  Future<List<Map<String, dynamic>>> getCallHistory({int limit = 50}) async {
    final snapshot = await _firestore
        .collection(_callsCollection)
        .where('participantIds', arrayContains: _currentUserId)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  /// Delete call document (cleanup)
  Future<void> deleteCall(String callId) async {
    // Delete ICE candidates first
    final candidatesSnapshot = await _firestore
        .collection(_callsCollection)
        .doc(callId)
        .collection(_iceCandidatesCollection)
        .get();
    
    final batch = _firestore.batch();
    for (final doc in candidatesSnapshot.docs) {
      batch.delete(doc.reference);
    }
    
    // Delete call document
    batch.delete(_firestore.collection(_callsCollection).doc(callId));
    
    await batch.commit();
  }
}
