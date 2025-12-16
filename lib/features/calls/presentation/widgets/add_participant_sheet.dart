import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../app/theme/app_colors.dart';

/// Bottom sheet for adding participants to a group call
class AddParticipantSheet extends StatefulWidget {
  final List<String> currentParticipants;
  final Function(List<String>) onParticipantsSelected;
  final int maxParticipants;

  const AddParticipantSheet({
    super.key,
    required this.currentParticipants,
    required this.onParticipantsSelected,
    this.maxParticipants = 8,
  });

  @override
  State<AddParticipantSheet> createState() => _AddParticipantSheetState();
}

class _AddParticipantSheetState extends State<AddParticipantSheet> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _selectedIds = {};
  List<Map<String, dynamic>> _contacts = [];
  List<Map<String, dynamic>> _filteredContacts = [];
  bool _isLoading = true;

  int get _availableSlots => widget.maxParticipants - widget.currentParticipants.length;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) return;

    try {
      // Load user's contacts
      final contactsSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .collection('contacts')
          .get();

      final contacts = <Map<String, dynamic>>[];
      for (final doc in contactsSnapshot.docs) {
        final contactId = doc.data()['userId'] as String?;
        if (contactId != null && !widget.currentParticipants.contains(contactId)) {
          // Get contact details
          final userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(contactId)
              .get();
          if (userDoc.exists) {
            contacts.add({
              'id': contactId,
              ...userDoc.data()!,
            });
          }
        }
      }

      setState(() {
        _contacts = contacts;
        _filteredContacts = contacts;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Failed to load contacts: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterContacts(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredContacts = _contacts;
      });
    } else {
      final lowercaseQuery = query.toLowerCase();
      setState(() {
        _filteredContacts = _contacts.where((contact) {
          final name = (contact['displayName'] as String?)?.toLowerCase() ?? '';
          final phone = (contact['phoneNumber'] as String?)?.toLowerCase() ?? '';
          return name.contains(lowercaseQuery) || phone.contains(lowercaseQuery);
        }).toList();
      });
    }
  }

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else if (_selectedIds.length < _availableSlots) {
        _selectedIds.add(id);
      } else {
        // Show max participants message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Maximum $_availableSlots more participants can be added'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }

  void _confirmSelection() {
    if (_selectedIds.isNotEmpty) {
      widget.onParticipantsSelected(_selectedIds.toList());
    }
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add participants',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_selectedIds.length} selected, $_availableSlots slots available',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                // Confirm button
                ElevatedButton(
                  onPressed: _selectedIds.isNotEmpty ? _confirmSelection : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A884),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    disabledBackgroundColor: Colors.grey[800],
                  ),
                  child: const Text('Add'),
                ),
              ],
            ),
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              onChanged: _filterContacts,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search contacts...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                filled: true,
                fillColor: const Color(0xFF2A2A2A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Selected participants chips
          if (_selectedIds.isNotEmpty)
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _selectedIds.length,
                itemBuilder: (context, index) {
                  final id = _selectedIds.elementAt(index);
                  final contact = _contacts.firstWhere(
                    (c) => c['id'] == id,
                    orElse: () => {'displayName': 'User'},
                  );
                  return _buildSelectedChip(id, contact);
                },
              ),
            ),

          if (_selectedIds.isNotEmpty)
            const Divider(color: Colors.grey, height: 24),

          // Contact list
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF00A884)),
                  )
                : _filteredContacts.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _filteredContacts.length,
                        itemBuilder: (context, index) {
                          final contact = _filteredContacts[index];
                          return _buildContactTile(contact);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedChip(String id, Map<String, dynamic> contact) {
    final name = contact['displayName'] as String? ?? 'User';
    final photoUrl = contact['photoUrl'] as String?;

    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(
        avatar: CircleAvatar(
          backgroundColor: AppColors.primary,
          backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
          child: photoUrl == null
              ? Text(
                  name[0].toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                )
              : null,
        ),
        label: Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),
        deleteIcon: const Icon(Icons.close, size: 16, color: Colors.white70),
        onDeleted: () => _toggleSelection(id),
        backgroundColor: const Color(0xFF2A2A2A),
        side: BorderSide.none,
      ),
    );
  }

  Widget _buildContactTile(Map<String, dynamic> contact) {
    final id = contact['id'] as String;
    final name = contact['displayName'] as String? ?? 'User';
    final photoUrl = contact['photoUrl'] as String?;
    final status = contact['status'] as String? ?? '';
    final isSelected = _selectedIds.contains(id);

    return ListTile(
      onTap: () => _toggleSelection(id),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary.withOpacity(0.3),
            backgroundImage: photoUrl != null
                ? CachedNetworkImageProvider(photoUrl)
                : null,
            child: photoUrl == null
                ? Text(
                    name[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
          if (isSelected)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Color(0xFF00A884),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
        ],
      ),
      title: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: status.isNotEmpty
          ? Text(
              status,
              style: TextStyle(color: Colors.grey[400]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Color(0xFF00A884))
          : Icon(Icons.radio_button_unchecked, color: Colors.grey[600]),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_search,
            size: 64,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 16),
          Text(
            _searchController.text.isNotEmpty
                ? 'No contacts found'
                : 'No contacts available',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
