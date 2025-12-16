import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/chat_entity.dart';

class ChatListItem extends StatelessWidget {
  final ChatEntity chat;

  const ChatListItem({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    // Check if we need to fetch user data
    // ChatType is an enum imported from chat_entity.dart
    final isPrivate = chat.type == ChatType.private;
    
    // To be safe with imports, I'll implicitly handle it or rely on existing imports.
    // ChatEntity uses ChatType enum.
    
    final needsFetch = (chat.name == 'Unknown User' || chat.name == null) && 
                       isPrivate && 
                       chat.participantIds.length > 1;

    if (needsFetch) {
       final currentUserId = FirebaseAuth.instance.currentUser?.uid;
       final otherId = chat.participantIds.firstWhere(
         (id) => id != currentUserId, 
         orElse: () => chat.participantIds.first
       );
       
       return FutureBuilder<DocumentSnapshot>(
         future: FirebaseFirestore.instance.collection('users').doc(otherId).get(),
         builder: (context, snapshot) {
           String displayName = chat.name ?? 'Unknown User';
           String? avatarUrl = chat.imageUrl;
           
           if (snapshot.hasData && snapshot.data!.exists) {
             final data = snapshot.data!.data() as Map<String, dynamic>;
             displayName = data['displayName'] as String? ?? displayName;
             avatarUrl = data['avatarUrl'] as String? ?? avatarUrl;
           }
           
           return _buildListItem(context, displayName, avatarUrl);
         },
       );
    }

    return _buildListItem(context, chat.name ?? 'Unknown User', chat.imageUrl);
  }

  Widget _buildListItem(BuildContext context, String name, String? imageUrl) {
    final lastMessage = chat.lastMessage;
    final time = lastMessage != null
        ? DateFormat.Hm().format(lastMessage.createdAt)
        : '';

    return InkWell(
      onTap: () => context.push('/chat/${chat.id}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              backgroundImage: imageUrl != null
                  ? NetworkImage(imageUrl)
                  : null,
              child: imageUrl == null
                  ? Text(
                      (name.isNotEmpty ? name[0] : '?').toUpperCase(),
                      style: AppTypography.h3.copyWith(color: AppColors.primary),
                    )
                  : null,
            ),
            const SizedBox(width: AppSpacing.md),
            
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Name
                      Expanded(
                        child: Text(
                          name,
                          style: AppTypography.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Time
                      Text(
                        time,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Last Message
                      Expanded(
                        child: Text(
                          _getLastMessageText(chat),
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondaryLight,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Unread Count
                      if (chat.unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            chat.unreadCount.toString(),
                            style: AppTypography.caption.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  String _getLastMessageText(ChatEntity chat) {
     final last = chat.lastMessage;
     if (last == null) return 'No messages yet';
     if (last.text?.isNotEmpty == true) return last.text!;
     if (last.attachments != null && last.attachments!.isNotEmpty) {
        return '📷 Attachment';
     }
     return 'Message';
  }
}
