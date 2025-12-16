import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

/// Common emoji reactions for messages
class MessageReactions {
  static const List<String> quickReactions = ['👍', '❤️', '😂', '😮', '😢', '🙏'];
  static const List<String> allReactions = [
    '👍', '👎', '❤️', '🔥', '⭐', '🎉',
    '😂', '😊', '😍', '🤔', '😮', '😢',
    '😡', '🙏', '👏', '💯', '✅', '❌',
  ];
}

/// Widget for displaying available reactions
class ReactionPicker extends StatelessWidget {
  final Function(String emoji) onReactionSelected;
  final bool showAll;

  const ReactionPicker({
    super.key,
    required this.onReactionSelected,
    this.showAll = false,
  });

  @override
  Widget build(BuildContext context) {
    final reactions = showAll 
        ? MessageReactions.allReactions 
        : MessageReactions.quickReactions;

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Wrap(
          spacing: 4,
          runSpacing: 4,
          children: reactions.map((emoji) {
            return InkWell(
              onTap: () => onReactionSelected(emoji),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// Widget displaying reactions on a message bubble
class MessageReactionBar extends StatelessWidget {
  final Map<String, List<String>> reactions; // emoji -> userIds
  final String currentUserId;
  final Function(String emoji) onReactionTap;

  const MessageReactionBar({
    super.key,
    required this.reactions,
    required this.currentUserId,
    required this.onReactionTap,
  });

  @override
  Widget build(BuildContext context) {
    if (reactions.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: reactions.entries.map((entry) {
        final emoji = entry.key;
        final userIds = entry.value;
        final count = userIds.length;
        final hasMyReaction = userIds.contains(currentUserId);

        return GestureDetector(
          onTap: () => onReactionTap(emoji),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: hasMyReaction
                  ? AppColors.primary.withValues(alpha: 0.2)
                  : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hasMyReaction
                    ? AppColors.primary
                    : Colors.grey.withValues(alpha: 0.3),
                width: 1,
              ),
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
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: hasMyReaction ? AppColors.primary : Colors.grey,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// Extension to show reaction picker as overlay
extension ReactionPickerOverlay on BuildContext {
  /// Show reaction picker near a message bubble
  Future<String?> showReactionPicker({
    required Offset anchor,
    bool showAll = false,
  }) async {
    String? selectedEmoji;
    
    await showDialog(
      context: this,
      barrierColor: Colors.transparent,
      builder: (context) => Stack(
        children: [
          // Dismiss area
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(color: Colors.transparent),
            ),
          ),
          // Reaction picker
          Positioned(
            left: anchor.dx,
            top: anchor.dy - 60,
            child: ReactionPicker(
              showAll: showAll,
              onReactionSelected: (emoji) {
                selectedEmoji = emoji;
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
    
    return selectedEmoji;
  }
}
