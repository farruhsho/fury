import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/message_entity.dart';

class SwipeableMessageBubble extends StatelessWidget {
  final MessageEntity message;
  final bool isMe;
  final VoidCallback? onReply;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onForward;
  final Function(String)? onReact;
  final VoidCallback? onRetry;
  final VoidCallback? onSelect;
  final VoidCallback? onCopy;

  const SwipeableMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.onReply,
    this.onEdit,
    this.onDelete,
    this.onForward,
    this.onReact,
    this.onRetry,
    this.onSelect,
    this.onCopy,
  });

  void _showMessageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSpacing.radiusXl),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: AppSpacing.lg),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Reaction Picker
            if (onReact != null) ...[
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: ['👍', '❤️', '😂', '😮', '😢', '🔥'].map((emoji) {
                    final isReacted = message.reactions.any((r) => r.emoji == emoji && r.userId == 'ME'); // 'ME' check needs actual ID, simpler to just allow toggle
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        onReact!(emoji);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                        ),
                        child: Text(emoji, style: const TextStyle(fontSize: 24)),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const Divider(height: 32),
            ],

            // Options
            if (onReply != null)
              _MessageOption(
                icon: Icons.reply,
                label: 'Reply',
                onTap: () {
                  Navigator.pop(context);
                  onReply!();
                },
              ),
            if (onCopy != null && (message.text?.isNotEmpty ?? false))
              _MessageOption(
                icon: Icons.copy,
                label: 'Copy',
                onTap: () {
                  Navigator.pop(context);
                  onCopy!();
                },
              ),
            if (isMe && onEdit != null)
              _MessageOption(
                icon: Icons.edit,
                label: 'Edit',
                onTap: () {
                  Navigator.pop(context);
                  onEdit!();
                },
              ),
            if (onForward != null)
              _MessageOption(
                icon: Icons.forward,
                label: 'Forward',
                onTap: () {
                  Navigator.pop(context);
                  onForward!();
                },
              ),
            if (onSelect != null)
              _MessageOption(
                icon: Icons.check_circle_outline,
                label: 'Select',
                onTap: () {
                  Navigator.pop(context);
                  onSelect!();
                },
              ),
            if (isMe && onDelete != null)
              _MessageOption(
                icon: Icons.delete,
                label: 'Delete',
                color: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  onDelete!();
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(message.id),
      endActionPane: !isMe
          ? ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.2,
              children: [
                SlidableAction(
                  onPressed: (context) => onReply?.call(),
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  icon: Icons.reply,
                ),
              ],
            )
          : null,
      startActionPane: isMe
          ? ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.2,
              children: [
                SlidableAction(
                  onPressed: (context) => onReply?.call(),
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  icon: Icons.reply,
                ),
              ],
            )
          : null,
      child: GestureDetector(
        onLongPress: () => _showMessageOptions(context),
        child: Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: isMe ? AppColors.primary : AppColors.surfaceLight,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(AppSpacing.radiusLg),
                topRight: const Radius.circular(AppSpacing.radiusLg),
                bottomLeft: isMe
                    ? const Radius.circular(AppSpacing.radiusLg)
                    : Radius.zero,
                bottomRight: isMe
                    ? Radius.zero
                    : const Radius.circular(AppSpacing.radiusLg),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Forwarded indicator
                if (message.forwardedFrom != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.forward, size: 12, color: Colors.grey), // AppColors.textSecondaryLight might not be available directly or needs context
                        const SizedBox(width: 4),
                        Text(
                          'Forwarded', // User didn't ask for "from whom" explicitly in the visual request, but "forwarded from" usually implies name. My entity just has String.
                          style: AppTypography.caption.copyWith(
                            fontStyle: FontStyle.italic, 
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Reply indicator
                if (message.replyTo != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                    padding: const EdgeInsets.all(AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Text(
                      message.replyTo!.text ?? '',
                      style: AppTypography.caption.copyWith(
                        color: isMe ? Colors.white70 : AppColors.textSecondaryLight,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                // Message text
                Text(
                  message.text ?? '',
                  style: AppTypography.bodyMedium.copyWith(
                    color: isMe ? Colors.white : AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 2),

                // Reactions
                if (message.reactions.isNotEmpty)
                  Wrap(
                    spacing: 4,
                    children: message.reactions.map((reaction) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          reaction.emoji,
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    }).toList(),
                  ),

                // Time and status
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat.Hm().format(message.createdAt),
                      style: AppTypography.caption.copyWith(
                        color: isMe
                            ? Colors.white.withValues(alpha: 0.7)
                            : AppColors.textSecondaryLight,
                        fontSize: 10,
                      ),
                    ),
                    if (isMe) ...[
                      const SizedBox(width: 4),
                      _buildStatusIcon(message.status),
                    ],
                    // Retry button for failed messages
                    if (isMe && message.status == MessageStatus.failed && onRetry != null) ...[
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: onRetry,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.refresh,
                            size: 14,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(MessageStatus status) {
    IconData icon;
    Color color;
    
    switch (status) {
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

class _MessageOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback onTap;

  const _MessageOption({
    required this.icon,
    required this.label,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.primary),
      title: Text(
        label,
        style: AppTypography.bodyMedium.copyWith(color: color),
      ),
      onTap: onTap,
    );
  }
}
