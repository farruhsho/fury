import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';

/// WhatsApp-style New Chat screen with group/channel creation options
class NewChatScreen extends StatefulWidget {
  const NewChatScreen({super.key});

  @override
  State<NewChatScreen> createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  final _searchController = TextEditingController();
  final Set<String> _selectedContacts = {};
  List<Map<String, dynamic>> _contacts = [];
  List<Map<String, dynamic>> _frequentContacts = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadContacts() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) return;

      // Load all users except current user
      final usersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isNotEqualTo: currentUser.uid)
          .limit(50)
          .get();

      final contacts = usersSnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'name': data['displayName'] ?? data['name'] ?? 'Unknown',
          'phone': data['phoneNumber'] ?? '',
          'avatarUrl': data['avatarUrl'] ?? data['photoUrl'],
          'status': data['status'] ?? '',
        };
      }).toList();

      // Simulate frequent contacts (first 3)
      final frequent = contacts.take(3).toList();

      setState(() {
        _contacts = contacts;
        _frequentContacts = frequent;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  List<Map<String, dynamic>> get _filteredContacts {
    if (_searchQuery.isEmpty) return _contacts;
    return _contacts.where((c) {
      final name = (c['name'] as String).toLowerCase();
      final phone = (c['phone'] as String).toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) || phone.contains(query);
    }).toList();
  }

  void _toggleContact(String contactId) {
    setState(() {
      if (_selectedContacts.contains(contactId)) {
        _selectedContacts.remove(contactId);
      } else {
        _selectedContacts.add(contactId);
      }
    });
  }

  Future<void> _startPrivateChat(Map<String, dynamic> contact) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    // Check if chat already exists
    final existingChat = await FirebaseFirestore.instance
        .collection('chats')
        .where('type', isEqualTo: 'private')
        .where('participantIds', arrayContains: currentUser.uid)
        .get();

    String? chatId;
    for (final doc in existingChat.docs) {
      final participants = List<String>.from(doc.data()['participantIds'] ?? []);
      if (participants.contains(contact['id'])) {
        chatId = doc.id;
        break;
      }
    }

    // Create new chat if doesn't exist
    if (chatId == null) {
      final chatDoc = await FirebaseFirestore.instance.collection('chats').add({
        'type': 'private',
        'participantIds': [currentUser.uid, contact['id']],
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      chatId = chatDoc.id;
    }

    if (mounted) {
      context.push('/chat/$chatId');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Новый чат', style: AppTypography.h3),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            color: AppColors.surfaceDark,
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value),
              style: const TextStyle(color: AppColors.textPrimaryLight),
              decoration: InputDecoration(
                hintText: 'Поиск по имени или номеру',
                hintStyle: TextStyle(color: AppColors.textSecondaryLight),
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondaryLight),
                prefixText: 'Кому: ',
                prefixStyle: TextStyle(color: AppColors.textSecondaryLight),
                filled: true,
                fillColor: AppColors.backgroundDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
              ),
            ),
          ),

          // Main content
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    children: [
                      // Quick actions
                      _buildQuickAction(
                        icon: Icons.group_add,
                        label: 'Новая группа',
                        onTap: () => context.push('/new-group'),
                      ),
                      _buildQuickAction(
                        icon: Icons.person_add,
                        label: 'Новый контакт',
                        trailing: const Icon(Icons.qr_code, color: AppColors.textSecondaryLight),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Добавление контакта...')),
                          );
                        },
                      ),
                      _buildQuickAction(
                        icon: Icons.groups,
                        label: 'Новое сообщество',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Создание сообщества...')),
                          );
                        },
                      ),

                      // Frequent contacts section
                      if (_frequentContacts.isNotEmpty) ...[
                        _buildSectionHeader('Часто общаетесь'),
                        ..._frequentContacts.map((c) => _buildContactTile(c)),
                      ],

                      // All contacts section
                      _buildSectionHeader('Контакты в Fury'),
                      ..._filteredContacts.map((c) => _buildContactTile(c)),

                      // Empty state
                      if (_filteredContacts.isEmpty && _searchQuery.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.xl),
                          child: Text(
                            'Контакты не найдены',
                            style: TextStyle(color: AppColors.textSecondaryLight),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
          ),
        ],
      ),
      // FAB for creating group when contacts selected
      floatingActionButton: _selectedContacts.isNotEmpty
          ? FloatingActionButton(
              backgroundColor: AppColors.primary,
              onPressed: () {
                // Navigate to group creation with selected contacts
                context.push('/new-group', extra: _selectedContacts.toList());
              },
              child: const Icon(Icons.arrow_forward, color: Colors.white),
            )
          : null,
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
      title: Text(
        label,
        style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimaryLight),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.sm),
      child: Text(
        title,
        style: AppTypography.caption.copyWith(
          color: AppColors.textSecondaryLight,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildContactTile(Map<String, dynamic> contact) {
    final isSelected = _selectedContacts.contains(contact['id']);
    final name = contact['name'] as String;
    final phone = contact['phone'] as String;
    final avatarUrl = contact['avatarUrl'] as String?;
    final status = contact['status'] as String;

    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.primary.withValues(alpha: 0.2),
        backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
        child: avatarUrl == null
            ? Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
      ),
      title: Text(
        name,
        style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimaryLight),
      ),
      subtitle: phone.isNotEmpty || status.isNotEmpty
          ? Text(
              phone.isNotEmpty ? phone : status,
              style: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      trailing: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.textSecondaryLight,
            width: 2,
          ),
          color: isSelected ? AppColors.primary : Colors.transparent,
        ),
        child: isSelected
            ? const Icon(Icons.check, size: 16, color: Colors.white)
            : null,
      ),
      onTap: () {
        if (_selectedContacts.isEmpty) {
          // Single tap starts private chat
          _startPrivateChat(contact);
        } else {
          // Multi-select mode
          _toggleContact(contact['id'] as String);
        }
      },
      onLongPress: () => _toggleContact(contact['id'] as String),
    );
  }
}
