import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../../features/calls/presentation/bloc/call_bloc.dart';
import '../../features/calls/domain/entities/call_entity.dart';
import '../../features/calls/data/datasources/call_signaling_datasource.dart';
import '../../features/calls/data/datasources/webrtc_service.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
import '../di/injection_container.dart';
import '../services/notification_service.dart';
import '../services/presence_service.dart';
import '../services/incoming_call_listener_service.dart';

/// Wrapper widget that provides global incoming call listening
/// Shows incoming call UI and active call as overlay via Stack
class GlobalCallHandler extends StatefulWidget {
  final Widget child;

  const GlobalCallHandler({
    super.key,
    required this.child,
  });

  @override
  State<GlobalCallHandler> createState() => _GlobalCallHandlerState();
}

class _GlobalCallHandlerState extends State<GlobalCallHandler> {
  CallBloc? _callBloc;
  PresenceService? _presenceService;
  IncomingCallListenerService? _callListenerService;
  
  // Call states
  IncomingCall? _incomingCall;
  bool _showIncomingOverlay = false;
  bool _showActiveCall = false;
  
  // Active call data (when accepted)
  String? _activeCallId;
  String? _activeCallerName;
  String? _activeCallerAvatar;
  bool _activeCallIsVideo = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(User? user) async {
    if (user != null && _callBloc == null) {
      _presenceService = sl<PresenceService>();
      await _presenceService?.initialize();
      
      _callListenerService = sl<IncomingCallListenerService>();
      await _callListenerService?.initialize(
        onIncomingCall: _handleIncomingCall,
        onCallEnded: _handleCallEnded,
        onCallAnswered: _handleCallAnswered,
      );
      
      setState(() {
        _callBloc = CallBloc(
          signalingDatasource: CallSignalingDatasource(),
          webrtcService: WebRTCService(),
          chatRepository: sl<ChatRepository>(),
        );
      });
      
      debugPrint('✅ [GLOBAL] Services initialized for user: ${user.uid}');
    } else if (user == null && _callBloc != null) {
      await _presenceService?.dispose();
      await _callListenerService?.dispose();
      _callBloc?.close();
      
      setState(() {
        _callBloc = null;
        _presenceService = null;
        _callListenerService = null;
        _incomingCall = null;
        _showIncomingOverlay = false;
        _showActiveCall = false;
      });
      
      debugPrint('🔴 [GLOBAL] Services disposed');
    }
  }

  void _handleIncomingCall(IncomingCall call) {
    if (_showIncomingOverlay || _showActiveCall) return;
    
    debugPrint('📞 [GLOBAL] Showing incoming call overlay for: ${call.callerName}');
    
    // Try to show notification - may fail on Windows
    try {
      sl<NotificationService>().showCallNotification(
        callId: call.id,
        callerName: call.callerName,
        isVideo: call.isVideo,
      );
    } catch (e) {
      debugPrint('⚠️ [GLOBAL] Could not show call notification: $e');
    }
    
    setState(() {
      _incomingCall = call;
      _showIncomingOverlay = true;
    });
  }

  void _acceptCall() async {
    final call = _incomingCall;
    if (call == null) return;
    
    debugPrint('✅ [GLOBAL] Accepting call: ${call.id}');
    
    // Mark this call as answered locally (to ignore removed event from listener)
    _callListenerService?.markCallAsAnswered(call.id);
    // Stop notification and ringtone
    await _callListenerService?.cancelNotificationAndRingtone(call.id);
    
    // Initialize WebRTC and send answer - CallBloc handles full signaling
    if (_callBloc != null) {
      _callBloc!.add(CallEvent.answerCall(call.id));
    }
    
    setState(() {
      _showIncomingOverlay = false;
      _incomingCall = null;
      
      // Show active call screen
      _showActiveCall = true;
      _activeCallId = call.id;
      _activeCallerName = call.callerName;
      _activeCallerAvatar = call.callerAvatar;
      _activeCallIsVideo = call.isVideo;
    });
  }

  void _declineCall({String? message}) async {
    final call = _incomingCall;
    if (call == null) return;
    
    debugPrint('❌ [GLOBAL] Declining call: ${call.id} (msg: $message)');
    
    // Use Bloc to decline if available (handles logging and status update)
    if (_callBloc != null) {
      _callBloc!.add(CallEvent.declineCall(call.id));
    } else {
      // Fallback if bloc not ready (unlikely)
      await _callListenerService?.declineCall(call.id);
    }
    
    setState(() {
      _showIncomingOverlay = false;
      _incomingCall = null;
    });
  }

