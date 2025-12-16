import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Chat list popup menu - shown when pressing three dots on main screen
class ChatListPopupMenu extends StatelessWidget {
  final VoidCallback? onNewGroup;
  final VoidCallback? onNewBroadcast;
  final VoidCallback? onLinkedDevices;
  final VoidCallback? onFavorites;
  final VoidCallback? onMarkAllRead;
  final VoidCallback? onSettings;

  const ChatListPopupMenu({
    super.key,
    this.onNewGroup,
    this.onNewBroadcast,
    this.onLinkedDevices,
    this.onFavorites,
    this.onMarkAllRead,
    this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: AppColors.textPrimaryLight),
      color: AppColors.surfaceDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      offset: const Offset(0, 50),
      onSelected: (value) => _handleSelection(context, value),
      itemBuilder: (context) => [
        _buildMenuItem('new_group', 'Новая группа', Icons.group_add_outlined),
        _buildMenuItem('new_broadcast', 'Новая рассылка', Icons.campaign_outlined),
        _buildMenuItem('linked_devices', 'Связанные устройства', Icons.devices_outlined),
        _buildMenuItem('favorites', 'Избранные', Icons.star_outline),
        _buildMenuItem('mark_all_read', 'Прочитать все', Icons.done_all),
        _buildMenuItem('settings', 'Настройки', Icons.settings_outlined),
      ],
    );
  }

  PopupMenuItem<String> _buildMenuItem(String value, String label, IconData icon) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textPrimaryLight),
          const SizedBox(width: 16),
          Text(
            label,
            style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimaryLight),
          ),
        ],
      ),
    );
  }

  void _handleSelection(BuildContext context, String value) {
    switch (value) {
      case 'new_group':
        if (onNewGroup != null) {
          onNewGroup!();
        } else {
          context.push('/create-group');
        }
        break;
      case 'new_broadcast':
        onNewBroadcast?.call();
        break;
      case 'linked_devices':
        if (onLinkedDevices != null) {
          onLinkedDevices!();
        } else {
          context.push('/linked-devices');
        }
        break;
      case 'favorites':
        onFavorites?.call();
        break;
      case 'mark_all_read':
        onMarkAllRead?.call();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Все чаты отмечены как прочитанные')),
        );
        break;
      case 'settings':
        if (onSettings != null) {
          onSettings!();
        } else {
          context.push('/settings');
        }
        break;
    }
  }

  /// Static method to show the menu programmatically
  static void show(BuildContext context, {
    VoidCallback? onNewGroup,
    VoidCallback? onNewBroadcast,
    VoidCallback? onLinkedDevices,
    VoidCallback? onFavorites,
    VoidCallback? onMarkAllRead,
    VoidCallback? onSettings,
  }) {
    showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(100, 80, 16, 0),
      color: AppColors.surfaceDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      items: [
        _buildStaticMenuItem('new_group', 'Новая группа', Icons.group_add_outlined),
        _buildStaticMenuItem('new_broadcast', 'Новая рассылка', Icons.campaign_outlined),
        _buildStaticMenuItem('linked_devices', 'Связанные устройства', Icons.devices_outlined),
        _buildStaticMenuItem('favorites', 'Избранные', Icons.star_outline),
        _buildStaticMenuItem('mark_all_read', 'Прочитать все', Icons.done_all),
        _buildStaticMenuItem('settings', 'Настройки', Icons.settings_outlined),
      ],
    ).then((value) {
      if (value != null) {
        switch (value) {
          case 'new_group':
            onNewGroup?.call() ?? context.push('/create-group');
            break;
          case 'new_broadcast':
            onNewBroadcast?.call();
            break;
          case 'linked_devices':
            onLinkedDevices?.call() ?? context.push('/linked-devices');
            break;
          case 'favorites':
            onFavorites?.call();
            break;
          case 'mark_all_read':
            onMarkAllRead?.call();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Все чаты отмечены как прочитанные')),
            );
            break;
          case 'settings':
            onSettings?.call() ?? context.push('/settings');
            break;
        }
      }
    });
  }

  static PopupMenuItem<String> _buildStaticMenuItem(String value, String label, IconData icon) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textPrimaryLight),
          const SizedBox(width: 16),
          Text(
            label,
            style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimaryLight),
          ),
        ],
      ),
    );
  }
}

