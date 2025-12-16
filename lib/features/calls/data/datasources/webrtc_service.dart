import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../../domain/entities/media_settings.dart';

/// WebRTC service for managing peer connections
/// 
/// Handles:
/// - ICE candidate gathering
/// - Offer/Answer SDP negotiation
/// - Audio/Video track management
/// - Connection state monitoring
class WebRTCService {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  MediaStream? _remoteStream;
  VideoQuality _currentQuality = VideoQuality.auto;
  
  // Callbacks
  Function(RTCIceCandidate)? onIceCandidate;
  Function(MediaStream)? onRemoteStream;
  Function(RTCPeerConnectionState)? onConnectionStateChange;
  Function(RTCIceConnectionState)? onIceConnectionStateChange;
  
  // STUN/TURN servers configuration
  // NOTE: For production, register at metered.ca for reliable TURN service
  static final Map<String, dynamic> _configuration = {
    'iceServers': [
      // Google's public STUN servers
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
      // Additional STUN servers for better NAT traversal
      {'urls': 'stun:stun.stunprotocol.org:3478'},
      {'urls': 'stun:stun.voip.blackberry.com:3478'},
    ],
    'sdpSemantics': 'unified-plan',
    // Pre-gather ICE candidates for faster connection
    'iceCandidatePoolSize': 10,
  };
  
  // Media constraints
  static final Map<String, dynamic> _offerSdpConstraints = {
    'offerToReceiveVideo': true,
    'offerToReceiveAudio': true,
  };
  
  bool get isConnected => 
      _peerConnection?.connectionState == RTCPeerConnectionState.RTCPeerConnectionStateConnected;
  
  /// Check if running on Windows desktop
  bool get _isWindowsDesktop {
    if (kIsWeb) return false;
    try {
      return Platform.isWindows;
    } catch (e) {
      return false;
    }
  }
  
  /// Initialize WebRTC and create peer connection
  Future<void> initialize() async {
    // Reset state for new call
    _hasRemoteDescription = false;
    _candidateQueue.clear();
    _currentQuality = VideoQuality.auto;
    
    _peerConnection = await createPeerConnection(_configuration);
    
    _setupPeerConnectionListeners();
  }
  
  void _setupPeerConnectionListeners() {
    _peerConnection?.onIceCandidate = (RTCIceCandidate candidate) {
      onIceCandidate?.call(candidate);
    };
    
    _peerConnection?.onTrack = (RTCTrackEvent event) {
      if (event.streams.isNotEmpty) {
        _remoteStream = event.streams[0];
        onRemoteStream?.call(_remoteStream!);
      }
    };
    
    _peerConnection?.onConnectionState = (RTCPeerConnectionState state) {
      onConnectionStateChange?.call(state);
    };
    
    _peerConnection?.onIceConnectionState = (RTCIceConnectionState state) {
      onIceConnectionStateChange?.call(state);
    };
  }
  
  /// Get local media stream (audio/video)
  Future<MediaStream> getLocalStream({
    bool audio = true,
    bool video = true,
  }) async {
    final constraints = {
      'audio': audio ? {
        'echoCancellation': true,
        'noiseSuppression': true,
        'autoGainControl': true,
      } : false,
      'video': video ? {
        'facingMode': 'user',
        'width': {'ideal': 1280},
        'height': {'ideal': 720},
        'frameRate': {'ideal': 30},
      } : false,
    };
    
    _localStream = await navigator.mediaDevices.getUserMedia(constraints);
    
    // Add tracks to peer connection
    _localStream!.getTracks().forEach((track) {
      _peerConnection?.addTrack(track, _localStream!);
    });
    
    return _localStream!;
  }

  /// Change video quality constraints
  Future<void> changeVideoQuality(VideoQuality quality) async {
    if (_localStream == null || quality == _currentQuality) return;
    
    _currentQuality = quality;
    final videoTracks = _localStream!.getVideoTracks();
    if (videoTracks.isEmpty) return;
    
    final track = videoTracks.first;
    final constraints = _getVideoConstraints(quality);
    
    try {
      await track.applyConstraints(constraints);
      print('✅ [WebRTC] Applied video constraints: $constraints');
    } catch (e) {
      print('❌ [WebRTC] Failed to apply constraints, restarting track: $e');
      // If applyConstraints fails (not supported on all platforms/browsers),
      // we need to replace the track
      await _replaceVideoTrack(constraints);
    }
  }
  
