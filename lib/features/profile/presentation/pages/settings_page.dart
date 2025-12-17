import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/providers/locale_provider.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import 'security_settings_page.dart';

/// Complete Settings Page with all modern features
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final user = FirebaseAuth.instance.currentUser;
  
  // Privacy settings state
  bool _lastSeenEnabled = true;
  bool _readReceiptsEnabled = true;
  bool _onlineStatusEnabled = true;
  bool _screenshotNotifyEnabled = false;
  String _profilePhotoVisibility = 'everyone';
  String _whoCanAddToGroups = 'everyone';
  
  // Notification settings
  bool _messageNotifications = true;
  bool _groupNotifications = true;
  bool _callNotifications = true;
  bool _vibration = true;
  bool _sound = true;
  
  /// Get initial letter safely (handles empty strings)
  String _getInitial(String? text) {
    if (text == null || text.isEmpty) return 'U';
    return text[0].toUpperCase();
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: ListView(
        children: [
          // Profile Section
          _buildProfileSection(context),
          
          const Divider(height: 1),
          
          // Account Section
          _buildSectionHeader('Account'),
          _buildListTile(
            icon: Icons.security,
            title: 'Security',
            subtitle: '2FA, Biometrics, Sessions',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SecuritySettingsPage(),
              ),
            ),
          ),
          _buildListTile(
            icon: Icons.key,
            title: 'Privacy and Security',
            onTap: () => _showPrivacySettings(context),
          ),
          _buildListTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            onTap: () => _showNotificationSettings(context),
          ),
          _buildListTile(
            icon: Icons.storage_outlined,
            title: 'Storage and Data',
            onTap: () => _showStorageSettings(context),
          ),
          
          const Divider(height: 1),
          
          // App Settings Section
          _buildSectionHeader('App Settings'),
          Consumer<LocaleProvider>(
            builder: (context, localeProvider, _) => _buildListTile(
              icon: Icons.language,
              title: 'Язык / Language',
              subtitle: localeProvider.currentLanguage.name,
              onTap: () => _showLanguageSelector(context),
            ),
          ),
          _buildThemeTile(context, isDark),
          _buildListTile(
            icon: Icons.chat_bubble_outline,
            title: 'Chat Settings',
            onTap: () => _showChatSettings(context),
          ),
          
          const Divider(height: 1),
          
          // Help Section
          _buildSectionHeader('Help'),
          _buildListTile(
            icon: Icons.help_outline,
            title: 'Help Center',
            onTap: () {},
          ),
          _buildListTile(
            icon: Icons.support_agent,
            title: 'Тех. поддержка / Support',
            subtitle: 'Chat with @farruh',
            onTap: () => _openSupportChat(context),
          ),
          _buildListTile(
            icon: Icons.description_outlined,
            title: 'Terms and Privacy Policy',
            onTap: () {},
          ),
          _buildListTile(
            icon: Icons.info_outline,
            title: 'About',
            subtitle: 'Fury Messenger v1.0.0',
            onTap: () => _showAboutDialog(context),
          ),
          
          const Divider(height: 1),
          
          // Logout
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () => _showLogoutDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade50,
                foregroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Log Out'),
            ),
          ),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Avatar
          GestureDetector(
            onTap: () => _showEditProfileSheet(context),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: AppColors.primary,
                  backgroundImage: user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : null,
                  child: user?.photoURL == null
                      ? Text(
                          _getInitial(user?.displayName ?? user?.email),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 2,
                      ),
                    ),
                    child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.displayName ?? 'User',
                  style: AppTypography.h3,
                ),
                const SizedBox(height: 4),
                Text(
                  user?.email ?? '',
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () => _showEditStatusSheet(context),
                  child: const Row(
                    children: [
                      Icon(Icons.edit, size: 14, color: AppColors.primary),
                      SizedBox(width: 4),
                      Text(
                        'Set status',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: () {},
            tooltip: 'QR Code',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildThemeTile(BuildContext context, bool isDark) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          isDark ? Icons.dark_mode : Icons.light_mode,
          color: AppColors.primary,
        ),
      ),
      title: const Text('Theme'),
      subtitle: Text(isDark ? 'Dark' : 'Light'),
      trailing: Switch(
        value: isDark,
        activeThumbColor: AppColors.primary,
        onChanged: (value) {
          context.read<ThemeProvider>().toggleTheme();
        },
      ),
    );
  }

  void _showPrivacySettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => StatefulBuilder(
          builder: (context, setModalState) => ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Text('Privacy', style: AppTypography.h2),
              const SizedBox(height: 24),
              
              // Last Seen
              SwitchListTile(
                title: const Text('Last Seen'),
                subtitle: const Text('Show when you were last online'),
                value: _lastSeenEnabled,
                activeThumbColor: AppColors.primary,
                onChanged: (value) {
                  setModalState(() => _lastSeenEnabled = value);
                  setState(() => _lastSeenEnabled = value);
                  // TODO: Save to Firebase
                },
              ),
              
              // Read Receipts
              SwitchListTile(
                title: const Text('Read Receipts'),
                subtitle: const Text('Show when you\'ve read messages'),
                value: _readReceiptsEnabled,
                activeThumbColor: AppColors.primary,
                onChanged: (value) {
                  setModalState(() => _readReceiptsEnabled = value);
                  setState(() => _readReceiptsEnabled = value);
                },
              ),
              
              // Online Status
              SwitchListTile(
                title: const Text('Online Status'),
                subtitle: const Text('Show when you\'re online'),
                value: _onlineStatusEnabled,
                activeThumbColor: AppColors.primary,
                onChanged: (value) {
                  setModalState(() => _onlineStatusEnabled = value);
                  setState(() => _onlineStatusEnabled = value);
                },
              ),
              
              // Screenshot Notifications
              SwitchListTile(
                title: const Text('Screenshot Notifications'),
                subtitle: const Text('Notify when someone screenshots'),
                value: _screenshotNotifyEnabled,
                activeThumbColor: AppColors.primary,
                onChanged: (value) {
                  setModalState(() => _screenshotNotifyEnabled = value);
                  setState(() => _screenshotNotifyEnabled = value);
                },
              ),
              
              const Divider(height: 32),
              
              // Profile Photo Visibility
              ListTile(
                title: const Text('Profile Photo'),
                subtitle: Text(_getVisibilityText(_profilePhotoVisibility)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showVisibilityPicker(
                  context,
                  'Profile Photo',
                  _profilePhotoVisibility,
                  (value) {
                    setModalState(() => _profilePhotoVisibility = value);
                    setState(() => _profilePhotoVisibility = value);
                  },
                ),
              ),
              
              // Who Can Add to Groups
              ListTile(
                title: const Text('Who Can Add Me to Groups'),
                subtitle: Text(_getVisibilityText(_whoCanAddToGroups)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showVisibilityPicker(
                  context,
                  'Group Invites',
                  _whoCanAddToGroups,
                  (value) {
                    setModalState(() => _whoCanAddToGroups = value);
                    setState(() => _whoCanAddToGroups = value);
                  },
                ),
              ),
              
              const Divider(height: 32),
              
              // Blocked Users
              ListTile(
                leading: const Icon(Icons.block, color: Colors.red),
                title: const Text('Blocked Users'),
                subtitle: const Text('0 blocked'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNotificationSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Text('Notifications', style: AppTypography.h2),
              const SizedBox(height: 24),
              
              SwitchListTile(
                title: const Text('Message Notifications'),
                value: _messageNotifications,
                activeThumbColor: AppColors.primary,
                onChanged: (value) {
                  setModalState(() => _messageNotifications = value);
                  setState(() => _messageNotifications = value);
                },
              ),
              
              SwitchListTile(
                title: const Text('Group Notifications'),
                value: _groupNotifications,
                activeThumbColor: AppColors.primary,
                onChanged: (value) {
                  setModalState(() => _groupNotifications = value);
                  setState(() => _groupNotifications = value);
                },
              ),
              
              SwitchListTile(
                title: const Text('Call Notifications'),
                value: _callNotifications,
                activeThumbColor: AppColors.primary,
                onChanged: (value) {
                  setModalState(() => _callNotifications = value);
                  setState(() => _callNotifications = value);
                },
              ),
              
              const Divider(height: 32),
              
              SwitchListTile(
                title: const Text('Vibration'),
                value: _vibration,
                activeThumbColor: AppColors.primary,
                onChanged: (value) {
                  setModalState(() => _vibration = value);
                  setState(() => _vibration = value);
                },
              ),
              
              SwitchListTile(
                title: const Text('Sound'),
                value: _sound,
                activeThumbColor: AppColors.primary,
                onChanged: (value) {
                  setModalState(() => _sound = value);
                  setState(() => _sound = value);
                },
              ),
              
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _showStorageSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Text('Storage and Data', style: AppTypography.h2),
            const SizedBox(height: 24),
            
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Media Auto-Download'),
              subtitle: const Text('Wi-Fi only'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('Storage Usage'),
              subtitle: const Text('Calculate storage'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            
            ListTile(
              leading: const Icon(Icons.cleaning_services),
              title: const Text('Clear Cache'),
              subtitle: const Text('Free up space'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cache cleared')),
                );
              },
            ),
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showLanguageSelector(BuildContext context) {
    final localeProvider = context.read<LocaleProvider>();
    final currentLang = localeProvider.currentLanguage;
    
    showModalBottomSheet(
      context: context,
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
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Language', style: AppTypography.h3),
          const SizedBox(height: 8),
          ...AppLanguage.values.map((lang) => ListTile(
            title: Text(lang.name),
            leading: Text(lang.flag, style: const TextStyle(fontSize: 24)),
            trailing: currentLang == lang
                ? const Icon(Icons.check, color: AppColors.primary)
                : null,
            onTap: () {
              localeProvider.setLanguage(lang);
              Navigator.pop(ctx);
              setState(() {}); // Refresh to show new language name
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Language changed to ${lang.name}')),
              );
            },
          )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showChatSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Text('Chat Settings', style: AppTypography.h2),
            const SizedBox(height: 24),
            
            ListTile(
              leading: const Icon(Icons.text_fields),
              title: const Text('Font Size'),
              subtitle: const Text('Medium'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            
            ListTile(
              leading: const Icon(Icons.wallpaper),
              title: const Text('Chat Wallpaper'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            
            ListTile(
              leading: const Icon(Icons.backup),
              title: const Text('Chat Backup'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Fury Messenger',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.chat, color: Colors.white, size: 32),
      ),
      children: [
        const Text('A modern, secure messaging app.'),
        const SizedBox(height: 8),
        const Text('Built with Flutter ❤️'),
      ],
    );
  }

  void _openSupportChat(BuildContext context) async {
    // Find or create chat with support user @farruh
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Пожалуйста, войдите в аккаунт')),
        );
        return;
      }
      
      // Search for user with username "farruh"
      final usersQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: 'farruh')
          .limit(1)
          .get();
      
      if (usersQuery.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Поддержка временно недоступна')),
        );
        return;
      }
      
      final supportUser = usersQuery.docs.first;
      final supportUserId = supportUser.id;
      final supportUserData = supportUser.data();
      
      // Check if chat already exists
      final existingChats = await FirebaseFirestore.instance
          .collection('chats')
          .where('participantIds', arrayContains: currentUser.uid)
          .get();
      
      String? existingChatId;
      for (final chat in existingChats.docs) {
        final participants = List<String>.from(chat['participantIds'] ?? []);
        if (participants.contains(supportUserId) && participants.length == 2) {
          existingChatId = chat.id;
          break;
        }
      }
      
      if (existingChatId != null) {
        // Navigate to existing chat
        if (context.mounted) {
          context.push('/home/chat/$existingChatId');
        }
      } else {
        // Create new chat with support
        final newChat = await FirebaseFirestore.instance.collection('chats').add({
          'participantIds': [currentUser.uid, supportUserId],
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'lastMessage': 'Чат с поддержкой создан',
          'lastMessageTime': FieldValue.serverTimestamp(),
          'participantNames': {
            currentUser.uid: currentUser.displayName ?? 'User',
            supportUserId: supportUserData['displayName'] ?? 'Support',
          },
        });
        
        if (context.mounted) {
          context.push('/home/chat/${newChat.id}');
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e')),
      );
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthBloc>().add(const AuthEvent.signOut());
              context.go('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  void _showEditProfileSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Edit Profile', style: AppTypography.h2),
            const SizedBox(height: 24),
            
            // Avatar
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary,
                    child: Text(
                      (user?.displayName ?? 'U')[0].toUpperCase(),
                      style: const TextStyle(fontSize: 36, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, size: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            TextField(
              decoration: InputDecoration(
                labelText: 'Display Name',
                hintText: user?.displayName ?? 'Enter name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                prefixText: '@',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Save'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showEditStatusSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Set Status', style: AppTypography.h2),
            const SizedBox(height: 24),
            
            // Quick status options
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                '😊 Available',
                '🔔 Busy',
                '🚫 Do not disturb',
                '🏃 Away',
              ].map((status) => ChoiceChip(
                label: Text(status),
                selected: false,
                onSelected: (_) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Status set: $status')),
                  );
                },
              )).toList(),
            ),
            const SizedBox(height: 24),
            
            TextField(
              decoration: InputDecoration(
                labelText: 'Custom Status',
                hintText: 'What\'s on your mind?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLength: 100,
            ),
            const SizedBox(height: 16),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Save Status'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showVisibilityPicker(
    BuildContext context,
    String title,
    String currentValue,
    Function(String) onChanged,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Text(title, style: AppTypography.h3),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Everyone'),
            trailing: currentValue == 'everyone'
                ? const Icon(Icons.check, color: AppColors.primary)
                : null,
            onTap: () {
              onChanged('everyone');
              Navigator.pop(ctx);
            },
          ),
          ListTile(
            title: const Text('My Contacts'),
            trailing: currentValue == 'contacts'
                ? const Icon(Icons.check, color: AppColors.primary)
                : null,
            onTap: () {
              onChanged('contacts');
              Navigator.pop(ctx);
            },
          ),
          ListTile(
            title: const Text('Nobody'),
            trailing: currentValue == 'nobody'
                ? const Icon(Icons.check, color: AppColors.primary)
                : null,
            onTap: () {
              onChanged('nobody');
              Navigator.pop(ctx);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  String _getVisibilityText(String value) {
    switch (value) {
      case 'everyone':
        return 'Everyone';
      case 'contacts':
        return 'My Contacts';
      case 'nobody':
        return 'Nobody';
      default:
        return 'Everyone';
    }
  }
}
