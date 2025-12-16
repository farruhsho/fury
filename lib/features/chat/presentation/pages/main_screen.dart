import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/di/injection_container.dart';
import '../bloc/chat_bloc/chat_bloc.dart';
import '../widgets/chat_list_item.dart';


/// Main screen with bottom navigation
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  bool _isOffline = false;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _isOffline = result == ConnectivityResult.none;
      });
    });
  }

  Future<void> _checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    setState(() {
      _isOffline = result == ConnectivityResult.none;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Offline indicator banner
          if (_isOffline)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.red.shade700,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off, color: Colors.white, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'No internet connection',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          // Main content
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: const [
                _ChatsTab(),
                _StatusTab(),
                _CommunitiesTab(),
                _CallsTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: 'Чаты',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.circle_outlined),
              activeIcon: Icon(Icons.circle),
              label: 'Актуальное',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups_outlined),
              activeIcon: Icon(Icons.groups),
              label: 'Сообщества',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.call_outlined),
              activeIcon: Icon(Icons.call),
              label: 'Звонки',
            ),
          ],
        ),
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () => _showNewChatOptions(context),
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }

  void _showNewChatOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child: Icon(Icons.person_add, color: AppColors.primary),
              ),
              title: const Text('New Chat'),
              subtitle: const Text('Start a conversation'),
              onTap: () {
                Navigator.pop(context);
                context.push('/home/search-users');
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.withValues(alpha: 0.1),
                child: const Icon(Icons.group_add, color: Colors.green),
              ),
              title: const Text('New Group'),
              subtitle: const Text('Create a group chat'),
              onTap: () {
                Navigator.pop(context);
                context.push('/home/create-group');
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.withValues(alpha: 0.1),
                child: const Icon(Icons.campaign, color: Colors.blue),
              ),
              title: const Text('Новый канал'),
              subtitle: const Text('Только вы публикуете'),
              onTap: () {
                Navigator.pop(context);
                context.push('/home/create-channel');
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// Chats tab content
class _ChatsTab extends StatelessWidget {
  const _ChatsTab();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChatBloc>()..add(const ChatEvent.loadChats()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fury Chat', style: AppTypography.h3),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => context.push('/home/search-users'),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => context.push('/home/settings'),
            ),
          ],
        ),
        body: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ChatBloc>().add(const ChatEvent.loadChats());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
              loaded: (chats) {
                if (chats.isEmpty) {
                  return _buildEmptyState(context);
                }
                return ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) => ChatListItem(chat: chats[index]),
                );
              },
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('👋', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 24),
          Text(
            'Start chatting!',
            style: AppTypography.h2.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Tap + to start a new conversation',
            style: AppTypography.bodyLarge.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

/// Status/Stories tab - Актуальное
class _StatusTab extends StatelessWidget {
  const _StatusTab();

  // Sample channels data
  static const List<Map<String, dynamic>> _sampleChannels = [
    {
      'name': 'WhatsApp',
      'subscribers': '231 млн подписчиков',
      'verified': true,
      'avatar': null,
      'color': 0xFF25D366,
    },
    {
      'name': 'Кызжибек Кутстр...',
      'subscribers': '5 тыс. подписчиков',
      'verified': false,
      'avatar': null,
      'color': 0xFF9C27B0,
    },
    {
      'name': 'Amira Rashidova',
      'subscribers': '1 тыс. подписчиков',
      'verified': true,
      'avatar': null,
      'color': 0xFFE91E63,
    },
    {
      'name': 'АЁЛЛАР КАН...',
      'subscribers': '26 тыс. подписчиков',
      'verified': false,
      'avatar': null,
      'color': 0xFFFF5722,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Актуальное', style: AppTypography.h3),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: currentUserId == null
          ? const Center(child: Text('Пожалуйста, войдите для просмотра статусов'))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('statuses')
                  .orderBy('createdAt', descending: true)
                  .limit(50)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 48, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'Не удалось загрузить статусы',
                          style: AppTypography.bodyLarge.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Filter out expired statuses client-side
                final now = DateTime.now();
                final statuses = (snapshot.data?.docs ?? []).where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final expiresAt = data['expiresAt'];
                  if (expiresAt is Timestamp) {
                    return expiresAt.toDate().isAfter(now);
                  }
                  return true;
                }).toList();

                return ListView(
                  children: [
                    // Status Section Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        'Статус',
                        style: AppTypography.h3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // My Status
                    _buildMyStatusSection(context, currentUserId, statuses),

                    const SizedBox(height: 16),

                    // Channels Section
                    _buildChannelsSection(context),

                    // Recent Status Updates
                    if (statuses.where((s) => (s.data() as Map)['userId'] != currentUserId).isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                        child: Text(
                          'Недавние обновления',
                          style: AppTypography.caption.copyWith(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ...statuses
                          .where((s) => (s.data() as Map)['userId'] != currentUserId)
                          .map((status) => _buildStatusItem(context, status)),
                    ],
                  ],
                );
              },
            ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'edit_fab',
            onPressed: () => _showAddStatusDialog(context),
            backgroundColor: Colors.grey[800],
            child: const Icon(Icons.edit, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'camera_fab',
            onPressed: () => _showAddStatusDialog(context),
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.camera_alt, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildMyStatusSection(BuildContext context, String userId, List<QueryDocumentSnapshot> statuses) {
    final myStatuses = statuses.where((s) => (s.data() as Map)['userId'] == userId).toList();
    final hasStatus = myStatuses.isNotEmpty;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Stack(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: hasStatus
                  ? Border.all(color: AppColors.primary, width: 2)
                  : null,
            ),
            child: CircleAvatar(
              radius: 26,
              backgroundColor: Colors.grey[300],
              child: Icon(
                Icons.camera_alt,
                color: Colors.grey[600],
                size: 24,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 2),
              ),
              child: const Icon(Icons.add, size: 14, color: Colors.white),
            ),
          ),
        ],
      ),
      title: const Text('Добавить статус', style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
        'Исчезает через 24 часа',
        style: TextStyle(color: Colors.grey[600], fontSize: 13),
      ),
      onTap: () => hasStatus
          ? _viewStatus(context, myStatuses.first)
          : _showAddStatusDialog(context),
    );
  }

  Widget _buildChannelsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Text(
            'Каналы',
            style: AppTypography.h3.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Будьте в курсе событий по самым важным темам.\nНиже примеры каналов, на которые вы можете подписаться.',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
        ),
        const SizedBox(height: 16),

        // Collapsible header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Подпишитесь на интересующие вас каналы',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ),
              Icon(Icons.keyboard_arrow_up, color: Colors.grey[600]),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Channel list
        ..._sampleChannels.map((channel) => _buildChannelItem(context, channel)),

        // Show more button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Показать больше каналов')),
              );
            },
            icon: const Icon(Icons.grid_view, size: 18),
            label: const Text('Показать больше'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: BorderSide(color: AppColors.primary),
              minimumSize: const Size(double.infinity, 44),
            ),
          ),
        ),

        // Create channel button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Создать канал')),
              );
            },
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Создать канал'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: BorderSide(color: AppColors.primary),
              minimumSize: const Size(double.infinity, 44),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChannelItem(BuildContext context, Map<String, dynamic> channel) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Color(channel['color'] as int),
        child: channel['avatar'] != null
            ? null
            : Text(
                (channel['name'] as String).isNotEmpty
                    ? (channel['name'] as String)[0].toUpperCase()
                    : '?',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              channel['name'] as String,
              style: const TextStyle(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (channel['verified'] == true) ...[
            const SizedBox(width: 4),
            Icon(Icons.verified, size: 16, color: Colors.blue[400]),
          ],
        ],
      ),
      subtitle: Text(
        channel['subscribers'] as String,
        style: TextStyle(color: Colors.grey[600], fontSize: 13),
      ),
      trailing: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Подписка на ${channel['name']}')),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: Size.zero,
        ),
        child: const Text('Подписаться'),
      ),
    );
  }

  Widget _buildStatusItem(BuildContext context, QueryDocumentSnapshot status) {
    final data = status.data() as Map<String, dynamic>;
    final userName = data['userName'] as String? ?? 'Unknown';
    final userAvatar = data['userAvatar'] as String?;
    final createdAt = data['createdAt'];

    String timeAgo = '';
    if (createdAt is Timestamp) {
      final diff = DateTime.now().difference(createdAt.toDate());
      if (diff.inMinutes < 60) {
        timeAgo = '${diff.inMinutes} мин. назад';
      } else if (diff.inHours < 24) {
        timeAgo = '${diff.inHours} ч. назад';
      } else {
        timeAgo = 'Вчера';
      }
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary, width: 2),
        ),
        child: CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          backgroundImage: userAvatar != null ? NetworkImage(userAvatar) : null,
          child: userAvatar == null
              ? Text(
                  userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                  style: AppTypography.bodyLarge.copyWith(color: AppColors.primary),
                )
              : null,
        ),
      ),
      title: Text(userName, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(timeAgo, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
      onTap: () => _viewStatus(context, status),
    );
  }

  void _viewStatus(BuildContext context, QueryDocumentSnapshot status) {
    final data = status.data() as Map<String, dynamic>;
    final content = data['content'] as String? ?? '';
    final type = data['type'] as String? ?? 'text';

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            Center(
              child: type == 'image' && content.isNotEmpty
                  ? Image.network(content, fit: BoxFit.contain)
                  : Container(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        content,
                        style: const TextStyle(color: Colors.white, fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
            Positioned(
              top: 50,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 28),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddStatusDialog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const _AddStatusScreen(),
      ),
    );
  }
}

