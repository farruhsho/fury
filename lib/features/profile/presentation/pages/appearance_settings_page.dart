import 'package:flutter/material.dart';
import '../../../../app/theme/app_typography.dart';

class AppearanceSettingsPage extends StatefulWidget {
  const AppearanceSettingsPage({super.key});

  @override
  State<AppearanceSettingsPage> createState() => _AppearanceSettingsPageState();
}

class _AppearanceSettingsPageState extends State<AppearanceSettingsPage> {
  String _theme = 'System default';
  String _fontSize = 'Medium';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance', style: AppTypography.h3),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Theme'),
            subtitle: Text(_theme),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showThemeDialog(),
          ),
          ListTile(
            leading: const Icon(Icons.text_fields),
            title: const Text('Font size'),
            subtitle: Text(_fontSize),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showFontSizeDialog(),
          ),
          ListTile(
            leading: const Icon(Icons.wallpaper),
            title: const Text('Chat wallpaper'),
            subtitle: const Text('Default'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Show wallpaper picker
            },
          ),
        ],
      ),
    );
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Choose theme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('System default'),
                value: 'System default',
                groupValue: _theme,
                onChanged: (value) {
                  setState(() => _theme = value!);
                  setDialogState(() {});
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text('Light'),
                value: 'Light',
                groupValue: _theme,
                onChanged: (value) {
                  setState(() => _theme = value!);
                  setDialogState(() {});
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text('Dark'),
                value: 'Dark',
                groupValue: _theme,
                onChanged: (value) {
                  setState(() => _theme = value!);
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

  void _showFontSizeDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Font size'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('Small'),
                value: 'Small',
                groupValue: _fontSize,
                onChanged: (value) {
                  setState(() => _fontSize = value!);
                  setDialogState(() {});
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text('Medium'),
                value: 'Medium',
                groupValue: _fontSize,
                onChanged: (value) {
                  setState(() => _fontSize = value!);
                  setDialogState(() {});
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text('Large'),
                value: 'Large',
                groupValue: _fontSize,
                onChanged: (value) {
                  setState(() => _fontSize = value!);
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
