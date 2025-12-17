import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/message_entity.dart';

/// WhatsApp-style group message bubble with avatar and sender name
class GroupMessageBubble extends StatelessWidget {
  final MessageEntity message;
  final bool isMe;
  final bool showAvatar;  // Show avatar for first message in a group from same sender
  final bool showSenderName;  // Show sender name for group chats
  final String? senderName;
  final String? senderAvatarUrl;
  final String? senderPhoneNumber;
  final Color? senderNameColor;

  const GroupMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.showAvatar = true,
    this.showSenderName = true,
    this.senderName,
    this.senderAvatarUrl,
    this.senderPhoneNumber,
    this.senderNameColor,
  });

  // Generate consistent color for sender name based on their ID
  Color _getSenderColor(String senderId) {
    final colors = [
      const Color(0xFFE91E63), // Pink
      const Color(0xFF9C27B0), // Purple
      const Color(0xFF673AB7), // Deep Purple
      const Color(0xFF3F51B5), // Indigo
      const Color(0xFF2196F3), // Blue
      const Color(0xFF00BCD4), // Cyan
      const Color(0xFF009688), // Teal
      const Color(0xFF4CAF50), // Green
      const Color(0xFFFF9800), // Orange
      const Color(0xFFFF5722), // Deep Orange
    ];
    final index = senderId.hashCode.abs() % colors.length;
    return colors[index];
  }

  @override
  Widget build(BuildContext context) {
    final nameColor = senderNameColor ?? _getSenderColor(message.senderId);
    
    return Padding(
      padding: EdgeInsets.only(
        left: isMe ? 48 : AppSpacing.sm,
        right: isMe ? AppSpacing.sm : 48,
        top: AppSpacing.xs,
        bottom: AppSpacing.xs,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          // Avatar for incoming messages
          if (!isMe && showAvatar) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: nameColor.withValues(alpha: 0.2),
              backgroundImage: senderAvatarUrl != null 
                  ? NetworkImage(senderAvatarUrl!) 
                  : null,
              child: senderAvatarUrl == null
                  ? Text(
                      (senderName?.isNotEmpty == true ? senderName![0] : '?').toUpperCase(),
                      style: TextStyle(
                        color: nameColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
          ] else if (!isMe) ...[
            const SizedBox(width: 40), // Space for alignment when avatar hidden
          ],
          
          // Message bubble
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: isMe ? AppColors.primary : AppColors.surfaceLight,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(AppSpacing.radiusLg),
                  topRight: const Radius.circular(AppSpacing.radiusLg),
                  bottomLeft: isMe ? const Radius.circular(AppSpacing.radiusLg) : Radius.zero,
                  bottomRight: isMe ? Radius.zero : const Radius.circular(AppSpacing.radiusLg),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sender name and phone (for group chats)
                  if (!isMe && showSenderName) ...[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          senderName ?? 'Unknown',
                          style: AppTypography.caption.copyWith(
                            color: nameColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (senderPhoneNumber != null) ...[
                          const SizedBox(width: 8),
                          Text(
                            senderPhoneNumber!,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondaryLight,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                  
                  // Forwarded label
                  if (message.forwardedFrom != null) ...[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.reply,
                          size: 12,
                          color: isMe ? Colors.white60 : AppColors.textSecondaryLight,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Пересланное сообщение',
                          style: AppTypography.caption.copyWith(
                            color: isMe ? Colors.white60 : AppColors.textSecondaryLight,
                            fontStyle: FontStyle.italic,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                  
                  // Message content
                  Text(
                    message.text ?? '',
                    style: AppTypography.bodyMedium.copyWith(
                      color: isMe ? Colors.white : AppColors.textPrimaryLight,
                    ),
                  ),
                  
                  const SizedBox(height: 2),
                  
                  // Time and status
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateFormat.Hm().format(message.createdAt),
                        style: AppTypography.caption.copyWith(
                          color: isMe ? Colors.white.withValues(alpha: 0.7) : AppColors.textSecondaryLight,
                          fontSize: 10,
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 4),
                        _buildStatusIcon(),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon() {
    IconData icon;
    Color color;
    
    switch (message.status) {
      case MessageStatus.sending:
        icon = Icons.access_time;
        color = Colors.white.withValues(alpha: 0.5);
        break;
      case MessageStatus.sent:
        icon = Icons.done;
        color = Colors.white.withValues(alpha: 0.7);
        break;
      case MessageStatus.delivered:
        icon = Icons.done_all;
        color = Colors.white.withValues(alpha: 0.7);
        break;
      case MessageStatus.read:
        icon = Icons.done_all;
        color = Colors.lightBlueAccent;
        break;
      case MessageStatus.failed:
        icon = Icons.error_outline;
        color = Colors.red.shade300;
        break;
    }
    
    return Icon(icon, size: 14, color: color);
  }
}

/// Audio message bubble with waveform visualization
class AudioMessageBubble extends StatefulWidget {
  final MessageEntity message;
  final bool isMe;
  final String? senderName;
  final String? senderAvatarUrl;
  final String? senderPhoneNumber;
  final Duration? duration;
  final List<double>? waveform;

  const AudioMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.senderName,
    this.senderAvatarUrl,
    this.senderPhoneNumber,
    this.duration,
    this.waveform,
  });

  @override
  State<AudioMessageBubble> createState() => _AudioMessageBubbleState();
}

class _AudioMessageBubbleState extends State<AudioMessageBubble> {
  bool _isPlaying = false;
  final double _progress = 0.0;

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final duration = widget.duration ?? const Duration(seconds: 0);
    final waveform = widget.waveform ?? List.generate(30, (i) => (i % 3 + 1) * 0.3);
    
    return Padding(
      padding: EdgeInsets.only(
        left: widget.isMe ? 48 : AppSpacing.sm,
        right: widget.isMe ? AppSpacing.sm : 48,
        top: AppSpacing.xs,
        bottom: AppSpacing.xs,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          // Avatar
          if (!widget.isMe) ...[
            CircleAvatar(
              radius: 20,
              backgroundImage: widget.senderAvatarUrl != null 
                  ? NetworkImage(widget.senderAvatarUrl!) 
                  : null,
              child: widget.senderAvatarUrl == null
                  ? Text(
                      (widget.senderName?.isNotEmpty == true ? widget.senderName![0] : '?').toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
          ],
          
          // Audio bubble
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: widget.isMe ? AppColors.primary : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Play button
                  GestureDetector(
                    onTap: () => setState(() => _isPlaying = !_isPlaying),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: widget.isMe 
                            ? Colors.white.withValues(alpha: 0.2)
                            : AppColors.primary.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        color: widget.isMe ? Colors.white : AppColors.primary,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  
                  // Waveform
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Waveform bars
                        SizedBox(
                          height: 24,
                          child: Row(
                            children: List.generate(
                              waveform.length.clamp(0, 30),
                              (i) {
                                final isPlayed = i / waveform.length < _progress;
                                return Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 0.5),
                                    height: 24 * waveform[i].clamp(0.2, 1.0),
                                    decoration: BoxDecoration(
                                      color: isPlayed
                                          ? (widget.isMe ? Colors.white : AppColors.primary)
                                          : (widget.isMe ? Colors.white.withValues(alpha: 0.4) : AppColors.textSecondaryLight),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Duration
                        Text(
                          _formatDuration(duration),
                          style: AppTypography.caption.copyWith(
                            color: widget.isMe 
                                ? Colors.white.withValues(alpha: 0.7)
                                : AppColors.textSecondaryLight,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Mic indicator for unplayed
                  if (!_isPlaying && _progress == 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.mic,
                        size: 20,
                        color: widget.isMe 
                            ? Colors.white.withValues(alpha: 0.7)
                            : AppColors.primary,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
