import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';

/// Enhanced Settings page with WhatsApp-style layout
class EnhancedSettingsPage extends StatefulWidget {
  const EnhancedSettingsPage({super.key});

  @override
  State<EnhancedSettingsPage> createState() => _EnhancedSettingsPageState();
}

class _EnhancedSettingsPageState extends State<EnhancedSettingsPage> {
  Map<String, dynamic>? _userData;
  bool _isLoading = true;
  bool _showSecurityBanner = true;

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
        }
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.backgroundDark,
        appBar: AppBar(
          backgroundColor: AppColors.surfaceDark,
          title: const Text('Настройки'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final userName = _userData?['displayName'] ?? _userData?['name'] ?? 'Пользователь';
    final userHandle = _userData?['username'] ?? '';
    final avatarUrl = _userData?['avatarUrl'] ?? _userData?['photoUrl'];

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Настройки', style: AppTypography.h3),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          // Security banner
          if (_showSecurityBanner)
            Container(
              margin: const EdgeInsets.all(AppSpacing.md),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.shield, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Защитите свой аккаунт',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textPrimaryLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Войдите с помощью функции распознавания лица, отпечатка пальца или с помощью функции блокировки экрана.',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Создать ключ доступа',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textSecondaryLight),
                    onPressed: () => setState(() => _showSecurityBanner = false),
                  ),
                ],
              ),
            ),

          // Profile section
          ListTile(
            contentPadding: const EdgeInsets.all(AppSpacing.md),
            leading: CircleAvatar(
              radius: 32,
              backgroundColor: AppColors.primary.withValues(alpha: 0.2),
              backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
              child: avatarUrl == null
                  ? Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    )
                  : null,
            ),
            title: Text(
              userName.toUpperCase(),
              style: AppTypography.h3.copyWith(color: AppColors.textPrimaryLight),
            ),
            subtitle: userHandle.isNotEmpty
                ? Text(
                    userHandle,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
                  )
                : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.qr_code, color: AppColors.primary),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, color: AppColors.primary),
                  onPressed: () {},
                ),
              ],
            ),
            onTap: () => context.push('/profile'),
          ),

          const Divider(color: AppColors.surfaceLight, height: 1),

          // Settings sections
          _buildSettingsTile(
            icon: Icons.key,
            title: 'Аккаунт',
            subtitle: 'Уведомления безопасности, изменение номера',
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.lock_outline,
            title: 'Конфиденциальность',
            subtitle: 'Заблокировать контакты, исчезающие сообщения',
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.face,
            title: 'Аватар',
            subtitle: 'Создать, изменить, фото профиля',
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.list_alt,
            title: 'Списки',
            subtitle: 'Управление контактами и группами',
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.chat_outlined,
            title: 'Чаты',
            subtitle: 'Тема, обои, история чатов',
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Уведомления',
            subtitle: 'Звуки сообщений, групп и звонков',
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.storage_outlined,
            title: 'Хранилище и данные',
            subtitle: 'Использование сети, автозагрузка',
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.language,
            title: 'Язык приложения',
            subtitle: 'Русский',
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.help_outline,
            title: 'Справка',
            subtitle: 'Центр поддержки, связаться с нами, политика',
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.people_outline,
            title: 'Пригласить друзей',
            onTap: () {},
          ),

          const SizedBox(height: AppSpacing.xl),

          // App info
          Center(
            child: Column(
              children: [
                Text(
                  'от',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'FURY',
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textSecondaryLight,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondaryLight),
      title: Text(
        title,
        style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimaryLight),
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
}
