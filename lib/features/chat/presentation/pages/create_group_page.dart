import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final _formKey = GlobalKey<FormState>();
  final _groupNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _searchController = TextEditingController();
  
  final List<Map<String, dynamic>> _selectedParticipants = [];
  List<Map<String, dynamic>> _contacts = [];
  List<Map<String, dynamic>> _filteredContacts = [];
  bool _isLoading = true;
  bool _isCreating = false;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    _descriptionController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  /// Load contacts from existing chats
  Future<void> _loadContacts() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    try {
      // Get all chats where current user is participant
      final chatsSnapshot = await FirebaseFirestore.instance
          .collection('chats')
          .where('participantIds', arrayContains: currentUser.uid)
          .get();

      final Set<String> contactIds = {};
      final List<Map<String, dynamic>> contacts = [];

      for (final chatDoc in chatsSnapshot.docs) {
        final chatData = chatDoc.data();
        final participantIds = List<String>.from(chatData['participantIds'] ?? []);
        
        for (final participantId in participantIds) {
          if (participantId != currentUser.uid && !contactIds.contains(participantId)) {
            contactIds.add(participantId);
            
            // Get user data
            final userDoc = await FirebaseFirestore.instance
                .collection('users')
                .doc(participantId)
                .get();
            
            if (userDoc.exists) {
              final userData = userDoc.data()!;
              contacts.add({
                'id': participantId,
                'displayName': userData['displayName'] ?? userData['username'] ?? 'User',
                'username': userData['username'],
                'avatarUrl': userData['avatarUrl'] ?? userData['photoUrl'],
              });
            }
          }
        }
      }

      setState(() {
        _contacts = contacts;
        _filteredContacts = contacts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка загрузки контактов: $e')),
        );
      }
    }
  }

  void _filterContacts(String query) {
    if (query.isEmpty) {
      setState(() => _filteredContacts = _contacts);
      return;
    }
    
    final lowerQuery = query.toLowerCase();
    setState(() {
      _filteredContacts = _contacts.where((contact) {
        final name = (contact['displayName'] as String? ?? '').toLowerCase();
        final username = (contact['username'] as String? ?? '').toLowerCase();
        return name.contains(lowerQuery) || username.contains(lowerQuery);
      }).toList();
    });
  }

  void _toggleParticipant(Map<String, dynamic> contact) {
    setState(() {
      final index = _selectedParticipants.indexWhere((p) => p['id'] == contact['id']);
      if (index >= 0) {
        _selectedParticipants.removeAt(index);
      } else {
        _selectedParticipants.add(contact);
      }
    });
  }

  bool _isSelected(String id) {
    return _selectedParticipants.any((p) => p['id'] == id);
  }

  Future<void> _createGroup() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_selectedParticipants.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Выберите хотя бы одного участника')),
      );
      return;
    }

    setState(() => _isCreating = true);

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) throw Exception('Не авторизован');

      // Get current user data
      final currentUserDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      final currentUserData = currentUserDoc.data() ?? {};

      // Build participant IDs and names
      final participantIds = [currentUser.uid, ..._selectedParticipants.map((p) => p['id'] as String)];
      final participantNames = <String, String>{
        currentUser.uid: currentUserData['displayName'] ?? currentUser.displayName ?? 'You',
      };
      for (final p in _selectedParticipants) {
        participantNames[p['id']] = p['displayName'] ?? 'User';
      }

      // Create group chat
      final groupRef = await FirebaseFirestore.instance.collection('chats').add({
        'type': 'group',
        'name': _groupNameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'participantIds': participantIds,
        'participantNames': participantNames,
        'adminIds': [currentUser.uid],
        'createdBy': currentUser.uid,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'lastMessage': 'Группа создана',
        'lastMessageTime': FieldValue.serverTimestamp(),
        'avatarUrl': null,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Группа создана!'), backgroundColor: Colors.green),
        );
        context.go('/home/chat/${groupRef.id}');
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
        title: const Text('Новая группа', style: AppTypography.h3),
        actions: [
          TextButton(
            onPressed: _isCreating ? null : _createGroup,
            child: _isCreating
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
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
        child: Column(
          children: [
            // Group info section
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[50],
              child: Column(
                children: [
                  // Group Avatar
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                          child: const Icon(
                            Icons.group,
                            size: 40,
                            color: AppColors.primary,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Group Name
                  TextFormField(
                    controller: _groupNameController,
                    decoration: InputDecoration(
                      labelText: 'Название группы',
                      hintText: 'Введите название',
                      prefixIcon: const Icon(Icons.group),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Введите название группы';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Description
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Описание (опционально)',
                      hintText: 'О чём эта группа?',
                      prefixIcon: const Icon(Icons.description),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),

            // Selected participants chips
            if (_selectedParticipants.isNotEmpty)
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _selectedParticipants.length,
                  itemBuilder: (context, index) {
                    final p = _selectedParticipants[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Chip(
                        avatar: CircleAvatar(
                          backgroundImage: p['avatarUrl'] != null
                              ? NetworkImage(p['avatarUrl'])
                              : null,
                          child: p['avatarUrl'] == null
                              ? Text((p['displayName'] as String? ?? '?')[0].toUpperCase())
                              : null,
                        ),
                        label: Text(p['displayName'] ?? 'User'),
                        onDeleted: () => _toggleParticipant(p),
                        deleteIcon: const Icon(Icons.close, size: 18),
                      ),
                    );
                  },
                ),
              ),

            // Search contacts
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: _filterContacts,
                decoration: InputDecoration(
                  hintText: 'Поиск контактов...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Контакты (${_filteredContacts.length})',
                    style: AppTypography.caption.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Выбрано: ${_selectedParticipants.length}',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Contacts list
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredContacts.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
                              const SizedBox(height: 16),
                              Text(
                                _contacts.isEmpty
                                    ? 'Нет контактов'
                                    : 'Контакты не найдены',
                                style: AppTypography.bodyLarge.copyWith(color: Colors.grey[600]),
                              ),
                              if (_contacts.isEmpty) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'Начните переписку, чтобы добавить контакты',
                                  style: AppTypography.caption.copyWith(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: _filteredContacts.length,
                          itemBuilder: (context, index) {
                            final contact = _filteredContacts[index];
                            final isSelected = _isSelected(contact['id']);
                            
                            return ListTile(
                              leading: Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                                    backgroundImage: contact['avatarUrl'] != null
                                        ? NetworkImage(contact['avatarUrl'])
                                        : null,
                                    child: contact['avatarUrl'] == null
                                        ? Text(
                                            (contact['displayName'] as String? ?? '?')[0].toUpperCase(),
                                            style: const TextStyle(color: AppColors.primary),
                                          )
                                        : null,
                                  ),
                                  if (isSelected)
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.white, width: 2),
                                        ),
                                        child: const Icon(Icons.check, size: 10, color: Colors.white),
                                      ),
                                    ),
                                ],
                              ),
                              title: Text(
                                contact['displayName'] ?? 'User',
                                style: AppTypography.bodyLarge.copyWith(
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                              subtitle: contact['username'] != null
                                  ? Text('@${contact['username']}')
                                  : null,
                              trailing: isSelected
                                  ? const Icon(Icons.check_circle, color: AppColors.primary)
                                  : Icon(Icons.circle_outlined, color: Colors.grey[400]),
                              onTap: () => _toggleParticipant(contact),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
