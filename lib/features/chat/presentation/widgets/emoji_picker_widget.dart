import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import '../../../../app/theme/app_colors.dart';

class EmojiPickerWidget extends StatelessWidget {
  final Function(String) onEmojiSelected;
  final VoidCallback? onBackspacePressed;

  const EmojiPickerWidget({
    super.key,
    required this.onEmojiSelected,
    this.onBackspacePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) {
          onEmojiSelected(emoji.emoji);
        },
        onBackspacePressed: onBackspacePressed,
        config: Config(
          height: 300,
          emojiViewConfig: EmojiViewConfig(
            columns: 7,
            emojiSizeMax: 32,
            verticalSpacing: 0,
            horizontalSpacing: 0,
            gridPadding: EdgeInsets.zero,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            recentsLimit: 28,
            noRecents: const Text(
              'No Recents',
              style: TextStyle(fontSize: 20, color: Colors.black26),
              textAlign: TextAlign.center,
            ),
            loadingIndicator: const SizedBox.shrink(),
            buttonMode: ButtonMode.MATERIAL,
          ),
          categoryViewConfig: CategoryViewConfig(
            initCategory: Category.RECENT,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            indicatorColor: AppColors.primary,
            iconColor: Colors.grey,
            iconColorSelected: AppColors.primary,
            backspaceColor: AppColors.primary,
            recentTabBehavior: RecentTabBehavior.RECENT,
            tabIndicatorAnimDuration: kTabScrollDuration,
            categoryIcons: const CategoryIcons(),
          ),
          skinToneConfig: const SkinToneConfig(
            enabled: true,
            dialogBackgroundColor: Colors.white,
            indicatorColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}
