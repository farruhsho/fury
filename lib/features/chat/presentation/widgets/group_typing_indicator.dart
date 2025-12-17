import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../app/theme/app_colors.dart';

/// Enhanced typing indicator supporting individual and group chats
class GroupTypingIndicator extends StatefulWidget {
  final String chatId;
  final bool isGroupChat;

  const GroupTypingIndicator({
    super.key,
    required this.chatId,
    this.isGroupChat = false,
  });

  @override
  State<GroupTypingIndicator> createState() => _GroupTypingIndicatorState();
}

class _GroupTypingIndicatorState extends State<GroupTypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _dotsController;
  StreamSubscription? _typingSubscription;
  List<TypingUser> _typingUsers = [];

  @override
  void initState() {
    super.initState();
    _dotsController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
    
    _listenToTyping();
  }

  void _listenToTyping() {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) return;

    _typingSubscription = FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .collection('typing')
        .where('isTyping', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      if (!mounted) return;
      
      final users = snapshot.docs
          .where((doc) => doc.id != currentUserId) // Exclude self
          .map((doc) {
            final data = doc.data();
            return TypingUser(
              id: doc.id,
              name: data['userName'] as String? ?? 'Someone',
              timestamp: (data['updatedAt'] as Timestamp?)?.toDate(),
            );
          })
          .where((user) {
            // Only show if updated in last 5 seconds
            if (user.timestamp == null) return true;
            return DateTime.now().difference(user.timestamp!).inSeconds < 5;
          })
          .toList();

      setState(() => _typingUsers = users);
    });
  }

  @override
  void dispose() {
    _dotsController.dispose();
    _typingSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_typingUsers.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Typing animation
          _buildDotsAnimation(),
          const SizedBox(width: 8),
          // Typing text
          Flexible(
            child: Text(
              _buildTypingText(),
              style: const TextStyle(
                fontSize: 13,
                color: FuryColors.cyberCyan,
                fontStyle: FontStyle.italic,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDotsAnimation() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _dotsController,
          builder: (context, child) {
            final delay = index * 0.15;
            final value = ((_dotsController.value - delay) % 1.0).clamp(0.0, 1.0);
            final scale = 0.5 + (0.5 * (value < 0.5 ? value * 2 : 2 - value * 2));
            
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: FuryColors.cyberCyan.withOpacity(scale),
                shape: BoxShape.circle,
              ),
            );
          },
        );
      }),
    );
  }

  String _buildTypingText() {
    if (_typingUsers.isEmpty) return '';
    
    if (_typingUsers.length == 1) {
      return '${_typingUsers[0].name} is typing';
    } else if (_typingUsers.length == 2) {
      return '${_typingUsers[0].name} and ${_typingUsers[1].name} are typing';
    } else {
      return '${_typingUsers[0].name} and ${_typingUsers.length - 1} others are typing';
    }
  }
}

class TypingUser {
  final String id;
  final String name;
  final DateTime? timestamp;

  TypingUser({
    required this.id,
    required this.name,
    this.timestamp,
  });
}

/// Service for managing typing status
class TypingService {
  static final _firestore = FirebaseFirestore.instance;
  static Timer? _typingTimer;

  /// Update typing status in Firestore
  static Future<void> setTyping({
    required String chatId,
    required bool isTyping,
  }) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final userName = FirebaseAuth.instance.currentUser?.displayName ?? 'User';
    if (userId == null) return;

    if (isTyping) {
      // Set typing with timestamp
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('typing')
          .doc(userId)
          .set({
        'isTyping': true,
        'userName': userName,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Auto-clear after 3 seconds of no updates
      _typingTimer?.cancel();
      _typingTimer = Timer(const Duration(seconds: 3), () {
        _clearTyping(chatId, userId);
      });
    } else {
      await _clearTyping(chatId, userId);
    }
  }

  static Future<void> _clearTyping(String chatId, String userId) async {
    _typingTimer?.cancel();
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('typing')
        .doc(userId)
        .set({'isTyping': false});
  }

  /// Call this when text changes
  static void onTextChanged(String chatId) {
    setTyping(chatId: chatId, isTyping: true);
  }

  /// Call this when message is sent
  static void onMessageSent(String chatId) {
    setTyping(chatId: chatId, isTyping: false);
  }
}
