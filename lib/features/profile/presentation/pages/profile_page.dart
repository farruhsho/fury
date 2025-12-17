import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Full-featured Profile Page
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _bioController = TextEditingController();
  
  bool _isLoading = true;
  bool _isSaving = false;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        _userData = doc.data();
        _displayNameController.text = _userData?['displayName'] ?? '';
        _usernameController.text = _userData?['username'] ?? '';
        _bioController.text = _userData?['bio'] ?? '';
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка загрузки: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('Не авторизован');

      // Check if username is taken (if changed)
      final newUsername = _usernameController.text.trim().toLowerCase();
      if (newUsername != _userData?['username']) {
        final existing = await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: newUsername)
            .get();
        
        if (existing.docs.isNotEmpty && existing.docs.first.id != user.uid) {
          throw Exception('Этот username уже занят');
        }
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'displayName': _displayNameController.text.trim(),
        'username': newUsername,
        'bio': _bioController.text.trim(),
        'displayNameLower': _displayNameController.text.trim().toLowerCase(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Update Firebase Auth display name
      await user.updateDisplayName(_displayNameController.text.trim());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Профиль сохранён!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _changeAvatar() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery, maxWidth: 512);
    
    if (image == null) return;

    // For now just show message - full implementation would upload to Firebase Storage
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Загрузка аватара будет добавлена позже')),
      );
    }
  }

  void _copyUsername() {
    final username = _usernameController.text.trim();
    if (username.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: '@$username'));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username скопирован!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль', style: AppTypography.h3),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _saveProfile,
            child: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
                    'Сохранить',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Avatar Section
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                          backgroundImage: _userData?['avatarUrl'] != null
                              ? NetworkImage(_userData!['avatarUrl'])
                              : (user?.photoURL != null
                                  ? NetworkImage(user!.photoURL!)
                                  : null),
                          child: (_userData?['avatarUrl'] == null && user?.photoURL == null)
                              ? Text(
                                  (_displayNameController.text.isNotEmpty
                                      ? _displayNameController.text[0]
                                      : '?').toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 48,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _changeAvatar,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Email (read-only)
                  Center(
                    child: Text(
                      user?.email ?? user?.phoneNumber ?? '',
                      style: AppTypography.bodyMedium.copyWith(color: Colors.grey[600]),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Display Name
                  TextFormField(
                    controller: _displayNameController,
                    decoration: InputDecoration(
                      labelText: 'Имя',
                      hintText: 'Ваше имя',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Введите имя';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Username
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'your_username',
                      prefixIcon: const Icon(Icons.alternate_email),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: _copyUsername,
                        tooltip: 'Копировать',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      helperText: 'Можно изменить один раз в 30 дней',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Введите username';
                      }
                      if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                        return 'Только буквы, цифры и _';
                      }
                      if (value.length < 3) {
                        return 'Минимум 3 символа';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Bio
                  TextFormField(
                    controller: _bioController,
                    decoration: InputDecoration(
                      labelText: 'О себе',
                      hintText: 'Расскажите о себе...',
                      prefixIcon: const Icon(Icons.info_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    maxLines: 3,
                    maxLength: 150,
                  ),
                  const SizedBox(height: 24),

                  // Stats Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('Чатов', _userData?['chatCount']?.toString() ?? '0'),
                        _buildStatItem('Контактов', _userData?['contactCount']?.toString() ?? '0'),
                        _buildStatItem('Групп', _userData?['groupCount']?.toString() ?? '0'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Account Info
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: const Text('Аккаунт создан'),
                    subtitle: Text(_formatDate(_userData?['createdAt'])),
                    tileColor: Colors.grey[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  ListTile(
                    leading: const Icon(Icons.access_time),
                    title: const Text('Последний онлайн'),
                    subtitle: Text(_formatDate(_userData?['lastSeen'])),
                    tileColor: Colors.grey[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Actions
                  OutlinedButton.icon(
                    onPressed: () => context.push('/home/settings'),
                    icon: const Icon(Icons.settings),
                    label: const Text('Настройки'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.h3.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTypography.caption.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return 'Неизвестно';
    if (timestamp is Timestamp) {
      final date = timestamp.toDate();
      return '${date.day}.${date.month}.${date.year}';
    }
    return 'Неизвестно';
  }
}
