import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';

class GroupInfoPage extends StatelessWidget {
  final String groupId;

  const GroupInfoPage({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Group Image
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.primary.withValues(alpha: 0.1),
                child: const Icon(
                  Icons.group,
                  size: 80,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),

          // Group Info
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.lg),

                // Group Name
                const Text(
                  'Group Name', // TODO: Get from chat entity
                  style: AppTypography.h2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),

                // Group Description
                Text(
                  'Created by User • X members',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ActionButton(
                      icon: Icons.call,
                      label: 'Audio',
                      onTap: () {
                        // TODO: Start group audio call
                      },
                    ),
                    _ActionButton(
                      icon: Icons.videocam,
                      label: 'Video',
                      onTap: () {
                        // TODO: Start group video call
                      },
                    ),
                    _ActionButton(
                      icon: Icons.search,
                      label: 'Search',
                      onTap: () {
                        // TODO: Search in chat
                      },
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),

                // Options List
                _OptionTile(
                  icon: Icons.notifications,
                  title: 'Mute notifications',
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {
                      // TODO: Toggle mute
                    },
                    activeThumbColor: AppColors.primary,
                  ),
                ),
                _OptionTile(
                  icon: Icons.wallpaper,
                  title: 'Wallpaper',
                  onTap: () {
                    // TODO: Change wallpaper
                  },
                ),
                _OptionTile(
                  icon: Icons.photo_library,
                  title: 'Media, links, and docs',
                  subtitle: '0',
                  onTap: () {
                    // TODO: Show media gallery
                  },
                ),

                const Divider(height: 32),

                // Members Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'X participants',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          // TODO: Search members
                        },
                      ),
                    ],
                  ),
                ),

                _OptionTile(
                  icon: Icons.person_add,
                  title: 'Add members',
                  iconColor: AppColors.primary,
                  onTap: () {
                    // TODO: Add members
                  },
                ),

                // TODO: List group members

                const Divider(height: 32),

                // Danger Zone
                _OptionTile(
                  icon: Icons.exit_to_app,
                  title: 'Exit group',
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: () {
                    _showExitGroupDialog(context);
                  },
                ),
                _OptionTile(
                  icon: Icons.report,
                  title: 'Report group',
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: () {
                    // TODO: Report group
                  },
                ),

                const SizedBox(height: AppSpacing.xxxl),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showExitGroupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Group'),
        content: const Text('Are you sure you want to exit this group?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Exit group
              Navigator.pop(context);
              context.pop();
            },
            child: const Text(
              'Exit',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.caption,
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Color? iconColor;
  final Color? textColor;
  final VoidCallback? onTap;

  const _OptionTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.iconColor,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? AppColors.textSecondaryLight),
      title: Text(
        title,
        style: AppTypography.bodyLarge.copyWith(color: textColor),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondaryLight,
              ),
            )
          : null,
      trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_right) : null),
      onTap: onTap,
    );
  }
}
