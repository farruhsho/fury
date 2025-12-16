import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../widgets/invite_link_sheet.dart';

/// Full-featured Group/Channel Info Page
class GroupChannelInfoPage extends StatefulWidget {
  final String chatId;
  
  const GroupChannelInfoPage({super.key, required this.chatId});

  @override
  State<GroupChannelInfoPage> createState() => _GroupChannelInfoPageState();
}

class _GroupChannelInfoPageState extends State<GroupChannelInfoPage> {
  bool _isLoading = true;
  bool _notificationsEnabled = true;
  Map<String, dynamic>? _chatData;
  List<Map<String, dynamic>> _members = [];
  
  bool get _isChannel => _chatData?['type'] == 'channel';
  bool get _isAdmin => (_chatData?['adminIds'] as List?)?.contains(
    FirebaseAuth.instance.currentUser?.uid,
  ) ?? false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Load chat/channel data
      final chatDoc = await FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatId)
          .get();
      
      if (!chatDoc.exists) {
        if (mounted) Navigator.pop(context);
        return;
      }

      _chatData = chatDoc.data();
      
      // Load members
      final participantIds = List<String>.from(_chatData?['participantIds'] ?? []);
      for (final id in participantIds.take(50)) { // Limit to 50
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .get();
        
        if (userDoc.exists) {
          _members.add({
            'id': id,
            ...userDoc.data()!,
            'isAdmin': (_chatData?['adminIds'] as List?)?.contains(id) ?? false,
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _leaveGroup() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_isChannel ? 'Отписаться от канала?' : 'Покинуть группу?'),
        content: Text(_isChannel 
          ? 'Вы больше не будете получать обновления этого канала.'
          : 'Вы больше не сможете читать сообщения этой группы.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(_isChannel ? 'Отписаться' : 'Покинуть'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return;

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatId)
          .update({
        'participantIds': FieldValue.arrayRemove([userId]),
      });

      if (mounted) {
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e')),
        );
      }
    }
  }

  void _showInviteLink() {
    if (_chatData == null) return;
    
    final inviteCode = _chatData!['inviteCode'] ?? widget.chatId.substring(0, 8);
    final inviteLink = 'https://fury.app/${_isChannel ? 'c' : 'g'}/$inviteCode';
    
    InviteLinkSheet.show(
      context: context,
      name: _chatData!['name'] ?? 'Group',
      inviteLink: inviteLink,
      inviteCode: inviteCode,
      isChannel: _isChannel,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final name = _chatData?['name'] ?? 'Group';
    final description = _chatData?['description'] ?? '';
    final memberCount = (_chatData?['participantIds'] as List?)?.length ?? 0;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Avatar
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withValues(alpha: 0.7),
                    ],
                  ),
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    backgroundImage: _chatData?['avatarUrl'] != null
                        ? NetworkImage(_chatData!['avatarUrl'])
                        : null,
                    child: _chatData?['avatarUrl'] == null
                        ? Icon(
                            _isChannel ? Icons.campaign : Icons.group,
                            size: 50,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
              ),
            ),
            actions: [
              if (_isAdmin)
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Редактирование скоро будет доступно')),
                    );
                  },
                ),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const ListTile(
                      leading: Icon(Icons.search),
                      title: Text('Поиск'),
                      contentPadding: EdgeInsets.zero,
                    ),
                    onTap: () {},
                  ),
                  PopupMenuItem(
                    child: const ListTile(
                      leading: Icon(Icons.report),
                      title: Text('Пожаловаться'),
                      contentPadding: EdgeInsets.zero,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info Section
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Type & Count
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _isChannel ? 'Канал' : 'Группа',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '$memberCount ${_isChannel ? 'подписчиков' : 'участников'}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      
                      if (description.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Описание',
                          style: AppTypography.caption.copyWith(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(description, style: AppTypography.bodyMedium),
                      ],
                    ],
                  ),
                ),

                const Divider(height: 1),

                // Actions
                ListTile(
                  leading: Icon(Icons.link, color: AppColors.primary),
                  title: const Text('Ссылка-приглашение'),
                  subtitle: const Text('Пригласить участников'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _showInviteLink,
                ),
                
                ListTile(
                  leading: Icon(
                    _notificationsEnabled ? Icons.notifications : Icons.notifications_off,
                    color: _notificationsEnabled ? AppColors.primary : Colors.grey,
                  ),
                  title: const Text('Уведомления'),
                  trailing: Switch(
                    value: _notificationsEnabled,
                    onChanged: (value) => setState(() => _notificationsEnabled = value),
                    activeColor: AppColors.primary,
                  ),
                ),

                const Divider(height: 1),

                // Members Section
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _isChannel ? 'Подписчики' : 'Участники',
                        style: AppTypography.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_isAdmin)
                        TextButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Добавление участников скоро')),
                            );
                          },
                          icon: const Icon(Icons.person_add, size: 18),
                          label: const Text('Добавить'),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Members List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final member = _members[index];
                final isCurrentUser = member['id'] == FirebaseAuth.instance.currentUser?.uid;
                
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    backgroundImage: member['avatarUrl'] != null
                        ? NetworkImage(member['avatarUrl'])
                        : null,
                    child: member['avatarUrl'] == null
                        ? Text(
                            (member['displayName'] as String? ?? '?')[0].toUpperCase(),
                            style: TextStyle(color: AppColors.primary),
                          )
                        : null,
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          member['displayName'] ?? member['username'] ?? 'User',
                          style: AppTypography.bodyLarge.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (member['isAdmin'] == true)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.orange.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Админ',
                            style: TextStyle(fontSize: 10, color: Colors.orange),
                          ),
                        ),
                      if (isCurrentUser)
                        const Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: Text('(Вы)', style: TextStyle(color: Colors.grey)),
                        ),
                    ],
                  ),
                  subtitle: member['username'] != null
                      ? Text('@${member['username']}')
                      : null,
                  onTap: isCurrentUser ? null : () {
                    // Open user profile or chat
                  },
                );
              },
              childCount: _members.length,
            ),
          ),

          // Leave Button
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: OutlinedButton.icon(
                onPressed: _leaveGroup,
                icon: Icon(
                  _isChannel ? Icons.unsubscribe : Icons.exit_to_app,
                  color: Colors.red,
                ),
                label: Text(
                  _isChannel ? 'Отписаться' : 'Покинуть группу',
                  style: const TextStyle(color: Colors.red),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Colors.red),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}
