import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/modern_components.dart';

/// Group chat creation and management page
class GroupChatPage extends StatefulWidget {
  final List<String> initialMembers;

  const GroupChatPage({
    super.key,
    this.initialMembers = const [],
  });

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _focusNode = FocusNode();
  String? _groupIcon;
  final List<GroupMember> _members = [];
  bool _isCreating = false;

  @override
  void initState() {
    super.initState();
    // Add initial members
    for (final memberId in widget.initialMembers) {
      _members.add(GroupMember(
        id: memberId,
        name: 'User $memberId',
        role: GroupRole.member,
      ));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _pickGroupIcon() {
    // TODO: Implement image picker for group icon
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image picker coming soon')),
    );
  }

  void _addMembers() {
    // TODO: Navigate to contact selector
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add members coming soon')),
    );
  }

  void _removeMember(GroupMember member) {
    setState(() {
      _members.remove(member);
    });
  }

  void _changeMemberRole(GroupMember member, GroupRole newRole) {
    setState(() {
      final index = _members.indexOf(member);
      if (index != -1) {
        _members[index] = member.copyWith(role: newRole);
      }
    });
  }

  Future<void> _createGroup() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a group name')),
      );
      return;
    }

    if (_members.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least 2 members')),
      );
      return;
    }

    setState(() => _isCreating = true);

    try {
      // TODO: Create group via ChatBloc
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Group "${_nameController.text}" created!')),
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
        title: const Text('New Group'),
        actions: [
          TextButton(
            onPressed: _isCreating ? null : _createGroup,
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
          // Group icon and name
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Group icon
              GestureDetector(
                onTap: _pickGroupIcon,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: _groupIcon != null
                      ? ClipOval(
                          child: Image.network(_groupIcon!, fit: BoxFit.cover),
                        )
                      : const Icon(
                          Icons.camera_alt,
                          color: AppColors.primary,
                          size: 32,
                        ),
                ),
              ),
              const SizedBox(width: 16),
              // Group name input
              Expanded(
                child: TextField(
                  controller: _nameController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    labelText: 'Group Name',
                    hintText: 'Enter group name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.group),
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Description
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Description (optional)',
              hintText: 'What is this group about?',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.description_outlined),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 24),

          // Members section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Members (${_members.length})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton.icon(
                onPressed: _addMembers,
                icon: const Icon(Icons.add),
                label: const Text('Add'),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Member list
          if (_members.isEmpty)
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(Icons.people_outline, size: 48, color: Colors.grey),
                  const SizedBox(height: 8),
                  const Text(
                    'No members added',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _addMembers,
                    child: const Text('Add Members'),
                  ),
                ],
              ),
            )
          else
            ...List.generate(_members.length, (index) {
              final member = _members[index];
              return _MemberTile(
                member: member,
                onRemove: () => _removeMember(member),
                onRoleChanged: (role) => _changeMemberRole(member, role),
              );
            }),

          const SizedBox(height: 24),

          // Group settings
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _buildSettingTile(
            icon: Icons.admin_panel_settings,
            title: 'Only admins can send messages',
            value: false,
            onChanged: (value) {},
          ),
          _buildSettingTile(
            icon: Icons.edit_off,
            title: 'Only admins can edit group info',
            value: true,
            onChanged: (value) {},
          ),
          _buildSettingTile(
            icon: Icons.person_add_disabled,
            title: 'Only admins can add members',
            value: false,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon),
      title: Text(title),
      value: value,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
    );
  }
}

/// Member tile widget
class _MemberTile extends StatelessWidget {
  final GroupMember member;
  final VoidCallback onRemove;
  final ValueChanged<GroupRole> onRoleChanged;

  const _MemberTile({
    required this.member,
    required this.onRemove,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ModernAvatar(
        name: member.name,
        imageUrl: member.avatarUrl,
        size: 44,
        showStatus: false,
      ),
      title: Text(member.name),
      subtitle: Text(
        member.role.displayName,
        style: TextStyle(
          color: member.role == GroupRole.admin ? AppColors.primary : null,
          fontSize: 12,
        ),
      ),
      trailing: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert),
        onSelected: (value) {
          if (value == 'remove') {
            onRemove();
          } else if (value == 'admin') {
            onRoleChanged(GroupRole.admin);
          } else if (value == 'member') {
            onRoleChanged(GroupRole.member);
          }
        },
        itemBuilder: (context) => [
          if (member.role != GroupRole.admin)
            const PopupMenuItem(
              value: 'admin',
              child: Text('Make Admin'),
            ),
          if (member.role == GroupRole.admin)
            const PopupMenuItem(
              value: 'member',
              child: Text('Remove as Admin'),
            ),
          const PopupMenuItem(
            value: 'remove',
            child: Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

/// Group member model
class GroupMember {
  final String id;
  final String name;
  final String? avatarUrl;
  final GroupRole role;

  const GroupMember({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.role = GroupRole.member,
  });

  GroupMember copyWith({
    String? id,
    String? name,
    String? avatarUrl,
    GroupRole? role,
  }) {
    return GroupMember(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
    );
  }
}

/// Group role enum
enum GroupRole {
  admin,
  member;

  String get displayName {
    switch (this) {
      case GroupRole.admin:
        return 'Admin';
      case GroupRole.member:
        return 'Member';
    }
  }
}
