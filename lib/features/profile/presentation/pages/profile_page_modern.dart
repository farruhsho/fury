import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/modern_components.dart';

/// Modern profile page with glassmorphism and animations
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ScrollController _scrollController = ScrollController();
  double _headerOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      setState(() {
        _headerOpacity = (1 - (offset / 200)).clamp(0.0, 1.0);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Animated app bar with profile header
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            stretch: true,
            backgroundColor: isDark ? AppColors.backgroundDark : AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gradient background
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primaryDark,
                          AppColors.primary,
                          AppColors.primaryLight,
                        ],
                      ),
                    ),
                  ),
                  // Pattern overlay
                  Opacity(
                    opacity: 0.1,
                    child: Image.network(
                      'https://www.toptal.com/designers/subtlepatterns/uploads/memphis-colorful.png',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    ),
                  ),
                  // Profile content
                  Opacity(
                    opacity: _headerOpacity,
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          // Avatar with edit button
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                ),
                                child: const ModernAvatar(
                                  name: 'User',
                                  size: 100,
                                  showStatus: false,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.accent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Name
                          const Text(
                            'User Name',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Status
                          Text(
                            'Available',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Profile sections
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  // Handle bar
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Quick actions
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildQuickAction(Icons.qr_code, 'QR Code'),
                        _buildQuickAction(Icons.share, 'Share'),
                        _buildQuickAction(Icons.edit, 'Edit'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Account section
                  _buildSection(
                    title: 'Account',
                    items: [
                      _ProfileItem(
                        icon: Icons.person_outline,
                        title: 'Personal Info',
                        subtitle: 'Name, phone, email',
                        onTap: () {},
                      ),
                      _ProfileItem(
                        icon: Icons.lock_outline,
                        title: 'Privacy',
                        subtitle: 'Last seen, profile photo, status',
                        onTap: () {},
                      ),
                      _ProfileItem(
                        icon: Icons.security,
                        title: 'Security',
                        subtitle: 'Two-step verification, fingerprint',
                        onTap: () {},
                      ),
                    ],
                  ),
                  
                  // App settings section
                  _buildSection(
                    title: 'App Settings',
                    items: [
                      _ProfileItem(
                        icon: Icons.notifications_outlined,
                        title: 'Notifications',
                        subtitle: 'Message, group, call notifications',
                        onTap: () {},
                      ),
                      _ProfileItem(
                        icon: Icons.palette_outlined,
                        title: 'Appearance',
                        subtitle: 'Theme, font size, chat wallpaper',
                        onTap: () {},
                      ),
                      _ProfileItem(
                        icon: Icons.language,
                        title: 'Language',
                        subtitle: 'English',
                        onTap: () {},
                      ),
                      _ProfileItem(
                        icon: Icons.storage_outlined,
                        title: 'Storage & Data',
                        subtitle: 'Network usage, auto-download',
                        onTap: () {},
                      ),
                    ],
                  ),
                  
                  // More section
                  _buildSection(
                    title: 'More',
                    items: [
                      _ProfileItem(
                        icon: Icons.help_outline,
                        title: 'Help',
                        subtitle: 'FAQ, contact us, privacy policy',
                        onTap: () {},
                      ),
                      _ProfileItem(
                        icon: Icons.info_outline,
                        title: 'About',
                        subtitle: 'Version 1.0.0',
                        onTap: () {},
                      ),
                      _ProfileItem(
                        icon: Icons.logout,
                        title: 'Log Out',
                        color: Colors.red,
                        onTap: () {},
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSection({required String title, required List<_ProfileItem> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
        ...items.map((item) => ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: (item.color ?? AppColors.primary).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              item.icon,
              color: item.color ?? AppColors.primary,
              size: 20,
            ),
          ),
          title: Text(
            item.title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: item.color,
            ),
          ),
          subtitle: item.subtitle != null
              ? Text(
                  item.subtitle!,
                  style: AppTypography.caption,
                )
              : null,
          trailing: item.color == null
              ? const Icon(Icons.chevron_right, color: Colors.grey)
              : null,
          onTap: item.onTap,
        )),
      ],
    );
  }
}

class _ProfileItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? color;
  final VoidCallback? onTap;

  const _ProfileItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.color,
    this.onTap,
  });
}
