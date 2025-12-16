import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_audio/just_audio.dart';
import '../../domain/entities/call_entity.dart';
import '../../domain/entities/media_settings.dart';
import '../../data/datasources/call_signaling_datasource.dart';
import '../../data/datasources/webrtc_service.dart';
import '../../../chat/domain/repositories/chat_repository.dart';

part 'call_bloc.freezed.dart';

@freezed
class CallEvent with _$CallEvent {
  const factory CallEvent.initiateCall({
    required String chatId,
    required String recipientId,
    required String recipientName,
    @Default(CallType.voice) CallType callType,
  }) = _InitiateCall;
  
  const factory CallEvent.answerCall(String callId) = _AnswerCall;
  
  const factory CallEvent.declineCall(String callId) = _DeclineCall;
  
  const factory CallEvent.endCall() = _EndCall;
  
  const factory CallEvent.toggleMute() = _ToggleMute;
  
  const factory CallEvent.toggleVideo() = _ToggleVideo;
  
  const factory CallEvent.switchCamera() = _SwitchCamera;
  
  const factory CallEvent.toggleSpeaker() = _ToggleSpeaker;
  
  const factory CallEvent.incomingCall(CallEntity incomingCallData) = _IncomingCall;
  
  const factory CallEvent.callStatusChanged(CallStatus status) = _CallStatusChanged;
  
  const factory CallEvent.remoteStreamReceived(MediaStream stream) = _RemoteStreamReceived;
  
  /// Update call quality stats from WebRTC
  const factory CallEvent.updateStats({
    required int latencyMs,
    required double packetLossPercent,
    required int jitterMs,
    required int duration,
  }) = _UpdateStats;
  
  const factory CallEvent.setVideoQuality(VideoQuality quality) = _SetVideoQuality;
  
  const factory CallEvent.updateAudioSettings(AudioSettings settings) = _UpdateAudioSettings;
  
  /// Add participants to the current group call
  const factory CallEvent.addParticipants(List<String> participantIds) = _AddParticipants;
}

@freezed
class CallState with _$CallState {
  const factory CallState({
    @Default(null) CallEntity? currentCall,
    @Default(false) bool isInitiating,
    @Default(false) bool isRinging,
    @Default(false) bool isConnected,
    @Default(false) bool isIncoming,
    @Default(false) bool isMuted,
    @Default(true) bool isVideoEnabled,
    @Default(false) bool isSpeakerOn,
    @Default(null) MediaStream? localStream,
    @Default(null) MediaStream? remoteStream,
    @Default(0) int callDuration,
    @Default(null) String? errorMessage,
    // Call quality stats
    @Default(null) int? latencyMs,
    @Default(null) double? packetLossPercent,
    @Default(null) int? jitterMs,
    @Default(0) int callQualityScore, // 0-100
    @Default(VideoQuality.auto) VideoQuality videoQuality,
    @Default(AudioSettings()) AudioSettings audioSettings,
  }) = _CallState;
}

class CallBloc extends Bloc<CallEvent, CallState> {
  final CallSignalingDatasource _signalingDatasource;
  final WebRTCService _webrtcService;
  final ChatRepository _chatRepository;
  
  Timer? _durationTimer;
  StreamSubscription? _callSubscription;
  StreamSubscription? _incomingCallSubscription;
  StreamSubscription? _iceCandidateSubscription;
  
  // Audio player only works on mobile platforms, not Windows desktop
  AudioPlayer? _ringtonePlayer;
  bool _isAudioSupported = false;
  
  String? _currentCallId;
  bool _isCallCaller = false;
  
  /// Stores the last parsed call entity from Firestore updates
  CallEntity? _lastParsedCall;
  
  /// Check if running on Windows desktop
  bool get _isWindowsDesktop {
    if (kIsWeb) return false;
    try {
      return Platform.isWindows;
    } catch (e) {
      return false;
    }
  }

