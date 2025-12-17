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
              ListTile(
                title: const Text('System default'),
                trailing: _theme == 'System default'
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  setState(() => _theme = 'System default');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Light'),
                trailing: _theme == 'Light'
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  setState(() => _theme = 'Light');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Dark'),
                trailing: _theme == 'Dark'
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  setState(() => _theme = 'Dark');
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
              ListTile(
                title: const Text('Small'),
                trailing: _fontSize == 'Small'
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  setState(() => _fontSize = 'Small');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Medium'),
                trailing: _fontSize == 'Medium'
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  setState(() => _fontSize = 'Medium');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Large'),
                trailing: _fontSize == 'Large'
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  setState(() => _fontSize = 'Large');
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
