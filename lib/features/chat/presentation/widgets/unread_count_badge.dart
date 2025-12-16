import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

/// Badge for displaying unread message count
class UnreadCountBadge extends StatelessWidget {
  final int count;
  final bool isMuted;
  final double size;

  const UnreadCountBadge({
    super.key,
    required this.count,
    this.isMuted = false,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();

    final displayCount = count > 99 ? '99+' : count.toString();
    final backgroundColor = isMuted ? Colors.grey : AppColors.primary;

    return Container(
      height: size,
      constraints: BoxConstraints(
        minWidth: size,
        maxWidth: size * 2,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size / 2),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: count > 9 ? 6 : 0,
      ),
      child: Center(
        child: Text(
          displayCount,
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.55,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// Animated unread count badge
class AnimatedUnreadBadge extends StatefulWidget {
  final int count;
  final bool isMuted;

  const AnimatedUnreadBadge({
    super.key,
    required this.count,
    this.isMuted = false,
  });

  @override
  State<AnimatedUnreadBadge> createState() => _AnimatedUnreadBadgeState();
}

class _AnimatedUnreadBadgeState extends State<AnimatedUnreadBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  int _previousCount = 0;

  @override
  void initState() {
    super.initState();
    _previousCount = widget.count;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.3),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.3, end: 1.0),
        weight: 50,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(AnimatedUnreadBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.count > _previousCount) {
      _controller.forward(from: 0);
    }
    _previousCount = widget.count;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: UnreadCountBadge(
            count: widget.count,
            isMuted: widget.isMuted,
          ),
        );
      },
    );
  }
}

/// Total unread badge for app icon (all chats)
class TotalUnreadBadge extends StatelessWidget {
  final int totalUnread;

  const TotalUnreadBadge({
    super.key,
    required this.totalUnread,
  });

  @override
  Widget build(BuildContext context) {
    if (totalUnread <= 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        totalUnread > 999 ? '999+' : totalUnread.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
