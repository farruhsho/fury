import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_colors.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _messageNotifications = true;
  bool _groupNotifications = true;
  bool _channelNotifications = true;
  bool _callNotifications = true;
  bool _showPreview = true;
  bool _vibrate = true;
  bool _sound = true;
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('settings')
          .doc('notifications')
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          _messageNotifications = data['messages'] ?? true;
          _groupNotifications = data['groups'] ?? true;
          _channelNotifications = data['channels'] ?? true;
          _callNotifications = data['calls'] ?? true;
          _showPreview = data['preview'] ?? true;
          _vibrate = data['vibrate'] ?? true;
          _sound = data['sound'] ?? true;
        });
      }
    } catch (e) {
      // Use defaults
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _saveSettings() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => _isSaving = true);

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('settings')
          .doc('notifications')
          .set({
        'messages': _messageNotifications,
        'groups': _groupNotifications,
        'channels': _channelNotifications,
        'calls': _callNotifications,
        'preview': _showPreview,
        'vibrate': _vibrate,
        'sound': _sound,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Настройки сохранены'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _updateSetting(String key, bool value, void Function(bool) setter) {
    setter(value);
    _saveSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Уведомления', style: AppTypography.h3),
        actions: [
          if (_isSaving)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Типы уведомлений',
                    style: AppTypography.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                
                SwitchListTile(
                  secondary: const Icon(Icons.chat_bubble_outline),
                  title: const Text('Сообщения'),
                  subtitle: const Text('Личные сообщения'),
                  value: _messageNotifications,
                  onChanged: (value) => _updateSetting(
                    'messages', value, (v) => setState(() => _messageNotifications = v),
                  ),
                  activeThumbColor: AppColors.primary,
                ),
                
                SwitchListTile(
                  secondary: const Icon(Icons.group_outlined),
                  title: const Text('Группы'),
                  subtitle: const Text('Сообщения в группах'),
                  value: _groupNotifications,
                  onChanged: (value) => _updateSetting(
                    'groups', value, (v) => setState(() => _groupNotifications = v),
                  ),
                  activeThumbColor: AppColors.primary,
                ),
                
                SwitchListTile(
                  secondary: const Icon(Icons.campaign_outlined),
                  title: const Text('Каналы'),
                  subtitle: const Text('Посты в каналах'),
                  value: _channelNotifications,
                  onChanged: (value) => _updateSetting(
                    'channels', value, (v) => setState(() => _channelNotifications = v),
                  ),
                  activeThumbColor: AppColors.primary,
                ),
                
                SwitchListTile(
                  secondary: const Icon(Icons.call_outlined),
                  title: const Text('Звонки'),
                  subtitle: const Text('Входящие звонки'),
                  value: _callNotifications,
                  onChanged: (value) => _updateSetting(
                    'calls', value, (v) => setState(() => _callNotifications = v),
                  ),
                  activeThumbColor: AppColors.primary,
                ),

                const Divider(height: 32),

                // Options Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Параметры',
                    style: AppTypography.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                
                SwitchListTile(
                  secondary: const Icon(Icons.visibility_outlined),
                  title: const Text('Показывать текст'),
                  subtitle: const Text('Содержание в уведомлении'),
                  value: _showPreview,
                  onChanged: (value) => _updateSetting(
                    'preview', value, (v) => setState(() => _showPreview = v),
                  ),
                  activeThumbColor: AppColors.primary,
                ),
                
                SwitchListTile(
                  secondary: const Icon(Icons.vibration),
                  title: const Text('Вибрация'),
                  subtitle: const Text('Вибрировать при уведомлении'),
                  value: _vibrate,
                  onChanged: (value) => _updateSetting(
                    'vibrate', value, (v) => setState(() => _vibrate = v),
                  ),
                  activeThumbColor: AppColors.primary,
                ),
                
                SwitchListTile(
                  secondary: const Icon(Icons.volume_up_outlined),
                  title: const Text('Звук'),
                  subtitle: const Text('Звуковое уведомление'),
                  value: _sound,
                  onChanged: (value) => _updateSetting(
                    'sound', value, (v) => setState(() => _sound = v),
                  ),
                  activeThumbColor: AppColors.primary,
                ),

                const Divider(height: 32),

                // Reset button
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        _messageNotifications = true;
                        _groupNotifications = true;
                        _channelNotifications = true;
                        _callNotifications = true;
                        _showPreview = true;
                        _vibrate = true;
                        _sound = true;
                      });
                      _saveSettings();
                    },
                    icon: const Icon(Icons.restore),
                    label: const Text('Сбросить настройки'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
