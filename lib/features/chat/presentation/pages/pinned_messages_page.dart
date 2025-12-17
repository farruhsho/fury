import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Page displaying all pinned messages in a chat
class PinnedMessagesPage extends StatelessWidget {
  final String chatId;

  const PinnedMessagesPage({
    super.key,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pinned Messages', style: AppTypography.h3),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Long press a message in chat to pin/unpin'),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .doc(chatId)
            .collection('messages')
            .where('isPinned', isEqualTo: true)
            .orderBy('pinnedAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                ],
              ),
            );
          }

          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.push_pin_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No pinned messages',
                    style: AppTypography.h3.copyWith(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Long press a message to pin it',
                    style: AppTypography.bodyMedium.copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data() as Map<String, dynamic>;
              
              return _PinnedMessageCard(
                messageId: doc.id,
                chatId: chatId,
                text: data['text'] as String? ?? '',
                senderName: data['senderName'] as String? ?? 'User',
                pinnedAt: (data['pinnedAt'] as Timestamp?)?.toDate(),
                createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
                type: data['type'] as String? ?? 'text',
              );
            },
          );
        },
      ),
    );
  }
}

class _PinnedMessageCard extends StatelessWidget {
  final String messageId;
  final String chatId;
  final String text;
  final String senderName;
  final DateTime? pinnedAt;
  final DateTime? createdAt;
  final String type;

  const _PinnedMessageCard({
    required this.messageId,
    required this.chatId,
    required this.text,
    required this.senderName,
    this.pinnedAt,
    this.createdAt,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to message in chat
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Navigate to message - coming soon')),
          );
        },
        onLongPress: () => _showUnpinDialog(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.primary,
                    child: Text(
                      senderName.isNotEmpty ? senderName[0].toUpperCase() : '?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          senderName,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        if (createdAt != null)
                          Text(
                            _formatDate(createdAt!),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.push_pin,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Pinned',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const Divider(height: 24),
              
              // Message content
              if (type == 'image')
                Row(
                  children: [
                    const Icon(Icons.image, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      'Photo',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                )
              else if (type == 'video')
                Row(
                  children: [
                    const Icon(Icons.videocam, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      'Video',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                )
              else if (type == 'audio')
                Row(
                  children: [
                    const Icon(Icons.mic, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      'Voice message',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                )
              else if (type == 'document')
                Row(
                  children: [
                    const Icon(Icons.insert_drive_file, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        text.isNotEmpty ? text : 'Document',
                        style: TextStyle(color: Colors.grey[700]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              else
                Text(text, maxLines: 5, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return 'Today at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    }
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showUnpinDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unpin Message'),
        content: const Text('Remove this message from pinned messages?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('chats')
                  .doc(chatId)
                  .collection('messages')
                  .doc(messageId)
                  .update({
                'isPinned': false,
                'pinnedAt': FieldValue.delete(),
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Message unpinned')),
              );
            },
            child: const Text('Unpin'),
          ),
        ],
      ),
    );
  }
}

/// Helper class for pinning messages
class PinnedMessagesHelper {
  static Future<void> pinMessage(String chatId, String messageId) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .update({
      'isPinned': true,
      'pinnedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> unpinMessage(String chatId, String messageId) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .update({
      'isPinned': false,
      'pinnedAt': FieldValue.delete(),
    });
  }

  static Future<int> getPinnedCount(String chatId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where('isPinned', isEqualTo: true)
        .get();
    return snapshot.docs.length;
  }
}