/// Full screen status creation with tabs
class _AddStatusScreen extends StatefulWidget {
  const _AddStatusScreen();

  @override
  State<_AddStatusScreen> createState() => _AddStatusScreenState();
}

class _AddStatusScreenState extends State<_AddStatusScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _textController = TextEditingController();
  int _selectedTemplate = 0;
  bool _isPublishing = false;
  
  // Template colors
  final List<Color> _templateColors = [
    const Color(0xFFE8B84A), // Yellow/Gold
    const Color(0xFF8E44AD), // Purple
    const Color(0xFF2ECC71), // Green
    const Color(0xFF3498DB), // Blue
    const Color(0xFFE74C3C), // Red
    const Color(0xFF1ABC9C), // Teal
    const Color(0xFF34495E), // Dark Blue
    const Color(0xFFF39C12), // Orange
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Добавление статуса',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Tab bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(30),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(
                  icon: Icon(Icons.edit),
                  text: 'Текст',
                ),
                Tab(
                  icon: Icon(Icons.view_quilt),
                  text: 'Макет',
                ),
                Tab(
                  icon: Icon(Icons.mic),
                  text: 'Голос',
                ),
              ],
            ),
          ),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTextTab(),
                _buildLayoutTab(),
                _buildVoiceTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTextTab() {
    return Container(
      color: _templateColors[_selectedTemplate],
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: TextField(
                  controller: _textController,
                  maxLines: null,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Введите текст статуса',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          
          // Color palette
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _templateColors.length,
              itemBuilder: (context, index) {
                final isSelected = index == _selectedTemplate;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTemplate = index),
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: _templateColors[index],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.white : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Publish button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isPublishing ? null : () => _publishTextStatus(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isPublishing
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : const Text(
                        'Опубликовать',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLayoutTab() {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: _templateColors.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedTemplate = index);
                  _tabController.animateTo(0);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _templateColors[index],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Шаблон ${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildVoiceTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.mic,
              size: 48,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Удерживайте для записи',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 48),
          GestureDetector(
            onLongPressStart: (_) {
              // Start recording
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('🎤 Запись началась...')),
              );
            },
            onLongPressEnd: (_) {
              // Stop recording and publish
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('⏹️ Голосовой статус пока недоступен')),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.mic, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Удерживайте',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Future<void> _publishTextStatus() async {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите текст статуса')),
      );
      return;
    }
    
    setState(() => _isPublishing = true);
    
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('Не авторизован');
      
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      
      final userData = userDoc.data() ?? {};
      final userName = userData['displayName'] ?? userData['username'] ?? user.displayName ?? 'User';
      final userAvatar = userData['avatarUrl'] ?? userData['photoUrl'] ?? user.photoURL;
      
      await FirebaseFirestore.instance.collection('statuses').add({
        'userId': user.uid,
        'userName': userName,
        'userAvatar': userAvatar,
        'type': 'text',
        'content': text,
        'backgroundColor': _templateColors[_selectedTemplate].value,
        'createdAt': FieldValue.serverTimestamp(),
        'expiresAt': Timestamp.fromDate(DateTime.now().add(const Duration(hours: 24))),
        'viewedBy': [],
      });
      
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Статус опубликован!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isPublishing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Ошибка: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}


