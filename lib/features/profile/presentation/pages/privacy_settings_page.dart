import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

class PrivacySettingsPage extends StatefulWidget {
  const PrivacySettingsPage({super.key});

  @override
  State<PrivacySettingsPage> createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  String _lastSeenPrivacy = 'Everyone';
  String _profilePhotoPrivacy = 'Everyone';
  String _aboutPrivacy = 'Everyone';
  bool _readReceipts = true;
  bool _onlineStatus = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy', style: AppTypography.h3),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Text(
              'Who can see my personal info',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          _PrivacyOption(
            title: 'Last seen & online',
            value: _lastSeenPrivacy,
            onTap: () => _showPrivacyDialog('Last seen & online', _lastSeenPrivacy, (value) {
              setState(() => _lastSeenPrivacy = value);
            }),
          ),
          _PrivacyOption(
            title: 'Profile photo',
            value: _profilePhotoPrivacy,
            onTap: () => _showPrivacyDialog('Profile photo', _profilePhotoPrivacy, (value) {
              setState(() => _profilePhotoPrivacy = value);
            }),
          ),
          _PrivacyOption(
            title: 'About',
            value: _aboutPrivacy,
            onTap: () => _showPrivacyDialog('About', _aboutPrivacy, (value) {
              setState(() => _aboutPrivacy = value);
            }),
          ),

          const Divider(height: 32),

          const Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Text(
              'Other settings',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          SwitchListTile(
            title: const Text('Read receipts'),
            subtitle: const Text('If turned off, you won\'t send or receive read receipts'),
            value: _readReceipts,
            onChanged: (value) {
              setState(() => _readReceipts = value);
            },
          ),
          SwitchListTile(
            title: const Text('Online status'),
            subtitle: const Text('If turned off, you won\'t be shown as online'),
            value: _onlineStatus,
            onChanged: (value) {
              setState(() => _onlineStatus = value);
            },
          ),

          const Divider(height: 32),

          ListTile(
            leading: const Icon(Icons.block, color: Colors.red),
            title: const Text('Blocked contacts'),
            subtitle: const Text('0 contacts'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to blocked contacts
            },
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog(String title, String currentValue, Function(String) onChanged) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('Everyone'),
                value: 'Everyone',
                groupValue: currentValue,
                onChanged: (value) {
                  onChanged(value!);
                  setDialogState(() {});
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text('My contacts'),
                value: 'My contacts',
                groupValue: currentValue,
                onChanged: (value) {
                  onChanged(value!);
                  setDialogState(() {});
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text('Nobody'),
                value: 'Nobody',
                groupValue: currentValue,
                onChanged: (value) {
                  onChanged(value!);
                  setDialogState(() {});
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrivacyOption extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const _PrivacyOption({
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        value,
        style: const TextStyle(color: AppColors.textSecondaryLight),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
