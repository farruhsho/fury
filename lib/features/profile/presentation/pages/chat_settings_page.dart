import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';

/// Chat settings page - Чаты
class ChatSettingsPage extends StatefulWidget {
  const ChatSettingsPage({super.key});

  @override
  State<ChatSettingsPage> createState() => _ChatSettingsPageState();
}

class _ChatSettingsPageState extends State<ChatSettingsPage> {
  bool _enterSend = false;
  bool _mediaVisibility = true;
  bool _keepChatsArchived = true;
  String _fontSize = 'medium'; // 'small', 'medium', 'large'

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _enterSend = prefs.getBool('enterSend') ?? false;
      _mediaVisibility = prefs.getBool('mediaVisibility') ?? true;
      _keepChatsArchived = prefs.getBool('keepChatsArchived') ?? true;
      _fontSize = prefs.getString('fontSize') ?? 'medium';
    });
  }

  Future<void> _saveSetting(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Чаты', style: AppTypography.h3),
      ),
      body: ListView(
        children: [
          // Chat theme
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.color_lens, color: AppColors.primary),
            ),
            title: Text(
              'Тема чата по умолчанию',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimaryLight,
              ),
            ),
            onTap: () => _showThemePicker(),
          ),

          const SizedBox(height: AppSpacing.md),

          // Chat settings section
          _buildSectionHeader('Настройки чата'),

          // Enter to send
          _buildSwitchItem(
            title: 'Отправка клавишей "Ввод"',
            subtitle: 'Клавиша ввода отправляет сообщение',
            value: _enterSend,
            onChanged: (value) {
              setState(() => _enterSend = value);
              _saveSetting('enterSend', value);
            },
          ),

          // Media visibility
          _buildSwitchItem(
            title: 'Видимость медиа',
            subtitle: 'Показывать недавно скачанные медиафайлы в галерее устройства',
            value: _mediaVisibility,
            onChanged: (value) {
              setState(() => _mediaVisibility = value);
              _saveSetting('mediaVisibility', value);
            },
          ),

          // Font size
          ListTile(
            title: Text(
              'Размер шрифта',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimaryLight,
              ),
            ),
            subtitle: Text(
              _getFontSizeLabel(_fontSize),
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondaryLight,
              ),
            ),
            onTap: () => _showFontSizePicker(),
          ),

          // Voice message transcription
          ListTile(
            title: Text(
              'Расшифровка гол. сообщений',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimaryLight,
              ),
            ),
            subtitle: Text(
              'Читайте новые голосовые сообщения',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondaryLight,
              ),
            ),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondaryLight),
            onTap: () {},
          ),

          const SizedBox(height: AppSpacing.md),

          // Archive section
          _buildSectionHeader('Архив чатов'),

          _buildSwitchItem(
            title: 'Хранить чаты в архиве',
            subtitle: 'Архивированные чаты не будут разархивированы при получении нового сообщения',
            value: _keepChatsArchived,
            onChanged: (value) {
              setState(() => _keepChatsArchived = value);
              _saveSetting('keepChatsArchived', value);
            },
          ),

          const Divider(color: AppColors.surfaceLight, height: 1),

          // Backup
          ListTile(
            leading: const Icon(Icons.cloud_upload_outlined, color: AppColors.textSecondaryLight),
            title: Text(
              'Резервная копия чатов',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimaryLight,
              ),
            ),
            onTap: () => _showBackupOptions(),
          ),

          // Transfer chats
          ListTile(
            leading: const Icon(Icons.swap_horiz, color: AppColors.textSecondaryLight),
            title: Text(
              'Перенос чатов',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimaryLight,
              ),
            ),
            onTap: () {},
          ),

          // Chat history
          ListTile(
            leading: const Icon(Icons.history, color: AppColors.textSecondaryLight),
            title: Text(
              'История чатов',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimaryLight,
              ),
            ),
            onTap: () => _showHistoryOptions(),
          ),

          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm,
      ),
      child: Text(
        title,
        style: AppTypography.caption.copyWith(
          color: AppColors.textSecondaryLight,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSwitchItem({
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      title: Text(
        title,
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.textPrimaryLight,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondaryLight,
              ),
            )
          : null,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.primary,
        inactiveTrackColor: AppColors.surfaceLight,
      ),
    );
  }

  String _getFontSizeLabel(String size) {
    switch (size) {
      case 'small': return 'Маленький';
      case 'medium': return 'Средний';
      case 'large': return 'Крупный';
      default: return 'Средний';
    }
  }

  void _showThemePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textSecondaryLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Тема чата',
              style: AppTypography.h3.copyWith(color: AppColors.textPrimaryLight),
            ),
            const SizedBox(height: 24),
            // Theme options
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildThemeOption('По умолчанию', Colors.grey.shade800),
                  _buildThemeOption('Розовый', Colors.pink.shade300),
                  _buildThemeOption('Синий', Colors.blue.shade300),
                  _buildThemeOption('Зелёный', Colors.green.shade300),
                  _buildThemeOption('Фиолетовый', Colors.purple.shade300),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(String name, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Тема изменена на: $name')),
        );
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 80,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 40,
                    height: 20,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: AppTypography.caption.copyWith(color: AppColors.textPrimaryLight),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showFontSizePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textSecondaryLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Размер шрифта',
            style: AppTypography.h3.copyWith(color: AppColors.textPrimaryLight),
          ),
          const SizedBox(height: 16),
          RadioListTile<String>(
            title: const Text('Маленький', style: TextStyle(color: AppColors.textPrimaryLight, fontSize: 14)),
            value: 'small',
            groupValue: _fontSize,
            onChanged: (v) {
              Navigator.pop(ctx);
              setState(() => _fontSize = v!);
              _saveSetting('fontSize', v);
            },
            activeColor: AppColors.primary,
          ),
          RadioListTile<String>(
            title: const Text('Средний', style: TextStyle(color: AppColors.textPrimaryLight, fontSize: 16)),
            value: 'medium',
            groupValue: _fontSize,
            onChanged: (v) {
              Navigator.pop(ctx);
              setState(() => _fontSize = v!);
              _saveSetting('fontSize', v);
            },
            activeColor: AppColors.primary,
          ),
          RadioListTile<String>(
            title: const Text('Крупный', style: TextStyle(color: AppColors.textPrimaryLight, fontSize: 18)),
            value: 'large',
            groupValue: _fontSize,
            onChanged: (v) {
              Navigator.pop(ctx);
              setState(() => _fontSize = v!);
              _saveSetting('fontSize', v);
            },
            activeColor: AppColors.primary,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _showBackupOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textSecondaryLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Резервная копия',
              style: AppTypography.h3.copyWith(color: AppColors.textPrimaryLight),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.cloud_upload, color: AppColors.primary),
              title: const Text('Создать резервную копию', style: TextStyle(color: AppColors.textPrimaryLight)),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Резервное копирование...')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.cloud_download, color: AppColors.textSecondaryLight),
              title: const Text('Восстановить', style: TextStyle(color: AppColors.textPrimaryLight)),
              onTap: () {
                Navigator.pop(ctx);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showHistoryOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textSecondaryLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'История чатов',
              style: AppTypography.h3.copyWith(color: AppColors.textPrimaryLight),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.upload, color: AppColors.textSecondaryLight),
              title: const Text('Экспортировать чат', style: TextStyle(color: AppColors.textPrimaryLight)),
              onTap: () {
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(Icons.archive_outlined, color: AppColors.textSecondaryLight),
              title: const Text('Архивированные чаты', style: TextStyle(color: AppColors.textPrimaryLight)),
              onTap: () {
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Удалить все чаты', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(ctx);
                _showDeleteConfirmation();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Удалить все чаты?', style: TextStyle(color: AppColors.textPrimaryLight)),
        content: const Text(
          'Это действие нельзя отменить. Все сообщения будут удалены.',
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
                const SnackBar(content: Text('Все чаты удалены')),
              );
            },
            child: const Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
