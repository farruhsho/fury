import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/di/injection_container.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/domain/usecases/search_users_usecase.dart';
import '../../../chat/domain/entities/chat_entity.dart';
import '../../../chat/domain/usecases/create_chat_usecase.dart';

/// Unified search page with tabs for Users, Groups, and Channels
class UnifiedSearchPage extends StatefulWidget {
  const UnifiedSearchPage({super.key});

  @override
  State<UnifiedSearchPage> createState() => _UnifiedSearchPageState();
}

class _UnifiedSearchPageState extends State<UnifiedSearchPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final SearchUsersUseCase _searchUsersUseCase = sl<SearchUsersUseCase>();
  final CreateChatUseCase _createChatUseCase = sl<CreateChatUseCase>();
  
  // Search results
  List<UserEntity> _users = [];
  List<Map<String, dynamic>> _groups = [];
  List<Map<String, dynamic>> _channels = [];
  
  bool _isLoading = false;
  bool _hasSearched = false;
  String _currentQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _search(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _users = [];
        _groups = [];
        _channels = [];
        _hasSearched = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _hasSearched = true;
      _currentQuery = query.trim().toLowerCase();
    });

    try {
      // Search users
      final usersResult = await _searchUsersUseCase(_currentQuery);
      usersResult.fold(
        (failure) => null,
        (users) => _users = users,
      );

      // Search groups
      final groupsSnapshot = await FirebaseFirestore.instance
          .collection('chats')
          .where('type', isEqualTo: 'group')
          .limit(20)
          .get();
      
      _groups = groupsSnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .where((group) {
            final name = (group['name'] as String? ?? '').toLowerCase();
            return name.contains(_currentQuery);
          })
          .toList();

      // Search channels (public only)
      final channelsSnapshot = await FirebaseFirestore.instance
          .collection('channels')
          .where('isPublic', isEqualTo: true)
          .limit(20)
          .get();
      
      _channels = channelsSnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .where((channel) {
            final name = (channel['name'] as String? ?? '').toLowerCase();
            final username = (channel['username'] as String? ?? '').toLowerCase();
            return name.contains(_currentQuery) || username.contains(_currentQuery);
          })
          .toList();

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка поиска: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _openUserChat(UserEntity user) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final result = await _createChatUseCase(
      participantIds: [user.id],
      type: ChatType.private,
    );

    if (mounted) {
      Navigator.of(context).pop();
      result.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ошибка: ${failure.message}')),
          );
        },
        (chatId) => context.go('/home/chat/$chatId'),
      );
    }
  }

  void _openGroup(Map<String, dynamic> group) {
    context.go('/home/chat/${group['id']}');
  }

  void _openChannel(Map<String, dynamic> channel) {
    context.go('/home/chat/${channel['id']}');
  }

  Future<void> _subscribeToChannel(Map<String, dynamic> channel) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    try {
      // Add user to channel subscribers
      await FirebaseFirestore.instance
          .collection('channels')
          .doc(channel['id'])
          .update({
        'subscriberIds': FieldValue.arrayUnion([currentUser.uid]),
        'subscriberCount': FieldValue.increment(1),
      });

      // Also update chats collection
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(channel['id'])
          .update({
        'participantIds': FieldValue.arrayUnion([currentUser.uid]),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ Вы подписались на "${channel['name']}"'),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/home/chat/${channel['id']}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поиск', style: AppTypography.h3),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Поиск по имени или @username...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _search('');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onChanged: (value) {
                    setState(() {});
                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (_searchController.text == value) {
                        _search(value);
                      }
                    });
                  },
                  onSubmitted: _search,
                ),
              ),
              
              // Tabs
              TabBar(
                controller: _tabController,
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColors.primary,
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.person, size: 18),
                        const SizedBox(width: 4),
                        Text('Люди${_users.isNotEmpty ? ' (${_users.length})' : ''}'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.group, size: 18),
                        const SizedBox(width: 4),
                        Text('Группы${_groups.isNotEmpty ? ' (${_groups.length})' : ''}'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.campaign, size: 18),
                        const SizedBox(width: 4),
                        Text('Каналы${_channels.isNotEmpty ? ' (${_channels.length})' : ''}'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                // Users Tab
                _buildUsersTab(),
                
                // Groups Tab
                _buildGroupsTab(),
                
                // Channels Tab
                _buildChannelsTab(),
              ],
            ),
    );
  }

  Widget _buildUsersTab() {
    if (!_hasSearched) {
      return _buildEmptyState(
        Icons.person_search,
        'Поиск людей',
        'Введите имя или @username',
      );
    }
    
    if (_users.isEmpty) {
      return _buildEmptyState(
        Icons.person_off,
        'Никого не найдено',
        'Попробуйте другой запрос',
      );
    }

    return ListView.builder(
      itemCount: _users.length,
      itemBuilder: (context, index) {
        final user = _users[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.primary,
            backgroundImage: user.avatarUrl != null
                ? NetworkImage(user.avatarUrl!)
                : null,
            child: user.avatarUrl == null
                ? Text(
                    (user.displayName ?? user.username ?? '?')[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  )
                : null,
          ),
          title: Text(
            user.displayName ?? user.username ?? 'User',
            style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          subtitle: user.username != null
              ? Text('@${user.username}', style: TextStyle(color: Colors.grey[600]))
              : null,
          trailing: const Icon(Icons.chat_bubble_outline),
          onTap: () => _openUserChat(user),
        );
      },
    );
  }

  Widget _buildGroupsTab() {
    if (!_hasSearched) {
      return _buildEmptyState(
        Icons.group,
        'Поиск групп',
        'Введите название группы',
      );
    }
    
    if (_groups.isEmpty) {
      return _buildEmptyState(
        Icons.group_off,
        'Группы не найдены',
        'Попробуйте другой запрос',
      );
    }

    return ListView.builder(
      itemCount: _groups.length,
      itemBuilder: (context, index) {
        final group = _groups[index];
        final memberCount = (group['participantIds'] as List?)?.length ?? 0;
        
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green.withValues(alpha: 0.2),
            backgroundImage: group['avatarUrl'] != null
                ? NetworkImage(group['avatarUrl'])
                : null,
            child: group['avatarUrl'] == null
                ? const Icon(Icons.group, color: Colors.green)
                : null,
          ),
          title: Text(
            group['name'] ?? 'Group',
            style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            '$memberCount участников',
            style: TextStyle(color: Colors.grey[600]),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => _openGroup(group),
        );
      },
    );
  }

  Widget _buildChannelsTab() {
    if (!_hasSearched) {
      return _buildEmptyState(
        Icons.campaign,
        'Поиск каналов',
        'Введите название или @username канала',
      );
    }
    
    if (_channels.isEmpty) {
      return _buildEmptyState(
        Icons.speaker_notes_off,
        'Каналы не найдены',
        'Попробуйте другой запрос',
      );
    }

    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    return ListView.builder(
      itemCount: _channels.length,
      itemBuilder: (context, index) {
        final channel = _channels[index];
        final subscriberCount = channel['subscriberCount'] ?? 0;
        final isSubscribed = (channel['subscriberIds'] as List?)?.contains(currentUserId) ?? false;
        
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue.withValues(alpha: 0.2),
            backgroundImage: channel['avatarUrl'] != null
                ? NetworkImage(channel['avatarUrl'])
                : null,
            child: channel['avatarUrl'] == null
                ? const Icon(Icons.campaign, color: Colors.blue)
                : null,
          ),
          title: Text(
            channel['name'] ?? 'Channel',
            style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (channel['username'] != null)
                Text('@${channel['username']}', style: const TextStyle(color: AppColors.primary)),
              Text(
                '$subscriberCount подписчиков',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
          trailing: isSubscribed
              ? TextButton(
                  onPressed: () => _openChannel(channel),
                  child: const Text('Открыть'),
                )
              : ElevatedButton(
                  onPressed: () => _subscribeToChannel(channel),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: const Text('Подписаться'),
                ),
          isThreeLine: channel['username'] != null,
          onTap: () => isSubscribed ? _openChannel(channel) : _subscribeToChannel(channel),
        );
      },
    );
  }

  Widget _buildEmptyState(IconData icon, String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppTypography.h3.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: AppTypography.bodyMedium.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
