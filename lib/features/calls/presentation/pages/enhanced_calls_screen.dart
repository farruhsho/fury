import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';

/// Enhanced Calls screen with favorites section
class EnhancedCallsScreen extends StatefulWidget {
  const EnhancedCallsScreen({super.key});

  @override
  State<EnhancedCallsScreen> createState() => _EnhancedCallsScreenState();
}

class _EnhancedCallsScreenState extends State<EnhancedCallsScreen> {
  List<Map<String, dynamic>> _favorites = [];
  List<Map<String, dynamic>> _recentCalls = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCalls();
  }

  Future<void> _loadCalls() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      // Load recent calls
      final callsSnapshot = await FirebaseFirestore.instance
          .collection('calls')
          .where('participantIds', arrayContains: user.uid)
          .orderBy('startedAt', descending: true)
          .limit(50)
          .get();

      final calls = <Map<String, dynamic>>[];
      for (final doc in callsSnapshot.docs) {
        final data = doc.data();
        data['id'] = doc.id;
        
        // Get other participant info
        final participantIds = List<String>.from(data['participantIds'] ?? []);
        final otherUserId = participantIds.firstWhere((id) => id != user.uid, orElse: () => '');
        
        if (otherUserId.isNotEmpty) {
          final userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(otherUserId)
              .get();
          if (userDoc.exists) {
            data['otherUser'] = userDoc.data();
          }
        }
        
        calls.add(data);
      }

      // Load favorites
      final favoritesDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .get();
      
      final favorites = favoritesDoc.docs.map((doc) => doc.data()).toList();

      setState(() {
        _recentCalls = calls;
        _favorites = favorites;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Звонки', style: AppTypography.h3),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showOptionsMenu(context),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadCalls,
              child: ListView(
                children: [
                  // Favorites section
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm,
                    ),
                    child: Text(
                      'Избранное',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondaryLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  
                  // Add to favorites button
                  ListTile(
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.favorite, color: Colors.white),
                    ),
                    title: Text(
                      'Добавить в Избранное',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    onTap: () => _showAddFavoriteSheet(context),
                  ),

                  // Favorite contacts
                  ..._favorites.map((fav) => _buildFavoriteTile(fav)),

                  // Recent calls section
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.sm,
                    ),
                    child: Text(
                      'Недавние',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondaryLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  // Recent calls list
                  if (_recentCalls.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Center(
                        child: Text(
                          'Нет недавних звонков',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ),
                    )
                  else
                    ..._recentCalls.map((call) => _buildCallTile(call)),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => _showNewCallSheet(context),
        child: const Icon(Icons.add_call, color: Colors.white),
      ),
    );
  }

  Widget _buildFavoriteTile(Map<String, dynamic> favorite) {
    final name = favorite['name'] ?? 'Unknown';
    final avatarUrl = favorite['avatarUrl'] as String?;

    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.primary.withValues(alpha: 0.2),
        backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
        child: avatarUrl == null
            ? Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
              )
            : null,
      ),
      title: Text(
        name,
        style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimaryLight),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.call, color: AppColors.primary),
            onPressed: () {
              // Start audio call
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: AppColors.primary),
            onPressed: () {
              // Start video call
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCallTile(Map<String, dynamic> call) {
    final otherUser = call['otherUser'] as Map<String, dynamic>?;
    final name = otherUser?['displayName'] ?? otherUser?['name'] ?? 'Unknown';
    final avatarUrl = otherUser?['avatarUrl'] as String?;
    final isVideo = call['isVideo'] == true;
    final startedAt = (call['startedAt'] as Timestamp?)?.toDate();
    final callerId = call['callerId'];
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    final isOutgoing = callerId == currentUserId;
    final status = call['status'] ?? 'ended';
    final isMissed = status == 'missed' || (status == 'ended' && !isOutgoing && call['duration'] == null);
    
    // Format time
    final timeStr = startedAt != null ? _formatCallTime(startedAt) : '';
    
    // Count calls from same person
    final callCount = _recentCalls.where((c) {
      final u = c['otherUser'] as Map<String, dynamic>?;
      return u?['displayName'] == name || u?['name'] == name;
    }).length;

    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.primary.withValues(alpha: 0.2),
        backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
        child: avatarUrl == null
            ? Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
              )
            : null,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              callCount > 1 ? '$name ($callCount)' : name,
              style: AppTypography.bodyLarge.copyWith(
                color: isMissed ? Colors.red.shade400 : AppColors.textPrimaryLight,
              ),
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Icon(
            isOutgoing ? Icons.call_made : Icons.call_received,
            size: 14,
            color: isMissed ? Colors.red.shade400 : AppColors.primary,
          ),
          const SizedBox(width: 4),
          Text(
            timeStr,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(
          isVideo ? Icons.videocam : Icons.call,
          color: AppColors.textSecondaryLight,
        ),
        onPressed: () {
          // Start call
        },
      ),
      onTap: () {
        // Show call details
      },
    );
  }

  String _formatCallTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final callDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    final time = '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

    if (callDate == today) {
      return 'Сегодня, $time';
    } else if (callDate == yesterday) {
      return 'Вчера, $time';
    } else {
      return '${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}, $time';
    }
  }

  void _showOptionsMenu(BuildContext context) {
    showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(100, 80, 16, 0),
      color: AppColors.surfaceDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      items: [
        const PopupMenuItem(
          value: 'clear',
          child: Row(
            children: [
              Icon(Icons.delete_outline, size: 20, color: AppColors.textPrimaryLight),
              SizedBox(width: 12),
              Text('Очистить журнал', style: TextStyle(color: AppColors.textPrimaryLight)),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'settings',
          child: Row(
            children: [
              Icon(Icons.settings_outlined, size: 20, color: AppColors.textPrimaryLight),
              SizedBox(width: 12),
              Text('Настройки', style: TextStyle(color: AppColors.textPrimaryLight)),
            ],
          ),
        ),
      ],
    );
  }

  void _showAddFavoriteSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textSecondaryLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Добавить в избранное',
              style: AppTypography.h3.copyWith(color: AppColors.textPrimaryLight),
            ),
            const SizedBox(height: 16),
            // Contact list would go here
            ListTile(
              leading: const Icon(Icons.person_add, color: AppColors.primary),
              title: const Text('Выбрать контакт', style: TextStyle(color: AppColors.textPrimaryLight)),
              onTap: () {
                Navigator.pop(ctx);
                context.push('/contacts');
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showNewCallSheet(BuildContext context) {
    context.push('/new-call');
  }
}
