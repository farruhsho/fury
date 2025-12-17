import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'package:timeago/timeago.dart' as timeago;
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/di/injection_container.dart';
import '../bloc/message_bloc/message_bloc.dart';
import '../widgets/swipeable_message_bubble.dart';
import '../widgets/message_input.dart';
import '../widgets/forward_message_dialog.dart';
import '../widgets/edit_message_dialog.dart';
import '../widgets/typing_indicator.dart';
import '../widgets/online_indicator.dart';
import '../widgets/smart_reply.dart';
import '../widgets/disappearing_messages.dart';
import '../widgets/chat_search_widget.dart';

import 'pinned_messages_page.dart';
import 'chat_media_gallery_page.dart';
import '../../../calls/domain/entities/call_entity.dart';
import '../../../calls/presentation/bloc/call_bloc.dart';

import '../../../calls/presentation/pages/call_page.dart';

/// Chat participant info model for local use
class ChatPartnerInfo {
  final String id;
  final String displayName;
  final String? avatarUrl;
  final bool isOnline;
  final DateTime? lastSeen;

  ChatPartnerInfo({
    required this.id,
    required this.displayName,
    this.avatarUrl,
    this.isOnline = false,
    this.lastSeen,
  });
}

class ChatPage extends StatefulWidget {
  final String chatId;

