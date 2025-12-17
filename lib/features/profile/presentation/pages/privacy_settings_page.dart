import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';

/// Privacy settings page - Конфиденциальность
class PrivacySettingsPage extends StatefulWidget {
  const PrivacySettingsPage({super.key});

  @override
  State<PrivacySettingsPage> createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  bool _showPrivacyCheck = true;
  bool _readReceipts = true;
  bool _cameraEffects = true;
  
  String _lastSeenStatus = 'nobody'; // 'everyone', 'contacts', 'nobody'
  String _profilePhotoStatus = 'contacts';
  String _infoStatus = 'contacts';
  String _linksStatus = 'contacts';
  String _groupsStatus = 'everyone';
  String _avatarStickersStatus = 'contacts';
  
  final int _excludedStatusContacts = 12;
  String _disappearingTimer = 'off'; // 'off', '24h', '7d', '90d'
  
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _readReceipts = prefs.getBool('readReceipts') ?? true;
      _cameraEffects = prefs.getBool('cameraEffects') ?? true;
      _lastSeenStatus = prefs.getString('lastSeenStatus') ?? 'nobody';
      _profilePhotoStatus = prefs.getString('profilePhotoStatus') ?? 'contacts';
      _infoStatus = prefs.getString('infoStatus') ?? 'contacts';
      _disappearingTimer = prefs.getString('disappearingTimer') ?? 'off';
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
        title: const Text('Конфиденциальность', style: AppTypography.h3),
      ),
      body: ListView(
        children: [
          // Privacy check banner
          if (_showPrivacyCheck)
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
                  const Icon(Icons.lock_outline, color: AppColors.primary, size: 32),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Проверка конфиденциальности',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textPrimaryLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        RichText(
                          text: TextSpan(
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondaryLight,
                            ),
                            children: const [
                              TextSpan(text: 'Настройте параметры конфиденциальности. '),
                              TextSpan(
                                text: 'Начать проверку',
                                style: TextStyle(color: AppColors.primary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textSecondaryLight),
                    onPressed: () => setState(() => _showPrivacyCheck = false),
                  ),
                ],
              ),
            ),

          // Section: Who can see my personal info
          _buildSectionHeader('Кто видит мою личную информацию'),

          _buildSettingItem(
            title: 'Время последнего посещения и статус "в сети"',
            value: _getStatusLabel(_lastSeenStatus),
            onTap: () => _showStatusPicker('lastSeenStatus', _lastSeenStatus),
          ),
          _buildSettingItem(
            title: 'Фото профиля',
            value: _getStatusLabel(_profilePhotoStatus),
            onTap: () => _showStatusPicker('profilePhotoStatus', _profilePhotoStatus),
          ),
          _buildSettingItem(
            title: 'Информация',
            value: _getStatusLabel(_infoStatus),
            onTap: () => _showStatusPicker('infoStatus', _infoStatus),
          ),
          _buildSettingItem(
            title: 'Ссылки',
            value: _getStatusLabel(_linksStatus),
            onTap: () => _showStatusPicker('linksStatus', _linksStatus),
          ),
          _buildSettingItem(
            title: 'Статус',
            value: 'Исключено контактов: $_excludedStatusContacts',
            onTap: () {},
          ),

          const Divider(color: AppColors.surfaceLight, height: 1),

          // Read receipts
          _buildSwitchItem(
            title: 'Отчёты о прочтении',
            subtitle: 'Если вы отключите отчёты о прочтении, то не сможете отправлять и получать эти отчёты. Данные уведомления нельзя отключить для групповых чатов.',
            value: _readReceipts,
            onChanged: (value) {
              setState(() => _readReceipts = value);
              _saveSetting('readReceipts', value);
            },
          ),

          const SizedBox(height: AppSpacing.md),

          // Disappearing messages section
          _buildSectionHeader('Исчезающие сообщения'),

          _buildSettingItem(
            title: 'Таймер',
            subtitle: 'Начинайте новые чаты с сообщениями, которые будут исчезать в соответствии с заданным таймером.',
            value: _getTimerLabel(_disappearingTimer),
            onTap: () => _showTimerPicker(),
          ),

          const Divider(color: AppColors.surfaceLight, height: 1),

          // Groups
          _buildSettingItem(
            title: 'Группы',
            value: _getStatusLabel(_groupsStatus),
            onTap: () => _showStatusPicker('groupsStatus', _groupsStatus),
          ),

          // Avatar stickers
          _buildSettingItem(
            title: 'Стикеры с аватаром',
            value: _getStatusLabel(_avatarStickersStatus),
            onTap: () => _showStatusPicker('avatarStickersStatus', _avatarStickersStatus),
          ),

          // Geo data
          _buildSettingItem(
            title: 'Геоданные',
            onTap: () {},
          ),

          // Calls
          _buildSettingItem(
            title: 'Звонки',
            subtitle: 'Отключить звук для неизвестных номеров',
            onTap: () {},
          ),

          // Contacts
          _buildSettingItem(
            title: 'Контакты',
            subtitle: 'Заблокировать контакты, контакты Fury',
            onTap: () {},
          ),

          // App lock
          _buildSettingItem(
            title: 'Блокировка приложения',
            value: 'Отключено',
            onTap: () {},
          ),

          // Chat lock
          _buildSettingItem(
            title: 'Закрытие чата',
            onTap: () {},
          ),

          // Camera effects
          _buildSwitchItem(
            title: 'Разрешить эффекты камеры',
            subtitle: 'Используйте эффекты во время съёмки и видеозвонков. Подробнее',
            value: _cameraEffects,
            onChanged: (value) {
              setState(() => _cameraEffects = value);
              _saveSetting('cameraEffects', value);
            },
          ),

          // Advanced
          _buildSettingItem(
            title: 'Расширенные',
            subtitle: 'Защитить IP-адрес во время звонков, отключить предпросмотр ссылок',
            onTap: () {},
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

  Widget _buildSettingItem({
    required String title,
    String? subtitle,
    String? value,
    required VoidCallback onTap,
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
          : value != null
              ? Text(
                  value,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                )
              : null,
      trailing: value != null && subtitle == null
          ? null
          : const Icon(Icons.chevron_right, color: AppColors.textSecondaryLight),
      onTap: onTap,
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

  String _getStatusLabel(String status) {
    switch (status) {
      case 'everyone': return 'Все';
      case 'contacts': return 'Мои контакты';
      case 'nobody': return 'Никто';
      default: return status;
    }
  }

  String _getTimerLabel(String timer) {
    switch (timer) {
      case 'off': return 'Выкл.';
      case '24h': return '24 часа';
      case '7d': return '7 дней';
      case '90d': return '90 дней';
      default: return timer;
    }
  }

  void _showStatusPicker(String settingKey, String currentValue) {
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
          RadioListTile<String>(
            title: const Text('Все', style: TextStyle(color: AppColors.textPrimaryLight)),
            value: 'everyone',
            groupValue: currentValue,
            onChanged: (v) {
              Navigator.pop(ctx);
              _updatePrivacySetting(settingKey, v!);
            },
            activeColor: AppColors.primary,
          ),
          RadioListTile<String>(
            title: const Text('Мои контакты', style: TextStyle(color: AppColors.textPrimaryLight)),
            value: 'contacts',
            groupValue: currentValue,
            onChanged: (v) {
              Navigator.pop(ctx);
              _updatePrivacySetting(settingKey, v!);
            },
            activeColor: AppColors.primary,
          ),
          RadioListTile<String>(
            title: const Text('Никто', style: TextStyle(color: AppColors.textPrimaryLight)),
            value: 'nobody',
            groupValue: currentValue,
            onChanged: (v) {
              Navigator.pop(ctx);
              _updatePrivacySetting(settingKey, v!);
            },
            activeColor: AppColors.primary,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _updatePrivacySetting(String key, String value) {
    setState(() {
      switch (key) {
        case 'lastSeenStatus': _lastSeenStatus = value; break;
        case 'profilePhotoStatus': _profilePhotoStatus = value; break;
        case 'infoStatus': _infoStatus = value; break;
        case 'linksStatus': _linksStatus = value; break;
        case 'groupsStatus': _groupsStatus = value; break;
        case 'avatarStickersStatus': _avatarStickersStatus = value; break;
      }
    });
    _saveSetting(key, value);
  }

  void _showTimerPicker() {
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
            'Таймер исчезающих сообщений',
            style: AppTypography.h3.copyWith(color: AppColors.textPrimaryLight),
          ),
          const SizedBox(height: 16),
          for (final timer in ['off', '24h', '7d', '90d'])
            RadioListTile<String>(
              title: Text(_getTimerLabel(timer), style: const TextStyle(color: AppColors.textPrimaryLight)),
              value: timer,
              groupValue: _disappearingTimer,
              onChanged: (v) {
                Navigator.pop(ctx);
                setState(() => _disappearingTimer = v!);
                _saveSetting('disappearingTimer', v);
              },
              activeColor: AppColors.primary,
            ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
