import 'package:flutter/material.dart';

/// Call controls for group calls (WhatsApp style)
class GroupCallControls extends StatelessWidget {
  final bool isMuted;
  final bool isVideoEnabled;
  final bool isSpeakerOn;
  final bool isVideo;
  final int participantCount;
  final VoidCallback onMuteToggle;
  final VoidCallback onVideoToggle;
  final VoidCallback onSpeakerToggle;
  final VoidCallback onCameraSwitch;
  final VoidCallback onEndCall;
  final VoidCallback onAddParticipant;

  const GroupCallControls({
    super.key,
    required this.isMuted,
    required this.isVideoEnabled,
    required this.isSpeakerOn,
    required this.isVideo,
    required this.participantCount,
    required this.onMuteToggle,
    required this.onVideoToggle,
    required this.onSpeakerToggle,
    required this.onCameraSwitch,
    required this.onEndCall,
    required this.onAddParticipant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
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
              // Mute button
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

              // Speaker button
              _ControlButton(
                icon: isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                label: 'Speaker',
                isActive: isSpeakerOn,
                onTap: onSpeakerToggle,
              ),

              // Flip camera (only for video calls)
              if (isVideo)
                _ControlButton(
                  icon: Icons.flip_camera_ios,
                  label: 'Flip',
                  isActive: true,
                  onTap: onCameraSwitch,
                ),

              // Add participant
              _ControlButton(
                icon: Icons.person_add,
                label: 'Add',
                isActive: true,
                accentColor: const Color(0xFF00A884),
                onTap: onAddParticipant,
              ),
            ],
          ),

          const SizedBox(height: 20),

          // End call button
          GestureDetector(
            onTap: onEndCall,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.call_end,
                color: Colors.white,
                size: 32,
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
    final inactiveColor = Colors.white.withOpacity(0.3);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: isActive
                  ? (accentColor ?? Colors.white).withOpacity(0.15)
                  : Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive ? activeColor : inactiveColor,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: isActive ? activeColor : inactiveColor,
              size: 24,
            ),
          ),
          const SizedBox(height: 6),
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

/// Floating action button for adding participants
class AddParticipantFab extends StatelessWidget {
  final VoidCallback onTap;
  final int maxParticipants;
  final int currentParticipants;

  const AddParticipantFab({
    super.key,
    required this.onTap,
    this.maxParticipants = 8,
    required this.currentParticipants,
  });

  @override
  Widget build(BuildContext context) {
    final canAdd = currentParticipants < maxParticipants;

    return FloatingActionButton(
      onPressed: canAdd ? onTap : null,
      backgroundColor: canAdd ? const Color(0xFF00A884) : Colors.grey,
      child: const Icon(Icons.person_add, color: Colors.white),
    );
  }
}
