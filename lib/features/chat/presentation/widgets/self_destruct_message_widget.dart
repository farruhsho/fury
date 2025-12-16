import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Widget for displaying self-destructing message countdown
class SelfDestructingMessageWidget extends StatefulWidget {
  final DateTime expiresAt;
  final Widget child;
  final VoidCallback? onExpired;

  const SelfDestructingMessageWidget({
    super.key,
    required this.expiresAt,
    required this.child,
    this.onExpired,
  });

  @override
  State<SelfDestructingMessageWidget> createState() => _SelfDestructingMessageWidgetState();
}

class _SelfDestructingMessageWidgetState extends State<SelfDestructingMessageWidget>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  Duration _remaining = Duration.zero;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _updateRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateRemaining());
    
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  void _updateRemaining() {
    final now = DateTime.now();
    final remaining = widget.expiresAt.difference(now);
    
    if (remaining.isNegative) {
      _timer?.cancel();
      widget.onExpired?.call();
      return;
    }
    
    if (mounted) {
      setState(() => _remaining = remaining);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  String _formatRemaining() {
    if (_remaining.inDays > 0) {
      return '${_remaining.inDays}d ${_remaining.inHours % 24}h';
    } else if (_remaining.inHours > 0) {
      return '${_remaining.inHours}h ${_remaining.inMinutes % 60}m';
    } else if (_remaining.inMinutes > 0) {
      return '${_remaining.inMinutes}m ${_remaining.inSeconds % 60}s';
    } else {
      return '${_remaining.inSeconds}s';
    }
  }

  Color _getTimerColor() {
    if (_remaining.inMinutes < 1) {
      return Colors.red;
    } else if (_remaining.inMinutes < 5) {
      return Colors.orange;
    } else {
      return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUrgent = _remaining.inMinutes < 1;
    
    return Stack(
      children: [
        // Message content
        widget.child,
        
        // Self-destruct indicator
        Positioned(
          top: 4,
          right: 4,
          child: AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _getTimerColor().withOpacity(
                    isUrgent ? 0.3 + (_pulseController.value * 0.3) : 0.2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 12,
                      color: _getTimerColor(),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatRemaining(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getTimerColor(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Dialog for setting self-destruct timer
class SelfDestructTimerDialog extends StatelessWidget {
  const SelfDestructTimerDialog({super.key});

  static Future<Duration?> show(BuildContext context) async {
    return showModalBottomSheet<Duration>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const SelfDestructTimerDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.timer, color: AppColors.primary),
                const SizedBox(width: 12),
                Text(
                  'Self-destruct timer',
                  style: AppTypography.h3,
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          _timerOption(context, 'Off', null),
          _timerOption(context, '5 seconds', const Duration(seconds: 5)),
          _timerOption(context, '30 seconds', const Duration(seconds: 30)),
          _timerOption(context, '1 minute', const Duration(minutes: 1)),
          _timerOption(context, '5 minutes', const Duration(minutes: 5)),
          _timerOption(context, '1 hour', const Duration(hours: 1)),
          _timerOption(context, '24 hours', const Duration(hours: 24)),
          _timerOption(context, '7 days', const Duration(days: 7)),
          
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
        ],
      ),
    );
  }

  Widget _timerOption(BuildContext context, String label, Duration? duration) {
    return ListTile(
      leading: Icon(
        duration == null ? Icons.timer_off : Icons.timer,
        color: duration == null ? Colors.grey : AppColors.primary,
      ),
      title: Text(label, style: AppTypography.bodyMedium),
      onTap: () => Navigator.pop(context, duration),
    );
  }
}

/// One-time view message indicator
class OneTimeViewBadge extends StatelessWidget {
  final bool isViewed;
  
  const OneTimeViewBadge({
    super.key,
    this.isViewed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isViewed ? Colors.grey.withOpacity(0.2) : Colors.orange.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isViewed ? Icons.visibility_off : Icons.visibility,
            size: 14,
            color: isViewed ? Colors.grey : Colors.orange,
          ),
          const SizedBox(width: 4),
          Text(
            isViewed ? 'Viewed' : 'View once',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isViewed ? Colors.grey : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}

/// Blur widget for one-time view content
class OneTimeViewContent extends StatefulWidget {
  final Widget child;
  final bool isViewed;
  final VoidCallback? onView;

  const OneTimeViewContent({
    super.key,
    required this.child,
    this.isViewed = false,
    this.onView,
  });

  @override
  State<OneTimeViewContent> createState() => _OneTimeViewContentState();
}

class _OneTimeViewContentState extends State<OneTimeViewContent> {
  bool _isRevealed = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isViewed) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.visibility_off, size: 32, color: Colors.grey),
            const SizedBox(height: 8),
            Text(
              'Media expired',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    if (!_isRevealed) {
      return GestureDetector(
        onTap: () {
          setState(() => _isRevealed = true);
          widget.onView?.call();
        },
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange.withOpacity(0.3)),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.touch_app, size: 32, color: Colors.orange),
              SizedBox(height: 8),
              Text(
                'Tap to view once',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return widget.child;
  }
}
