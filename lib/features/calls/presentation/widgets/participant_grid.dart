import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../../../app/theme/app_colors.dart';

/// Grid view of call participants (WhatsApp style)
class ParticipantGrid extends StatelessWidget {
  final RTCVideoRenderer? localRenderer;
  final Map<String, RTCVideoRenderer> remoteRenderers;
  final Map<String, String> participantNames;
  final bool isVideoEnabled;
  final String localUserId;

  const ParticipantGrid({
    super.key,
    required this.localRenderer,
    required this.remoteRenderers,
    required this.participantNames,
    required this.isVideoEnabled,
    required this.localUserId,
  });

  @override
  Widget build(BuildContext context) {
    final totalParticipants = remoteRenderers.length + 1; // +1 for local

    if (totalParticipants == 1) {
      // Only local user - full screen
      return _buildParticipantTile(
        renderer: localRenderer,
        name: 'You',
        isLocal: true,
        isVideoEnabled: isVideoEnabled,
        fullScreen: true,
      );
    }

    if (totalParticipants == 2) {
      // 2 participants - split screen vertically
      return Column(
        children: [
          Expanded(
            child: _buildParticipantTile(
              renderer: remoteRenderers.values.first,
              name: participantNames[remoteRenderers.keys.first] ?? 'Participant',
              isLocal: false,
              isVideoEnabled: true,
              fullScreen: true,
            ),
          ),
          Expanded(
            child: _buildParticipantTile(
              renderer: localRenderer,
              name: 'You',
              isLocal: true,
              isVideoEnabled: isVideoEnabled,
              fullScreen: true,
            ),
          ),
        ],
      );
    }

    // 3+ participants - grid layout
    return _buildGridLayout(totalParticipants);
  }

  Widget _buildGridLayout(int count) {
    final allParticipants = <Widget>[
      // Local participant first
      _buildParticipantTile(
        renderer: localRenderer,
        name: 'You',
        isLocal: true,
        isVideoEnabled: isVideoEnabled,
        fullScreen: false,
      ),
      // Remote participants
      ...remoteRenderers.entries.map((entry) {
        return _buildParticipantTile(
          renderer: entry.value,
          name: participantNames[entry.key] ?? 'Participant',
          isLocal: false,
          isVideoEnabled: true,
          fullScreen: false,
        );
      }),
    ];

    // Determine grid columns based on participant count
    int crossAxisCount;
    if (count <= 4) {
      crossAxisCount = 2;
    } else if (count <= 9) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 4;
    }

    return GridView.builder(
      padding: const EdgeInsets.all(4),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: allParticipants.length,
      itemBuilder: (context, index) => allParticipants[index],
    );
  }

  Widget _buildParticipantTile({
    required RTCVideoRenderer? renderer,
    required String name,
    required bool isLocal,
    required bool isVideoEnabled,
    required bool fullScreen,
  }) {
    return Container(
      margin: fullScreen ? EdgeInsets.zero : const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: fullScreen ? null : BorderRadius.circular(12),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Video or avatar
          if (renderer != null && renderer.srcObject != null && isVideoEnabled)
            RTCVideoView(
              renderer,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              mirror: isLocal,
            )
          else
            _buildAvatarPlaceholder(name, fullScreen),

          // Name label at bottom
          Positioned(
            left: 8,
            right: 8,
            bottom: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Mute indicator would go here
                  Flexible(
                    child: Text(
                      isLocal ? 'You' : name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isLocal) ...[
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.person,
                      color: Colors.white70,
                      size: 14,
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Connection quality indicator (top right)
          Positioned(
            top: 8,
            right: 8,
            child: _buildConnectionIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarPlaceholder(String name, bool fullScreen) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    final avatarSize = fullScreen ? 120.0 : 64.0;
    final fontSize = fullScreen ? 48.0 : 28.0;

    return Container(
      color: const Color(0xFF2A2A2A),
      child: Center(
        child: Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.primary.withValues(alpha: 0.7),
              ],
            ),
          ),
          child: Center(
            child: Text(
              initial,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConnectionIndicator() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSignalBar(true),
          const SizedBox(width: 1),
          _buildSignalBar(true),
          const SizedBox(width: 1),
          _buildSignalBar(true),
          const SizedBox(width: 1),
          _buildSignalBar(false),
        ],
      ),
    );
  }

  Widget _buildSignalBar(bool active) {
    return Container(
      width: 3,
      height: 10,
      decoration: BoxDecoration(
        color: active ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}

/// Single participant view for minimized mode
class ParticipantMiniView extends StatelessWidget {
  final RTCVideoRenderer? renderer;
  final String name;
  final bool isVideoEnabled;
  final VoidCallback? onTap;

  const ParticipantMiniView({
    super.key,
    required this.renderer,
    required this.name,
    required this.isVideoEnabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 140,
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (renderer != null && renderer!.srcObject != null && isVideoEnabled)
              RTCVideoView(
                renderer!,
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                mirror: true,
              )
            else
              Center(
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.5),
                  ),
                  child: Center(
                    child: Text(
                      name.isNotEmpty ? name[0].toUpperCase() : '?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            // Name label
            Positioned(
              left: 4,
              right: 4,
              bottom: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