/// Communities tab - Сообщества
class _CommunitiesTab extends StatelessWidget {
  const _CommunitiesTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Сообщества', style: AppTypography.h3),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.groups, size: 64, color: AppColors.primary),
            ),
            const SizedBox(height: 24),
            Text(
              'Сообщества',
              style: AppTypography.h2.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Общайтесь с группами по интересам',
              style: AppTypography.bodyLarge.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Сообщества скоро будут доступны!')),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Создать сообщество'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Calls tab - Звонки
class _CallsTab extends StatelessWidget {
  const _CallsTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Звонки', style: AppTypography.h3),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('calls')
            .orderBy('createdAt', descending: true)
            .limit(50)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.call_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Нет недавних звонков',
                    style: AppTypography.h3.copyWith(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ваша история звонков появится здесь',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyMedium.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          final calls = snapshot.data!.docs;
          return ListView.builder(
            itemCount: calls.length,
            itemBuilder: (context, index) {
              final call = calls[index].data() as Map<String, dynamic>;
              final callerId = call['callerId'] as String?;
              final callerName = call['callerName'] as String? ?? 'Unknown';
              final recipientName = call['recipientName'] as String? ?? 'Unknown';
              final status = call['status'] as String? ?? 'ended';
              final callType = call['type'] as String? ?? 'voice';
              final createdAt = (call['createdAt'] as Timestamp?)?.toDate();
              final currentUserId = FirebaseAuth.instance.currentUser?.uid;
              final isOutgoing = callerId == currentUserId;
              final displayName = isOutgoing ? recipientName : callerName;
              final isVideo = callType == 'video';
              final isMissed = status == 'missed' || status == 'declined';
              
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: Text(
                    displayName.isNotEmpty ? displayName[0].toUpperCase() : '?',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
                title: Text(displayName),
                subtitle: Row(
                  children: [
                    Icon(
                      isOutgoing 
                          ? (isMissed ? Icons.call_missed_outgoing : Icons.call_made)
                          : (isMissed ? Icons.call_missed : Icons.call_received),
                      size: 14,
                      color: isMissed ? Colors.red : Colors.green,
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      isVideo ? Icons.videocam : Icons.call,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      createdAt != null
                          ? _formatTime(createdAt)
                          : '',
                      style: AppTypography.caption,
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(
                    isVideo ? Icons.videocam : Icons.call,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Звоним $displayName...')),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    
    if (diff.inDays == 0) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[time.weekday - 1];
    } else {
      return '${time.day}.${time.month}.${time.year}';
    }
  }
}
