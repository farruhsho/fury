import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/call_entity.dart';
import '../bloc/call_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'call_page.dart';

/// Call details page showing contact info and call history
/// Based on WhatsApp's "Данные о звонке" screen
class CallDetailsPage extends StatelessWidget {
  final String recipientId;
  final String recipientName;
  final String? recipientAvatarUrl;
  final String? chatId;

  const CallDetailsPage({
    super.key,
    required this.recipientId,
    required this.recipientName,
    this.recipientAvatarUrl,
    this.chatId,
  });

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Данные о звонке'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'clear':
                  _clearCallHistory(context);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear',
                child: Text('Очистить историю'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Contact Info Header
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                  backgroundImage: recipientAvatarUrl != null
                      ? NetworkImage(recipientAvatarUrl!)
                      : null,
                  child: recipientAvatarUrl == null
                      ? Text(
                          recipientName.isNotEmpty
                              ? recipientName[0].toUpperCase()
                              : '?',
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: 16),
                
                // Name
                Text(
                  recipientName,
                  style: AppTypography.h2,
                ),
                const SizedBox(height: 24),
                
                // Quick Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _QuickActionButton(
                      icon: Icons.message_outlined,
                      label: 'Написать',
                      onTap: () => _openChat(context),
                    ),
                    const SizedBox(width: 24),
                    _QuickActionButton(
                      icon: Icons.call_outlined,
                      label: 'Аудио',
                      onTap: () => _initiateCall(context, isVideo: false),
                    ),
                    const SizedBox(width: 24),
                    _QuickActionButton(
                      icon: Icons.videocam_outlined,
                      label: 'Видеозвонок',
                      onTap: () => _initiateCall(context, isVideo: true),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const Divider(),
          
          // Call History with this contact
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _getCallHistoryStream(currentUserId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return _buildEmptyState();
                }
                
                final calls = snapshot.data!.docs;
                
                // Group calls by date
                final groupedCalls = <String, List<QueryDocumentSnapshot>>{};
                for (final call in calls) {
                  final data = call.data() as Map<String, dynamic>;
                  final timestamp = data['startedAt'] as Timestamp?;
                  if (timestamp != null) {
                    final date = timestamp.toDate();
                    final dateKey = _formatDateHeader(date);
                    groupedCalls.putIfAbsent(dateKey, () => []).add(call);
                  }
                }
                
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: groupedCalls.length,
                  itemBuilder: (context, index) {
                    final dateKey = groupedCalls.keys.elementAt(index);
                    final callsForDate = groupedCalls[dateKey]!;
                    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date Header
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            dateKey,
                            style: AppTypography.caption.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // Calls for this date
                        ...callsForDate.map((call) => _CallHistoryItem(
                          callDoc: call,
                          currentUserId: currentUserId ?? '',
                        )),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Stream<QuerySnapshot> _getCallHistoryStream(String? currentUserId) {
    if (currentUserId == null) return const Stream.empty();
    
    return FirebaseFirestore.instance
        .collection('calls')
        .where('participants', arrayContains: currentUserId)
        .orderBy('startedAt', descending: true)
        .snapshots()
        .map((snapshot) {
          // Filter to only calls with this specific recipient
          final filteredDocs = snapshot.docs.where((doc) {
            final data = doc.data();
            final participants = List<String>.from(data['participants'] ?? []);
            return participants.contains(recipientId);
          }).toList();
          
          // Return a modified snapshot-like object
          return snapshot;
        });
  }
  
  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final callDate = DateTime(date.year, date.month, date.day);
    
    if (callDate == today) {
      return 'Сегодня';
    } else if (callDate == yesterday) {
      return 'Вчера';
    } else {
      return DateFormat('d MMMM', 'ru').format(date);
    }
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.call_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Нет истории звонков',
            style: AppTypography.bodyLarge.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            'Звонки с $recipientName будут здесь',
            style: AppTypography.bodyMedium.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
  
  void _openChat(BuildContext context) {
    if (chatId != null) {
      Navigator.of(context).pushNamed('/chat/$chatId');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Чат не найден')),
      );
    }
  }
  
  void _initiateCall(BuildContext context, {required bool isVideo}) {
    try {
      final callBloc = context.read<CallBloc>();
      
      callBloc.add(CallEvent.initiateCall(
        chatId: chatId ?? '',
        recipientId: recipientId,
        recipientName: recipientName,
        callType: isVideo ? CallType.video : CallType.voice,
      ));
      
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CallPage(
            recipientName: recipientName,
            isVideo: isVideo,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось начать звонок')),
      );
    }
  }
  
  void _clearCallHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Очистить историю?'),
        content: Text('Удалить все звонки с $recipientName?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              // TODO: Implement clear history
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('История очищена')),
              );
            },
            child: const Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

/// Quick action button widget
class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Call history item widget
class _CallHistoryItem extends StatelessWidget {
  final QueryDocumentSnapshot callDoc;
  final String currentUserId;

  const _CallHistoryItem({
    required this.callDoc,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final data = callDoc.data() as Map<String, dynamic>;
    final callerId = data['callerId'] as String? ?? '';
    final isOutgoing = callerId == currentUserId;
    final callType = data['callType'] as String? ?? 'voice';
    final status = data['status'] as String? ?? '';
    final isMissed = status == 'missed' || status == 'declined';
    final duration = data['duration'] as int? ?? 0;
    final dataUsed = data['dataUsed'] as int? ?? 0;
    final timestamp = data['startedAt'] as Timestamp?;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Call direction icon
          Icon(
            isOutgoing
                ? Icons.call_made
                : (isMissed ? Icons.call_missed : Icons.call_received),
            color: isMissed ? Colors.red : Colors.green,
            size: 20,
          ),
          const SizedBox(width: 12),
          
          // Call type and time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      isOutgoing ? 'Исходящий' : (isMissed ? 'Пропущенный' : 'Входящий'),
                      style: AppTypography.bodyMedium,
                    ),
                    const SizedBox(width: 8),
                    if (callType == 'video')
                      const Icon(Icons.videocam, size: 16, color: Colors.grey),
                  ],
                ),
                if (timestamp != null)
                  Text(
                    DateFormat('HH:mm').format(timestamp.toDate()),
                    style: AppTypography.caption.copyWith(color: Colors.grey),
                  ),
              ],
            ),
          ),
          
          // Duration and data
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (duration > 0)
                Text(
                  _formatDuration(duration),
                  style: AppTypography.caption,
                ),
              if (dataUsed > 0)
                Text(
                  _formatDataUsed(dataUsed),
                  style: AppTypography.caption.copyWith(color: Colors.grey),
                ),
            ],
          ),
        ],
      ),
    );
  }
  
  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    if (minutes > 0) {
      return '$minutes мин ${secs > 0 ? '$secs с' : ''}';
    }
    return '$secs с';
  }
  
  String _formatDataUsed(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(0)} КБ';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} МБ';
  }
}
