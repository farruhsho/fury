import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/biometric_service.dart';
import '../../../../core/services/two_factor_auth_service.dart';
import '../../../../core/services/device_session_service.dart';
import '../../../../core/services/hidden_chats_service.dart';

/// Complete Security Settings Page with 2FA, Biometrics, Device Sessions, Hidden Chats
class SecuritySettingsPage extends StatefulWidget {
  const SecuritySettingsPage({super.key});

  @override
  State<SecuritySettingsPage> createState() => _SecuritySettingsPageState();
}

class _SecuritySettingsPageState extends State<SecuritySettingsPage> {
  final _biometricService = BiometricService();
  final _twoFactorService = TwoFactorAuthService();
  final _deviceSessionService = DeviceSessionService();
  final _hiddenChatsService = HiddenChatsService();

  bool _biometricAvailable = false;
  bool _biometricEnabled = false;
  bool _appLockEnabled = false;
  bool _twoFactorEnabled = false;
  bool _hiddenChatsEnabled = false;
  List<BiometricType> _availableBiometrics = [];
  List<DeviceSession> _sessions = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final biometricAvailable = await _biometricService.isBiometricAvailable();
    final availableBiometrics = await _biometricService.getAvailableBiometrics();
    final biometricEnabled = await _biometricService.isBiometricLockEnabled();
    final appLockEnabled = await _biometricService.isAppLockEnabled();
    final twoFactorEnabled = await _twoFactorService.isEnabled();
    final hiddenChatsEnabled = await _hiddenChatsService.hasPinSet();
    final sessions = await _deviceSessionService.getActiveSessions();

