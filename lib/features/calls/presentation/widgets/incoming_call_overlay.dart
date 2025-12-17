import 'package:flutter/material.dart';
import '../../domain/entities/call_entity.dart';

/// Full-screen overlay for incoming calls (WhatsApp style)
class IncomingCallOverlay extends StatefulWidget {
  final CallEntity call;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final VoidCallback? onMessage;

  const IncomingCallOverlay({
    super.key,
    required this.call,
    required this.onAccept,
    required this.onDecline,
    this.onMessage,
  });

  @override
  State<IncomingCallOverlay> createState() => _IncomingCallOverlayState();
}

class _IncomingCallOverlayState extends State<IncomingCallOverlay>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rippleController;
  late AnimationController _slideController;
  late Animation<double> _pulseAnimation;

  double _declineSlide = 0;
  double _acceptSlide = 0;
  static const _slideThreshold = 100.0;

  @override
  void initState() {
    super.initState();

    // Pulse animation for avatar
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Ripple animation
    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    // Slide animation for buttons
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rippleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _onDeclineHorizontalDrag(DragUpdateDetails details) {
    setState(() {
      _declineSlide = (_declineSlide + details.delta.dx).clamp(-_slideThreshold, 0);
    });
  }

  void _onDeclineHorizontalDragEnd(DragEndDetails details) {
    if (_declineSlide.abs() >= _slideThreshold * 0.8) {
      widget.onDecline();
    } else {
      setState(() {
        _declineSlide = 0;
      });
    }
  }

  void _onAcceptHorizontalDrag(DragUpdateDetails details) {
    setState(() {
      _acceptSlide = (_acceptSlide + details.delta.dx).clamp(0, _slideThreshold);
    });
  }

  void _onAcceptHorizontalDragEnd(DragEndDetails details) {
    if (_acceptSlide >= _slideThreshold * 0.8) {
      widget.onAccept();
    } else {
      setState(() {
        _acceptSlide = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isVideo = widget.call.type == CallType.video ||
                    widget.call.type == CallType.groupVideo;

    return Material(
      color: const Color(0xFF0B141A),
      child: SafeArea(
        child: Stack(
          children: [
            // Background gradient
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF0B141A),
                      Color(0xFF1F2C33),
                      Color(0xFF0B141A),
                    ],
                  ),
                ),
              ),
            ),

            // Ripple effect behind avatar
            Positioned.fill(
              child: Center(
                child: AnimatedBuilder(
                  animation: _rippleController,
                  builder: (context, child) {
                    return CustomPaint(
                      size: const Size(300, 300),
                      painter: _RipplePainter(
                        progress: _rippleController.value,
                        color: const Color(0xFF00A884),
                      ),
                    );
                  },
                ),
              ),
            ),

            Column(
              children: [
                const SizedBox(height: 40),

                // Encryption indicator
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.lock,
                        color: Color(0xFF00A884),
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'End-to-end encrypted',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 1),

                // Pulsing avatar with ripple
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: child,
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF2A3942),
                      border: Border.all(
                        color: const Color(0xFF00A884).withValues(alpha: 0.5),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00A884).withValues(alpha: 0.3),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: widget.call.callerAvatarUrl != null
                          ? Image.network(
                              widget.call.callerAvatarUrl!,
                              width: 144,
                              height: 144,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _buildInitials(),
                            )
                          : _buildInitials(),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Caller name
                Text(
                  widget.call.callerName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 8),

                // Call type indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isVideo ? Icons.videocam : Icons.call,
                      color: Colors.grey[400],
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isVideo ? 'Incoming video call' : 'Incoming voice call',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                const Spacer(flex: 2),

                // Secondary action buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSecondaryButton(
                        icon: Icons.alarm,
                        label: 'Remind me',
                        onTap: () {
                          // TODO: Set reminder
                        },
                      ),
                      _buildSecondaryButton(
                        icon: Icons.message,
                        label: 'Message',
                        onTap: widget.onMessage,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Main action buttons with swipe hint
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Decline button with swipe
                      GestureDetector(
                        onHorizontalDragUpdate: _onDeclineHorizontalDrag,
                        onHorizontalDragEnd: _onDeclineHorizontalDragEnd,
                        child: Transform.translate(
                          offset: Offset(_declineSlide, 0),
                          child: _buildMainActionButton(
                            icon: Icons.call_end,
                            color: const Color(0xFFEA4335),
                            onTap: widget.onDecline,
                            showSwipeHint: true,
                            swipeDirection: 'left',
                          ),
                        ),
                      ),

                      // Accept button with swipe
                      GestureDetector(
                        onHorizontalDragUpdate: _onAcceptHorizontalDrag,
                        onHorizontalDragEnd: _onAcceptHorizontalDragEnd,
                        child: Transform.translate(
                          offset: Offset(_acceptSlide, 0),
                          child: _buildMainActionButton(
                            icon: isVideo ? Icons.videocam : Icons.call,
                            color: const Color(0xFF00A884),
                            onTap: widget.onAccept,
                            showSwipeHint: true,
                            swipeDirection: 'right',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Swipe instructions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Swipe left to decline',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Swipe right to accept',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitials() {
    final name = widget.call.callerName;
    final initials = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Container(
      color: const Color(0xFF2A3942),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 64,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool showSwipeHint = false,
    String swipeDirection = 'right',
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        if (showSwipeHint) ...[
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (swipeDirection == 'left')
                Icon(Icons.chevron_left, color: Colors.grey[600], size: 16),
              Icon(
                swipeDirection == 'left' ? Icons.chevron_left : Icons.chevron_right,
                color: Colors.grey[500],
                size: 16,
              ),
              if (swipeDirection == 'right')
                Icon(Icons.chevron_right, color: Colors.grey[600], size: 16),
            ],
          ),
        ],
      ],
    );
  }
}

/// Custom painter for ripple effect
class _RipplePainter extends CustomPainter {
  final double progress;
  final Color color;

  _RipplePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    for (int i = 0; i < 3; i++) {
      final rippleProgress = (progress + (i * 0.33)) % 1.0;
      final radius = maxRadius * rippleProgress;
      final opacity = (1.0 - rippleProgress) * 0.3;

      final paint = Paint()
        ..color = color.withValues(alpha: opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(_RipplePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// Shows incoming call overlay as a dialog
void showIncomingCallOverlay({
  required BuildContext context,
  required CallEntity call,
  required Function(String callId) onAccept,
  required Function(String callId) onDecline,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    builder: (context) => IncomingCallOverlay(
      call: call,
      onAccept: () {
        Navigator.of(context).pop();
        onAccept(call.id);
      },
      onDecline: () {
        Navigator.of(context).pop();
        onDecline(call.id);
      },
    ),
  );
}