/// Sticker/Emoji picker widget
class StickerEmojiPicker extends StatefulWidget {
  final ValueChanged<String>? onEmojiSelected;
  final ValueChanged<String>? onStickerSelected;
  final ValueChanged<String>? onGifSelected;
  final VoidCallback? onCreateSticker;

  const StickerEmojiPicker({
    super.key,
    this.onEmojiSelected,
    this.onStickerSelected,
    this.onGifSelected,
    this.onCreateSticker,
  });

  @override
  State<StickerEmojiPicker> createState() => _StickerEmojiPickerState();
}

class _StickerEmojiPickerState extends State<StickerEmojiPicker> {
  int _selectedTab = 0;
  
  final List<String> _recentEmojis = ['👍', '❤️', '😂', '😮', '😢', '🙏', '👏', '🔥'];
  
  final List<String> _emojis = [
    '😀', '😃', '😄', '😁', '😆', '😅', '🤣', '😂',
    '🙂', '🙃', '😉', '😊', '😇', '🥰', '😍', '🤩',
    '😘', '😗', '☺️', '😚', '😙', '🥲', '😋', '😛',
    '😜', '🤪', '😝', '🤑', '🤗', '🤭', '🤫', '🤔',
    '🤐', '🤨', '😐', '😑', '😶', '😏', '😒', '🙄',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: AppColors.textSecondaryLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Tab bar
          Container(
            height: 44,
            color: AppColors.surfaceLight,
            child: Row(
              children: [
                _buildTab(0, Icons.search),
                _buildTab(1, Icons.emoji_emotions_outlined),
                _buildTab(2, null, label: 'GIF'),
                _buildTab(3, Icons.sticky_note_2_outlined),
                _buildTab(4, Icons.brush_outlined),
              ],
            ),
          ),

          // Content
          Expanded(
            child: _buildContent(),
          ),

          // Recent emojis bar
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              border: Border(
                top: BorderSide(color: AppColors.surfaceDark),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _recentEmojis.map((emoji) {
                return GestureDetector(
                  onTap: () => widget.onEmojiSelected?.call(emoji),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(emoji, style: const TextStyle(fontSize: 24)),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(int index, IconData? icon, {String? label}) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: label != null
                ? Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? AppColors.primary : AppColors.textSecondaryLight,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Icon(
                    icon,
                    color: isSelected ? AppColors.primary : AppColors.textSecondaryLight,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedTab) {
      case 0: // Search
        return _buildSearchTab();
      case 1: // Emoji
        return _buildEmojiGrid();
      case 2: // GIF
        return _buildGifTab();
      case 3: // Stickers
        return _buildStickersTab();
      case 4: // Create
        return _buildCreateTab();
      default:
        return _buildEmojiGrid();
    }
  }

  Widget _buildSearchTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        style: const TextStyle(color: AppColors.textPrimaryLight),
        decoration: InputDecoration(
          hintText: 'Поиск стикеров и эмодзи',
          hintStyle: TextStyle(color: AppColors.textSecondaryLight),
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondaryLight),
          filled: true,
          fillColor: AppColors.surfaceLight,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildEmojiGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: _emojis.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => widget.onEmojiSelected?.call(_emojis[index]),
          child: Center(
            child: Text(_emojis[index], style: const TextStyle(fontSize: 24)),
          ),
        );
      },
    );
  }

  Widget _buildGifTab() {
    return const Center(
      child: Text(
        'GIF загружаются...',
        style: TextStyle(color: AppColors.textSecondaryLight),
      ),
    );
  }

  Widget _buildStickersTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.sticky_note_2, color: AppColors.textSecondaryLight),
        );
      },
    );
  }

  Widget _buildCreateTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: AppColors.primary, size: 40),
          ),
          const SizedBox(height: 16),
          Text(
            'Создать',
            style: AppTypography.bodyLarge.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: 8),
          Text(
            'Создайте свой стикер',
            style: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
          ),
        ],
      ),
    );
  }
}
