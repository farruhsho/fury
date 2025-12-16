import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../app/theme/app_colors.dart';
import '../../data/datasources/group_call_service.dart';
import '../widgets/group_call_controls.dart';
import '../widgets/participant_grid.dart';
import '../widgets/add_participant_sheet.dart';

/// Group call page with participant grid (WhatsApp style)
class GroupCallPage extends StatefulWidget {
  final String? callId;
  final String chatId;
  final String chatName;
  final List<String> participantIds;
  final bool isVideo;
  final bool isIncoming;

  const GroupCallPage({
    super.key,
    this.callId,
    required this.chatId,
    required this.chatName,
    required this.participantIds,
    this.isVideo = false,
    this.isIncoming = false,
  });

  @override
  State<GroupCallPage> createState() => _GroupCallPageState();
}

class _GroupCallPageState extends State<GroupCallPage> with TickerProviderStateMixin {
  late GroupCallService _groupCallService;

  final Map<String, RTCVideoRenderer> _renderers = {};
  RTCVideoRenderer? _localRenderer;

  bool _isMuted = false;
  bool _isVideoEnabled = true;
  bool _isSpeakerOn = true;
  bool _isConnecting = true;
  bool _showControls = true;

  int _callDuration = 0;
  Timer? _durationTimer;
  Timer? _hideControlsTimer;

  late AnimationController _pulseController;

  StreamSubscription? _remoteStreamsSubscription;
  StreamSubscription? _participantsSubscription;

  List<String> _participants = [];
  Map<String, String> _participantNames = {};

  @override
  void initState() {
    super.initState();
    _initializeCall();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _startHideControlsTimer();
  }

