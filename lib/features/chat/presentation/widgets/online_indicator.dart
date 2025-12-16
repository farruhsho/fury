import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../app/theme/app_colors.dart';

/// Real-time online indicator that listens to Firestore
class OnlineIndicator extends StatefulWidget {
  final String? userId;
  final bool? isOnline; // Optional static value
  final double size;

  const OnlineIndicator({
    super.key,
    this.userId,
    this.isOnline,
    this.size = 12,
  });

  @override
  State<OnlineIndicator> createState() => _OnlineIndicatorState();
}

class _OnlineIndicatorState extends State<OnlineIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  StreamSubscription? _subscription;
  bool _isOnline = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Use static value if provided, otherwise listen to Firestore
    if (widget.isOnline != null) {
      _isOnline = widget.isOnline!;
    } else if (widget.userId != null) {
      _listenToPresence();
    }
  }

  void _listenToPresence() {
    _subscription = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId!)
        .snapshots()
        .listen((snapshot) {
      if (mounted && snapshot.exists) {
        final data = snapshot.data();
        final isOnline = data?['isOnline'] as bool? ?? false;
        if (isOnline != _isOnline) {
          setState(() => _isOnline = isOnline);
        }
      }
    });
  }

  @override
  void didUpdateWidget(OnlineIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Handle static value changes
    if (widget.isOnline != null) {
      if (widget.isOnline != _isOnline) {
        setState(() => _isOnline = widget.isOnline!);
      }
    }
    
    // Handle userId changes
    if (widget.userId != oldWidget.userId) {
      _subscription?.cancel();
      if (widget.userId != null && widget.isOnline == null) {
        _listenToPresence();
      }
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isOnline) {
      return Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[400],
          border: Border.all(color: Colors.white, width: 1.5),
        ),
      );
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green.withOpacity(0.8 + (_animation.value * 0.2)),
            border: Border.all(color: Colors.white, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(_animation.value * 0.5),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Status text widget showing online/last seen
class UserStatusText extends StatelessWidget {
  final String userId;
  final TextStyle? style;

  const UserStatusText({
    super.key,
    required this.userId,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('Offline', style: style ?? _defaultStyle(context));
        }

        final data = snapshot.data!.data() as Map<String, dynamic>?;
        final isOnline = data?['isOnline'] as bool? ?? false;
        final lastSeen = (data?['lastSeen'] as Timestamp?)?.toDate();

        if (isOnline) {
          return Text(
            'Online',
            style: (style ?? _defaultStyle(context)).copyWith(
              color: AppColors.success,
            ),
          );
        }

        final statusText = _getLastSeenText(lastSeen);
        return Text(statusText, style: style ?? _defaultStyle(context));
      },
    );
  }

  TextStyle _defaultStyle(BuildContext context) {
    return TextStyle(
      fontSize: 12,
      color: Colors.grey[600],
    );
  }

  String _getLastSeenText(DateTime? lastSeen) {
    if (lastSeen == null) return 'Offline';

    final now = DateTime.now();
    final diff = now.difference(lastSeen);

    if (diff.inMinutes < 1) return 'Last seen just now';
    if (diff.inMinutes < 60) return 'Last seen ${diff.inMinutes}m ago';
    if (diff.inHours < 24) return 'Last seen ${diff.inHours}h ago';
    if (diff.inDays < 7) return 'Last seen ${diff.inDays}d ago';
    return 'Last seen a while ago';
  }
}
