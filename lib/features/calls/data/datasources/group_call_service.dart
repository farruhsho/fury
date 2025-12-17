import 'dart:async';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Call type enum for group calls
enum CallType { voice, video }

/// Group call service for multi-party video/voice calls
/// 
/// Implements mesh topology for small groups (up to 8 participants).
/// For larger groups, consider SFU (Selective Forwarding Unit).
class GroupCallService {
  final FirebaseFirestore _firestore;
  final String _currentUserId;
  
  // Map of participantId -> RTCPeerConnection
  final Map<String, RTCPeerConnection> _peerConnections = {};
  
  // Map of participantId -> MediaStream (remote streams)
  final Map<String, MediaStream> _remoteStreams = {};
  
  MediaStream? _localStream;
  String? _activeCallId;
  
  final _remoteStreamsController = StreamController<Map<String, MediaStream>>.broadcast();
  final _participantsController = StreamController<List<String>>.broadcast();
  
  /// Stream of remote participant streams
  Stream<Map<String, MediaStream>> get remoteStreamsStream => _remoteStreamsController.stream;
  
  /// Stream of participant IDs
  Stream<List<String>> get participantsStream => _participantsController.stream;
  
  /// Current remote streams
  Map<String, MediaStream> get remoteStreams => Map.unmodifiable(_remoteStreams);
  
  /// Local stream
  MediaStream? get localStream => _localStream;
  
  /// Active call ID
  String? get activeCallId => _activeCallId;
  
