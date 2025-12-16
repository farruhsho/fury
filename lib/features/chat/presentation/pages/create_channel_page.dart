import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Create Channel Page - channels are broadcast-only (only admins can post)
class CreateChannelPage extends StatefulWidget {
  const CreateChannelPage({super.key});

  @override
  State<CreateChannelPage> createState() => _CreateChannelPageState();
}

class _CreateChannelPageState extends State<CreateChannelPage> {
  final _formKey = GlobalKey<FormState>();
  final _channelNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _usernameController = TextEditingController();
  
  bool _isPublic = true;
  bool _isCreating = false;

  @override
  void dispose() {
    _channelNameController.dispose();
    _descriptionController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _createChannel() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isCreating = true);

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) throw Exception('Не авторизован');

      // Generate unique channel username if not provided
      String channelUsername = _usernameController.text.trim().toLowerCase();
      if (channelUsername.isEmpty) {
        channelUsername = _channelNameController.text.trim()
            .toLowerCase()
            .replaceAll(RegExp(r'[^a-z0-9]'), '_');
      }

      // Check if username is taken
      final existingChannel = await FirebaseFirestore.instance
          .collection('channels')
          .where('username', isEqualTo: channelUsername)
          .get();

      if (existingChannel.docs.isNotEmpty) {
        // Add random suffix
        channelUsername = '${channelUsername}_${const Uuid().v4().substring(0, 4)}';
      }

      // Generate invite link
      final inviteCode = const Uuid().v4().substring(0, 8);

      // Get current user data
      final currentUserDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      final currentUserData = currentUserDoc.data() ?? {};

      // Create channel
      final channelRef = await FirebaseFirestore.instance.collection('channels').add({
        'type': 'channel',
        'name': _channelNameController.text.trim(),
        'username': channelUsername,
        'description': _descriptionController.text.trim(),
        'isPublic': _isPublic,
        'inviteCode': inviteCode,
        'inviteLink': 'https://fury.app/c/$inviteCode',
        'creatorId': currentUser.uid,
        'creatorName': currentUserData['displayName'] ?? currentUser.displayName ?? 'User',
        'adminIds': [currentUser.uid],
        'subscriberIds': [currentUser.uid],
        'subscriberCount': 1,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'lastMessage': 'Канал создан',
        'lastMessageTime': FieldValue.serverTimestamp(),
        'avatarUrl': null,
      });

      // Also create in chats collection for unified chat list
      await FirebaseFirestore.instance.collection('chats').doc(channelRef.id).set({
        'type': 'channel',
        'channelId': channelRef.id,
        'name': _channelNameController.text.trim(),
        'username': channelUsername,
        'description': _descriptionController.text.trim(),
        'isPublic': _isPublic,
        'inviteCode': inviteCode,
        'participantIds': [currentUser.uid], // Subscribers
        'adminIds': [currentUser.uid],
        'createdBy': currentUser.uid,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'lastMessage': 'Канал создан',
        'lastMessageTime': FieldValue.serverTimestamp(),
        'avatarUrl': null,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ Канал @$channelUsername создан!'),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/home/chat/${channelRef.id}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isCreating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новый канал', style: AppTypography.h3),
        actions: [
          TextButton(
            onPressed: _isCreating ? null : _createChannel,
            child: _isCreating
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    'Создать',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Channel Avatar
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    child: Icon(
                      Icons.campaign,
                      size: 50,
                      color: AppColors.primary,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Channel Name
            TextFormField(
              controller: _channelNameController,
              decoration: InputDecoration(
                labelText: 'Название канала',
                hintText: 'Введите название',
                prefixIcon: const Icon(Icons.campaign),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Введите название канала';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Channel Username
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Юзернейм (ссылка)',
                hintText: 'my_channel',
                prefixIcon: const Icon(Icons.alternate_email),
                prefixIconConstraints: const BoxConstraints(minWidth: 50),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                helperText: 'Будет доступен по ссылке @username',
              ),
            ),
            const SizedBox(height: 16),

            // Description
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Описание (опционально)',
                hintText: 'О чём этот канал?',
                prefixIcon: const Icon(Icons.description),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            // Channel Type
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Тип канала',
                    style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  
                  // Public Channel
                  RadioListTile<bool>(
                    value: true,
                    groupValue: _isPublic,
                    onChanged: (value) => setState(() => _isPublic = value!),
                    title: Row(
                      children: [
                        Icon(Icons.public, color: AppColors.primary),
                        const SizedBox(width: 8),
                        const Text('Публичный'),
                      ],
                    ),
                    subtitle: const Text('Любой может найти и подписаться'),
                    activeColor: AppColors.primary,
                    contentPadding: EdgeInsets.zero,
                  ),
                  
                  // Private Channel
                  RadioListTile<bool>(
                    value: false,
                    groupValue: _isPublic,
                    onChanged: (value) => setState(() => _isPublic = value!),
                    title: Row(
                      children: [
                        Icon(Icons.lock, color: Colors.orange),
                        const SizedBox(width: 8),
                        const Text('Приватный'),
                      ],
                    ),
                    subtitle: const Text('Только по ссылке-приглашению'),
                    activeColor: AppColors.primary,
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'В каналах только администраторы могут публиковать сообщения. Подписчики могут только читать.',
                      style: AppTypography.bodySmall.copyWith(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
