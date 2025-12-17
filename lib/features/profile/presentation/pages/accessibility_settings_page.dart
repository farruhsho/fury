import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';

/// Accessibility settings page - Специальные возможности
class AccessibilitySettingsPage extends StatefulWidget {
  const AccessibilitySettingsPage({super.key});

  @override
  State<AccessibilitySettingsPage> createState() => _AccessibilitySettingsPageState();
}

class _AccessibilitySettingsPageState extends State<AccessibilitySettingsPage> {
  bool _highContrast = false;
  bool _animationsEnabled = true;
  bool _reduceMotion = false;
  bool _largeText = false;
  
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _highContrast = prefs.getBool('highContrast') ?? false;
      _animationsEnabled = prefs.getBool('animationsEnabled') ?? true;
      _reduceMotion = prefs.getBool('reduceMotion') ?? false;
      _largeText = prefs.getBool('largeText') ?? false;
    });
  }

  Future<void> _saveSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Специальные возможности', style: AppTypography.h3),
      ),
      body: ListView(
        children: [
          // High contrast
          _buildSettingSwitch(
            title: 'Повысить контрастность',
            subtitle: 'Затемнить основные цвета, чтобы улучшить видимость в дневном режиме.',
            value: _highContrast,
            onChanged: (value) {
              setState(() => _highContrast = value);
              _saveSetting('highContrast', value);
            },
          ),

          const Divider(color: AppColors.surfaceLight, height: 1),

          // Animations
          _buildSettingItem(
            title: 'Анимация',
            subtitle: 'Выберите, будут ли стикеры и GIF двигаться автоматически.',
            onTap: () => _showAnimationOptions(context),
          ),

          const Divider(color: AppColors.surfaceLight, height: 1),

          // Reduce motion
          _buildSettingSwitch(
            title: 'Уменьшить движение',
            subtitle: 'Отключить анимации интерфейса для уменьшения отвлекающих факторов.',
            value: _reduceMotion,
            onChanged: (value) {
              setState(() => _reduceMotion = value);
              _saveSetting('reduceMotion', value);
            },
          ),

          const Divider(color: AppColors.surfaceLight, height: 1),

          // Large text
          _buildSettingSwitch(
            title: 'Крупный текст',
            subtitle: 'Увеличить размер текста в приложении.',
            value: _largeText,
            onChanged: (value) {
              setState(() => _largeText = value);
              _saveSetting('largeText', value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
            inactiveTrackColor: AppColors.surfaceLight,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: AppTypography.bodyLarge.copyWith(
          color: AppColors.textPrimaryLight,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.textSecondaryLight,
        ),
      ),
      onTap: onTap,
    );
  }

  void _showAnimationOptions(BuildContext context) {
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
            'Анимация стикеров и GIF',
            style: AppTypography.h3.copyWith(color: AppColors.textPrimaryLight),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Всегда', style: TextStyle(color: AppColors.textPrimaryLight)),
            subtitle: const Text('Стикеры и GIF всегда двигаются', 
              style: TextStyle(color: AppColors.textSecondaryLight)),
            trailing: _animationsEnabled == true
                ? const Icon(Icons.check, color: AppColors.primary)
                : null,
            onTap: () {
              setState(() => _animationsEnabled = true);
              _saveSetting('animationsEnabled', true);
              Navigator.pop(ctx);
            },
          ),
          ListTile(
            title: const Text('Никогда', style: TextStyle(color: AppColors.textPrimaryLight)),
            subtitle: const Text('Стикеры и GIF не двигаются автоматически', 
              style: TextStyle(color: AppColors.textSecondaryLight)),
            trailing: _animationsEnabled == false
                ? const Icon(Icons.check, color: AppColors.primary)
                : null,
            onTap: () {
              setState(() => _animationsEnabled = false);
              _saveSetting('animationsEnabled', false);
              Navigator.pop(ctx);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
