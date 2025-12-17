import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';

/// Status screen - view and create statuses
class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  List<Map<String, dynamic>> _recentStatuses = [];
  List<Map<String, dynamic>> _viewedStatuses = [];
  Map<String, dynamic>? _myStatus;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStatuses();
  }

  Future<void> _loadStatuses() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) return;

      // Load statuses from Firebase
      final statusesSnapshot = await FirebaseFirestore.instance
          .collection('statuses')
          .where('expiresAt', isGreaterThan: Timestamp.now())
          .orderBy('expiresAt')
          .orderBy('createdAt', descending: true)
          .limit(50)
          .get();

      final myStatuses = <Map<String, dynamic>>[];
      final recent = <Map<String, dynamic>>[];
      final viewed = <Map<String, dynamic>>[];

      for (final doc in statusesSnapshot.docs) {
        final data = doc.data();
        data['id'] = doc.id;
        
        if (data['userId'] == currentUser.uid) {
          myStatuses.add(data);
        } else {
          final viewedBy = List<String>.from(data['viewedBy'] ?? []);
          if (viewedBy.contains(currentUser.uid)) {
            viewed.add(data);
          } else {
            recent.add(data);
          }
        }
      }

      setState(() {
        _myStatus = myStatuses.isNotEmpty ? myStatuses.first : null;
        _recentStatuses = recent;
        _viewedStatuses = viewed;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _showStatusMenu(BuildContext context) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 80, 16, 0),
      color: AppColors.surfaceDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      items: [
        _buildMenuItem('privacy', 'Конфиденциальность статуса', Icons.lock_outline),
        _buildMenuItem('favorites', 'Избранные', Icons.star_outline),
        _buildMenuItem('settings', 'Настройки', Icons.settings_outlined),
      ],
    ).then((value) {
      if (value == 'privacy') {
        // Open status privacy settings
      } else if (value == 'favorites') {
        // Open favorites
      } else if (value == 'settings') {
        context.push('/settings');
      }
    });
  }

  PopupMenuItem<String> _buildMenuItem(String value, String label, IconData icon) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textPrimaryLight),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: AppColors.textPrimaryLight)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        title: const Text('Актуальное', style: AppTypography.h3),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showStatusMenu(context),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadStatuses,
              child: ListView(
                children: [
                  // My Status section
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Text(
                      'Статус',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondaryLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  _buildMyStatusTile(),

                  // Recent statuses
                  if (_recentStatuses.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.sm,
                      ),
                      child: Text(
                        'Недавние обновления',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondaryLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ..._recentStatuses.map((s) => _buildStatusTile(s, false)),
                  ],

                  // Viewed statuses
                  if (_viewedStatuses.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.sm,
                      ),
                      child: Text(
                        'Просмотренные',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondaryLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ..._viewedStatuses.map((s) => _buildStatusTile(s, true)),
                  ],

                  // Empty state
                  if (_recentStatuses.isEmpty && _viewedStatuses.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Center(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.camera_alt_outlined,
                              size: 64,
                              color: AppColors.textSecondaryLight,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Нет статусов',
                              style: AppTypography.bodyLarge.copyWith(
                                color: AppColors.textSecondaryLight,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Статусы контактов будут отображаться здесь',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textSecondaryLight,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),  
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          // Open camera for status
          context.push('/camera', extra: {'forStatus': true});
        },
        child: const Icon(Icons.camera_alt, color: Colors.white),
      ),
    );
  }

  Widget _buildMyStatusTile() {
    final hasStatus = _myStatus != null;
    
    return ListTile(
      leading: Stack(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: hasStatus ? AppColors.primary : Colors.grey.shade600,
                width: 2,
              ),
            ),
            child: const CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.surfaceLight,
              child: Icon(Icons.person, color: AppColors.textSecondaryLight),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surfaceDark, width: 2),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 14),
            ),
          ),
        ],
      ),
      title: Text(
        'Добавить статус',
        style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimaryLight),
      ),
      subtitle: Text(
        hasStatus ? 'Нажмите для просмотра' : 'Исчезает через 24 часа',
        style: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
      ),
      onTap: () {
        if (hasStatus) {
          // View own status
        } else {
          // Create new status
          context.push('/camera', extra: {'forStatus': true});
        }
      },
    );
  }

  Widget _buildStatusTile(Map<String, dynamic> status, bool isViewed) {
    final userName = status['userName'] ?? 'Unknown';
    final avatarUrl = status['userAvatarUrl'] as String?;
    final createdAt = (status['createdAt'] as Timestamp?)?.toDate();
    final timeAgo = createdAt != null ? _formatTimeAgo(createdAt) : '';

    return ListTile(
      leading: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isViewed ? Colors.grey.shade600 : AppColors.primary,
            width: 2,
          ),
        ),
        child: CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.surfaceLight,
          backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
          child: avatarUrl == null
              ? Text(
                  userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              : null,
        ),
      ),
      title: Text(
        userName,
        style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimaryLight),
      ),
      subtitle: Text(
        timeAgo,
        style: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
      ),
      onTap: () {
        // View status
      },
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    
    if (diff.inMinutes < 1) return 'Только что';
    if (diff.inMinutes < 60) return '${diff.inMinutes} мин. назад';
    if (diff.inHours < 24) return '${diff.inHours} ч. назад';
    return 'Вчера';
  }
}
