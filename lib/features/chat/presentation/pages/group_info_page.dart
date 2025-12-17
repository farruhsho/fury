import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';

/// WhatsApp-style Group Info page
class GroupInfoPage extends StatefulWidget {
  final String chatId;

  const GroupInfoPage({super.key, required this.chatId});

  @override
  State<GroupInfoPage> createState() => _GroupInfoPageState();
}

class _GroupInfoPageState extends State<GroupInfoPage> {
  Map<String, dynamic>? _groupData;
  List<Map<String, dynamic>> _participants = [];
  List<Map<String, dynamic>> _recentMedia = [];
  bool _isLoading = true;
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadGroupInfo();
  }

  Future<void> _loadGroupInfo() async {
    try {
      // Load group data
      final groupDoc = await FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatId)
          .get();

      if (groupDoc.exists) {
        final data = groupDoc.data()!;
        
        // Load participants
        final participantIds = List<String>.from(data['participantIds'] ?? []);
        final participants = <Map<String, dynamic>>[];
        
        for (final id in participantIds.take(10)) {
          final userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(id)
              .get();
          if (userDoc.exists) {
            participants.add({
              'id': id,
              ...userDoc.data()!,
            });
          }
        }

        // Load recent media
        final messagesSnapshot = await FirebaseFirestore.instance
            .collection('chats')
            .doc(widget.chatId)
            .collection('messages')
            .where('attachments', isNotEqualTo: null)
            .orderBy('attachments')
            .orderBy('createdAt', descending: true)
            .limit(10)
            .get();

        final media = messagesSnapshot.docs
            .map((doc) => doc.data())
            .where((m) => m['attachments'] != null)
            .toList();

        setState(() {
          _groupData = data;
          _participants = participants;
          _recentMedia = media.cast<Map<String, dynamic>>();
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.backgroundDark,
        appBar: AppBar(backgroundColor: AppColors.surfaceDark),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final groupName = _groupData?['name'] ?? 'Группа';
    final participantCount = _participants.length;
    final description = _groupData?['description'] ?? '';
    final createdAt = (_groupData?['createdAt'] as Timestamp?)?.toDate();

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: CustomScrollView(
        slivers: [
          // Collapsing header with group avatar
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.surfaceDark,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => _showOptionsMenu(context),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  // Group avatar
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                    backgroundImage: _groupData?['imageUrl'] != null
                        ? NetworkImage(_groupData!['imageUrl'])
                        : null,
                    child: _groupData?['imageUrl'] == null
                        ? const Icon(Icons.group, size: 50, color: AppColors.primary)
                        : null,
                  ),
                  const SizedBox(height: 16),
                  // Group name
                  Text(
                    groupName,
                    style: AppTypography.h2.copyWith(color: AppColors.textPrimaryLight),
                  ),
                  const SizedBox(height: 4),
                  // Participant count
                  Text(
                    'Группа · $participantCount участника',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Action buttons
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.headset,
                      label: 'Аудиочат',
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.search,
                      label: 'Поиск',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Description section
          if (description.isNotEmpty)
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                color: AppColors.surfaceDark,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    if (createdAt != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Создана ${_formatDate(createdAt)}',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

          // Media section
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.surfaceDark,
              margin: const EdgeInsets.only(top: AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Медиа, ссылки и докум.',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/media-gallery/${widget.chatId}'),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_recentMedia.isNotEmpty)
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                        itemCount: _recentMedia.length,
                        itemBuilder: (context, index) {
                          return _buildMediaThumbnail(_recentMedia[index]);
                        },
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Text(
                        'Нет медиа файлов',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                    ),
                  const SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
          ),

          // Settings section
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.surfaceDark,
              margin: const EdgeInsets.only(top: AppSpacing.sm),
              child: Column(
                children: [
                  _buildSettingTile(
                    icon: Icons.notifications_outlined,
                    title: 'Уведомления',
                    subtitle: _notificationsEnabled ? 'Все' : 'Отключены',
                    onTap: () {
                      setState(() => _notificationsEnabled = !_notificationsEnabled);
                    },
                  ),
                  _buildSettingTile(
                    icon: Icons.photo_outlined,
                    title: 'Видимость медиа',
                    onTap: () {},
                  ),
                  _buildSettingTile(
                    icon: Icons.lock_outline,
                    title: 'Шифрование',
                    subtitle: 'Сообщения защищены сквозным шифрованием',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          // Participants section
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.surfaceDark,
              margin: const EdgeInsets.only(top: AppSpacing.sm),
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Text(
                      '$participantCount участников',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  // Add participant button
                  ListTile(
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person_add, color: Colors.white),
                    ),
                    title: Text(
                      'Добавить участников',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    onTap: () {},
                  ),
                  // Invite link button
                  ListTile(
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.link, color: Colors.white),
                    ),
                    title: Text(
                      'Пригласить по ссылке',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          // Participants list
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final participant = _participants[index];
                return Container(
                  color: AppColors.surfaceDark,
                  child: _buildParticipantTile(participant),
                );
              },
              childCount: _participants.length,
            ),
          ),

          // Exit group button
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.surfaceDark,
              margin: const EdgeInsets.only(top: AppSpacing.sm),
              child: ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.red.shade400),
                title: Text(
                  'Выйти из группы',
                  style: AppTypography.bodyLarge.copyWith(
                    color: Colors.red.shade400,
                  ),
                ),
                onTap: () => _showExitConfirmation(context),
              ),
            ),
          ),

          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.caption.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaThumbnail(Map<String, dynamic> media) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.only(right: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            child: media['thumbnailUrl'] != null
                ? Image.network(
                    media['thumbnailUrl'],
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  )
                : const Center(
                    child: Icon(Icons.image, color: AppColors.textSecondaryLight),
                  ),
          ),
          // Video indicator
          if (media['type'] == 'video')
            Positioned(
              left: 4,
              bottom: 4,
              child: Row(
                children: [
                  const Icon(Icons.videocam, size: 14, color: Colors.white),
                  const SizedBox(width: 2),
                  Text(
                    media['duration'] ?? '0:00',
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondaryLight),
      title: Text(
        title,
        style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimaryLight),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondaryLight,
              ),
            )
          : null,
      onTap: onTap,
    );
  }

  Widget _buildParticipantTile(Map<String, dynamic> participant) {
    final name = participant['displayName'] ?? participant['name'] ?? 'Unknown';
    final phone = participant['phoneNumber'] ?? '';
    final avatarUrl = participant['avatarUrl'];
    final isAdmin = participant['role'] == 'admin';

    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.primary.withValues(alpha: 0.2),
        backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
        child: avatarUrl == null
            ? Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
              )
            : null,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimaryLight),
            ),
          ),
          if (isAdmin)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Админ',
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontSize: 10,
                ),
              ),
            ),
        ],
      ),
      subtitle: phone.isNotEmpty
          ? Text(
              phone,
              style: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
            )
          : null,
      onTap: () {
        // Show participant options
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textSecondaryLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.edit, color: AppColors.textPrimaryLight),
            title: const Text('Редактировать группу', 
              style: TextStyle(color: AppColors.textPrimaryLight)),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.share, color: AppColors.textPrimaryLight),
            title: const Text('Поделиться', 
              style: TextStyle(color: AppColors.textPrimaryLight)),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.report, color: Colors.red.shade400),
            title: Text('Пожаловаться', 
              style: TextStyle(color: Colors.red.shade400)),
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showExitConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Выйти из группы?', 
          style: TextStyle(color: AppColors.textPrimaryLight)),
        content: const Text(
          'Вы уверены, что хотите выйти из этой группы?',
          style: TextStyle(color: AppColors.textSecondaryLight),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена', style: TextStyle(color: AppColors.textSecondaryLight)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pop();
              // TODO: Implement leave group
            },
            child: Text('Выйти', style: TextStyle(color: Colors.red.shade400)),
          ),
        ],
      ),
    );
  }
}
