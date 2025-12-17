import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Message selection action bar - shown when messages are selected
class MessageSelectionBar extends StatelessWidget {
  final int selectedCount;
  final VoidCallback onClose;
  final VoidCallback onReply;
  final VoidCallback onStar;
  final VoidCallback onDelete;
  final VoidCallback onForward;
  final VoidCallback? onCopy;
  final VoidCallback? onMore;

  const MessageSelectionBar({
    super.key,
    required this.selectedCount,
    required this.onClose,
    required this.onReply,
    required this.onStar,
    required this.onDelete,
    required this.onForward,
    this.onCopy,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: AppColors.surfaceDark,
      child: Row(
        children: [
          // Close button
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.textPrimaryLight),
            onPressed: onClose,
          ),
          // Selected count
          Text(
            '$selectedCount',
            style: AppTypography.h3.copyWith(color: AppColors.textPrimaryLight),
          ),
          const Spacer(),
          // Action buttons
          IconButton(
            icon: const Icon(Icons.reply, color: AppColors.textPrimaryLight),
            onPressed: onReply,
            tooltip: 'Ответить',
          ),
          IconButton(
            icon: const Icon(Icons.star_border, color: AppColors.textPrimaryLight),
            onPressed: onStar,
            tooltip: 'В избранное',
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.textPrimaryLight),
            onPressed: onDelete,
            tooltip: 'Удалить',
          ),
          IconButton(
            icon: const Icon(Icons.forward, color: AppColors.textPrimaryLight),
            onPressed: onForward,
            tooltip: 'Переслать',
          ),
          if (onMore != null)
            IconButton(
              icon: const Icon(Icons.more_vert, color: AppColors.textPrimaryLight),
              onPressed: onMore,
              tooltip: 'Ещё',
            ),
        ],
      ),
    );
  }
}

/// Chat popup menu - shown when pressing three dots
class ChatPopupMenu extends StatelessWidget {
  final String chatId;
  final bool isGroup;
  final VoidCallback? onViewContact;
  final VoidCallback? onMediaGallery;
  final VoidCallback? onSearch;
  final VoidCallback? onMute;
  final VoidCallback? onWallpaper;
  final VoidCallback? onMore;

  const ChatPopupMenu({
    super.key,
    required this.chatId,
    this.isGroup = false,
    this.onViewContact,
    this.onMediaGallery,
    this.onSearch,
    this.onMute,
    this.onWallpaper,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: AppColors.textPrimaryLight),
      color: AppColors.surfaceDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onSelected: (value) => _handleMenuSelection(context, value),
      itemBuilder: (context) => [
        _buildMenuItem('view_contact', isGroup ? 'Данные группы' : 'Просмотр контакта', Icons.person),
        _buildMenuItem('media', 'Медиа, ссылки и докум.', Icons.photo_library),
        _buildMenuItem('search', 'Поиск', Icons.search),
        _buildMenuItem('mute', 'Без звука', Icons.notifications_off_outlined),
        _buildMenuItem('wallpaper', 'Обои', Icons.wallpaper),
        const PopupMenuDivider(),
        _buildMenuItem('report', 'Пожаловаться', Icons.report_outlined, isDestructive: true),
        _buildMenuItem('block', 'Заблокировать', Icons.block, isDestructive: true),
        _buildMenuItem('clear', 'Очистить чат', Icons.cleaning_services, isDestructive: true),
        if (!isGroup)
          _buildMenuItem('export', 'Экспорт чата', Icons.upload_file),
      ],
    );
  }

  PopupMenuItem<String> _buildMenuItem(
    String value, 
    String label, 
    IconData icon, 
    {bool isDestructive = false}
  ) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(
            icon, 
            size: 20,
            color: isDestructive ? Colors.red.shade400 : AppColors.textPrimaryLight,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              color: isDestructive ? Colors.red.shade400 : AppColors.textPrimaryLight,
            ),
          ),
        ],
      ),
    );
  }

  void _handleMenuSelection(BuildContext context, String value) {
    switch (value) {
      case 'view_contact':
        onViewContact?.call();
        break;
      case 'media':
        onMediaGallery?.call();
        break;
      case 'search':
        onSearch?.call();
        break;
      case 'mute':
        onMute?.call();
        break;
      case 'wallpaper':
        onWallpaper?.call();
        break;
      case 'report':
        _showReportDialog(context);
        break;
      case 'block':
        _showBlockDialog(context);
        break;
      case 'clear':
        _showClearChatDialog(context);
        break;
      case 'export':
        _showExportDialog(context);
        break;
    }
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Пожаловаться', style: TextStyle(color: AppColors.textPrimaryLight)),
        content: const Text(
          'Вы хотите пожаловаться на этот чат?',
          style: TextStyle(color: AppColors.textSecondaryLight),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена', style: TextStyle(color: AppColors.textSecondaryLight)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Жалоба отправлена')),
              );
            },
            child: Text('Пожаловаться', style: TextStyle(color: Colors.red.shade400)),
          ),
        ],
      ),
    );
  }

  void _showBlockDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Заблокировать?', style: TextStyle(color: AppColors.textPrimaryLight)),
        content: const Text(
          'Заблокированные контакты не смогут вам писать или звонить.',
          style: TextStyle(color: AppColors.textSecondaryLight),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена', style: TextStyle(color: AppColors.textSecondaryLight)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Контакт заблокирован')),
              );
            },
            child: Text('Заблокировать', style: TextStyle(color: Colors.red.shade400)),
          ),
        ],
      ),
    );
  }

  void _showClearChatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Очистить чат?', style: TextStyle(color: AppColors.textPrimaryLight)),
        content: const Text(
          'Все сообщения будут удалены. Это действие нельзя отменить.',
          style: TextStyle(color: AppColors.textSecondaryLight),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена', style: TextStyle(color: AppColors.textSecondaryLight)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Чат очищен')),
              );
            },
            child: Text('Очистить', style: TextStyle(color: Colors.red.shade400)),
          ),
        ],
      ),
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Экспорт чата', style: TextStyle(color: AppColors.textPrimaryLight)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.text_snippet, color: AppColors.primary),
              title: const Text('Без медиа', style: TextStyle(color: AppColors.textPrimaryLight)),
              subtitle: const Text('Только текст сообщений', 
                style: TextStyle(color: AppColors.textSecondaryLight)),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Экспорт начат...')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder, color: AppColors.primary),
              title: const Text('С медиа', style: TextStyle(color: AppColors.textPrimaryLight)),
              subtitle: const Text('Текст + фото/видео/файлы', 
                style: TextStyle(color: AppColors.textSecondaryLight)),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Экспорт с медиа начат...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Message action popup - shown on long press of a message