  Map<String, dynamic> _getVideoConstraints(VideoQuality quality) {
    switch (quality) {
      case VideoQuality.low:
        return {
          'width': {'ideal': 320},
          'height': {'ideal': 240},
          'frameRate': {'ideal': 15},
        };
      case VideoQuality.medium:
        return {
          'width': {'ideal': 640},
          'height': {'ideal': 480},
          'frameRate': {'ideal': 24},
        };
      case VideoQuality.high:
        return {
          'width': {'ideal': 1280},
          'height': {'ideal': 720},
          'frameRate': {'ideal': 30},
        };
      case VideoQuality.auto:
      default:
         // Default to High, adaptive logic will downgrade if needed
        return {
          'width': {'ideal': 1280},
          'height': {'ideal': 720},
          'frameRate': {'ideal': 30},
        };
    }
  }

  Future<void> _replaceVideoTrack(Map<String, dynamic> constraints) async {
    try {
      final mediaConstraints = {'video': constraints, 'audio': false};
      final newStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
      final newTrack = newStream.getVideoTracks().first;
      
      final senders = await _peerConnection!.getSenders();
      final videoSender = senders.firstWhere((sender) => sender.track?.kind == 'video');
      
      // Replace track on peer connection
      await videoSender.replaceTrack(newTrack);
      
      // Remove old track from local stream and add new one
      final oldTrack = _localStream!.getVideoTracks().first;
      _localStream!.removeTrack(oldTrack);
      _localStream!.addTrack(newTrack);
      oldTrack.stop();
      
    } catch (e) {
       print('❌ [WebRTC] Failed to replace video track: $e');
    }
  }

  /// Update audio constraints (requires restarting track usually)
  Future<void> updateAudioSettings(AudioSettings settings) async {
    // Audio constraints are applied at track creation usually. 
    // applyConstraints might work for some properties.
    if (_localStream == null) return;
    
    final audioTracks = _localStream!.getAudioTracks();
    if (audioTracks.isEmpty) return;
    
    final track = audioTracks.first;
    
    final constraints = {
      'echoCancellation': settings.echoCancellation,
      'noiseSuppression': settings.noiseSuppression,
      'autoGainControl': settings.autoGainControl,
    };
    
    try {
      // Try applying constraints first
      await track.applyConstraints(constraints);
       print('✅ [WebRTC] Applied audio constraints: $constraints');
    } catch (e) {
       print('⚠️ [WebRTC] Should replace audio track (not implemented to avoid glitching)');
       // Replacing audio track during call can be disruptive. 
       // For now, we rely on applyConstraints or initial setup.
       // If critical, we can implement _replaceAudioTrack similar to video.
    }
  }
  
  /// Create offer SDP for initiating call
  Future<RTCSessionDescription> createOffer() async {
    final offer = await _peerConnection!.createOffer(_offerSdpConstraints);
    await _peerConnection!.setLocalDescription(offer);
    return offer;
  }
  
  /// Handle incoming offer and create answer
  Future<RTCSessionDescription> handleOffer(RTCSessionDescription offer) async {
    await _peerConnection!.setRemoteDescription(offer);
    await _flushCandidateQueue();
    
    // Create answer with constraints to ensure we receive audio/video
    final answer = await _peerConnection!.createAnswer(_offerSdpConstraints);
    await _peerConnection!.setLocalDescription(answer);
    
    return answer;
  }
  
  /// Handle incoming answer
  Future<void> handleAnswer(RTCSessionDescription answer) async {
    await _peerConnection!.setRemoteDescription(answer);
    await _flushCandidateQueue();
  }
  
  final List<RTCIceCandidate> _candidateQueue = [];
  bool _hasRemoteDescription = false;

  /// Add ICE candidate from remote peer
  Future<void> addIceCandidate(RTCIceCandidate candidate) async {
    if (_peerConnection == null) return;
    
    // Check if remote description is set
    // NOTE: On some platforms (Windows), getRemoteDescription throws if not set
    if (_hasRemoteDescription) {
      try {
        await _peerConnection!.addCandidate(candidate);
        debugPrint('📞 [WebRTC] Added ICE candidate immediately');
      } catch (e) {
        debugPrint('⚠️ [WebRTC] Failed to add ICE candidate: $e');
      }
    } else {
      // Queue candidate if remote description is not set yet
      debugPrint('📞 [WebRTC] Queuing ICE candidate (remote description not set)');
      _candidateQueue.add(candidate);
    }
  }

