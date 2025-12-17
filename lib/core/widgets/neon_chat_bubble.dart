import 'dart:ui';
import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

/// 🔥 Neon Chat Bubble Styles
/// Glass-effect bubbles with neon accents
class NeonChatBubble extends StatelessWidget {
  final Widget child;
  final bool isOutgoing;
  final bool showTail;
  final bool isSelected;
  final VoidCallback? onLongPress;

  const NeonChatBubble({
    super.key,
    required this.child,
    required this.isOutgoing,
    this.showTail = true,
    this.isSelected = false,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
      bottomLeft: Radius.circular(isOutgoing ? 20 : (showTail ? 4 : 20)),
      bottomRight: Radius.circular(isOutgoing ? (showTail ? 4 : 20) : 20),
    );

    return GestureDetector(
      onLongPress: onLongPress,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(
          left: isOutgoing ? 60 : 8,
          right: isOutgoing ? 8 : 60,
          top: 2,
          bottom: 2,
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: isOutgoing
                    ? FuryColors.outgoingBubbleGradient
                    : null,
                color: isOutgoing ? null : FuryColors.incomingBubble,
                borderRadius: borderRadius,
                border: Border.all(
                  color: isSelected
                      ? FuryColors.neonPink
                      : (isOutgoing
                          ? FuryColors.neonPink.withValues(alpha: 0.2)
                          : FuryColors.cyberCyan.withValues(alpha: 0.1)),
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? FuryColors.neonPinkGlow(intensity: 0.5)
                    : null,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// Neon message text with status
class NeonMessageContent extends StatelessWidget {
  final String text;
  final String time;
  final bool isOutgoing;
  final MessageStatus status;
  final bool isEdited;

  const NeonMessageContent({
    super.key,
    required this.text,
    required this.time,
    required this.isOutgoing,
    this.status = MessageStatus.sent,
    this.isEdited = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isOutgoing ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: FuryColors.textPrimary,
            fontSize: 15,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isEdited) ...[
              Text(
                'edited',
                style: TextStyle(
                  color: FuryColors.textMuted.withValues(alpha: 0.6),
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              time,
              style: const TextStyle(
                color: FuryColors.textMuted,
                fontSize: 11,
              ),
            ),
            if (isOutgoing) ...[
              const SizedBox(width: 4),
              _buildStatusIcon(),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildStatusIcon() {
    IconData icon;
    Color color;

    switch (status) {
      case MessageStatus.sending:
        return const SizedBox(
          width: 14,
          height: 14,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            color: FuryColors.textMuted,
          ),
        );
      case MessageStatus.sent:
        icon = Icons.check;
        color = FuryColors.checkSent;
        break;
      case MessageStatus.delivered:
        icon = Icons.done_all;
        color = FuryColors.checkDelivered;
        break;
      case MessageStatus.read:
        icon = Icons.done_all;
        color = FuryColors.checkRead;
        break;
      case MessageStatus.failed:
        icon = Icons.error_outline;
        color = FuryColors.error;
        break;
    }

    return Icon(icon, size: 14, color: color);
  }
}

enum MessageStatus { sending, sent, delivered, read, failed }

/// Neon voice message player
class NeonVoiceMessage extends StatelessWidget {
  final Duration duration;
  final double progress;
  final bool isPlaying;
  final bool isOutgoing;
  final VoidCallback onPlayPause;

  const NeonVoiceMessage({
    super.key,
    required this.duration,
    required this.progress,
    required this.isPlaying,
    required this.isOutgoing,
    required this.onPlayPause,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = isOutgoing ? FuryColors.neonPink : FuryColors.cyberCyan;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Play/Pause button
        GestureDetector(
          onTap: onPlayPause,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: accentColor, width: 2),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.3),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: accentColor,
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: 12),
        
        // Waveform
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Waveform bars
              SizedBox(
                height: 24,
                child: CustomPaint(
                  painter: _WaveformPainter(
                    progress: progress,
                    activeColor: accentColor,
                    inactiveColor: FuryColors.textMuted.withValues(alpha: 0.3),
                  ),
                  size: const Size(double.infinity, 24),
                ),
              ),
              const SizedBox(height: 4),
              // Duration
              Text(
                _formatDuration(duration),
                style: const TextStyle(
                  color: FuryColors.textMuted,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

class _WaveformPainter extends CustomPainter {
  final double progress;
  final Color activeColor;
  final Color inactiveColor;

  _WaveformPainter({
    required this.progress,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const barCount = 30;
    final barWidth = size.width / barCount * 0.6;
    final gap = size.width / barCount * 0.4;
    
    // Simulated waveform heights
    final heights = List.generate(barCount, (i) {
      final x = i / barCount;
      return (0.3 + 0.7 * (1 - (x - 0.5).abs() * 2)) * 
             (0.5 + 0.5 * ((i * 7) % 11) / 10);
    });

    for (int i = 0; i < barCount; i++) {
      final x = i * (barWidth + gap);
      final height = heights[i] * size.height;
      final y = (size.height - height) / 2;
      
      final isActive = i / barCount <= progress;
      
      final paint = Paint()
        ..color = isActive ? activeColor : inactiveColor
        ..style = PaintingStyle.fill;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, barWidth, height),
          const Radius.circular(2),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _WaveformPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// Neon reaction chip
class NeonReaction extends StatelessWidget {
  final String emoji;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const NeonReaction({
    super.key,
    required this.emoji,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? FuryColors.neonPink.withValues(alpha: 0.2)
              : FuryColors.glassDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? FuryColors.neonPink
                : FuryColors.glassLight,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: FuryColors.neonPink.withValues(alpha: 0.3),
                    blurRadius: 8,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 14)),
            if (count > 1) ...[
              const SizedBox(width: 4),
              Text(
                count.toString(),
                style: TextStyle(
                  color: isSelected
                      ? FuryColors.neonPink
                      : FuryColors.textMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