class MessageActionMenu extends StatelessWidget {
  final VoidCallback onReply;
  final VoidCallback onCopy;
  final VoidCallback onForward;
  final VoidCallback onStar;
  final VoidCallback onDelete;
  final VoidCallback? onPin;
  final VoidCallback? onEdit;
  final VoidCallback? onReplyPrivately;
  final VoidCallback? onReport;
  final bool isMyMessage;
  final bool isGroup;

  const MessageActionMenu({
    super.key,
    required this.onReply,
    required this.onCopy,
    required this.onForward,
    required this.onStar,
    required this.onDelete,
    this.onPin,
    this.onEdit,
    this.onReplyPrivately,
    this.onReport,
    this.isMyMessage = false,
    this.isGroup = false,
  });

  static void show(BuildContext context, MessageActionMenu menu) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => menu._buildSheet(ctx),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This widget is meant to be shown via static show() method
    // but we need to implement build for StatelessWidget
    return _buildSheet(context);
  }

  Widget _buildSheet(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textSecondaryLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          _buildActionRow(context),
          const Divider(color: AppColors.surfaceLight),
          _buildOptionTile('Ответить', Icons.reply, onReply, context),
          if (isGroup && !isMyMessage && onReplyPrivately != null)
            _buildOptionTile('Ответить лично', Icons.person, onReplyPrivately!, context),
          _buildOptionTile('Копировать', Icons.copy, onCopy, context),
          _buildOptionTile('Переслать', Icons.forward, onForward, context),
          if (onPin != null)
            _buildOptionTile('Закрепить', Icons.push_pin, onPin!, context),
          if (isMyMessage && onEdit != null)
            _buildOptionTile('Редактировать', Icons.edit, onEdit!, context),
          _buildOptionTile('В избранное', Icons.star_border, onStar, context),
          _buildOptionTile('Удалить', Icons.delete_outline, onDelete, context, isDestructive: true),
          if (!isMyMessage && onReport != null)
            _buildOptionTile('Пожаловаться', Icons.report_outlined, onReport!, context, isDestructive: true),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildActionRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildQuickAction(Icons.reply, 'Ответить', onReply, context),
          _buildQuickAction(Icons.copy, 'Копировать', onCopy, context),
          _buildQuickAction(Icons.forward, 'Переслать', onForward, context),
          _buildQuickAction(Icons.star_border, 'Избранное', onStar, context),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, VoidCallback onTap, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondaryLight,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(
    String label, 
    IconData icon, 
    VoidCallback onTap, 
    BuildContext context,
    {bool isDestructive = false}
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red.shade400 : AppColors.textPrimaryLight,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isDestructive ? Colors.red.shade400 : AppColors.textPrimaryLight,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
