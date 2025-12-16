import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

/// Device Management Page - Shows active sessions and allows logout from other devices
class DeviceManagementPage extends StatefulWidget {
  const DeviceManagementPage({super.key});

  @override
  State<DeviceManagementPage> createState() => _DeviceManagementPageState();
}

class _DeviceManagementPageState extends State<DeviceManagementPage> {
  bool _isLoading = false;
  String? _currentDeviceId;

  @override
  void initState() {
    super.initState();
    _getCurrentDeviceId();
  }

  Future<void> _getCurrentDeviceId() async {
    try {
      String deviceId;
      final platform = _getPlatformName();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      deviceId = '${platform}_$timestamp';
      
      setState(() {
        _currentDeviceId = deviceId;
      });
    } catch (e) {
      debugPrint('Error getting device ID: $e');
    }
  }

  String _getPlatformName() {
    if (kIsWeb) return 'web';
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    if (Platform.isWindows) return 'windows';
    if (Platform.isMacOS) return 'macos';
    if (Platform.isLinux) return 'linux';
    return 'unknown';
  }


  Future<void> _logoutFromAllOtherDevices() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log out from other devices?'),
        content: const Text(
          'This will end all sessions on other devices. You will remain logged in on this device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Log Out All'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      // Get all sessions except current
      final sessions = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('sessions')
          .get();

      final batch = FirebaseFirestore.instance.batch();
      for (final doc in sessions.docs) {
        // Don't delete current session
        if (doc.id != _currentDeviceId) {
          batch.delete(doc.reference);
        }
      }
      await batch.commit();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logged out from all other devices'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _terminateSession(String sessionId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('sessions')
          .doc(sessionId)
          .delete();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Session terminated'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _formatLastActive(dynamic timestamp) {
    if (timestamp == null) return 'Unknown';
    
    DateTime lastActive;
    if (timestamp is Timestamp) {
      lastActive = timestamp.toDate();
    } else if (timestamp is DateTime) {
      lastActive = timestamp;
    } else {
      return 'Unknown';
    }

    final now = DateTime.now();
    final diff = now.difference(lastActive);

    if (diff.inMinutes < 1) {
      return 'Just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} minutes ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hours ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return '${lastActive.day}/${lastActive.month}/${lastActive.year}';
    }
  }

  IconData _getDeviceIcon(String? platform) {
    switch (platform?.toLowerCase()) {
      case 'android':
        return Icons.phone_android;
      case 'ios':
        return Icons.phone_iphone;
      case 'windows':
        return Icons.desktop_windows;
      case 'macos':
        return Icons.desktop_mac;
      case 'linux':
        return Icons.computer;
      case 'web':
        return Icons.web;
      default:
        return Icons.devices;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Linked Devices', style: AppTypography.h3),
        actions: [
          if (_isLoading)
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
      body: user == null
          ? const Center(child: Text('Please login'))
          : Column(
              children: [
                // Log out all button
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: OutlinedButton.icon(
                    onPressed: _isLoading ? null : _logoutFromAllOtherDevices,
                    icon: const Icon(Icons.logout, color: Colors.red),
                    label: const Text(
                      'Log out from all other devices',
                      style: TextStyle(color: Colors.red),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Active Sessions',
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .collection('sessions')
                        .orderBy('lastActive', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error_outline, size: 48, color: Colors.grey),
                              const SizedBox(height: 16),
                              Text('Error: ${snapshot.error}'),
                            ],
                          ),
                        );
                      }

                      final sessions = snapshot.data?.docs ?? [];

                      if (sessions.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.devices, size: 64, color: Colors.grey.shade400),
                              const SizedBox(height: 16),
                              Text(
                                'No sessions recorded yet',
                                style: AppTypography.bodyLarge.copyWith(color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Sessions will appear here when you login from other devices',
                                style: AppTypography.bodySmall.copyWith(color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: sessions.length,
                        itemBuilder: (context, index) {
                          final session = sessions[index];
                          final data = session.data() as Map<String, dynamic>;
                          final isCurrentDevice = session.id == _currentDeviceId;
                          final platform = data['platform'] as String?;
                          final deviceName = data['deviceName'] as String? ?? 'Unknown Device';
                          final lastActive = data['lastActive'];

                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: isCurrentDevice
                                  ? AppColors.primary.withOpacity(0.1)
                                  : Colors.grey.withOpacity(0.1),
                              child: Icon(
                                _getDeviceIcon(platform),
                                color: isCurrentDevice ? AppColors.primary : Colors.grey,
                              ),
                            ),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    deviceName,
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                if (isCurrentDevice)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      'This device',
                                      style: TextStyle(color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                              ],
                            ),
                            subtitle: Text(
                              '${platform ?? 'Unknown'} • ${_formatLastActive(lastActive)}',
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                            ),
                            trailing: isCurrentDevice
                                ? null
                                : IconButton(
                                    icon: const Icon(Icons.close, color: Colors.red),
                                    onPressed: () => _terminateSession(session.id),
                                  ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
