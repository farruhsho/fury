import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';

/// Contact search screen with selection
class ContactSearchScreen extends StatefulWidget {
  final bool multiSelect;
  final String? title;
  final ValueChanged<List<String>>? onContactsSelected;

  const ContactSearchScreen({
    super.key,
    this.multiSelect = true,
    this.title,
    this.onContactsSelected,
  });

  @override
  State<ContactSearchScreen> createState() => _ContactSearchScreenState();
}

class _ContactSearchScreenState extends State<ContactSearchScreen> {
  final _searchController = TextEditingController();
  List<Map<String, dynamic>> _frequentContacts = [];
  List<Map<String, dynamic>> _allContacts = [];
  List<Map<String, dynamic>> _filteredContacts = [];
  final Set<String> _selectedContacts = {};
  bool _isLoading = true;

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
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final usersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isNotEqualTo: user.uid)
          .limit(100)
          .get();

      final contacts = usersSnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'name': data['displayName'] ?? data['name'] ?? 'Unknown',
          'phone': data['phoneNumber'] ?? '',
          'avatarUrl': data['avatarUrl'] ?? data['photoUrl'],
        };
      }).toList();

      // Sort by name
      contacts.sort((a, b) => (a['name'] as String).compareTo(b['name'] as String));

      // First 5 as frequent
      final frequent = contacts.take(5).toList();

      setState(() {
        _frequentContacts = frequent;
        _allContacts = contacts;
        _filteredContacts = contacts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _filterContacts(String query) {
    if (query.isEmpty) {
      setState(() => _filteredContacts = _allContacts);
    } else {
      final lowerQuery = query.toLowerCase();
      setState(() {
        _filteredContacts = _allContacts.where((c) {
          final name = (c['name'] as String).toLowerCase();
          final phone = (c['phone'] as String).toLowerCase();
          return name.contains(lowerQuery) || phone.contains(lowerQuery);
        }).toList();
      });
    }
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

  void _submitSelection() {
    widget.onContactsSelected?.call(_selectedContacts.toList());
    context.pop(_selectedContacts.toList());
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
        title: TextField(
          controller: _searchController,
          style: const TextStyle(color: AppColors.textPrimaryLight),
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Поиск по имени или номеру...',
            hintStyle: TextStyle(color: AppColors.textSecondaryLight),
            border: InputBorder.none,
          ),
          onChanged: _filterContacts,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: () {
              // Change view mode
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      // Frequent contacts
                      if (_searchController.text.isEmpty && _frequentContacts.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm,
                          ),
                          child: Text(
                            'Часто общаетесь',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondaryLight,
                            ),
                          ),
                        ),
                        ..._frequentContacts.map((c) => _buildContactTile(c)),
                      ],

                      // All contacts
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm,
                        ),
                        child: Text(
                          _searchController.text.isEmpty ? 'Все контакты' : 'Результаты',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ),
                      ..._filteredContacts.map((c) => _buildContactTile(c)),

                      // Empty state
                      if (_filteredContacts.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.xl),
                          child: Center(
                            child: Text(
                              'Контакты не найдены',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textSecondaryLight,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Bottom toolbar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  color: AppColors.surfaceDark,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.apps, color: AppColors.textSecondaryLight),
                        onPressed: () {},
                      ),
                      const Text('GIF', style: TextStyle(color: AppColors.textSecondaryLight)),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(Icons.photo_library_outlined, color: AppColors.textSecondaryLight),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.text_fields, color: AppColors.textSecondaryLight),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.emoji_emotions_outlined, color: AppColors.textSecondaryLight),
                        onPressed: () {},
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.mic, color: AppColors.textSecondaryLight),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: widget.multiSelect && _selectedContacts.isNotEmpty
          ? FloatingActionButton(
              backgroundColor: AppColors.primary,
              onPressed: _submitSelection,
              child: const Icon(Icons.arrow_forward, color: Colors.white),
            )
          : null,
    );
  }

  Widget _buildContactTile(Map<String, dynamic> contact) {
    final name = contact['name'] as String;
    final phone = contact['phone'] as String;
    final avatarUrl = contact['avatarUrl'] as String?;
    final isSelected = _selectedContacts.contains(contact['id']);

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
      title: Text(
        name,
        style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimaryLight),
      ),
      subtitle: phone.isNotEmpty
          ? Text(
              phone,
              style: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
            )
          : null,
      trailing: widget.multiSelect
          ? Container(
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
            )
          : null,
      onTap: () {
        if (widget.multiSelect) {
          _toggleContact(contact['id'] as String);
        } else {
          context.pop(contact['id']);
        }
      },
    );
  }
}