  void _endActiveCall() async {
    debugPrint('📞 [GLOBAL] Ending active call');
    
    final callId = _activeCallId;
    
    if (_callBloc != null && callId != null) {
      _callBloc!.add(const CallEvent.endCall());
      await _callListenerService?.endCall(callId);
    }
    
    setState(() {
      _showActiveCall = false;
      _activeCallId = null;
      _activeCallerName = null;
      _activeCallerAvatar = null;
    });
  }

  void _handleCallEnded(String callId) {
    debugPrint('📞 [GLOBAL] Call ended: $callId');
    
    if (_incomingCall?.id == callId) {
      setState(() {
        _showIncomingOverlay = false;
        _incomingCall = null;
      });
    }
    
    if (_activeCallId == callId) {
      setState(() {
        _showActiveCall = false;
        _activeCallId = null;
      });
    }
  }

  void _handleCallAnswered(String callId) {
    debugPrint('📞 [GLOBAL] Call answered elsewhere: $callId');
    
    // If this was our incoming call, hide it (answered on another device)
    if (_incomingCall?.id == callId && !_showActiveCall) {
      setState(() {
        _showIncomingOverlay = false;
        _incomingCall = null;
      });
    }
  }

  @override
  void dispose() {
    _callBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;
    
    if (_callBloc != null) {
      child = BlocProvider.value(
        value: _callBloc!,
        child: BlocListener<CallBloc, CallState>(
          listener: (context, state) {
            // Auto-end call when state is reset (all flags false) or status is ended/failed
            final status = state.currentCall?.status;
            final isCallEnded = status == CallStatus.ended || status == CallStatus.failed;
            final isStateReset = !state.isConnected && !state.isRinging && !state.isInitiating && !state.isIncoming;

            if (_showActiveCall && (isCallEnded || isStateReset)) {
              Future.delayed(const Duration(milliseconds: 500), () {
                if (mounted && _showActiveCall) {
                  setState(() {
                    _showActiveCall = false;
                    _activeCallId = null;
                    _activeCallerName = null;
                    _activeCallerAvatar = null;
                  });
                }
              });
            }
          },
          child: widget.child,
        ),
      );
    }

    // Stack overlays
    return Stack(
      children: [
        child,
        
        // Active call overlay (full screen)
        if (_showActiveCall && _activeCallId != null && _callBloc != null)
          Positioned.fill(
            child: Material(
              color: Colors.black,
              child: BlocProvider.value(
                value: _callBloc!,
                child: _ActiveCallScreen(
                  callId: _activeCallId!,
                  callerName: _activeCallerName ?? 'Unknown',
                  callerAvatar: _activeCallerAvatar,
                  isVideo: _activeCallIsVideo,
                  onEndCall: _endActiveCall,
                ),
              ),
            ),
          ),
        
        // Incoming call overlay
        if (_showIncomingOverlay && _incomingCall != null)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: _IncomingCallOverlay(
                  call: _incomingCall!,
                  onAccept: _acceptCall,
                  onDecline: () => _declineCall(),
                  onQuickReject: (message) => _declineCall(message: message),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Active call screen (simplified version of CallPage)
class _ActiveCallScreen extends StatefulWidget {
  final String callId;
  final String callerName;
  final String? callerAvatar;
  final bool isVideo;
  final VoidCallback onEndCall;

  const _ActiveCallScreen({
    required this.callId,
    required this.callerName,
    this.callerAvatar,
    required this.isVideo,
    required this.onEndCall,
  });

  @override
  State<_ActiveCallScreen> createState() => _ActiveCallScreenState();
}

class _ActiveCallScreenState extends State<_ActiveCallScreen> {
  RTCVideoRenderer? _remoteRenderer;
  RTCVideoRenderer? _localRenderer;
  bool _rendererInitialized = false;

  @override
  void initState() {
    super.initState();
    _initRenderers();
  }

  Future<void> _initRenderers() async {
    _remoteRenderer = RTCVideoRenderer();
    _localRenderer = RTCVideoRenderer();
    await _remoteRenderer!.initialize();
    await _localRenderer!.initialize();
    setState(() {
      _rendererInitialized = true;
    });
    debugPrint('📞 [CALL_SCREEN] Renderers initialized');
  }

  @override
  void dispose() {
    _remoteRenderer?.dispose();
    _localRenderer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CallBloc, CallState>(
      listener: (context, state) {
        // Attach streams to renderers when received
        if (_rendererInitialized) {
          if (state.remoteStream != null && _remoteRenderer != null) {
            if (_remoteRenderer!.srcObject != state.remoteStream) {
              _remoteRenderer!.srcObject = state.remoteStream;
              debugPrint('📞 [CALL_SCREEN] Attached remote stream to renderer');
            }
          }
          if (state.localStream != null && _localRenderer != null) {
            if (_localRenderer!.srcObject != state.localStream) {
              _localRenderer!.srcObject = state.localStream;
              debugPrint('📞 [CALL_SCREEN] Attached local stream to renderer');
            }
          }
        }
      },
      builder: (context, state) {
        // Video call UI
        if (widget.isVideo && _rendererInitialized) {
          return _buildVideoCallUI(context, state);
        }
        // Voice call UI
        return _buildVoiceCallUI(context, state);
      },
    );
  }

  Widget _buildVideoCallUI(BuildContext context, CallState state) {
    return Stack(
      children: [
        // Remote video (full screen)
        if (state.remoteStream != null && _remoteRenderer != null)
          Positioned.fill(
            child: RTCVideoView(
              _remoteRenderer!,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
          )
        else
          // Placeholder when no remote video
          Positioned.fill(
            child: Container(
              color: Colors.grey[900],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue.shade400,
                      backgroundImage: _getValidAvatarImage(widget.callerAvatar),
                      child: _getValidAvatarImage(widget.callerAvatar) == null
                          ? Text(
                              widget.callerName.isNotEmpty
                                  ? widget.callerName[0].toUpperCase()
                                  : '?',
                              style: const TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.callerName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getStatusText(state),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        // Local video (picture-in-picture)
        if (state.localStream != null && _localRenderer != null && state.isVideoEnabled)
          Positioned(
            top: 48,
            right: 16,
            child: GestureDetector(
              onTap: () => context.read<CallBloc>().add(const CallEvent.switchCamera()),
              child: Container(
                width: 100,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                clipBehavior: Clip.hardEdge,
                child: RTCVideoView(
                  _localRenderer!,
                  mirror: true,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                ),
              ),
            ),
          ),

        // Top bar with status and duration
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: widget.onEndCall,
                  ),
                  const Spacer(),
                  if (state.isConnected)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        _formatDuration(state.callDuration),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  else
                    Text(
                      _getStatusText(state),
                      style: const TextStyle(color: Colors.white70),
                    ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),
        ),

        // Controls
        Positioned(
          bottom: 32,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Mute
                _CallControl(
                  icon: state.isMuted ? Icons.mic_off : Icons.mic,
                  label: state.isMuted ? 'Вкл' : 'Выкл',
                  isActive: !state.isMuted,
                  onTap: () {
                    context.read<CallBloc>().add(const CallEvent.toggleMute());
                  },
                ),

                // Video toggle
                _CallControl(
                  icon: state.isVideoEnabled ? Icons.videocam : Icons.videocam_off,
                  label: state.isVideoEnabled ? 'Видео' : 'Видео',
                  isActive: state.isVideoEnabled,
                  onTap: () {
                    context.read<CallBloc>().add(const CallEvent.toggleVideo());
                  },
                ),

                // End call
                _CallControl(
                  icon: Icons.call_end,
                  label: 'Завершить',
                  isRed: true,
                  onTap: widget.onEndCall,
                ),

                // Switch camera
                _CallControl(
                  icon: Icons.flip_camera_ios,
                  label: 'Камера',
                  onTap: () {
                    context.read<CallBloc>().add(const CallEvent.switchCamera());
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVoiceCallUI(BuildContext context, CallState state) {
    return SafeArea(
      child: Stack(
        children: [
          // Background gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.shade900,
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),

          // Main content
          Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: widget.onEndCall,
                    ),
                    const Spacer(),
                    if (state.isConnected)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          _formatDuration(state.callDuration),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    else
                      Text(
                        _getStatusText(state),
                        style: const TextStyle(color: Colors.white70),
                      ),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // Main content
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.blue.shade400,
                        backgroundImage: _getValidAvatarImage(widget.callerAvatar),
                        child: _getValidAvatarImage(widget.callerAvatar) == null
                            ? Text(
                                widget.callerName.isNotEmpty
                                    ? widget.callerName[0].toUpperCase()
                                    : '?',
                                style: const TextStyle(
                                  fontSize: 48,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(height: 24),

                      // Name
                      Text(
                        widget.callerName,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Status
                      Text(
                        _getStatusText(state),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[400],
                        ),
                      ),

                      // Hidden video renderer for audio playback (WebRTC requirement)
                      if (_remoteRenderer != null && _rendererInitialized)
                        SizedBox(
                          width: 1,
                          height: 1,
                          child: RTCVideoView(_remoteRenderer!),
                        ),
                    ],
                  ),
                ),
              ),

              // Controls
              Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Mute
                    _CallControl(
                      icon: state.isMuted ? Icons.mic_off : Icons.mic,
                      label: state.isMuted ? 'Вкл' : 'Выкл',
                      isActive: !state.isMuted,
                      onTap: () {
                        context.read<CallBloc>().add(const CallEvent.toggleMute());
                      },
                    ),

                    // End call
                    _CallControl(
                      icon: Icons.call_end,
                      label: 'Завершить',
                      isRed: true,
                      onTap: widget.onEndCall,
                    ),

                    // Speaker
                    _CallControl(
                      icon: state.isSpeakerOn ? Icons.volume_up : Icons.volume_down,
                      label: state.isSpeakerOn ? 'Динамик' : 'Телефон',
                      isActive: state.isSpeakerOn,
                      onTap: () {
                        context.read<CallBloc>().add(const CallEvent.toggleSpeaker());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getStatusText(CallState state) {
    final status = state.currentCall?.status;
    if (state.isInitiating) return 'Соединение...';
    if (state.isConnected) return 'Подключено';
    if (state.isRinging) return 'Вызов...';
    if (status == CallStatus.ended) return 'Завершён';
    if (status == CallStatus.failed) return 'Ошибка';
    if (status == CallStatus.connecting || status == CallStatus.active) return 'Соединение...';
    return 'В звонке';
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
  
  /// Returns a valid NetworkImage or null if the URL is empty/invalid
  ImageProvider? _getValidAvatarImage(String? url) {
    if (url == null || url.isEmpty || url == 'null') {
      return null;
    }
    // Check if it's a valid URL (starts with http or https)
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return NetworkImage(url);
    }
    return null;
  }
}

class _CallControl extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final bool isRed;
  final VoidCallback onTap;

  const _CallControl({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.isRed = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isRed 
                  ? Colors.red 
                  : (isActive ? Colors.white : Colors.grey[800]),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isRed ? Colors.white : (isActive ? Colors.black : Colors.white70),
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

/// Incoming call banner widget
class _IncomingCallOverlay extends StatelessWidget {
  final IncomingCall call;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final Function(String) onQuickReject;

  const _IncomingCallOverlay({
    required this.call,
    required this.onAccept,
    required this.onDecline,
    required this.onQuickReject,
  });

  void _showQuickRejectSheet(BuildContext context) {
    // Use a simple overlay dialog instead of showModalBottomSheet
    // to avoid Navigator context issues
    showDialog(
      context: context,
      barrierDismissible: true,
      useRootNavigator: true,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Quick Reply',
                  style: Theme.of(dialogContext).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                _buildQuickReplyButton(dialogContext, "I can't talk right now."),
                _buildQuickReplyButton(dialogContext, "I'll call you back later."),
                _buildQuickReplyButton(dialogContext, "I'm driving."),
                _buildQuickReplyButton(dialogContext, "In a meeting."),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickReplyButton(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: OutlinedButton(
        onPressed: () {
          Navigator.of(context).pop();
          onQuickReject(text);
        },
        child: Text(text, textAlign: TextAlign.center),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! < -500) {
          // Swipe Up - Accept
          onAccept();
        } else if (details.primaryVelocity! > 500) {
          // Swipe Down - Decline
          onDecline();
        }
      },
      child: Card(
        elevation: 8,
        color: const Color(0xFF1E1E2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.blue.shade400,
                backgroundImage: _getValidAvatarImage(call.callerAvatar),
                child: _getValidAvatarImage(call.callerAvatar) == null
                    ? Text(
                        call.callerName.isNotEmpty 
                            ? call.callerName[0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      call.callerName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          call.isVideo ? Icons.videocam : Icons.call,
                          color: Colors.white70,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            call.isVideo ? 'Video Call' : 'Incoming Call',
                            style: const TextStyle(color: Colors.white70, fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 8),
              
              // Actions - using GestureDetector instead of IconButton to avoid tooltip issues
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ActionButton(
                    icon: Icons.message,
                    color: Colors.white,
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    onTap: () => _showQuickRejectSheet(context),
                  ),
                  const SizedBox(width: 8),
                  _ActionButton(
                    icon: Icons.call_end,
                    color: Colors.red,
                    backgroundColor: Colors.red.withValues(alpha: 0.2),
                    onTap: onDecline,
                  ),
                  const SizedBox(width: 8),
                  _ActionButton(
                    icon: Icons.call,
                    color: Colors.green,
                    backgroundColor: Colors.green.withValues(alpha: 0.2),
                    onTap: onAccept,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  /// Returns a valid NetworkImage or null if the URL is empty/invalid
  ImageProvider? _getValidAvatarImage(String? url) {
    if (url == null || url.isEmpty || url == 'null') {
      return null;
    }
    // Check if it's a valid URL (starts with http or https)
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return NetworkImage(url);
    }
    return null;
  }
}

/// Simple action button without tooltip to avoid Overlay requirement
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}

