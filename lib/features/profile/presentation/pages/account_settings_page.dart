import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';

/// Account settings page - Аккаунт
class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Аккаунт', style: AppTypography.h3),
      ),
      body: ListView(
        children: [
          // Passkeys
          _buildSettingsItem(
            icon: Icons.key,
            title: 'Ключи доступа',
            onTap: () => _showPasskeysInfo(),
          ),

          // Email
          _buildSettingsItem(
            icon: Icons.email_outlined,
            title: 'Электронный адрес',
            subtitle: _user?.email,
            onTap: () => _showEmailDialog(),
          ),

          // Two-step verification
          _buildSettingsItem(
            icon: Icons.more_horiz,
            title: 'Двухшаговая проверка',
            onTap: () => _showTwoFactorSettings(),
          ),

          // Change number
          _buildSettingsItem(
            icon: Icons.phone_android,
            title: 'Изменить номер',
            onTap: () => _showChangeNumberDialog(),
          ),

          // Request account info
          _buildSettingsItem(
            icon: Icons.description_outlined,
            title: 'Запрос информации аккаунта',
            onTap: () => _showRequestInfoDialog(),
          ),

          // Add account
          _buildSettingsItem(
            icon: Icons.person_add_outlined,
            title: 'Добавить аккаунт',
            onTap: () => _showAddAccountDialog(),
          ),

          const Divider(color: AppColors.surfaceLight, height: 32),

          // Delete account
          _buildSettingsItem(
            icon: Icons.delete_outline,
            title: 'Удалить аккаунт',
            iconColor: Colors.red,
            titleColor: Colors.red,
            onTap: () => _showDeleteAccountDialog(),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    String? subtitle,
    Color? iconColor,
    Color? titleColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? AppColors.textSecondaryLight),
      title: Text(
        title,
        style: AppTypography.bodyMedium.copyWith(
          color: titleColor ?? AppColors.textPrimaryLight,
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
      onTap: onTap,
    );
  }

  void _showPasskeysInfo() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Ключи доступа', style: TextStyle(color: AppColors.textPrimaryLight)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ключи доступа позволяют входить без пароля, используя биометрию (отпечаток пальца или Face ID).',
              style: TextStyle(color: AppColors.textSecondaryLight),
            ),
            const SizedBox(height: 16),
            Text(
              'Настроенные ключи: 0',
              style: TextStyle(color: AppColors.textPrimaryLight),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Закрыть', style: TextStyle(color: AppColors.textSecondaryLight)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Настройка ключа доступа...')),
              );
            },
            child: Text('Добавить ключ', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  void _showEmailDialog() {
    final controller = TextEditingController(text: _user?.email ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Электронный адрес', style: TextStyle(color: AppColors.textPrimaryLight)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              style: const TextStyle(color: AppColors.textPrimaryLight),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'example@mail.com',
                hintStyle: TextStyle(color: AppColors.textSecondaryLight),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Адрес электронной почты используется для восстановления аккаунта.',
              style: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Отмена', style: TextStyle(color: AppColors.textSecondaryLight)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await _user?.verifyBeforeUpdateEmail(controller.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Проверьте почту для подтверждения')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Ошибка: $e')),
                );
              }
            },
            child: Text('Сохранить', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  void _showTwoFactorSettings() {
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
            Icon(Icons.security, size: 48, color: AppColors.primary),
            const SizedBox(height: 16),
            Text(
              'Двухшаговая проверка',
              style: AppTypography.h3.copyWith(color: AppColors.textPrimaryLight),
            ),
            const SizedBox(height: 8),
            Text(
              'Добавьте дополнительный уровень безопасности к вашему аккаунту с помощью 6-значного PIN-кода.',
              style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondaryLight),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.pop(ctx);
                  _setupTwoFactor();
                },
                child: const Text('Включить', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _setupTwoFactor() {
    final pinController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Создать PIN-код', style: TextStyle(color: AppColors.textPrimaryLight)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Введите 6-значный PIN-код, который будет использоваться для дополнительной защиты.',
              style: TextStyle(color: AppColors.textSecondaryLight),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: pinController,
              style: const TextStyle(color: AppColors.textPrimaryLight, letterSpacing: 8),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 6,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '••••••',
                hintStyle: TextStyle(color: AppColors.textSecondaryLight),
                counterText: '',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Отмена', style: TextStyle(color: AppColors.textSecondaryLight)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Двухшаговая проверка включена')),
              );
            },
            child: Text('Подтвердить', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  void _showChangeNumberDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Изменить номер', style: TextStyle(color: AppColors.textPrimaryLight)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Изменение номера позволяет перенести информацию аккаунта на новый номер телефона.',
              style: TextStyle(color: AppColors.textSecondaryLight),
            ),
            const SizedBox(height: 16),
            Text(
              '• Все группы и настройки сохранятся',
              style: TextStyle(color: AppColors.textSecondaryLight),
            ),
            Text(
              '• Контакты получат уведомление',
              style: TextStyle(color: AppColors.textSecondaryLight),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Отмена', style: TextStyle(color: AppColors.textSecondaryLight)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              // Start change number flow
            },
            child: Text('Далее', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  void _showRequestInfoDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Запрос информации', style: TextStyle(color: AppColors.textPrimaryLight)),
        content: Text(
          'Вы можете запросить отчёт о данных вашего аккаунта и настройках. Отчёт будет готов в течение 3 дней.',
          style: TextStyle(color: AppColors.textSecondaryLight),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Отмена', style: TextStyle(color: AppColors.textSecondaryLight)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Запрос отправлен')),
              );
            },
            child: Text('Запросить', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  void _showAddAccountDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Добавить аккаунт', style: TextStyle(color: AppColors.textPrimaryLight)),
        content: Text(
          'Вы можете использовать несколько аккаунтов Fury на одном устройстве.',
          style: TextStyle(color: AppColors.textSecondaryLight),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Отмена', style: TextStyle(color: AppColors.textSecondaryLight)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.go('/login');
            },
            child: Text('Добавить', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Удалить аккаунт?', style: TextStyle(color: Colors.red)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Удаление аккаунта:',
              style: TextStyle(color: AppColors.textPrimaryLight, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('• Удалит аккаунт из Fury', style: TextStyle(color: AppColors.textSecondaryLight)),
            Text('• Удалит историю сообщений', style: TextStyle(color: AppColors.textSecondaryLight)),
            Text('• Удалит вас из всех групп', style: TextStyle(color: AppColors.textSecondaryLight)),
            Text('• Удалит резервные копии', style: TextStyle(color: AppColors.textSecondaryLight)),
            const SizedBox(height: 16),
            Text(
              'Это действие нельзя отменить.',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Отмена', style: TextStyle(color: AppColors.textSecondaryLight)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await _user?.delete();
                context.go('/login');
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Ошибка: $e')),
                );
              }
            },
            child: const Text('Удалить аккаунт', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
