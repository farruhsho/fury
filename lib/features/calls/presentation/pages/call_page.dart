import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
// wakelock_plus is optional - add to pubspec.yaml if needed
// import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/call_entity.dart' hide CallQuality;
import '../bloc/call_bloc.dart';
import '../widgets/call_controls.dart';
import '../widgets/call_quality_indicator.dart';
import '../widgets/add_participant_sheet.dart';
import '../widgets/video_tile.dart';

class CallPage extends StatefulWidget {
  final String? callId;
  final String? chatId;
  final String recipientId;
  final String recipientName;
  final String? recipientAvatarUrl;
  final bool isVideo;
  final bool isIncoming;

  const CallPage({
    super.key,
    this.callId,
    this.chatId,
    this.recipientId = '',
    required this.recipientName,
    this.recipientAvatarUrl,
    this.isVideo = false,
    this.isIncoming = false,
  });

  @override
  State<CallPage> createState() => _CallPageState();
}

enum PipPosition { topLeft, topRight, bottomLeft, bottomRight }

class _CallPageState extends State<CallPage> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  bool _isLocalRendererInitialized = false;
  bool _isRemoteRendererInitialized = false;
  
  // UI State
  bool _isSwapped = false; // For 1-on-1: Swap local/remote
  bool _isFrontCamera = true;
  final PipPosition _pipPosition = PipPosition.bottomRight;
  bool _showControls = true;

  bool get _isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  void initState() {
    super.initState();
    // WakelockPlus.enable(); // Uncomment when wakelock_plus is added to pubspec.yaml
    _initRenderers();
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    setState(() {
      _isLocalRendererInitialized = true;
      _isRemoteRendererInitialized = true;
    });
  }

  @override
  void dispose() {
    // WakelockPlus.disable(); // Uncomment when wakelock_plus is added to pubspec.yaml
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  void _onSwitchCamera() {
    setState(() {
      _isFrontCamera = !_isFrontCamera;
    });
    context.read<CallBloc>().add(const CallEvent.switchCamera());
  }

  void _showAddParticipantSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) => AddParticipantSheet(
        currentParticipants: [widget.recipientId],
        onParticipantsSelected: (selectedIds) {
          context.read<CallBloc>().add(CallEvent.addParticipants(selectedIds));
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Inviting ${selectedIds.length} participant(s)...'),
              backgroundColor: const Color(0xFF00A884),
            ),
          );
        },
      ),
    );
  }

  void _updateRenderers(CallState state) {
    if (state.localStream != null && _isLocalRendererInitialized) {
      if (_localRenderer.srcObject?.id != state.localStream!.id) {
        _localRenderer.srcObject = state.localStream;
      }
    }
    if (state.remoteStream != null && _isRemoteRendererInitialized) {
      if (_remoteRenderer.srcObject?.id != state.remoteStream!.id) {
        _remoteRenderer.srcObject = state.remoteStream;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CallBloc, CallState>(
      listener: (context, state) {
        _updateRenderers(state);
        
        // Auto-close if call ended
        final status = state.currentCall?.status;
        if ((!state.isConnected && !state.isRinging && !state.isInitiating && !state.isIncoming) ||
            status == CallStatus.ended || 
            status == CallStatus.declined ||
            status == CallStatus.failed) {
           Navigator.of(context).pop();
        }
        
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      builder: (context, state) {
        final participantCount = state.currentCall?.participantIds.length ?? 2;
        final isGroupCall = participantCount > 2;

        return Scaffold(
          backgroundColor: Colors.black,
          body: GestureDetector(
            onTap: () => setState(() => _showControls = !_showControls),
            child: Stack(
              children: [
                // MAIN CONTENT LAYER
                if (widget.isVideo)
                  isGroupCall 
                      ? _buildGroupGridUI(state)
                      : _buildOneOnOneUI(state)
                else
                  _buildAudioUI(state),

                 // QUALITY INDICATOR (Top Right)
                if (_showControls && state.isConnected)
                  Positioned(
                    top: 16, // SafeArea handled by padding/margin usually, or wrap in SafeArea
                    right: 16,
                    child: SafeArea(
                      child: GestureDetector(
                        onTap: () => _showQualityDetails(context, state),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: CallQualityIndicator(
                            quality: _getCallQuality(state.callQualityScore),
                            size: 20,
                            showLabel: true,
                          ),
                        ),
                      ),
                    ),
                  ),

                // INCOMING CALL OVERLAY
                if (state.isIncoming && state.isRinging)
                  _buildIncomingOverlay(state),

                // BOTTOM CONTROLS
                if (_showControls && !state.isIncoming)
                  Positioned(
                    bottom: 32,
                    left: 0,
                    right: 0,
                    child: CallControls(
                      isMuted: state.isMuted,
                      isVideoEnabled: state.isVideoEnabled,
                      isSpeakerOn: state.isSpeakerOn,
                      isVideo: widget.isVideo,
                      isIncoming: false, // Handled by overlay
                      isConnected: state.isConnected,
                      onMuteToggle: () => context.read<CallBloc>().add(const CallEvent.toggleMute()),
                      onVideoToggle: () => context.read<CallBloc>().add(const CallEvent.toggleVideo()),
                      onSpeakerToggle: () => context.read<CallBloc>().add(const CallEvent.toggleSpeaker()),
                      onCameraSwitch: _isMobile ? _onSwitchCamera : null,
                      onEndCall: () => context.read<CallBloc>().add(const CallEvent.endCall()),
                      onAcceptCall: () {}, // Not used in active state
                      onDeclineCall: () {}, // Not used in active state
                      onAddParticipant: state.isConnected ? _showAddParticipantSheet : null,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- 1-ON-1 LAYOUT (PiP) ---
  Widget _buildOneOnOneUI(CallState state) {
    final hasRemote = state.remoteStream != null;
    final hasLocal = state.localStream != null;
    
    RTCVideoRenderer? mainRenderer = _isSwapped ? _localRenderer : _remoteRenderer;
    RTCVideoRenderer? smallRenderer = _isSwapped ? _remoteRenderer : _localRenderer;
    bool isMainLocal = _isSwapped;
    bool isSmallLocal = !_isSwapped;
    
    if (!hasRemote) {
      mainRenderer = _localRenderer;
      isMainLocal = true;
      smallRenderer = null; 
    }

    return Stack(
      children: [
        // FULL SCREEN
        Positioned.fill(
          child: ((isMainLocal ? hasLocal : hasRemote))
              ? RTCVideoView(
                  mainRenderer,
                  mirror: isMainLocal ? _isFrontCamera : false,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                )
              : Container(color: Colors.grey[900]),
        ),

        // PiP VIEW
        if (hasRemote && hasLocal)
          Positioned(
            top: _pipPosition == PipPosition.topLeft || _pipPosition == PipPosition.topRight ? 80 : null,
            bottom: _pipPosition == PipPosition.bottomLeft || _pipPosition == PipPosition.bottomRight ? 120 : null,
            left: _pipPosition == PipPosition.topLeft || _pipPosition == PipPosition.bottomLeft ? 16 : null,
            right: _pipPosition == PipPosition.topRight || _pipPosition == PipPosition.bottomRight ? 16 : null,
            child: VideoTile(
              renderer: smallRenderer,
              userName: isSmallLocal ? 'You' : (state.currentCall?.callerName ?? widget.recipientName),
              isLocal: isSmallLocal,
              isMuted: isSmallLocal ? state.isMuted : false,
              onTap: () => setState(() => _isSwapped = !_isSwapped),
            ),
          ),
      ],
    );
  }

  // --- GROUP GRID LAYOUT ---
  Widget _buildGroupGridUI(CallState state) {
    final participants = <Widget>[];
    
    // 1. ME
    participants.add(VideoTile(
      key: const ValueKey('local'),
      renderer: state.localStream != null ? _localRenderer : null,
      userName: 'You',
      isLocal: true,
      isMuted: state.isMuted,
    ));

    // 2. ACTIVE REMOTE (Stream holder)
    if (state.remoteStream != null) {
      participants.add(VideoTile(
        key: ValueKey('remote_${state.currentCall?.callerId ?? "unknown"}'),
        renderer: _remoteRenderer,
        userName: state.currentCall?.callerName ?? widget.recipientName,
        isLocal: false,
      ));
    }

    // 3. OTHERS (Placeholders)
    if (state.currentCall != null) {
      final myId = FirebaseAuth.instance.currentUser?.uid;
      final activeRemoteId = state.currentCall?.callerId; 
      
      for (final pid in state.currentCall!.participantIds) {
        if (pid == myId) continue;
        if (pid == activeRemoteId && state.remoteStream != null) continue; 
        
        participants.add(VideoTile(
          key: ValueKey(pid),
          userName: 'User ...${pid.substring(pid.length > 4 ? pid.length - 4 : 0)}', 
          isLocal: false,
        ));
      }
    }

    int crossAxisCount = participants.length > 4 ? 3 : 2;
    if (participants.length <= 1) crossAxisCount = 1;

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.only(top: 80, bottom: 120, left: 8, right: 8),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.7,
        ),
        itemCount: participants.length,
        itemBuilder: (context, index) => participants[index],
      ),
    );
  }

  // --- AUDIO UI ---
  Widget _buildAudioUI(CallState state) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primaryDark, Colors.black],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             CircleAvatar(
               radius: 60,
               backgroundColor: AppColors.primary.withValues(alpha: 0.3),
               backgroundImage: widget.recipientAvatarUrl != null
                   ? NetworkImage(widget.recipientAvatarUrl!)
                   : null,
               child: widget.recipientAvatarUrl == null
                   ? Text(
                        widget.recipientName.isNotEmpty ? widget.recipientName[0].toUpperCase() : '?',
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                     )
                   : null,
             ),
             const SizedBox(height: 24),
             Text(
               state.currentCall?.callerName ?? widget.recipientName,
               style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600),
             ),
             const SizedBox(height: 8),
             Text(
               _getCallStatusText(state),
               style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 16),
             ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncomingOverlay(CallState state) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.call, size: 64, color: Colors.green),
            const SizedBox(height: 32),
            Text('Incoming ${widget.isVideo ? 'Video' : 'Voice'} Call', style: const TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(height: 16),
            Text(widget.recipientName, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(Icons.call_end, Colors.red, 'Decline', () => context.read<CallBloc>().add(CallEvent.declineCall(widget.callId!))),
                _buildActionButton(Icons.call, Colors.green, 'Accept', () => context.read<CallBloc>().add(CallEvent.answerCall(widget.callId!))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, String label, VoidCallback onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: label, // Prevent tag conflicts
          onPressed: onTap,
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }

  void _showQualityDetails(BuildContext context, CallState state) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: CallQualityDetails(
          quality: _getCallQuality(state.callQualityScore),
          latencyMs: state.latencyMs,
          packetLossPercent: state.packetLossPercent,
          jitterMs: state.jitterMs,
        ),
      ),
    );
  }

  String _getCallStatusText(CallState state) {
    if (state.isIncoming && state.isRinging) return 'Входящий вызов...';
    if (state.isInitiating) return 'Соединение...';
    if (state.isRinging) return 'Вызов...';
    if (state.isConnected) return _formatDuration(state.callDuration);
    return 'Ожидание...';
  }

  CallQuality _getCallQuality(int score) {
    if (score >= 80) return CallQuality.excellent;
    if (score >= 60) return CallQuality.good;
    if (score >= 40) return CallQuality.fair;
    if (score >= 20) return CallQuality.poor;
    return CallQuality.disconnected;
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
