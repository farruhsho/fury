import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/message_entity.dart';

/// Context menu for message actions (long press)
class MessageContextMenu extends StatelessWidget {
  final MessageEntity message;
  final bool isMe;
  final VoidCallback? onReply;
  final VoidCallback? onForward;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onCopy;
  final VoidCallback? onPin;
  final VoidCallback? onReact;
  final VoidCallback? onSelect;

  const MessageContextMenu({
    super.key,
    required this.message,
    required this.isMe,
    this.onReply,
    this.onForward,
    this.onEdit,
    this.onDelete,
    this.onCopy,
    this.onPin,
    this.onReact,
    this.onSelect,
  });

  static Future<void> show({
    required BuildContext context,
    required MessageEntity message,
    required bool isMe,
    VoidCallback? onReply,
    VoidCallback? onForward,
    VoidCallback? onEdit,
    VoidCallback? onDelete,
    VoidCallback? onCopy,
    VoidCallback? onPin,
    VoidCallback? onReact,
    VoidCallback? onSelect,
  }) async {
    // Haptic feedback
    HapticFeedback.mediumImpact();
    
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => MessageContextMenu(
        message: message,
        isMe: isMe,
        onReply: onReply,
        onForward: onForward,
        onEdit: onEdit,
        onDelete: onDelete,
        onCopy: onCopy,
        onPin: onPin,
        onReact: onReact,
        onSelect: onSelect,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Quick reactions row
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ReactionButton(emoji: '👍', onTap: () {
                  Navigator.pop(context);
                  onReact?.call();
                }),
                _ReactionButton(emoji: '❤️', onTap: () {
                  Navigator.pop(context);
                  onReact?.call();
                }),
                _ReactionButton(emoji: '😂', onTap: () {
                  Navigator.pop(context);
                  onReact?.call();
                }),
                _ReactionButton(emoji: '😮', onTap: () {
                  Navigator.pop(context);
                  onReact?.call();
                }),
                _ReactionButton(emoji: '😢', onTap: () {
                  Navigator.pop(context);
                  onReact?.call();
                }),
                _ReactionButton(emoji: '🔥', onTap: () {
                  Navigator.pop(context);
                  onReact?.call();
                }),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // Action items
          _ActionItem(
            icon: Icons.reply,
            label: 'Reply',
            onTap: () {
              Navigator.pop(context);
              onReply?.call();
            },
          ),
          
          if (message.text != null && message.text!.isNotEmpty)
            _ActionItem(
              icon: Icons.copy,
              label: 'Copy',
              onTap: () {
                Clipboard.setData(ClipboardData(text: message.text ?? ''));
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Copied to clipboard'),
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 1),
                  ),
                );
                onCopy?.call();
              },
            ),
          
          _ActionItem(
            icon: Icons.forward,
            label: 'Forward',
            onTap: () {
              Navigator.pop(context);
              onForward?.call();
            },
          ),
          
          _ActionItem(
            icon: Icons.push_pin,
            label: message.isPinned ? 'Unpin' : 'Pin',
            onTap: () {
              Navigator.pop(context);
              onPin?.call();
            },
          ),
          
          // Edit - only for own text messages
          if (isMe && message.type == MessageType.text)
            _ActionItem(
              icon: Icons.edit,
              label: 'Edit',
              onTap: () {
                Navigator.pop(context);
                onEdit?.call();
              },
            ),
          
          _ActionItem(
            icon: Icons.check_box_outlined,
            label: 'Select',
            onTap: () {
              Navigator.pop(context);
              onSelect?.call();
            },
          ),
          
          const Divider(height: 1),
          
          // Delete - only for own messages
          if (isMe)
            _ActionItem(
              icon: Icons.delete_outline,
              label: 'Delete',
              color: Colors.red,
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(context);
              },
            ),
          
          const SizedBox(height: 16),
          
          // Safe area for bottom
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Message'),
        content: const Text('Are you sure you want to delete this message?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete?.call();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete for Everyone'),
          ),
        ],
      ),
    );
  }
}

class _ReactionButton extends StatelessWidget {
  final String emoji;
  final VoidCallback onTap;

  const _ReactionButton({
    required this.emoji,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _ActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.textPrimaryLight),
      title: Text(
        label,
        style: AppTypography.bodyMedium.copyWith(
          color: color ?? AppColors.textPrimaryLight,
        ),
      ),
      onTap: onTap,
    );
  }
}