  CallBloc({
    required CallSignalingDatasource signalingDatasource,
    required WebRTCService webrtcService,
    required ChatRepository chatRepository,
  })  : _signalingDatasource = signalingDatasource,
        _webrtcService = webrtcService,
        _chatRepository = chatRepository,
        super(const CallState()) {
    
    on<_InitiateCall>(_onInitiateCall);
    on<_AnswerCall>(_onAnswerCall);
    on<_DeclineCall>(_onDeclineCall);
    on<_EndCall>(_onEndCall);
    on<_ToggleMute>(_onToggleMute);
    on<_ToggleVideo>(_onToggleVideo);
    on<_SwitchCamera>(_onSwitchCamera);
    on<_ToggleSpeaker>(_onToggleSpeaker);
    on<_IncomingCall>(_onIncomingCall);
    on<_CallStatusChanged>(_onCallStatusChanged);
    on<_RemoteStreamReceived>(_onRemoteStreamReceived);
    on<_UpdateStats>(_onUpdateStats);
    on<_SetVideoQuality>(_onSetVideoQuality);
    on<_UpdateAudioSettings>(_onUpdateAudioSettings);
    on<_AddParticipants>(_onAddParticipants);
    
    // Initialize audio player only on supported platforms
    _initializeAudioPlayer();
    
    // Listen for incoming calls
    _startListeningForIncomingCalls();
  }
  
  void _initializeAudioPlayer() {
    try {
      // just_audio supports Android, iOS, macOS, and web
      // It does NOT support Windows desktop
      if (!_isWindowsDesktop) {
        _ringtonePlayer = AudioPlayer();
        _isAudioSupported = true;
        debugPrint('🔊 [CALL_BLOC] Audio player initialized');
      } else {
        debugPrint('⚠️ [CALL_BLOC] Audio not supported on Windows desktop');
      }
    } catch (e) {
      debugPrint('⚠️ [CALL_BLOC] Failed to initialize audio player: $e');
      _isAudioSupported = false;
    }
  }
  