  const ChatPage({super.key, required this.chatId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isTyping = false;
  String? _lastReceivedMessage;
  DisappearingDuration _disappearingDuration = DisappearingDuration.off;
  
  // Chat data
  ChatPartnerInfo? _partner;
  String? _chatName;
  bool _isLoading = true;
  String? _error;
  bool _isGroup = false;
  
  // Selection Mode
  final Set<String> _selectedMessageIds = {};
  bool get _isSelectionMode => _selectedMessageIds.isNotEmpty;

  void _toggleSelection(String messageId) {
    setState(() {
      if (_selectedMessageIds.contains(messageId)) {
        _selectedMessageIds.remove(messageId);
      } else {
        _selectedMessageIds.add(messageId);
      }
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedMessageIds.clear();
    });
  }

  void _onDeleteSelected(BuildContext context) {
    final state = context.read<MessageBloc>().state;
    state.maybeWhen(
      loaded: (messages) {
        final selectedMessages = messages.where((m) => _selectedMessageIds.contains(m.id)).toList();
        if (selectedMessages.isEmpty) return;
        
        final currentUserId = FirebaseAuth.instance.currentUser?.uid;
        // Check if all selected messages were sent by me
        final allMine = selectedMessages.every((m) => m.senderId == currentUserId);
        
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Delete ${selectedMessages.length} messages?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              if (allMine)
                TextButton(
                  onPressed: () {
                    for (final msg in selectedMessages) {
                       context.read<MessageBloc>().add(
                         MessageEvent.deleteMessage(messageId: msg.id, forEveryone: true)
                       );
                    }
                    _clearSelection();
                    Navigator.pop(context);
                  },
                  child: const Text('Delete for everyone', style: TextStyle(color: Colors.red)),
                ),
               TextButton(
                  onPressed: () {
                    for (final msg in selectedMessages) {
                       context.read<MessageBloc>().add(
                         MessageEvent.deleteMessage(messageId: msg.id, forEveryone: false)
                       );
                    }
                    _clearSelection();
                    Navigator.pop(context);
                  },
                  child: const Text('Delete for me'),
                ),
            ],
          ),
        );
      },
      orElse: () {},
    );
  }

  void _onCopySelected(BuildContext context) {
    final state = context.read<MessageBloc>().state;
    state.maybeWhen(
      loaded: (messages) {
        final selectedMessages = messages
            .where((m) => _selectedMessageIds.contains(m.id))
            .where((m) => m.text != null && m.text!.isNotEmpty)
            .toList();
        
        if (selectedMessages.isEmpty) return;
        
        // Sort by time
        selectedMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        
        final textToCopy = selectedMessages.map((m) => m.text).join('\n\n');
        Clipboard.setData(ClipboardData(text: textToCopy));
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Copied to clipboard')),
        );
        _clearSelection();
      },
      orElse: () {},
    );
  }

  void _onForwardSelected(BuildContext context) {
    final state = context.read<MessageBloc>().state;
    state.maybeWhen(
      loaded: (messages) {
        final selectedMessages = messages
            .where((m) => _selectedMessageIds.contains(m.id))
            .toList();
            
        if (selectedMessages.isEmpty) return;
        
        // Use the first message text/type for the dialog preview, 
        // but we'll need to modify the dialog or logic to handle multiple.
        // For now, using the existing dialog but wrapping the forward logic.
        
        ForwardMessageDialog.show(
          context: context,
          messageText: selectedMessages.length == 1 
              ? (selectedMessages.first.text ?? '[Media]') 
              : '${selectedMessages.length} messages',
          messageId: selectedMessages.first.id, // Placeholder, not used in multi-forward
          onForward: (targetChatIds) {
            // Dispatch forward event for each message to each target
            for (final msg in selectedMessages) {
              context.read<MessageBloc>().add(
                MessageEvent.forwardMessage(
                  messageId: msg.id,
                  originalText: msg.text ?? '[Attachment]',
                  targetChatIds: targetChatIds,
                ),
              );
            }
            _clearSelection();
          },
        );
      },
      orElse: () {},
    );
  }
  StreamSubscription? _typingSubscription;

  @override
  void initState() {
    super.initState();
    _loadChatInfo();
    _setupTypingListener();
    
    // Mark messages as read when chat opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<MessageBloc>().add(
          MessageEvent.markAsRead(widget.chatId),
        );
      }
    });
  }

  void _setupTypingListener() {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) return;

    // Listen to typing indicators in this chat
    _typingSubscription = FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .collection('typing')
        .snapshots()
        .listen((snapshot) {
      if (!mounted) return;
      
      // Check if anyone (other than current user) is typing
      final isAnyoneTyping = snapshot.docs.any((doc) {
        if (doc.id == currentUserId) return false;
        final data = doc.data();
        final isTyping = data['isTyping'] as bool? ?? false;
        final timestamp = data['timestamp'] as Timestamp?;
        
        // Typing indicator is valid for 10 seconds
        if (timestamp != null) {
          final age = DateTime.now().difference(timestamp.toDate());
          if (age.inSeconds > 10) return false;
        }
        
        return isTyping;
      });

      if (isAnyoneTyping != _isTyping) {
        setState(() => _isTyping = isAnyoneTyping);
      }
    });
  }

  @override
  void dispose() {
    _typingSubscription?.cancel();
    super.dispose();
  }

  /// Load chat info directly from Firestore
  Future<void> _loadChatInfo() async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) {
      if (mounted) {
        setState(() {
          _error = 'Not authenticated';
          _isLoading = false;
        });
      }
      return;
    }

    try {
      // Fetch chat document directly
      final chatDoc = await FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatId)
          .get();

      if (!chatDoc.exists) {
        if (mounted) {
          setState(() {
            _error = 'Chat not found';
            _isLoading = false;
          });
        }
        return;
      }

      final data = chatDoc.data()!;
      final chatType = data['type'] as String? ?? 'private';
      _isGroup = chatType == 'group';

      if (_isGroup) {
        // Group chat - use group name
        final groupInfo = data['groupInfo'] as Map<String, dynamic>?;
        _chatName = groupInfo?['name'] ?? data['name'] ?? 'Group Chat';
      } else {
        // Private chat - get partner info
        final participantIds = List<String>.from(data['participantIds'] ?? []);
        final partnerId = participantIds.firstWhere(
          (id) => id != currentUserId,
          orElse: () => '',
        );

        if (partnerId.isNotEmpty) {
          // Try to get from participants map first
          final participants = data['participants'] as Map<String, dynamic>?;
          if (participants != null && participants.containsKey(partnerId)) {
            final partnerData = participants[partnerId] as Map<String, dynamic>;
            _partner = ChatPartnerInfo(
              id: partnerId,
              displayName: partnerData['displayName'] ?? 'User',
              avatarUrl: partnerData['avatarUrl'],
              isOnline: partnerData['isOnline'] ?? false,
              lastSeen: partnerData['lastSeen'] != null
                  ? (partnerData['lastSeen'] as Timestamp).toDate()
                  : null,
            );
          } else {
            // Fallback: fetch from users collection
            final userDoc = await FirebaseFirestore.instance
                .collection('users')
                .doc(partnerId)
                .get();

            if (userDoc.exists) {
              final userData = userDoc.data()!;
              _partner = ChatPartnerInfo(
                id: partnerId,
                displayName: userData['displayName'] ?? 
                             userData['username'] ?? 
                             userData['email']?.split('@')[0] ?? 
                             'User',
                avatarUrl: userData['avatarUrl'] ?? userData['photoURL'],
                isOnline: userData['isOnline'] ?? false,
                lastSeen: userData['lastSeen'] != null
                    ? (userData['lastSeen'] as Timestamp).toDate()
                    : null,
              );
            }
          }
        }
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading chat info: $e');
      if (mounted) {
        setState(() {
          _error = 'Failed to load chat';
          _isLoading = false;
        });
      }
    }
  }

  String _getLastSeenText(DateTime? lastSeen) {
    if (lastSeen == null) return 'Offline';
    return 'Last seen ${timeago.format(lastSeen, locale: 'en_short')}';
  }

  void _initiateCall(BuildContext context, {
    required bool isVideo,
    required String recipientId,
    required String recipientName,
  }) {
    try {
      // Use global CallBloc from GlobalCallHandler
      final callBloc = context.read<CallBloc>();
      
      callBloc.add(CallEvent.initiateCall(
        chatId: widget.chatId,
        recipientId: recipientId,
        recipientName: recipientName,
        callType: isVideo ? CallType.video : CallType.voice,
      ));
      
      // Navigate to CallPage which uses the global CallBloc
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CallPage(recipientName: recipientName, isVideo: isVideo),
        ),
      );
    } catch (e) {
      print('Call initiation error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to initiate call. Service not ready.')),
      );
    }
  }

  void _showChatOptions(BuildContext context) {
    final displayName = _partner?.displayName ?? _chatName ?? 'Chat';
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: _partner?.avatarUrl != null
                        ? NetworkImage(_partner!.avatarUrl!)
                        : null,
                    backgroundColor: AppColors.primary,
                    child: _partner?.avatarUrl == null
                        ? Text(
                            displayName.isNotEmpty ? displayName[0].toUpperCase() : '?',
                            style: const TextStyle(color: Colors.white, fontSize: 20),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      displayName,
                      style: AppTypography.h3,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            
            // View Contact/Group Info
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text(_isGroup ? 'Информация о группе' : 'Просмотр контакта'),
              onTap: () {
                Navigator.pop(ctx);
                // Navigate to contact/group info page
                if (_isGroup) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Group info coming soon')),
                  );
                } else if (_partner != null) {
                  // TODO: Navigate to contact profile
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Контакт: ${_partner!.displayName}')),
                  );
                }
              },
            ),
            
            // Search in Chat
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Поиск'),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatSearchWidget(chatId: widget.chatId),
                  ),
                );
              },
            ),
            
            // Media, Links, Docs
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Медиа, ссылки и докум.'),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatMediaGalleryPage(
                      chatId: widget.chatId,
                      chatName: displayName,
                    ),
                  ),
                );
              },
            ),
            
            // Mute
            ListTile(
              leading: const Icon(Icons.notifications_off_outlined),
              title: const Text('Без звука'),
              onTap: () {
                Navigator.pop(ctx);
                _showMuteOptions(context);
              },
            ),
            
            // Disappearing Messages
            ListTile(
              leading: Icon(
                Icons.timer_outlined,
                color: _disappearingDuration != DisappearingDuration.off
                    ? AppColors.primary
                    : null,
              ),
              title: const Text('Исчезающие сообщения'),
              subtitle: Text(_disappearingDuration.displayName),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(ctx);
                showDisappearingMessagesSheet(
                  context: context,
                  currentDuration: _disappearingDuration,
                  onDurationChanged: (duration) {
                    setState(() => _disappearingDuration = duration);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(duration == DisappearingDuration.off
                            ? 'Исчезающие сообщения отключены'
                            : 'Сообщения исчезнут через ${duration.displayName}'),
                      ),
                    );
                  },
                );
              },
            ),
            
            // Block (only for private chats)
            if (!_isGroup && _partner != null)
              ListTile(
                leading: const Icon(Icons.block, color: Colors.red),
                title: const Text('Заблокировать', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(ctx);
                  _showBlockConfirmation(context);
                },
              ),
          ],
        ),
      ),
    );
  }
  
  void _showMuteOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              title: Text('Отключить уведомления', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            ListTile(
              title: const Text('8 часов'),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Уведомления отключены на 8 часов')),
                );
              },
            ),
            ListTile(
              title: const Text('1 неделя'),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Уведомления отключены на неделю')),
                );
              },
            ),
            ListTile(
              title: const Text('Всегда'),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Уведомления отключены')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  void _showBlockConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Заблокировать пользователя?'),
        content: Text('Вы уверены, что хотите заблокировать ${_partner?.displayName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              // TODO: Implement block functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Пользователь заблокирован')),
              );
            },
            child: const Text('Заблокировать', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    // Get display name for title
    final displayName = _partner?.displayName ?? _chatName ?? 'Chat';

    return BlocProvider(
      create: (context) => sl<MessageBloc>()
        ..add(MessageEvent.loadMessages(widget.chatId)),
      child: Scaffold(
        appBar: _isSelectionMode
            ? AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: _clearSelection,
                ),
                title: Text('${_selectedMessageIds.length} selected'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.reply),
                    tooltip: 'Reply', // Logic for single selection reply could be added here
                    onPressed: _selectedMessageIds.length == 1 
                      ? () {
                          // TODO: Implement reply to specific message from selection
                          _clearSelection();
                        } 
                      : null, 
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    tooltip: 'Delete',
                    onPressed: () => _onDeleteSelected(context),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    tooltip: 'Copy',
                    onPressed: () => _onCopySelected(context),
                  ),
                  IconButton(
                    icon: const Icon(Icons.forward),
                    tooltip: 'Forward',
                    onPressed: () => _onForwardSelected(context),
                  ),
                ],
                backgroundColor: AppColors.primaryDark,
              )
            : AppBar(
          titleSpacing: 0,
          title: _isLoading
              ? const Text('Loading...')
              : Row(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: _partner?.avatarUrl != null
                          ? NetworkImage(_partner!.avatarUrl!)
                          : null,
                      backgroundColor: AppColors.primary,
                      child: _partner?.avatarUrl == null
                          ? Text(
                              displayName.isNotEmpty 
                                  ? displayName[0].toUpperCase() 
                                  : '?',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayName,
                            style: AppTypography.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          _isTyping
                              ? const TypingIndicator()
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (!_isGroup && _partner != null) ...[
                                      OnlineIndicator(
                                        userId: _partner!.id,
                                        size: 8,
                                      ),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: UserStatusText(
                                          userId: _partner!.id,
                                          style: AppTypography.caption,
                                        ),
                                      ),
                                    ] else ...[
                                      Flexible(
                                        child: Text(
                                          _isGroup
                                              ? 'Group Chat'
                                              : 'Offline',
                                          style: AppTypography.caption.copyWith(
                                            color: AppColors.textSecondaryLight,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
          actions: [
            if (!_isGroup && _partner != null) ...[
              IconButton(
                icon: const Icon(Icons.videocam),
                tooltip: 'Video Call',
                onPressed: () => _initiateCall(
                  context,
                  isVideo: true,
                  recipientId: _partner!.id,
                  recipientName: _partner!.displayName,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.call),
                tooltip: 'Voice Call',
                onPressed: () => _initiateCall(
                  context,
                  isVideo: false,
                  recipientId: _partner!.id,
                  recipientName: _partner!.displayName,
                ),
              ),
            ],
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search in chat',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatSearchWidget(chatId: widget.chatId),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.push_pin_outlined),
              tooltip: 'Pinned messages',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PinnedMessagesPage(chatId: widget.chatId),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => _showChatOptions(context),
            ),
          ],
        ),
        body: _error != null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(_error!),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isLoading = true;
                          _error = null;
                        });
                        _loadChatInfo();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  // Disappearing messages indicator
                  if (_disappearingDuration != DisappearingDuration.off)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      color: AppColors.primary.withValues(alpha: 0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Messages disappear after ${_disappearingDuration.displayName}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  // Messages List
                  Expanded(
                    child: BlocConsumer<MessageBloc, MessageState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          loaded: (messages) {
                            if (messages.isNotEmpty) {
                              final lastMsg = messages.first;
                              if (lastMsg.senderId != currentUserId && 
                                  lastMsg.text != null) {
                                if (mounted) {
                                  setState(() {
                                    _lastReceivedMessage = lastMsg.text;
                                  });
                                }
                              }
                            }
                          },
                          orElse: () {},
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          error: (message) => Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.error_outline,
                                    size: 48, color: Colors.red),
                                const SizedBox(height: 16),
                                Text(message),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<MessageBloc>().add(
                                      MessageEvent.loadMessages(widget.chatId),
                                    );
                                  },
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                          loaded: (messages) {
                            if (messages.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '👋',
                                      style: TextStyle(fontSize: 64),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No messages yet',
                                      style: AppTypography.h3.copyWith(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Send a message to start the conversation',
                                      textAlign: TextAlign.center,
                                      style: AppTypography.bodyMedium.copyWith(
                                        color: AppColors.textSecondaryLight,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return ListView.builder(
                              reverse: true,
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppSpacing.sm),
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final message = messages[index];
                                final isMe = message.senderId == currentUserId;
                                final isSelected = _selectedMessageIds.contains(message.id);
                                return GestureDetector(
                                  // In selection mode, tapping toggles selection
                                  onTap: _isSelectionMode 
                                      ? () => _toggleSelection(message.id)
                                      : null,
                                  // Long press starts selection mode
                                  onLongPress: () => _toggleSelection(message.id),
                                  child: Container(
                                    color: isSelected 
                                        ? AppColors.primary.withValues(alpha: 0.2) 
                                        : null,
                                    child: SwipeableMessageBubble(
                                      message: message,
                                      isMe: isMe,
                                      onReply: _isSelectionMode ? null : () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Reply feature coming soon'))
                                        );
                                      },
                                      onEdit: _isSelectionMode || !isMe ? null : () {
                                          EditMessageDialog.show(
                                            context: context,
                                            originalText: message.text ?? '',
                                            onSave: (newText) {
                                              context.read<MessageBloc>().add(
                                                MessageEvent.editMessage(
                                                  messageId: message.id,
                                                  newText: newText,
                                                ),
                                              );
                                            },
                                          );
                                      },
                                      onDelete: isMe
                                          ? () {
                                              // Single delete (legacy, or route to new dialog)
                                               _toggleSelection(message.id);
                                               _onDeleteSelected(context);
                                            }
                                          : null,
                                      onForward: () {
                                        // Forward single message
                                        ForwardMessageDialog.show(
                                          context: context,
                                          messageText: message.text ?? '[Media]',
                                          messageId: message.id,
                                          onForward: (targetChatIds) {
                                             context.read<MessageBloc>().add(
                                                MessageEvent.forwardMessage(
                                                  messageId: message.id,
                                                  originalText: message.text ?? '',
                                                  targetChatIds: targetChatIds,
                                                ),
                                              );
                                          },
                                        );
                                      },
                                      onReact: (emoji) {
                                        context.read<MessageBloc>().add(
                                          MessageEvent.reactToMessage(
                                            messageId: message.id,
                                            emoji: emoji,
                                          ),
                                        );
                                      },
                                      onSelect: () => _toggleSelection(message.id),
                                      onCopy: () {
                                          if (message.text != null) {
                                            Clipboard.setData(ClipboardData(text: message.text!));
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Copied to clipboard')),
                                            );
                                          }
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          orElse: () =>
                              const Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  ),

                  // Smart Reply Suggestions
                  if (_lastReceivedMessage != null)
                    SmartReplySuggestions(
                      suggestions: SmartReplyService.generateSuggestions(
                          _lastReceivedMessage!),
                      onSuggestionTap: (suggestion) {
                        context.read<MessageBloc>().add(
                              MessageEvent.sendMessage(
                                chatId: widget.chatId,
                                text: suggestion,
                              ),
                            );
                        setState(() => _lastReceivedMessage = null);
                      },
                    ),

                  // Message Input
                  MessageInput(chatId: widget.chatId),
                ],
              ),
      ),
    );
  }
}