  Future<void> _initializeCall() async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) {
      Navigator.of(context).pop();
      return;
    }

    _groupCallService = GroupCallService(
      firestore: FirebaseFirestore.instance,
      currentUserId: currentUserId,
    );

    // Initialize local renderer
    _localRenderer = RTCVideoRenderer();
    await _localRenderer!.initialize();

    // Listen to remote streams
    _remoteStreamsSubscription = _groupCallService.remoteStreamsStream.listen((streams) async {
      for (final entry in streams.entries) {
        if (!_renderers.containsKey(entry.key)) {
          final renderer = RTCVideoRenderer();
          await renderer.initialize();
          renderer.srcObject = entry.value;
          setState(() {
            _renderers[entry.key] = renderer;
          });
        } else {
          _renderers[entry.key]!.srcObject = entry.value;
        }
      }

      // Remove disconnected participants
      final disconnected = _renderers.keys
          .where((id) => !streams.containsKey(id))
          .toList();
      for (final id in disconnected) {
        await _renderers[id]?.dispose();
        setState(() {
          _renderers.remove(id);
        });
      }
    });

    // Listen to participants
    _participantsSubscription = _groupCallService.participantsStream.listen((participants) {
      setState(() {
        _participants = participants;
      });
      _loadParticipantNames(participants);
    });

    try {
      if (widget.isIncoming && widget.callId != null) {
        // Join existing call
        await _groupCallService.joinGroupCall(widget.callId!, video: widget.isVideo);
      } else {
        // Create new call
        await _groupCallService.createGroupCall(
          chatId: widget.chatId,
          participantIds: widget.participantIds,
          type: widget.isVideo ? CallType.video : CallType.voice,
        );
      }

      // Set local stream to renderer
      if (_groupCallService.localStream != null && _localRenderer != null) {
        _localRenderer!.srcObject = _groupCallService.localStream;
      }

      setState(() {
        _isConnecting = false;
        _isVideoEnabled = widget.isVideo;
      });

      _startDurationTimer();
    } catch (e) {
      debugPrint('Failed to initialize call: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to start call: $e')),
        );
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> _loadParticipantNames(List<String> participantIds) async {
    for (final id in participantIds) {
      if (!_participantNames.containsKey(id)) {
        try {
          final doc = await FirebaseFirestore.instance
              .collection('users')
              .doc(id)
              .get();
          if (doc.exists) {
            setState(() {
              _participantNames[id] = doc.data()?['displayName'] ?? 'User';
            });
          }
        } catch (_) {}
      }
    }
  }

  void _startDurationTimer() {
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _callDuration++;
      });
    });
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) {
      _startHideControlsTimer();
    }
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
    _groupCallService.toggleAudio(!_isMuted);
  }

  void _toggleVideo() {
    setState(() {
      _isVideoEnabled = !_isVideoEnabled;
    });
    _groupCallService.toggleVideo(_isVideoEnabled);
  }

  Future<void> _toggleSpeaker() async {
    setState(() {
      _isSpeakerOn = !_isSpeakerOn;
    });
    try {
      await Helper.setSpeakerphoneOn(_isSpeakerOn);
    } catch (e) {
      debugPrint('Failed to toggle speaker: $e');
    }
  }

  Future<void> _switchCamera() async {
    await _groupCallService.switchCamera();
  }

  Future<void> _endCall() async {
    await _groupCallService.leaveCall();
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _showAddParticipantSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => AddParticipantSheet(
        currentParticipants: _participants,
        onParticipantsSelected: (selectedIds) async {
          // In a full implementation, you would signal these users
          // For now, just show a message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Inviting ${selectedIds.length} participants...')),
          );
        },
      ),
    );
  }

  String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _durationTimer?.cancel();
    _hideControlsTimer?.cancel();
    _pulseController.dispose();
    _remoteStreamsSubscription?.cancel();
    _participantsSubscription?.cancel();
    _localRenderer?.dispose();
    for (final renderer in _renderers.values) {
      renderer.dispose();
    }
    _groupCallService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B),
      body: GestureDetector(
        onTap: _toggleControls,
        child: SafeArea(
          child: Stack(
            children: [
              // Participant grid
              if (!_isConnecting)
                ParticipantGrid(
                  localRenderer: _localRenderer,
                  remoteRenderers: _renderers,
                  participantNames: _participantNames,
                  isVideoEnabled: _isVideoEnabled,
                  localUserId: FirebaseAuth.instance.currentUser?.uid ?? '',
                )
              else
                _buildConnectingState(),

              // Top bar
              AnimatedOpacity(
                opacity: _showControls ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: _buildTopBar(),
              ),

              // Controls
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                bottom: _showControls ? 32 : -100,
                left: 0,
                right: 0,
                child: GroupCallControls(
                  isMuted: _isMuted,
                  isVideoEnabled: _isVideoEnabled,
                  isSpeakerOn: _isSpeakerOn,
                  isVideo: widget.isVideo,
                  participantCount: _participants.length,
                  onMuteToggle: _toggleMute,
                  onVideoToggle: _toggleVideo,
                  onSpeakerToggle: _toggleSpeaker,
                  onCameraSwitch: _switchCamera,
                  onEndCall: _endCall,
                  onAddParticipant: _showAddParticipantSheet,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConnectingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated connecting indicator
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 100 + (_pulseController.value * 20),
                height: 100 + (_pulseController.value * 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.3 - (_pulseController.value * 0.2)),
                ),
                child: Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withOpacity(0.5),
                    ),
                    child: const Icon(
                      Icons.group_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          Text(
            widget.chatName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Connecting...',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.7),
            Colors.transparent,
          ],
        ),
      ),
      child: Row(
        children: [
          // Back button
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const SizedBox(width: 8),
          // Call info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.chatName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    if (!_isConnecting) ...[
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _formatDuration(_callDuration),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    const Icon(
                      Icons.person,
                      color: Colors.white70,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${_participants.length}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Encryption indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lock, color: Colors.green, size: 14),
                SizedBox(width: 4),
                Text(
                  'Encrypted',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