    if (mounted) {
      setState(() {
        _biometricAvailable = biometricAvailable;
        _availableBiometrics = availableBiometrics;
        _biometricEnabled = biometricEnabled;
        _appLockEnabled = appLockEnabled;
        _twoFactorEnabled = twoFactorEnabled;
        _hiddenChatsEnabled = hiddenChatsEnabled;
        _sessions = sessions;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security', style: AppTypography.h3),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                _buildSectionHeader('App Lock'),
                _buildBiometricTile(),
                _buildAppLockTile(),
                
                const Divider(height: 32),
                _buildSectionHeader('Two-Factor Authentication'),
                _buildTwoFactorTile(),
                
                const Divider(height: 32),
                _buildSectionHeader('Hidden Chats'),
                _buildHiddenChatsTile(),
                
                const Divider(height: 32),
                _buildSectionHeader('Active Sessions'),
                ..._buildSessionsList(),
                _buildLogoutAllTile(),
                
                const SizedBox(height: 32),
              ],
            ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.sm),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildBiometricTile() {
    final biometricName = _biometricService.getBiometricTypeName(_availableBiometrics);
    
    return SwitchListTile(
      title: Text(biometricName),
      subtitle: Text(
        _biometricAvailable
            ? 'Use $biometricName to unlock the app'
            : 'Biometric authentication not available',
      ),
      secondary: Icon(
        _availableBiometrics.contains(BiometricType.face)
            ? Icons.face
            : Icons.fingerprint,
        color: _biometricEnabled ? AppColors.primary : null,
      ),
      value: _biometricEnabled,
      onChanged: _biometricAvailable
          ? (value) async {
              if (value) {
                final authenticated = await _biometricService.authenticate(
                  reason: 'Authenticate to enable $biometricName',
                );
                if (authenticated) {
                  await _biometricService.setBiometricLockEnabled(true);
                  setState(() => _biometricEnabled = true);
                }
              } else {
                await _biometricService.setBiometricLockEnabled(false);
                setState(() => _biometricEnabled = false);
              }
            }
          : null,
    );
  }

  Widget _buildAppLockTile() {
    return SwitchListTile(
      title: const Text('App Lock'),
      subtitle: const Text('Require authentication when opening app'),
      secondary: Icon(
        Icons.lock_outline,
        color: _appLockEnabled ? AppColors.primary : null,
      ),
      value: _appLockEnabled,
      onChanged: (value) async {
        if (value && !_biometricEnabled) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Enable biometric first')),
          );
          return;
        }
        await _biometricService.setAppLockEnabled(value);
        setState(() => _appLockEnabled = value);
      },
    );
  }

  Widget _buildTwoFactorTile() {
    return ListTile(
      leading: Icon(
        Icons.security,
        color: _twoFactorEnabled ? AppColors.primary : null,
      ),
      title: const Text('Two-Factor Authentication'),
      subtitle: Text(_twoFactorEnabled ? 'Enabled' : 'Disabled'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _twoFactorEnabled ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _twoFactorEnabled ? 'ON' : 'OFF',
              style: TextStyle(
                color: _twoFactorEnabled ? Colors.green : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: () => _show2FADialog(),
    );
  }

  void _show2FADialog() {
    if (_twoFactorEnabled) {
      _showDisable2FADialog();
    } else {
      _showEnable2FADialog();
    }
  }

  void _showEnable2FADialog() {
    final secret = _twoFactorService.generateSecret();
    final backupCodes = _twoFactorService.generateBackupCodes();
    final codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enable 2FA'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add this secret to your authenticator app:',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        secret,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, size: 20),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: secret));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Secret copied!')),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text('Enter the 6-digit code from your app:'),
              const SizedBox(height: 8),
              TextField(
                controller: codeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: const InputDecoration(
                  hintText: '000000',
                  counterText: '',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Backup Codes:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...backupCodes.take(5).map((code) => Text(
                code,
                style: const TextStyle(fontFamily: 'monospace'),
              )),
              const Text('...and 5 more'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_twoFactorService.verifyCode(secret, codeController.text)) {
                await _twoFactorService.enable2FA(secret, backupCodes);
                Navigator.pop(context);
                setState(() => _twoFactorEnabled = true);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('2FA enabled successfully!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invalid code. Try again.')),
                );
              }
            },
            child: const Text('Enable'),
          ),
        ],
      ),
    );
  }

  void _showDisable2FADialog() {
    final codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Disable 2FA'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter your 2FA code to disable:'),
            const SizedBox(height: 16),
            TextField(
              controller: codeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                hintText: '000000',
                counterText: '',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              if (await _twoFactorService.verify(codeController.text)) {
                await _twoFactorService.disable2FA();
                Navigator.pop(context);
                setState(() => _twoFactorEnabled = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('2FA disabled')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invalid code')),
                );
              }
            },
            child: const Text('Disable'),
          ),
        ],
      ),
    );
  }

  Widget _buildHiddenChatsTile() {
    return ListTile(
      leading: Icon(
        Icons.visibility_off,
        color: _hiddenChatsEnabled ? AppColors.primary : null,
      ),
      title: const Text('Hidden Chats Folder'),
      subtitle: Text(
        _hiddenChatsEnabled
            ? 'Protected with PIN'
            : 'Set a PIN to hide sensitive chats',
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showHiddenChatsDialog(),
    );
  }

  void _showHiddenChatsDialog() {
    final pinController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_hiddenChatsEnabled ? 'Hidden Chats PIN' : 'Set Hidden Chats PIN'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _hiddenChatsEnabled
                  ? 'Enter current PIN to access or change it:'
                  : 'Create a 4-digit PIN for hidden chats:',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: pinController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: '••••',
                counterText: '',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          if (_hiddenChatsEnabled)
            TextButton(
              onPressed: () async {
                if (await _hiddenChatsService.verifyPin(pinController.text)) {
                  await _hiddenChatsService.removePin();
                  Navigator.pop(context);
                  setState(() => _hiddenChatsEnabled = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Hidden chats PIN removed')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Incorrect PIN')),
                  );
                }
              },
              child: const Text('Remove PIN', style: TextStyle(color: Colors.red)),
            ),
          ElevatedButton(
            onPressed: () async {
              if (pinController.text.length == 4) {
                if (_hiddenChatsEnabled) {
                  if (await _hiddenChatsService.verifyPin(pinController.text)) {
                    Navigator.pop(context);
                    // Navigate to hidden chats
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Accessing hidden chats...')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Incorrect PIN')),
                    );
                  }
                } else {
                  await _hiddenChatsService.setPin(pinController.text);
                  Navigator.pop(context);
                  setState(() => _hiddenChatsEnabled = true);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Hidden chats PIN set!')),
                  );
                }
              }
            },
            child: Text(_hiddenChatsEnabled ? 'Unlock' : 'Set PIN'),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSessionsList() {
    if (_sessions.isEmpty) {
      return [
        const ListTile(
          leading: Icon(Icons.devices),
          title: Text('No active sessions'),
          subtitle: Text('Session tracking will appear here'),
        ),
      ];
    }

    return _sessions.map((session) {
      return ListTile(
        leading: Icon(
          _getDeviceIcon(session.platform),
          color: session.isCurrent ? AppColors.primary : null,
        ),
        title: Row(
          children: [
            Text(session.deviceName),
            if (session.isCurrent) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'This device',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Text(
          '${session.platform} • Last active: ${_formatLastActive(session.lastActive)}',
        ),
        trailing: session.isCurrent
            ? null
            : IconButton(
                icon: const Icon(Icons.logout, color: Colors.red),
                onPressed: () => _terminateSession(session.id),
              ),
      );
    }).toList();
  }

  IconData _getDeviceIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'android':
        return Icons.android;
      case 'ios':
        return Icons.phone_iphone;
      case 'web':
        return Icons.web;
      case 'windows':
        return Icons.desktop_windows;
      case 'macos':
        return Icons.desktop_mac;
      default:
        return Icons.devices;
    }
  }

  String _formatLastActive(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  Future<void> _terminateSession(String sessionId) async {
    await _deviceSessionService.terminateSession(sessionId);
    setState(() {
      _sessions.removeWhere((s) => s.id == sessionId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Session terminated')),
    );
  }

  Widget _buildLogoutAllTile() {
    return ListTile(
      leading: const Icon(Icons.logout, color: Colors.red),
      title: const Text(
        'Log Out from All Devices',
        style: TextStyle(color: Colors.red),
      ),
      subtitle: const Text('End all other sessions'),
      onTap: () => _showLogoutAllDialog(),
    );
  }

  void _showLogoutAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out from All Devices?'),
        content: const Text(
          'This will terminate all other sessions. You will stay logged in on this device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              await _deviceSessionService.terminateOtherSessions();
              Navigator.pop(context);
              await _loadSettings();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All other sessions terminated')),
              );
            },
            child: const Text('Log Out All'),
          ),
        ],
      ),
    );
  }
}
