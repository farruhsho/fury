import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/modern_components.dart';

/// Broadcast list creation and management
/// 
/// Broadcast lists allow sending messages to multiple contacts
/// without creating a group chat. Recipients receive messages
/// as individual chats.
class BroadcastListPage extends StatefulWidget {
  const BroadcastListPage({super.key});

  @override
  State<BroadcastListPage> createState() => _BroadcastListPageState();
}

class _BroadcastListPageState extends State<BroadcastListPage> {
  final _nameController = TextEditingController();
  final List<BroadcastRecipient> _recipients = [];
  bool _isCreating = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _addRecipients() {
    // TODO: Navigate to contact selector
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => _ContactSelector(
          scrollController: scrollController,
          selectedIds: _recipients.map((r) => r.id).toList(),
          onSelectionChanged: (selected) {
            setState(() {
              _recipients.clear();
              _recipients.addAll(selected);
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _removeRecipient(BroadcastRecipient recipient) {
    setState(() {
      _recipients.remove(recipient);
    });
  }

  Future<void> _createBroadcast() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a broadcast name')),
      );
      return;
    }

    if (_recipients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one recipient')),
      );
      return;
    }

    setState(() => _isCreating = true);

    try {
      // TODO: Create broadcast via ChatBloc
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Broadcast "${_nameController.text}" created with ${_recipients.length} recipients',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isCreating = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Broadcast'),
        actions: [
          TextButton(
            onPressed: _isCreating ? null : _createBroadcast,
            child: _isCreating
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Create'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Broadcast icon
          Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.campaign,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Broadcast name
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Broadcast Name',
              hintText: 'e.g., Family Updates',
              prefixIcon: const Icon(Icons.label_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 8),
          
          Text(
            'Recipients will receive messages as individual chats',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 24),

          // Recipients section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recipients (${_recipients.length})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton.icon(
                onPressed: _addRecipients,
                icon: const Icon(Icons.person_add),
                label: const Text('Add'),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Recipient list
          if (_recipients.isEmpty)
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(Icons.group_add, size: 48, color: Colors.grey),
                  const SizedBox(height: 8),
                  const Text(
                    'No recipients added',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _addRecipients,
                    child: const Text('Add Recipients'),
                  ),
                ],
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _recipients.map((recipient) {
                return Chip(
                  avatar: CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: Text(
                      recipient.name[0].toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  label: Text(recipient.name),
                  deleteIcon: const Icon(Icons.close, size: 18),
                  onDeleted: () => _removeRecipient(recipient),
                );
              }).toList(),
            ),
          const SizedBox(height: 24),

          // Info card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.info.withValues(alpha: 0.3),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.info),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Messages sent to this broadcast will appear as individual messages to each recipient.',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.info,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Contact selector for broadcast recipients
class _ContactSelector extends StatefulWidget {
  final ScrollController scrollController;
  final List<String> selectedIds;
  final void Function(List<BroadcastRecipient>) onSelectionChanged;

  const _ContactSelector({
    required this.scrollController,
    required this.selectedIds,
    required this.onSelectionChanged,
  });

  @override
  State<_ContactSelector> createState() => _ContactSelectorState();
}

class _ContactSelectorState extends State<_ContactSelector> {
  final List<BroadcastRecipient> _selected = [];
  final _searchController = TextEditingController();

  // Mock contacts - replace with actual contact data
  final List<BroadcastRecipient> _contacts = List.generate(
    20,
    (i) => BroadcastRecipient(
      id: 'user_$i',
      name: 'Contact ${i + 1}',
      phone: '+1234567890$i',
    ),
  );

  @override
  void initState() {
    super.initState();
    // Pre-select contacts
    _selected.addAll(
      _contacts.where((c) => widget.selectedIds.contains(c.id)),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleContact(BroadcastRecipient contact) {
    setState(() {
      if (_selected.contains(contact)) {
        _selected.remove(contact);
      } else {
        _selected.add(contact);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Handle bar
        Container(
          margin: const EdgeInsets.only(top: 8),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        
        // Header
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select Recipients',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => widget.onSelectionChanged(_selected),
                child: Text('Done (${_selected.length})'),
              ),
            ],
          ),
        ),
        
        // Search
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search contacts...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onChanged: (value) => setState(() {}),
          ),
        ),
        const SizedBox(height: 8),
        
        // Contact list
        Expanded(
          child: ListView.builder(
            controller: widget.scrollController,
            itemCount: _contacts.length,
            itemBuilder: (context, index) {
              final contact = _contacts[index];
              final isSelected = _selected.contains(contact);
              
              // Filter by search
              if (_searchController.text.isNotEmpty &&
                  !contact.name.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  )) {
                return const SizedBox.shrink();
              }
              
              return ListTile(
                leading: Stack(
                  children: [
                    ModernAvatar(
                      name: contact.name,
                      size: 44,
                      showStatus: false,
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
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                title: Text(contact.name),
                subtitle: Text(contact.phone ?? ''),
                onTap: () => _toggleContact(contact),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Broadcast recipient model
class BroadcastRecipient {
  final String id;
  final String name;
  final String? phone;
  final String? avatarUrl;

  const BroadcastRecipient({
    required this.id,
    required this.name,
    this.phone,
    this.avatarUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BroadcastRecipient && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Broadcast list entity
class BroadcastList {
  final String id;
  final String name;
  final List<String> recipientIds;
  final DateTime createdAt;
  final DateTime? lastMessageAt;

  const BroadcastList({
    required this.id,
    required this.name,
    required this.recipientIds,
    required this.createdAt,
    this.lastMessageAt,
  });
}