  Future<void> _flushCandidateQueue() async {
    _hasRemoteDescription = true;
    debugPrint('📞 [WebRTC] Flushing ${_candidateQueue.length} queued ICE candidates');
    for (final candidate in _candidateQueue) {
      try {
        await _peerConnection?.addCandidate(candidate);
      } catch (e) {
        // Ignore specific candidate errors
        debugPrint('⚠️ [WebRTC] Failed to add queued candidate: $e');
      }
    }
    _candidateQueue.clear();
  }
  
  /// Toggle audio mute
  void toggleAudio(bool enabled) {
    _localStream?.getAudioTracks().forEach((track) {
      track.enabled = enabled;
    });
  }
  
  /// Toggle video
  /// When enabled is false, video track is disabled (black frame sent to peer)
  /// When enabled is true, video track is re-enabled and transmission resumes
  Future<void> toggleVideo(bool enabled) async {
    if (_localStream == null) return;
    
    final videoTracks = _localStream!.getVideoTracks();
    if (videoTracks.isEmpty) return;
    
    for (final track in videoTracks) {
      track.enabled = enabled;
      debugPrint('📹 [WebRTC] Video track ${track.id} enabled: $enabled');
    }
    
    // For some platforms, we may need to update the sender as well
    if (_peerConnection != null) {
      try {
        final senders = await _peerConnection!.getSenders();
        for (final sender in senders) {
          if (sender.track?.kind == 'video') {
            // Ensure the track state is synchronized
            if (sender.track != null) {
              sender.track!.enabled = enabled;
            }
          }
        }
      } catch (e) {
        debugPrint('⚠️ [WebRTC] Could not update sender track: $e');
      }
    }
  }
  
  /// Switch camera (front/back)
  Future<void> switchCamera() async {
    final videoTrack = _localStream?.getVideoTracks().first;
    if (videoTrack != null) {
      await Helper.switchCamera(videoTrack);
    }
  }
  
  /// Enable/disable speaker
  Future<void> setSpeakerphone(bool enabled) async {
    // Speakerphone is not supported on Web or Windows desktop
    if (kIsWeb) {
      debugPrint('⚠️ [WebRTC] Speakerphone not supported on Web');
      return;
    }
    if (_isWindowsDesktop) {
      debugPrint('⚠️ [WebRTC] Speakerphone not supported on Windows');
      return;
    }
    try {
      await Helper.setSpeakerphoneOn(enabled);
    } catch (e) {
      debugPrint('⚠️ [WebRTC] Could not set speakerphone: $e');
    }
  }
  
  /// Get connection statistics
  Future<Map<String, dynamic>> getStats() async {
    final stats = await _peerConnection?.getStats();
    final result = <String, dynamic>{};
    
    stats?.forEach((report) {
      if (report.type == 'candidate-pair' && report.values['state'] == 'succeeded') {
        result['roundTripTime'] = report.values['currentRoundTripTime'];
        result['bytesReceived'] = report.values['bytesReceived'];
        result['bytesSent'] = report.values['bytesSent'];
      }
      if (report.type == 'inbound-rtp' && report.values['kind'] == 'video') {
        result['framesDecoded'] = report.values['framesDecoded'];
        result['packetsLost'] = report.values['packetsLost'];
        result['jitter'] = report.values['jitter'];
      }
    });
    
    return result;
  }
  
  /// Clean up and close connection
  Future<void> dispose() async {
    try {
      // Stop all tracks
      _localStream?.getTracks().forEach((track) {
        try {
          track.stop();
        } catch (e) {
          debugPrint('⚠️ [WebRTC] Could not stop track: $e');
        }
      });
      
      // Dispose streams with error handling
      try {
        await _localStream?.dispose();
      } catch (e) {
        debugPrint('⚠️ [WebRTC] Could not dispose local stream: $e');
      }
      
      try {
        await _remoteStream?.dispose();
      } catch (e) {
        debugPrint('⚠️ [WebRTC] Could not dispose remote stream: $e');
      }
      
      // Close peer connection
      try {
        await _peerConnection?.close();
      } catch (e) {
        debugPrint('⚠️ [WebRTC] Could not close peer connection: $e');
      }
    } catch (e) {
      debugPrint('⚠️ [WebRTC] Error during dispose: $e');
    } finally {
      _localStream = null;
      _remoteStream = null;
      _peerConnection = null;
      _hasRemoteDescription = false;
      _candidateQueue.clear();
    }
  }
  
  /// Restart ICE connection (for reconnection)
  Future<void> restartIce() async {
    await _peerConnection?.restartIce();
  }
}
