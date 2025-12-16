import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Dialog for selecting chats to forward a message to
class ForwardMessageDialog extends StatefulWidget {
  final String messageText;
  final String messageId;
  final Function(List<String> selectedChatIds) onForward;

  const ForwardMessageDialog({
    super.key,
    required this.messageText,
    required this.messageId,
    required this.onForward,
  });

  static Future<void> show({
    required BuildContext context,
    required String messageText,
    required String messageId,
    required Function(List<String> selectedChatIds) onForward,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ForwardMessageDialog(
        messageText: messageText,
        messageId: messageId,
        onForward: onForward,
      ),
    );
  }

  @override
  State<ForwardMessageDialog> createState() => _ForwardMessageDialogState();
}

class _ForwardMessageDialogState extends State<ForwardMessageDialog> {
  final Set<String> _selectedChatIds = {};
  bool _isLoading = true;
  List<_ChatItem> _chats = [];

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  Future<void> _loadChats() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('chats')
          .orderBy('updatedAt', descending: true)
          .limit(50)
          .get();

      final chats = <_ChatItem>[];
      
      for (final doc in snapshot.docs) {
        final data = doc.data();
        final participantIds = data['participantIds'] as List<dynamic>?;
        
        if (participantIds?.contains(userId) != true) continue;
        
        // Get chat name
        String name = data['name'] ?? '';
        String? avatarUrl;
        
        // For private chats, get the other user's info
        if (data['type'] == 'private') {
          final participants = data['participants'] as Map<String, dynamic>?;
          if (participants != null) {
            final otherUserId = participantIds!.firstWhere(
              (id) => id != userId,
              orElse: () => null,
            );
            if (otherUserId != null && participants[otherUserId] != null) {
              final otherUser = participants[otherUserId] as Map<String, dynamic>;
              name = otherUser['displayName'] ?? 'User';
              avatarUrl = otherUser['avatarUrl'] as String?;
            }
          }
        }
        
        chats.add(_ChatItem(
          id: doc.id,
          name: name.isEmpty ? 'Chat' : name,
          avatarUrl: avatarUrl,
          isGroup: data['type'] != 'private',
        ));
      }

      if (mounted) {
        setState(() {
          _chats = chats;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('❌ [FORWARD] Error loading chats: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _toggleSelection(String chatId) {
    setState(() {
      if (_selectedChatIds.contains(chatId)) {
        _selectedChatIds.remove(chatId);
      } else {
        _selectedChatIds.add(chatId);
      }
    });
  }

  void _handleForward() {
    if (_selectedChatIds.isEmpty) return;
    
    widget.onForward(_selectedChatIds.toList());
    Navigator.of(context).pop();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Forwarded to ${_selectedChatIds.length} chat(s)'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Text(
                    'Forward to...',
                    style: AppTypography.h3,
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                  onPressed: _selectedChatIds.isEmpty ? null : _handleForward,
                  child: Text(
                    'Send (${_selectedChatIds.length})',
                    style: TextStyle(
                      color: _selectedChatIds.isEmpty 
                          ? Colors.grey 
                          : AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Message preview
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.format_quote, color: Colors.grey, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.messageText,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          const Divider(height: 1),
          
          // Chat list
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _chats.isEmpty
                    ? Center(
                        child: Text(
                          'No chats available',
                          style: AppTypography.bodyMedium.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: _chats.length,
                        itemBuilder: (context, index) {
                          final chat = _chats[index];
                          final isSelected = _selectedChatIds.contains(chat.id);
                          
                          return ListTile(
                            leading: Stack(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                                  backgroundImage: chat.avatarUrl != null
                                      ? NetworkImage(chat.avatarUrl!)
                                      : null,
                                  child: chat.avatarUrl == null
                                      ? Text(
                                          chat.name.isNotEmpty
                                              ? chat.name[0].toUpperCase()
                                              : '?',
                                          style: const TextStyle(
                                            color: AppColors.primary,
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
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                        color: AppColors.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            title: Text(
                              chat.name,
                              style: AppTypography.bodyMedium.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: chat.isGroup
                                ? Text(
                                    'Group',
                                    style: AppTypography.caption.copyWith(
                                      color: Colors.grey,
                                    ),
                                  )
                                : null,
                            trailing: Checkbox(
                              value: isSelected,
                              onChanged: (_) => _toggleSelection(chat.id),
                              activeColor: AppColors.primary,
                            ),
                            onTap: () => _toggleSelection(chat.id),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class _ChatItem {
  final String id;
  final String name;
  final String? avatarUrl;
  final bool isGroup;

  _ChatItem({
    required this.id,
    required this.name,
    this.avatarUrl,
    required this.isGroup,
  });
}
