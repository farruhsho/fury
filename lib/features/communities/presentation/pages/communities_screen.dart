import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';

/// Communities screen - WhatsApp-style communities
class CommunitiesScreen extends StatefulWidget {
  const CommunitiesScreen({super.key});

  @override
  State<CommunitiesScreen> createState() => _CommunitiesScreenState();
}

class _CommunitiesScreenState extends State<CommunitiesScreen> {
  List<Map<String, dynamic>> _communities = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCommunities();
  }

  Future<void> _loadCommunities() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final communitiesSnapshot = await FirebaseFirestore.instance
          .collection('communities')
          .where('memberIds', arrayContains: user.uid)
          .get();

      final communities = <Map<String, dynamic>>[];
      
      for (final doc in communitiesSnapshot.docs) {
        final data = doc.data();
        data['id'] = doc.id;
        
        // Load groups in community
        final groupsSnapshot = await FirebaseFirestore.instance
            .collection('communities')
            .doc(doc.id)
            .collection('groups')
            .get();
        
        data['groups'] = groupsSnapshot.docs.map((g) {
          final groupData = g.data();
          groupData['id'] = g.id;
          return groupData;
        }).toList();
        
        communities.add(data);
      }

      setState(() {
        _communities = communities;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        title: Text('Сообщества', style: AppTypography.h3),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadCommunities,
              child: ListView(
                children: [
                  // New community button
                  ListTile(
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          const Center(
                            child: Icon(Icons.groups, color: AppColors.textSecondaryLight, size: 28),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.add, color: Colors.white, size: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: Text(
                      'Новое сообщество',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    onTap: () => _showCreateCommunityDialog(context),
                  ),

                  const Divider(color: AppColors.surfaceLight, height: 1),

                  // Communities list
                  if (_communities.isEmpty)
                    _buildEmptyState()
                  else
                    ..._communities.map((c) => _buildCommunityItem(c)),
                ],
              ),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        children: [
          Icon(
            Icons.groups_outlined,
            size: 64,
            color: AppColors.textSecondaryLight,
          ),
          const SizedBox(height: 16),
          Text(
            'Нет сообществ',
            style: AppTypography.h3.copyWith(color: AppColors.textSecondaryLight),
          ),
          const SizedBox(height: 8),
          Text(
            'Создайте сообщество для организации связанных групп.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondaryLight,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityItem(Map<String, dynamic> community) {
    final name = community['name'] ?? 'Community';
    final groups = community['groups'] as List<dynamic>? ?? [];
    final avatarUrl = community['avatarUrl'] as String?;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Community header
        ListTile(
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: avatarUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(avatarUrl, fit: BoxFit.cover),
                  )
                : const Icon(Icons.groups, color: AppColors.primary),
          ),
          title: Text(
            name,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textPrimaryLight,
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: () {
            // Open community details
          },
        ),

        // Groups in community
        ...groups.map((group) => _buildGroupItem(group as Map<String, dynamic>)),

        // "All" button
        ListTile(
          leading: const SizedBox(width: 24),
          title: Row(
            children: [
              const Icon(Icons.chevron_right, color: AppColors.textSecondaryLight, size: 20),
              const SizedBox(width: 8),
              Text(
                'Все',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimaryLight,
                ),
              ),
            ],
          ),
          onTap: () {
            // Show all groups
          },
        ),

        const Divider(color: AppColors.surfaceLight, height: 1),
      ],
    );
  }

  Widget _buildGroupItem(Map<String, dynamic> group) {
    final name = group['name'] ?? 'Group';
    final lastMessage = group['lastMessage'] ?? '';
    final isAnnouncement = group['isAnnouncement'] == true;
    final timestamp = group['lastMessageTime'] as Timestamp?;
    final timeStr = timestamp != null ? _formatDate(timestamp.toDate()) : '';

    return ListTile(
      contentPadding: const EdgeInsets.only(left: 72, right: 16),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isAnnouncement ? Icons.campaign : Icons.chat_bubble_outline,
          color: AppColors.textSecondaryLight,
          size: 20,
        ),
      ),
      title: Text(
        name,
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.textPrimaryLight,
        ),
      ),
      subtitle: lastMessage.isNotEmpty
          ? Text(
              lastMessage,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondaryLight,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      trailing: timeStr.isNotEmpty
          ? Text(
              timeStr,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondaryLight,
              ),
            )
          : null,
      onTap: () {
        // Open group chat
        context.push('/chat/${group['id']}');
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  void _showCreateCommunityDialog(BuildContext context) {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: Text(
          'Новое сообщество',
          style: TextStyle(color: AppColors.textPrimaryLight),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: const TextStyle(color: AppColors.textPrimaryLight),
              decoration: InputDecoration(
                hintText: 'Название сообщества',
                hintStyle: TextStyle(color: AppColors.textSecondaryLight),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Сообщества объединяют связанные группы для удобной организации.',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Отмена', style: TextStyle(color: AppColors.textSecondaryLight)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              if (nameController.text.isNotEmpty) {
                _createCommunity(nameController.text);
              }
            },
            child: Text('Создать', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  Future<void> _createCommunity(String name) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      await FirebaseFirestore.instance.collection('communities').add({
        'name': name,
        'createdAt': FieldValue.serverTimestamp(),
        'createdBy': user.uid,
        'memberIds': [user.uid],
        'adminIds': [user.uid],
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Сообщество создано')),
      );
      
      _loadCommunities();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e')),
      );
    }
  }
}
