import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../app/theme/app_colors.dart';

/// Service and UI component for blocked user handling
class BlockedUserService {
  static final _firestore = FirebaseFirestore.instance;

  /// Block a user
  static Future<void> blockUser(String userId) async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) return;

    await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('blocked')
        .doc(userId)
        .set({
      'blockedAt': FieldValue.serverTimestamp(),
    });

    print('🚫 [BLOCK] Blocked user: $userId');
  }

  /// Unblock a user
  static Future<void> unblockUser(String userId) async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) return;

    await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('blocked')
        .doc(userId)
        .delete();

    print('✅ [BLOCK] Unblocked user: $userId');
  }

  /// Check if a user is blocked
  static Future<bool> isUserBlocked(String userId) async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) return false;

    final doc = await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('blocked')
        .doc(userId)
        .get();

    return doc.exists;
  }

  /// Get stream of blocked user IDs
  static Stream<List<String>> getBlockedUsersStream() {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) return Stream.value([]);

    return _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('blocked')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
  }

  /// Show block confirmation dialog
  static Future<bool?> showBlockDialog(
    BuildContext context, {
    required String userName,
    required String userId,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: FuryColors.darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: FuryColors.error.withValues(alpha: 0.3)),
        ),
        title: Row(
          children: [
            const Icon(Icons.block, color: FuryColors.error),
            const SizedBox(width: 12),
            Text(
              'Block $userName?',
              style: const TextStyle(color: FuryColors.textPrimary),
            ),
          ],
        ),
        content: const Text(
          'Blocked contacts will no longer be able to:\n'
          '• Send you messages\n'
          '• See your online status\n'
          '• View your profile updates\n'
          '• Call you',
          style: TextStyle(
            color: FuryColors.textSecondary,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: FuryColors.textMuted),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await blockUser(userId);
              if (context.mounted) Navigator.pop(context, true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: FuryColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Block'),
          ),
        ],
      ),
    );
  }
}

/// Widget to show when chat is with blocked user
class BlockedUserBanner extends StatelessWidget {
  final String userName;
  final String userId;
  final VoidCallback? onUnblock;

  const BlockedUserBanner({
    super.key,
    required this.userName,
    required this.userId,
    this.onUnblock,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FuryColors.error.withValues(alpha: 0.1),
        border: Border(
          bottom: BorderSide(color: FuryColors.error.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.block, color: FuryColors.error, size: 20),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'You have blocked this contact',
              style: TextStyle(color: FuryColors.error, fontSize: 14),
            ),
          ),
          TextButton(
            onPressed: () async {
              await BlockedUserService.unblockUser(userId);
              if (!context.mounted) return;
              onUnblock?.call();
            },
            child: const Text(
              'Unblock',
              style: TextStyle(color: FuryColors.cyberCyan),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget for "you can't reply to this conversation" banner
class CannotReplyBanner extends StatelessWidget {
  final String reason;

  const CannotReplyBanner({
    super.key,
    this.reason = 'You can\'t reply to this conversation',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: FuryColors.glassDark,
        border: Border(
          top: BorderSide(color: FuryColors.glassLight),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.info_outline, color: FuryColors.textMuted, size: 18),
          const SizedBox(width: 8),
          Text(
            reason,
            style: const TextStyle(
              color: FuryColors.textMuted,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
