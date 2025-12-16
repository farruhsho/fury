import 'package:flutter/material.dart';

/// Call control buttons for voice/video calls (WhatsApp style)
class CallControls extends StatelessWidget {
  final bool isMuted;
  final bool isVideoEnabled;
  final bool isSpeakerOn;
  final bool isVideo;
  final bool isIncoming;
  final bool isConnected;
  final VoidCallback onMuteToggle;
  final VoidCallback onVideoToggle;
  final VoidCallback onSpeakerToggle;
  final VoidCallback? onCameraSwitch;
  final VoidCallback onEndCall;
  final VoidCallback onAcceptCall;
  final VoidCallback onDeclineCall;
  final VoidCallback? onAddParticipant;

  const CallControls({
    super.key,
    required this.isMuted,
    required this.isVideoEnabled,
    required this.isSpeakerOn,
    required this.isVideo,
    required this.isIncoming,
    required this.isConnected,
    required this.onMuteToggle,
    required this.onVideoToggle,
    required this.onSpeakerToggle,
    this.onCameraSwitch,
    required this.onEndCall,
    required this.onAcceptCall,
    required this.onDeclineCall,
    this.onAddParticipant,
  });

  @override
  Widget build(BuildContext context) {
    // Incoming call: show accept/decline buttons
    if (isIncoming && !isConnected) {
      return _buildIncomingCallControls();
    }

    // Active call controls
    return _buildActiveCallControls();
  }

  Widget _buildIncomingCallControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Decline button
          _AnimatedCallButton(
            icon: Icons.call_end,
            backgroundColor: const Color(0xFFEA4335),
            onTap: onDeclineCall,
            size: 72,
            label: 'Decline',
          ),
          // Accept button
          _AnimatedCallButton(
            icon: isVideo ? Icons.videocam : Icons.call,
            backgroundColor: const Color(0xFF00A884),
            onTap: onAcceptCall,
            size: 72,
            label: 'Accept',
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCallControls() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withOpacity(0.9),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main controls row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Speaker
              _ControlButton(
                icon: isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                label: 'Speaker',
                isActive: isSpeakerOn,
                onTap: onSpeakerToggle,
              ),

              // Mute
              _ControlButton(
                icon: isMuted ? Icons.mic_off : Icons.mic,
                label: isMuted ? 'Unmute' : 'Mute',
                isActive: !isMuted,
                onTap: onMuteToggle,
              ),

              // Video toggle (only for video calls)
              if (isVideo)
                _ControlButton(
                  icon: isVideoEnabled ? Icons.videocam : Icons.videocam_off,
                  label: isVideoEnabled ? 'Stop' : 'Video',
                  isActive: isVideoEnabled,
                  onTap: onVideoToggle,
                ),

              // Flip camera (only for video calls with callback)
              if (isVideo && onCameraSwitch != null)
                _ControlButton(
                  icon: Icons.flip_camera_ios,
                  label: 'Flip',
                  isActive: true,
                  onTap: onCameraSwitch!,
                ),

              // Add participant
              if (onAddParticipant != null)
                _ControlButton(
                  icon: Icons.person_add,
                  label: 'Add',
                  isActive: true,
                  accentColor: const Color(0xFF00A884),
                  onTap: onAddParticipant!,
                ),
            ],
          ),

          const SizedBox(height: 24),

          // End call button
          GestureDetector(
            onTap: onEndCall,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFEA4335),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFEA4335).withOpacity(0.4),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.call_end,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final Color? accentColor;
  final VoidCallback onTap;

  const _ControlButton({
    required this.icon,
    required this.label,
    required this.isActive,
    this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = accentColor ?? Colors.white;
    final inactiveColor = Colors.white.withOpacity(0.4);
    final bgColor = isActive
        ? (accentColor ?? Colors.white).withOpacity(0.15)
        : Colors.white.withOpacity(0.08);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive ? activeColor.withOpacity(0.5) : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Icon(
              icon,
              color: isActive ? activeColor : inactiveColor,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white70 : Colors.white38,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedCallButton extends StatefulWidget {
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onTap;
  final double size;
  final String label;

  const _AnimatedCallButton({
    required this.icon,
    required this.backgroundColor,
    required this.onTap,
    this.size = 64,
    required this.label,
  });

  @override
  State<_AnimatedCallButton> createState() => _AnimatedCallButtonState();
}

class _AnimatedCallButtonState extends State<_AnimatedCallButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: widget.backgroundColor == const Color(0xFF00A884)
                  ? _scaleAnimation.value
                  : 1.0,
              child: child,
            );
          },
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: widget.backgroundColor.withOpacity(0.4),
                    blurRadius: 16,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Icon(
                widget.icon,
                color: Colors.white,
                size: widget.size * 0.4,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

/// Compact call controls for PiP or minimized view
class CompactCallControls extends StatelessWidget {
  final bool isMuted;
  final VoidCallback onMuteToggle;
  final VoidCallback onEndCall;

  const CompactCallControls({
    super.key,
    required this.isMuted,
    required this.onMuteToggle,
    required this.onEndCall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CompactButton(
            icon: isMuted ? Icons.mic_off : Icons.mic,
            onTap: onMuteToggle,
          ),
          const SizedBox(width: 16),
          _CompactButton(
            icon: Icons.call_end,
            color: Colors.red,
            onTap: onEndCall,
          ),
        ],
      ),
    );
  }
}

class _CompactButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CompactButton({
    required this.icon,
    this.color = Colors.white,
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
          color: color == Colors.red ? Colors.red : Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