  /// ICE servers configuration
  final Map<String, dynamic> _iceServers = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
      {'urls': 'stun:stun1.l.google.com:19302'},
      {'urls': 'stun:stun2.l.google.com:19302'},
      {'urls': 'stun:stun3.l.google.com:19302'},
      {'urls': 'stun:stun4.l.google.com:19302'},
      // OpenRelay free TURN servers (from Metered.ca - for testing)
      {
        'urls': [
          'turn:openrelay.metered.ca:80',
          'turn:openrelay.metered.ca:443',
          'turns:openrelay.metered.ca:443',
        ],
        'username': 'openrelayproject',
        'credential': 'openrelayproject',
      },
      {'urls': 'stun:stun.stunprotocol.org:3478'},
      {'urls': 'stun:stun.voip.blackberry.com:3478'},
    ],
    'sdpSemantics': 'unified-plan',
    'iceCandidatePoolSize': 10,
  };

  GroupCallService({
    required FirebaseFirestore firestore,
    required String currentUserId,
  })  : _firestore = firestore,
        _currentUserId = currentUserId;

  /// Initialize local media stream
  Future<MediaStream> _initLocalStream({bool video = true}) async {
    final mediaConstraints = {
      'audio': true,
      'video': video ? {
        'facingMode': 'user',
        'width': {'ideal': 640},
        'height': {'ideal': 480},
      } : false,
    };
    
    _localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
    return _localStream!;
  }

  /// Create a group call
  Future<String> createGroupCall({
    required String chatId,
    required List<String> participantIds,
    required CallType type,
  }) async {
    // Initialize local stream
    await _initLocalStream(video: type == CallType.video);
    
    // Create call document
    final callRef = _firestore.collection('group_calls').doc();
    _activeCallId = callRef.id;
    
    await callRef.set({
      'id': callRef.id,
      'chatId': chatId,
      'creatorId': _currentUserId,
      'participantIds': [_currentUserId, ...participantIds],
      'activeParticipants': [_currentUserId],
      'type': type.name,
      'status': 'ringing',
      'createdAt': FieldValue.serverTimestamp(),
    });
    
    // Listen for participants joining
    _listenForParticipants(callRef.id);
    
    // Listen for signaling messages
    _listenForSignaling(callRef.id);
    
    return callRef.id;
  }

  /// Add participants to an active group call
  /// 
  /// This invites new users to join the call by adding them to participantIds.
  /// They will receive a call notification and can choose to join.
  Future<void> addParticipants(List<String> newParticipantIds) async {
    if (_activeCallId == null) {
      throw Exception('No active call to add participants to');
    }
    
    final callRef = _firestore.collection('group_calls').doc(_activeCallId);
    final callDoc = await callRef.get();
    
    if (!callDoc.exists) {
      throw Exception('Call not found');
    }
    
    final data = callDoc.data()!;
    final currentParticipantIds = List<String>.from(data['participantIds'] ?? []);
    const maxParticipants = 8;
    
    // Filter out users already in the call
    final usersToAdd = newParticipantIds
        .where((id) => !currentParticipantIds.contains(id))
        .toList();
    
    if (currentParticipantIds.length + usersToAdd.length > maxParticipants) {
      throw Exception('Maximum $maxParticipants participants allowed');
    }
    
    if (usersToAdd.isEmpty) {
      return; // All users already in call
    }
    
    // Add new participants to the participantIds list
    await callRef.update({
      'participantIds': FieldValue.arrayUnion(usersToAdd),
    });
    
    // Send call invitations to new participants
    for (final userId in usersToAdd) {
      await _firestore.collection('call_invitations').doc('${_activeCallId}_$userId').set({
        'callId': _activeCallId,
        'callerId': _currentUserId,
        'calleeId': userId,
        'type': data['type'],
        'chatId': data['chatId'],
        'isGroupCall': true,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  /// Join an existing group call
  Future<void> joinGroupCall(String callId, {bool video = true}) async {
    _activeCallId = callId;
    
    // Initialize local stream
    await _initLocalStream(video: video);
    
    // Add self to active participants
    final callRef = _firestore.collection('group_calls').doc(callId);
    await callRef.update({
      'activeParticipants': FieldValue.arrayUnion([_currentUserId]),
    });
    
    // Get existing participants and create peer connections
    final callDoc = await callRef.get();
    final data = callDoc.data();
    if (data != null) {
      final activeParticipants = List<String>.from(data['activeParticipants'] ?? []);
      
      for (final participantId in activeParticipants) {
        if (participantId != _currentUserId) {
          await _createPeerConnection(callId, participantId, createOffer: true);
        }
      }
    }
    
    // Listen for new participants
    _listenForParticipants(callId);
    
    // Listen for signaling
    _listenForSignaling(callId);
  }

  /// Create peer connection for a participant
  Future<RTCPeerConnection> _createPeerConnection(
    String callId, 
    String participantId, {
    bool createOffer = false,
  }) async {
    final pc = await createPeerConnection(_iceServers);
    _peerConnections[participantId] = pc;
    
    // Add local tracks
    if (_localStream != null) {
      for (final track in _localStream!.getTracks()) {
        await pc.addTrack(track, _localStream!);
      }
    }
    
    // Handle ICE candidates
    pc.onIceCandidate = (candidate) {
      _sendSignalingMessage(callId, participantId, {
        'type': 'ice-candidate',
        'candidate': candidate.toMap(),
      });
    };
    
    // Handle incoming tracks
    pc.onTrack = (event) {
      if (event.streams.isNotEmpty) {
        _remoteStreams[participantId] = event.streams[0];
        _remoteStreamsController.add(Map.from(_remoteStreams));
      }
    };
    
    // Handle connection state
    pc.onConnectionState = (state) {
      if (state == RTCPeerConnectionState.RTCPeerConnectionStateDisconnected ||
          state == RTCPeerConnectionState.RTCPeerConnectionStateFailed) {
        _handleParticipantDisconnected(participantId);
      }
    };
    
    // Create offer if needed
    if (createOffer) {
      final offer = await pc.createOffer();
      await pc.setLocalDescription(offer);
      
      _sendSignalingMessage(callId, participantId, {
        'type': 'offer',
        'sdp': offer.sdp,
      });
    }
    
    return pc;
  }

  /// Listen for participant changes
  void _listenForParticipants(String callId) {
    _firestore.collection('group_calls').doc(callId).snapshots().listen((doc) {
      final data = doc.data();
      if (data != null) {
        final activeParticipants = List<String>.from(data['activeParticipants'] ?? []);
        _participantsController.add(activeParticipants);
        
        // Create connections for new participants
        for (final participantId in activeParticipants) {
          if (participantId != _currentUserId && 
              !_peerConnections.containsKey(participantId)) {
            // New participant joined - they will send offer
          }
        }
        
        // Clean up disconnected participants
        final disconnected = _peerConnections.keys
            .where((id) => !activeParticipants.contains(id))
            .toList();
        for (final id in disconnected) {
          _handleParticipantDisconnected(id);
        }
      }
    });
  }

  /// Listen for signaling messages
  void _listenForSignaling(String callId) {
    _firestore
        .collection('group_calls')
        .doc(callId)
        .collection('signaling')
        .where('targetId', isEqualTo: _currentUserId)
        .orderBy('timestamp')
        .snapshots()
        .listen((snapshot) async {
      for (final change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          final data = change.doc.data();
          if (data != null) {
            await _handleSignalingMessage(callId, data);
            // Delete processed message
            await change.doc.reference.delete();
          }
        }
      }
    });
  }

  /// Send signaling message
  Future<void> _sendSignalingMessage(
    String callId, 
    String targetId, 
    Map<String, dynamic> message,
  ) async {
    await _firestore
        .collection('group_calls')
        .doc(callId)
        .collection('signaling')
        .add({
      ...message,
      'senderId': _currentUserId,
      'targetId': targetId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  /// Handle incoming signaling message
  Future<void> _handleSignalingMessage(
    String callId, 
    Map<String, dynamic> data,
  ) async {
    final senderId = data['senderId'] as String;
    final type = data['type'] as String;
    
    RTCPeerConnection pc;
    if (_peerConnections.containsKey(senderId)) {
      pc = _peerConnections[senderId]!;
    } else {
      pc = await _createPeerConnection(callId, senderId);
    }
    
    switch (type) {
      case 'offer':
        final offer = RTCSessionDescription(data['sdp'], 'offer');
        await pc.setRemoteDescription(offer);
        
        final answer = await pc.createAnswer();
        await pc.setLocalDescription(answer);
        
        _sendSignalingMessage(callId, senderId, {
          'type': 'answer',
          'sdp': answer.sdp,
        });
        break;
        
      case 'answer':
        final answer = RTCSessionDescription(data['sdp'], 'answer');
        await pc.setRemoteDescription(answer);
        break;
        
      case 'ice-candidate':
        final candidateMap = data['candidate'] as Map<String, dynamic>;
        final candidate = RTCIceCandidate(
          candidateMap['candidate'],
          candidateMap['sdpMid'],
          candidateMap['sdpMLineIndex'],
        );
        await pc.addCandidate(candidate);
        break;
    }
  }

  /// Handle participant disconnection
  void _handleParticipantDisconnected(String participantId) {
    _peerConnections[participantId]?.close();
    _peerConnections.remove(participantId);
    
    _remoteStreams[participantId]?.dispose();
    _remoteStreams.remove(participantId);
    
    _remoteStreamsController.add(Map.from(_remoteStreams));
  }

  /// Leave the current call
  Future<void> leaveCall() async {
    if (_activeCallId == null) return;
    
    // Remove from active participants
    await _firestore.collection('group_calls').doc(_activeCallId).update({
      'activeParticipants': FieldValue.arrayRemove([_currentUserId]),
    });
    
    // Close all peer connections
    for (final pc in _peerConnections.values) {
      await pc.close();
    }
    _peerConnections.clear();
    
    // Clean up remote streams
    for (final stream in _remoteStreams.values) {
      await stream.dispose();
    }
    _remoteStreams.clear();
    
    // Clean up local stream
    await _localStream?.dispose();
    _localStream = null;
    
    _activeCallId = null;
    _remoteStreamsController.add({});
  }

  /// Toggle local audio
  void toggleAudio(bool enabled) {
    _localStream?.getAudioTracks().forEach((track) {
      track.enabled = enabled;
    });
  }

  /// Toggle local video
  void toggleVideo(bool enabled) {
    _localStream?.getVideoTracks().forEach((track) {
      track.enabled = enabled;
    });
  }

  /// Switch camera
  Future<void> switchCamera() async {
    final videoTracks = _localStream?.getVideoTracks();
    if (videoTracks != null && videoTracks.isNotEmpty) {
      await Helper.switchCamera(videoTracks.first);
    }
  }

  /// Dispose resources
  Future<void> dispose() async {
    await leaveCall();
    await _remoteStreamsController.close();
    await _participantsController.close();
  }
}
