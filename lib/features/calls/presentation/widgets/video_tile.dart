import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

/// A reusable tile for displaying a participant in a video call
class VideoTile extends StatelessWidget {
  final RTCVideoRenderer? renderer;
  final String userName;
  final String? avatarUrl;
  final bool isLocal;
  final bool isAudioOnly;
  final bool isMuted;
  final bool isSpeaking;
  final VoidCallback? onTap;

  const VideoTile({
    super.key,
    this.renderer,
    required this.userName,
    this.avatarUrl,
    this.isLocal = false,
    this.isAudioOnly = false,
    this.isMuted = false,
    this.isSpeaking = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
          border: isSpeaking ? Border.all(color: Colors.green, width: 3) : null,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            // Video Layer
            if (renderer != null && !isAudioOnly)
              Positioned.fill(
                child: RTCVideoView(
                  renderer!,
                  mirror: isLocal,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                ),
              )
            else
              // Avatar Placeholder
              Positioned.fill(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue.shade700,
                        backgroundImage: _getAvatarImage(avatarUrl),
                        child: _getAvatarImage(avatarUrl) == null
                            ? Text(
                                userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(height: 8),
                      // Only show name if no video
                      Text(
                        isLocal ? 'You' : userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Overlays
            Positioned(
              bottom: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isMuted)
                      const Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Icon(Icons.mic_off, color: Colors.red, size: 14),
                      ),
                    Text(
                      isLocal ? 'Me' : userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider? _getAvatarImage(String? url) {
    if (url == null || url.isEmpty || url == 'null') return null;
    if (url.startsWith('http')) return NetworkImage(url);
    return null;
  }
}