  void _startListeningForIncomingCalls() {
    try {
      _incomingCallSubscription = _signalingDatasource
          .listenToIncomingCalls()
          .listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          final doc = snapshot.docs.first;
          final callData = doc.data();
          
          // Parse call entity from Firestore data
          final callEntity = CallEntity(
            id: callData['id'] as String? ?? doc.id,
            chatId: callData['chatId'] as String? ?? '',
            callerId: callData['callerId'] as String? ?? '',
            callerName: callData['callerName'] as String? ?? 'Unknown',
            callerAvatarUrl: callData['callerAvatarUrl'] as String?,
            participantIds: List<String>.from(callData['participantIds'] ?? []),
            type: CallType.values.byName(callData['type'] as String? ?? 'voice'),
            status: CallStatus.values.byName(callData['status'] as String? ?? 'ringing'),
            createdAt: (callData['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
          );
          
          // Only handle if we're not already in a call
          if (state.currentCall == null && !state.isConnected && !state.isInitiating) {
            add(CallEvent.incomingCall(callEntity));
          }
        }
      }, onError: (error) {
        // Silently handle errors (e.g., user not authenticated)
        // This can happen during sign-out or if auth expires
      });
    } catch (e) {
      // Silently handle errors during initialization
      // User may not be authenticated yet
    }
  }
  
  Future<void> _playCallerRingtone() async {
    if (!_isAudioSupported || _ringtonePlayer == null) return;
    try {
      // Don't play on web if not supported or on receiving end
      if (!_isCallCaller) return;
      if (kIsWeb) return; // Skip on web for now to avoid Source error if asset not found
      
      await _ringtonePlayer!.setAsset('assets/sounds/ringtone.mp3');
      await _ringtonePlayer!.setLoopMode(LoopMode.one);
      await _ringtonePlayer!.setVolume(0.5); // Lower volume for ear
      await _ringtonePlayer!.play();
    } catch (e) {
      debugPrint('⚠️ [CALL_BLOC] Could not play caller ringtone: $e');
    }
  }

  Future<void> _stopCallerRingtone() async {
    if (!_isAudioSupported || _ringtonePlayer == null) return;
    try {
      await _ringtonePlayer!.stop();
    } catch (e) {
      debugPrint('⚠️ [CALL_BLOC] Could not stop caller ringtone: $e');
    }
  }

  Future<void> _onInitiateCall(
    _InitiateCall event,
    Emitter<CallState> emit,
  ) async {
    try {
      debugPrint('📞 [CALL_BLOC] Initiating call to ${event.recipientId}');
      emit(state.copyWith(isInitiating: true, errorMessage: null));
      
      // Get current user data
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) throw Exception('Not authenticated');
      
      final callerName = currentUser.displayName ?? currentUser.email?.split('@').first ?? 'User';
      final callerAvatarUrl = currentUser.photoURL;
      
      // 1. Generate Call ID locally
      final callId = _signalingDatasource.generateCallId();
      debugPrint('📞 [CALL_BLOC] Generated local call ID: $callId');
      
      // 2. Set _currentCallId so ICE candidates can be sent immediately
      _currentCallId = callId;
      _isCallCaller = true;
      
      // 3. Initialize WebRTC and setup callbacks
      await _webrtcService.initialize();
      debugPrint('📞 [CALL_BLOC] WebRTC initialized');
      _setupWebRTCCallbacks(emit);
      
      // 4. Start listening for ICE candidates from callee (even before they exist)
      _listenToIceCandidates(callId, emit);
      
      // 5. Get local media
      final localStream = await _webrtcService.getLocalStream(
        video: event.callType == CallType.video || event.callType == CallType.groupVideo,
      );
      debugPrint('📞 [CALL_BLOC] Got local stream');
      
      emit(state.copyWith(
        localStream: localStream,
        isVideoEnabled: event.callType == CallType.video,
      ));
      
      // 6. Create offer - this generates ICE candidates which are sent to Firestore
      //    because _currentCallId is already set
      final offer = await _webrtcService.createOffer();
      debugPrint('📞 [CALL_BLOC] Created offer, SDP length: ${offer.sdp?.length ?? 0}');
      
      // 7. Create call in Firestore with the FULL offer
      await _signalingDatasource.createCall(
        callId: callId,
        chatId: event.chatId,
        recipientId: event.recipientId,
        type: event.callType,
        offer: offer.sdp!,
        callerName: callerName,
        callerAvatarUrl: callerAvatarUrl,
        recipientName: event.recipientName,
        recipientAvatarUrl: null,
      );
      debugPrint('📞 [CALL_BLOC] Call document created in Firestore with full offer');
      
      // 8. Start listening for call updates (e.g., answer)
      _listenToCallUpdates(callId, emit);
      
      emit(state.copyWith(
        isInitiating: false,
        isRinging: true,
      ));
      debugPrint('📞 [CALL_BLOC] Call initiated successfully');
      
      // Start ringtone
      _playCallerRingtone();
      
    } catch (e) {
      emit(state.copyWith(
        isInitiating: false,
        errorMessage: 'Failed to initiate call: $e',
      ));
    }
  }
  
  Future<void> _onAnswerCall(
    _AnswerCall event,
    Emitter<CallState> emit,
  ) async {
    try {
      debugPrint('📞 [CALL_BLOC] Answering call: ${event.callId}');
      emit(state.copyWith(isInitiating: true));
      
      // IMPORTANT: Set callId FIRST so ICE candidates can be sent
      _currentCallId = event.callId;
      _isCallCaller = false;
      
      // Get call data
      final callData = await _signalingDatasource.getCall(event.callId);
      if (callData == null) throw Exception('Call not found');
      debugPrint('📞 [CALL_BLOC] Got call data, offer exists: ${callData['offer'] != null}');
      
      // Initialize WebRTC
      await _webrtcService.initialize();
      debugPrint('📞 [CALL_BLOC] WebRTC initialized');
      
      // Setup callbacks - AFTER setting _currentCallId so ICE candidates are sent!
      _setupWebRTCCallbacks(emit);
      
      // Start listening for ICE candidates from caller BEFORE handling offer
      _listenToIceCandidates(event.callId, emit);
      
      // Determine call type
      final callType = CallType.values.byName(callData['type'] as String);
      debugPrint('📞 [CALL_BLOC] Call type: $callType');
      
      // Get local media
      final localStream = await _webrtcService.getLocalStream(
        video: callType == CallType.video || callType == CallType.groupVideo,
      );
      debugPrint('📞 [CALL_BLOC] Got local stream');
      
      emit(state.copyWith(localStream: localStream));
      
      // Handle offer from caller - this generates ICE candidates
      final offerSdp = callData['offer'] as String;
      debugPrint('📞 [CALL_BLOC] Offer SDP length: ${offerSdp.length}');
      final offer = RTCSessionDescription(offerSdp, 'offer');
      final answer = await _webrtcService.handleOffer(offer);
      debugPrint('📞 [CALL_BLOC] Created answer, SDP length: ${answer.sdp?.length ?? 0}');
      
      // Send answer
      await _signalingDatasource.answerCall(
        callId: event.callId,
        answer: answer.sdp!,
      );
      debugPrint('📞 [CALL_BLOC] Answer sent to Firestore');
      
      // Start listening for call updates
      _listenToCallUpdates(event.callId, emit);
      debugPrint('📞 [CALL_BLOC] Started listening for updates and ICE candidates');
      
      emit(state.copyWith(
        isInitiating: false,
        isRinging: false,
        isIncoming: false,
        isConnected: true,
      ));
      
      _startDurationTimer(emit);
      debugPrint('📞 [CALL_BLOC] Call answered successfully');
      
    } catch (e, stack) {
      debugPrint('❌ [CALL_BLOC] Failed to answer call: $e');
      debugPrint('❌ [CALL_BLOC] Stack: $stack');
      emit(state.copyWith(
        isInitiating: false,
        errorMessage: 'Failed to answer call: $e',
      ));
    }
  }
  
  Future<void> _onDeclineCall(
    _DeclineCall event,
    Emitter<CallState> emit,
  ) async {
    await _signalingDatasource.updateCallStatus(
      callId: event.callId,
      status: CallStatus.declined,
      endReason: CallEndReason.declined,
    );
    
    if (state.currentCall != null) {
       _chatRepository.sendMessage(
              chatId: state.currentCall!.chatId,
              text: 'Call declined',
       );
    }
    
    emit(const CallState());
  }
  
  Future<void> _onEndCall(
    _EndCall event,
    Emitter<CallState> emit,
  ) async {
    if (_currentCallId != null) {
      await _signalingDatasource.updateCallStatus(
        callId: _currentCallId!,
        status: CallStatus.ended,
        endReason: CallEndReason.completed,
      );
    }
    
    await _cleanup();
    emit(const CallState());
  }
  
  void _onToggleMute(_ToggleMute event, Emitter<CallState> emit) {
    final newMuteState = !state.isMuted;
    _webrtcService.toggleAudio(!newMuteState);
    emit(state.copyWith(isMuted: newMuteState));
  }
  
  Future<void> _onToggleVideo(_ToggleVideo event, Emitter<CallState> emit) async {
    final newVideoState = !state.isVideoEnabled;
    await _webrtcService.toggleVideo(newVideoState);
    emit(state.copyWith(isVideoEnabled: newVideoState));
  }
  
  Future<void> _onSwitchCamera(
    _SwitchCamera event,
    Emitter<CallState> emit,
  ) async {
    await _webrtcService.switchCamera();
  }
  
  Future<void> _onToggleSpeaker(
    _ToggleSpeaker event,
    Emitter<CallState> emit,
  ) async {
    final newSpeakerState = !state.isSpeakerOn;
    await _webrtcService.setSpeakerphone(newSpeakerState);
    emit(state.copyWith(isSpeakerOn: newSpeakerState));
  }
  
  void _onIncomingCall(_IncomingCall event, Emitter<CallState> emit) {
    emit(state.copyWith(
      currentCall: event.incomingCallData,
      isIncoming: true,
      isRinging: true,
    ));
  }
  
  void _onCallStatusChanged(_CallStatusChanged event, Emitter<CallState> emit) {
    // Update the currentCall if we have a parsed one
    final callToUse = _lastParsedCall ?? state.currentCall;
    
    switch (event.status) {
      case CallStatus.connected:
        _stopCallerRingtone();
        emit(state.copyWith(
          currentCall: callToUse,
          isConnected: true, 
          isRinging: false,
        ));
        _startDurationTimer(emit);
        break;
      case CallStatus.ended:
      case CallStatus.failed:
      case CallStatus.declined:
        _stopCallerRingtone();
        
        // Log call message
        if (state.currentCall != null) {
          final call = state.currentCall!;
          String? messageText;
          
          if (state.isConnected) {
             final durationStr = '${(state.callDuration ~/ 60).toString().padLeft(2, '0')}:${(state.callDuration % 60).toString().padLeft(2, '0')}';
             messageText = 'Call ended. Duration: $durationStr';
          } else if (state.isIncoming && event.status == CallStatus.ended) {
             // Missed call (ended remotely before connect)
             messageText = 'Missed call';
          } else if (event.status == CallStatus.declined) {
            // If I declined an incoming call
            if (state.isIncoming) {
               messageText = 'Call declined';
            }
          }
          
          if (messageText != null) {
            _chatRepository.sendMessage(
              chatId: call.chatId,
              text: messageText,
            );
          }
        }

        _cleanup();
        emit(const CallState());
        break;
      default:
        break;
    }
  }
  
  void _onRemoteStreamReceived(
    _RemoteStreamReceived event,
    Emitter<CallState> emit,
  ) {
    emit(state.copyWith(remoteStream: event.stream));
  }
  
  void _setupWebRTCCallbacks(Emitter<CallState> emit) {
    _webrtcService.onIceCandidate = (candidate) {
      if (_currentCallId != null) {
        debugPrint('📞 [CALL_BLOC] Sending ICE candidate (isCaller=$_isCallCaller)');
        _signalingDatasource.addIceCandidate(
          callId: _currentCallId!,
          candidate: IceCandidateEntity(
            candidate: candidate.candidate!,
            sdpMid: candidate.sdpMid!,
            sdpMLineIndex: candidate.sdpMLineIndex!,
          ),
          isFromCaller: _isCallCaller,
        );
      }
    };
    
    _webrtcService.onRemoteStream = (stream) {
      debugPrint('📞 [CALL_BLOC] Remote stream received!');
      add(CallEvent.remoteStreamReceived(stream));
    };
    
    _webrtcService.onConnectionStateChange = (state) {
      debugPrint('📞 [CALL_BLOC] Connection state changed: $state');
      if (state == RTCPeerConnectionState.RTCPeerConnectionStateConnected) {
        add(const CallEvent.callStatusChanged(CallStatus.connected));
      } else if (state == RTCPeerConnectionState.RTCPeerConnectionStateFailed) {
        add(const CallEvent.callStatusChanged(CallStatus.failed));
      }
    };
  }
  
  void _listenToCallUpdates(String callId, Emitter<CallState> emit) {
    debugPrint('📞 [CALL_BLOC] Starting to listen to call updates: $callId');
    _callSubscription = _signalingDatasource.listenToCall(callId).listen((snapshot) async {
      final data = snapshot.data();
      if (data == null) {
        debugPrint('📞 [CALL_BLOC] Call document is null');
        return;
      }
      
      final status = CallStatus.values.byName(data['status'] as String);
      final hasAnswer = data['answer'] != null;
      debugPrint('📞 [CALL_BLOC] Call update: status=$status, hasAnswer=$hasAnswer, isCaller=$_isCallCaller');
      
      // Parse full entity to get participants updates
      // Note: We update currentCall directly via callStatusChanged handler
      // which now also stores the parsed call entity
      try {
        final updatedCall = CallEntity(
          id: snapshot.id,
          chatId: data['chatId'] as String? ?? '',
          callerId: data['callerId'] as String? ?? '',
          callerName: data['callerName'] as String? ?? 'Unknown',
          callerAvatarUrl: data['callerAvatarUrl'] as String?,
          participantIds: List<String>.from(data['participantIds'] ?? []),
          type: CallType.values.byName(data['type'] as String? ?? 'voice'),
          status: status,
          createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
          duration: data['duration'] as int? ?? 0,
          endReason: data['endReason'] != null 
              ? CallEndReason.values.byName(data['endReason'] as String) 
              : null,
          offer: data['offer'] as String?,
          answer: data['answer'] as String?,
        );
        // Store the updated call entity - we'll pass it via a different mechanism
        _lastParsedCall = updatedCall;
      } catch (e) {
        debugPrint('⚠️ [CALL_BLOC] Failed to parse call update: $e');
      }

      // Handle answer from callee
      if (_isCallCaller && data['answer'] != null && status == CallStatus.connecting) {
        final answerSdp = data['answer'] as String;
        debugPrint('📞 [CALL_BLOC] CALLER: Received answer! SDP length: ${answerSdp.length}');
        final answer = RTCSessionDescription(answerSdp, 'answer');
        await _webrtcService.handleAnswer(answer);
        debugPrint('📞 [CALL_BLOC] CALLER: Answer set to remote description');
      }
      
      add(CallEvent.callStatusChanged(status));
    });
  }
  
  void _listenToIceCandidates(String callId, Emitter<CallState> emit) {
    debugPrint('📞 [CALL_BLOC] Starting to listen for ICE candidates (forCaller=${_isCallCaller})');
    _iceCandidateSubscription = _signalingDatasource
        .listenToIceCandidates(callId: callId, forCaller: _isCallCaller)
        .listen((snapshot) async {
      for (final doc in snapshot.docChanges) {
        if (doc.type == DocumentChangeType.added) {
          final data = doc.doc.data();
          if (data != null) {
            debugPrint('📞 [CALL_BLOC] Received ICE candidate from remote peer');
            final candidate = RTCIceCandidate(
              data['candidate'] as String,
              data['sdpMid'] as String,
              data['sdpMLineIndex'] as int,
            );
            await _webrtcService.addIceCandidate(candidate);
          }
        }
      }
    });
  }
  
  void _startDurationTimer(Emitter<CallState> emit) {
    _durationTimer?.cancel();
    int duration = 0;
    
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (_) async {
      duration++;
      
      // Collect WebRTC stats every 2 seconds
      if (duration % 2 == 0) {
        try {
          final stats = await _webrtcService.getStats();
          
          // Parse stats
          final rtt = stats['roundTripTime'];
          final packetsLost = stats['packetsLost'];
          final jitter = stats['jitter'];
          
          // Convert to usable values
          final latencyMs = rtt != null 
              ? (rtt is double ? (rtt * 1000).round() : rtt as int)
              : 50; // Default good latency
          final packetLoss = packetsLost != null 
              ? (packetsLost as int).toDouble() 
              : 0.0;
          final jitterMs = jitter != null 
              ? (jitter is double ? (jitter * 1000).round() : jitter as int)
              : 20; // Default good jitter
          
          add(CallEvent.updateStats(
            latencyMs: latencyMs,
            packetLossPercent: packetLoss,
            jitterMs: jitterMs,
            duration: duration,
          ));
          
          // Adaptive Quality Logic
          // If in Auto mode, check stats and adjust quality automatically
          if (state.videoQuality == VideoQuality.auto) {
             // Only adjust if we have valid stats
             if (packetLoss > 5.0 || latencyMs > 300) {
                // Network is bad -> Low Quality
                _webrtcService.changeVideoQuality(VideoQuality.low);
             } else if (packetLoss > 2.0 || latencyMs > 150) {
                // Network is mediocre -> Medium Quality
                _webrtcService.changeVideoQuality(VideoQuality.medium);
             } else {
                // Network is good -> High Quality (default)
                _webrtcService.changeVideoQuality(VideoQuality.high);
             }
          }
        } catch (_) {
          // If stats fail, just update duration with default good quality
          add(CallEvent.updateStats(
            latencyMs: 50,
            packetLossPercent: 0,
            jitterMs: 20,
            duration: duration,
          ));
        }
      } else {
        // Just update duration on odd seconds
        add(CallEvent.updateStats(
          latencyMs: state.latencyMs ?? 50,
          packetLossPercent: state.packetLossPercent ?? 0,
          jitterMs: state.jitterMs ?? 20,
          duration: duration,
        ));
      }
    });
  }
  
  /// Handle stats update event
  void _onUpdateStats(_UpdateStats event, Emitter<CallState> emit) {
    // Calculate quality score (0-100)
    int score = 100;
    
    // Latency penalty
    if (event.latencyMs > 300) {
      score -= 40;
    } else if (event.latencyMs > 200) {
      score -= 25;
    } else if (event.latencyMs > 100) {
      score -= 10;
    }
    
    // Packet loss penalty
    if (event.packetLossPercent > 10) {
      score -= 50;
    } else if (event.packetLossPercent > 5) {
      score -= 30;
    } else if (event.packetLossPercent > 1) {
      score -= 15;
    }
    
    // Jitter penalty
    if (event.jitterMs > 100) {
      score -= 20;
    } else if (event.jitterMs > 50) {
      score -= 10;
    }
    
    emit(state.copyWith(
      callDuration: event.duration,
      latencyMs: event.latencyMs,
      packetLossPercent: event.packetLossPercent,
      jitterMs: event.jitterMs,
      callQualityScore: score.clamp(0, 100),
    ));
  }

  Future<void> _onSetVideoQuality(
    _SetVideoQuality event,
    Emitter<CallState> emit,
  ) async {
    await _webrtcService.changeVideoQuality(event.quality);
    emit(state.copyWith(videoQuality: event.quality));
  }
  
  Future<void> _onUpdateAudioSettings(
    _UpdateAudioSettings event,
    Emitter<CallState> emit,
  ) async {
    await _webrtcService.updateAudioSettings(event.settings);
    emit(state.copyWith(audioSettings: event.settings));
  }
  
  /// Handle adding participants to a group call
  Future<void> _onAddParticipants(
    _AddParticipants event,
    Emitter<CallState> emit,
  ) async {
    if (_currentCallId == null) {
      debugPrint('⚠️ [CALL_BLOC] Cannot add participants: No active call');
      return;
    }
    
    try {
      debugPrint('📞 [CALL_BLOC] Adding ${event.participantIds.length} participants');
      
      // Get current call data
      final callDoc = await FirebaseFirestore.instance
          .collection('calls')
          .doc(_currentCallId)
          .get();
      
      if (!callDoc.exists) {
        debugPrint('⚠️ [CALL_BLOC] Call document not found');
        return;
      }
      
      final callData = callDoc.data()!;
      
      // Send call invitations to new participants
      for (final userId in event.participantIds) {
        await FirebaseFirestore.instance
            .collection('call_invitations')
            .doc('${_currentCallId}_$userId')
            .set({
          'callId': _currentCallId,
          'callerId': FirebaseAuth.instance.currentUser?.uid,
          'calleeId': userId,
          'type': callData['type'] ?? 'voice',
          'chatId': callData['chatId'] ?? '',
          'isGroupCall': true,
          'status': 'pending',
          'createdAt': FieldValue.serverTimestamp(),
        });
        debugPrint('📞 [CALL_BLOC] Sent call invitation to $userId');
      }
      
      // Update call document with new participant IDs
      await FirebaseFirestore.instance
          .collection('calls')
          .doc(_currentCallId)
          .update({
        'participantIds': FieldValue.arrayUnion(event.participantIds),
      });
      
      debugPrint('📞 [CALL_BLOC] Updated call with new participants');
    } catch (e) {
      debugPrint('❌ [CALL_BLOC] Failed to add participants: $e');
    }
  }
  
  Future<void> _cleanup() async {
    _durationTimer?.cancel();
    _callSubscription?.cancel();
    _iceCandidateSubscription?.cancel();
    await _webrtcService.dispose();
    _currentCallId = null;
  }
  
  @override
  Future<void> close() {
    _incomingCallSubscription?.cancel();
    _cleanup();
    return super.close();
  }
}
