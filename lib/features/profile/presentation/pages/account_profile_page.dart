import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';

/// Account Profile Info page - from Settings
class AccountProfilePage extends StatefulWidget {
  const AccountProfilePage({super.key});

  @override
  State<AccountProfilePage> createState() => _AccountProfilePageState();
}

class _AccountProfilePageState extends State<AccountProfilePage> {
  Map<String, dynamic>? _userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (doc.exists) {
          setState(() {
            _userData = doc.data();
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _editField(String field, String currentValue) {
    final controller = TextEditingController(text: currentValue);
    
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: Text(
          _getFieldLabel(field),
          style: TextStyle(color: AppColors.textPrimaryLight),
        ),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: AppColors.textPrimaryLight),
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Введите ${_getFieldLabel(field).toLowerCase()}',
            hintStyle: TextStyle(color: AppColors.textSecondaryLight),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Отмена', style: TextStyle(color: AppColors.textSecondaryLight)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await _updateField(field, controller.text);
            },
            child: Text('Сохранить', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  String _getFieldLabel(String field) {
    switch (field) {
      case 'displayName': return 'Имя';
      case 'info': return 'Информация';
      case 'phoneNumber': return 'Телефон';
      default: return field;
    }
  }

  Future<void> _updateField(String field, String value) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({field: value});
        
        setState(() {
          _userData?[field] = value;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Сохранено')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e')),
      );
    }
  }

  Future<void> _changeAvatar() async {
    // TODO: Implement image picker
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Выбор фото...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.backgroundDark,
        appBar: AppBar(
          backgroundColor: AppColors.surfaceDark,
          title: const Text('Профиль'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final name = _userData?['displayName'] ?? _userData?['name'] ?? '';
    final info = _userData?['info'] ?? _userData?['username'] ?? '';
    final phone = _userData?['phoneNumber'] ?? '';
    final avatarUrl = _userData?['avatarUrl'] ?? _userData?['photoUrl'];

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Профиль', style: AppTypography.h3),
      ),
      body: ListView(
        children: [
          const SizedBox(height: AppSpacing.xl),
          
          // Avatar section
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _changeAvatar,
                  child: CircleAvatar(
                    radius: 64,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                    backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
                    child: avatarUrl == null
                        ? Text(
                            name.isNotEmpty ? name[0].toUpperCase() : '?',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                TextButton(
                  onPressed: _changeAvatar,
                  child: Text(
                    'Изменить',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Name field
          _buildProfileField(
            icon: Icons.person_outline,
            label: 'Имя',
            value: name,
            onTap: () => _editField('displayName', name),
          ),

          // Info field
          _buildProfileField(
            icon: Icons.info_outline,
            label: 'Информация',
            value: info.isNotEmpty ? info : 'Добавить информацию',
            isPlaceholder: info.isEmpty,
            onTap: () => _editField('info', info),
          ),

          // Phone field
          _buildProfileField(
            icon: Icons.phone_outlined,
            label: 'Телефон',
            value: phone.isNotEmpty ? phone : 'Добавить номер',
            isPlaceholder: phone.isEmpty,
            onTap: () => _editField('phoneNumber', phone),
          ),

          // Links field
          _buildProfileField(
            icon: Icons.link,
            label: 'Ссылки',
            value: 'Добавить ссылки',
            isPlaceholder: true,
            valueColor: AppColors.primary,
            onTap: () {
              // Add links
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileField({
    required IconData icon,
    required String label,
    required String value,
    bool isPlaceholder = false,
    Color? valueColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondaryLight),
      title: Text(
        label,
        style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondaryLight),
      ),
      subtitle: Text(
        value,
        style: AppTypography.bodyLarge.copyWith(
          color: valueColor ?? (isPlaceholder ? AppColors.primary : AppColors.textPrimaryLight),
        ),
      ),
      onTap: onTap,
    );
  }
}
