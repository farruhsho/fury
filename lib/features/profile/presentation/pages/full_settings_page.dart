import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';

/// Full settings page with all WhatsApp-style options
class FullSettingsPage extends StatefulWidget {
  const FullSettingsPage({super.key});

  @override
  State<FullSettingsPage> createState() => _FullSettingsPageState();
}

class _FullSettingsPageState extends State<FullSettingsPage> {
  Map<String, dynamic>? _userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (doc.exists) {
          setState(() {
            _userData = doc.data();
            _isLoading = false;
          });
          return;
        }
      }
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final name = _userData?['displayName'] ?? _userData?['name'] ?? user?.displayName ?? 'User';
    final info = _userData?['info'] ?? _userData?['username'] ?? '';
    final avatarUrl = _userData?['avatarUrl'] ?? _userData?['photoUrl'] ?? user?.photoURL;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Настройки', style: AppTypography.h3),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search settings
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                // Profile header
                ListTile(
                  contentPadding: const EdgeInsets.all(AppSpacing.md),
                  leading: CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                    backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
                    child: avatarUrl == null
                        ? Text(
                            name.isNotEmpty ? name[0].toUpperCase() : '?',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                  title: Text(
                    name,
                    style: AppTypography.h3.copyWith(color: AppColors.textPrimaryLight),
                  ),
                  subtitle: Text(
                    info.isNotEmpty ? info : 'Добавить информацию',
                    style: AppTypography.bodyMedium.copyWith(
                      color: info.isNotEmpty ? AppColors.textSecondaryLight : AppColors.primary,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.qr_code, color: AppColors.primary),
                        onPressed: () => context.push('/qr-code'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.expand_more, color: AppColors.primary),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  onTap: () => context.push('/profile'),
                ),

                const Divider(color: AppColors.surfaceLight, height: 1),

                // Account
                _buildSettingsItem(
                  icon: Icons.key,
                  title: 'Аккаунт',
                  subtitle: 'Безопасность, изменить номер',
                  onTap: () => context.push('/account-settings'),
                ),

                // Privacy
                _buildSettingsItem(
                  icon: Icons.lock_outline,
                  title: 'Конфиденциальность',
                  subtitle: 'Последний раз в сети, блокировка',
                  onTap: () => context.push('/privacy-settings'),
                ),

                // Avatar
                _buildSettingsItem(
                  icon: Icons.face,
                  title: 'Аватар',
                  subtitle: 'Создать, редактировать, профиль',
                  onTap: () {},
                ),

                // Favorites
                _buildSettingsItem(
                  icon: Icons.star_outline,
                  title: 'Избранное',
                  subtitle: 'Добавление, изменение порядка',
                  onTap: () {},
                ),

                // Chats
                _buildSettingsItem(
                  icon: Icons.chat_outlined,
                  title: 'Чаты',
                  subtitle: 'Тема, обои, история чатов',
                  onTap: () => context.push('/chat-settings'),
                ),

                // Notifications
                _buildSettingsItem(
                  icon: Icons.notifications_outlined,
                  title: 'Уведомления',
                  subtitle: 'Звуки сообщений, групп и звонков',
                  onTap: () => context.push('/notification-settings'),
                ),

                // Storage and data
                _buildSettingsItem(
                  icon: Icons.sync,
                  title: 'Данные и хранилище',
                  subtitle: 'Использование сети, автозагрузка',
                  onTap: () => context.push('/storage-settings'),
                ),

                // Accessibility
                _buildSettingsItem(
                  icon: Icons.accessibility_new,
                  title: 'Специальные возможности',
                  subtitle: 'Повысить контрастность, анимация',
                  onTap: () => context.push('/accessibility-settings'),
                ),

                // Language
                _buildSettingsItem(
                  icon: Icons.language,
                  title: 'Язык приложения',
                  subtitle: 'Русский (язык устройства)',
                  onTap: () => _showLanguagePicker(),
                ),

                // Help and feedback
                _buildSettingsItem(
                  icon: Icons.help_outline,
                  title: 'Помощь и отзывы',
                  subtitle: 'Справочный центр, связь с нами, политика конфиденциальности',
                  onTap: () => _showHelpOptions(),
                ),

                // Invite friend
                _buildSettingsItem(
                  icon: Icons.people_outline,
                  title: 'Пригласить друга',
                  onTap: () => _shareApp(),
                ),

                // App updates
                _buildSettingsItem(
                  icon: Icons.system_update_outlined,
                  title: 'Обновления приложения',
                  onTap: () => _checkUpdates(),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Meta section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Row(
                    children: [
                      Text(
                        '∞ Meta',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondaryLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                ListTile(
                  title: Text(
                    'Центр аккаунтов',
                    style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimaryLight),
                  ),
                  subtitle: Text(
                    'Централизованно управляйте своими аккаунтами в WhatsApp, Instagram, на Facebook и в других продуктах.',
                    style: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
                  ),
                  onTap: () {},
                ),

                // Other Meta products
                Padding(
                  padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm),
                  child: Text(
                    'Другие продукты Meta',
                    style: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildMetaProductButton(Icons.camera_alt, 'Instagram', () => _openUrl('https://instagram.com')),
                      const SizedBox(width: 32),
                      _buildMetaProductButton(Icons.facebook, 'Facebook', () => _openUrl('https://facebook.com')),
                      const SizedBox(width: 32),
                      _buildMetaProductButton(Icons.alternate_email, 'Threads', () => _openUrl('https://threads.net')),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                // Version
                Center(
                  child: Text(
                    'Fury v1.0.0',
                    style: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondaryLight),
      title: Text(
        title,
        style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimaryLight),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
            )
          : null,
      onTap: onTap,
    );
  }

  Widget _buildMetaProductButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.textSecondaryLight),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.textSecondaryLight),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
          ),
        ],
      ),
    );
  }

  void _showLanguagePicker() {
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
            'Язык приложения',
            style: AppTypography.h3.copyWith(color: AppColors.textPrimaryLight),
          ),
          const SizedBox(height: 16),
          for (final lang in ['Русский', 'English', 'Uzbek', 'Tajik'])
            RadioListTile<String>(
              title: Text(lang, style: const TextStyle(color: AppColors.textPrimaryLight)),
              value: lang,
              groupValue: 'Русский',
              onChanged: (v) {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Язык изменён на: $v')),
                );
              },
              activeColor: AppColors.primary,
            ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _showHelpOptions() {
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
              'Помощь',
              style: AppTypography.h3.copyWith(color: AppColors.textPrimaryLight),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.help_center, color: AppColors.textSecondaryLight),
              title: const Text('Справочный центр', style: TextStyle(color: AppColors.textPrimaryLight)),
              onTap: () {
                Navigator.pop(ctx);
                _openUrl('https://fury.app/help');
              },
            ),
            ListTile(
              leading: const Icon(Icons.email_outlined, color: AppColors.textSecondaryLight),
              title: const Text('Связаться с нами', style: TextStyle(color: AppColors.textPrimaryLight)),
              onTap: () {
                Navigator.pop(ctx);
                _openUrl('mailto:support@fury.app');
              },
            ),
            ListTile(
              leading: const Icon(Icons.description_outlined, color: AppColors.textSecondaryLight),
              title: const Text('Политика конфиденциальности', style: TextStyle(color: AppColors.textPrimaryLight)),
              onTap: () {
                Navigator.pop(ctx);
                _openUrl('https://fury.app/privacy');
              },
            ),
            ListTile(
              leading: const Icon(Icons.article_outlined, color: AppColors.textSecondaryLight),
              title: const Text('Условия использования', style: TextStyle(color: AppColors.textPrimaryLight)),
              onTap: () {
                Navigator.pop(ctx);
                _openUrl('https://fury.app/terms');
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _shareApp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Поделиться приложением...')),
    );
  }

  void _checkUpdates() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('У вас установлена последняя версия')),
    );
  }

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
