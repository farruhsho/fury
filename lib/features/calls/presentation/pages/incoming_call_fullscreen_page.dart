import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/incoming_call_listener_service.dart';

/// Full-screen incoming call page that shows when app is in background
/// This page is launched when a high-priority FCM notification is received
class IncomingCallFullscreenPage extends StatefulWidget {
  final String callId;
  final String callerName;
  final String? callerAvatar;
  final bool isVideo;

  const IncomingCallFullscreenPage({
    super.key,
    required this.callId,
    required this.callerName,
    this.callerAvatar,
    this.isVideo = false,
  });

  @override
  State<IncomingCallFullscreenPage> createState() => _IncomingCallFullscreenPageState();
}

class _IncomingCallFullscreenPageState extends State<IncomingCallFullscreenPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    // Set system UI for full screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    
    // Pulse animation for answer button
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _answerCall() {
    // Navigate to call page
    context.go('/call/${widget.callId}?isVideo=${widget.isVideo}&callerName=${Uri.encodeComponent(widget.callerName)}');
  }

  void _declineCall() async {
    // Decline the call
    final callListener = IncomingCallListenerService();
    await callListener.declineCall(widget.callId);
    
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF0F0F1A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              
              // Call type indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.isVideo ? Icons.videocam : Icons.phone,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.isVideo ? 'Incoming Video Call' : 'Incoming Voice Call',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Caller avatar
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: widget.callerAvatar != null
                    ? CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(widget.callerAvatar!),
                      )
                    : Center(
                        child: Text(
                          widget.callerName.isNotEmpty
                              ? widget.callerName[0].toUpperCase()
                              : '?',
                          style: const TextStyle(
                            fontSize: 56,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
              
              const SizedBox(height: 24),
              
              // Caller name
              Text(
                widget.callerName,
                style: AppTypography.h2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Status text
              Text(
                'is calling you...',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              
              const Spacer(),
              
              // Call action buttons
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Decline button
                    _buildActionButton(
                      icon: Icons.call_end,
                      color: Colors.red,
                      label: 'Decline',
                      onTap: _declineCall,
                    ),
                    
                    // Answer button with pulse animation
                    ScaleTransition(
                      scale: _pulseAnimation,
                      child: _buildActionButton(
                        icon: widget.isVideo ? Icons.videocam : Icons.call,
                        color: Colors.green,
                        label: 'Answer',
                        onTap: _answerCall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 16,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
