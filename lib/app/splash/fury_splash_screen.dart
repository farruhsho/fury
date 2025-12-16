import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';

/// 🔥 Fury Chat Animated Splash Screen
/// Neon flame animation with glass effects
class FurySplashScreen extends StatefulWidget {
  const FurySplashScreen({super.key});

  @override
  State<FurySplashScreen> createState() => _FurySplashScreenState();
}

class _FurySplashScreenState extends State<FurySplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _ringController;
  late AnimationController _flameController;
  late AnimationController _textController;
  late AnimationController _pulseController;
  late AnimationController _transitionController;

  late Animation<double> _ringOpacity;
  late Animation<double> _ringRotation;
  late Animation<double> _flameScale;
  late Animation<double> _flameOpacity;
  late Animation<double> _textOpacity;
  late Animation<double> _textOffset;
  late Animation<double> _pulseScale;
  late Animation<double> _transitionSlide;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimationSequence();
  }

  void _setupAnimations() {
    // Ring animation (0.3s - 0.8s)
    _ringController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _ringOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ringController, curve: Curves.easeIn),
    );
    _ringRotation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _ringController, curve: Curves.easeInOutCubic),
    );

    // Flame animation (0.8s - 2.0s)
    _flameController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _flameScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flameController, curve: Curves.easeOutBack),
    );
    _flameOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flameController, curve: Curves.easeOut),
    );

    // Text animation (2.0s - 2.9s)
    _textController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _textOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );
    _textOffset = Tween<double>(begin: 20, end: 0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.elasticOut),
    );

    // Pulse animation (2.9s - 3.3s)
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _pulseScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.08), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.08, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));

    // Transition animation (3.3s - 3.5s)
    _transitionController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _transitionSlide = Tween<double>(begin: 0, end: -1).animate(
      CurvedAnimation(parent: _transitionController, curve: Curves.easeInQuart),
    );
  }

  Future<void> _startAnimationSequence() async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Phase 1: Ring appears
    _ringController.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    
    // Phase 2: Flame emerges
    _flameController.forward();
    await Future.delayed(const Duration(milliseconds: 600));
    
    // Phase 3: Text appears
    _textController.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Phase 4: Pulse
    await _pulseController.forward();
    await _pulseController.reverse();
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Phase 5: Transition
    _transitionController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Navigate to home
    if (mounted) {
      context.go('/home');
    }
  }

  @override
  void dispose() {
    _ringController.dispose();
    _flameController.dispose();
    _textController.dispose();
    _pulseController.dispose();
    _transitionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FuryColors.deepBlack,
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _ringController,
          _flameController,
          _textController,
          _pulseController,
          _transitionController,
        ]),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              _transitionSlide.value * MediaQuery.of(context).size.width,
              0,
            ),
            child: Stack(
              children: [
                // Background particles
                _buildBackgroundParticles(),
                
                // Main content
                Center(
                  child: Transform.scale(
                    scale: _pulseScale.value,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo with ring
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // Glow ring
                            _buildNeonRing(),
                            
                            // Flame logo
                            _buildFlameLogo(),
                          ],
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // App name
                        _buildAppName(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBackgroundParticles() {
    return CustomPaint(
      painter: _ParticlesPainter(
        progress: _flameController.value,
        color: FuryColors.neonPink,
      ),
      size: Size.infinite,
    );
  }

  Widget _buildNeonRing() {
    return Opacity(
      opacity: _ringOpacity.value,
      child: Transform.rotate(
        angle: _ringRotation.value,
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: FuryColors.neonPink.withValues(alpha: 0.6),
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: FuryColors.neonPink.withValues(alpha: 0.4),
                blurRadius: 30,
                spreadRadius: 5,
              ),
              BoxShadow(
                color: FuryColors.electricPurple.withValues(alpha: 0.3),
                blurRadius: 50,
                spreadRadius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlameLogo() {
    return Opacity(
      opacity: _flameOpacity.value,
      child: Transform.scale(
        scale: _flameScale.value,
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: FuryColors.flameGradient,
            boxShadow: [
              BoxShadow(
                color: FuryColors.neonPink.withValues(alpha: 0.5),
                blurRadius: 40,
                spreadRadius: 5,
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.local_fire_department,
              size: 64,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppName() {
    return Opacity(
      opacity: _textOpacity.value,
      child: Transform.translate(
        offset: Offset(0, _textOffset.value),
        child: Column(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => FuryColors.flameGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: const Text(
                'FURY',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 8,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'CHAT',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                letterSpacing: 12,
                color: FuryColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom painter for background particles
class _ParticlesPainter extends CustomPainter {
  final double progress;
  final Color color;

  _ParticlesPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42);
    final paint = Paint()
      ..color = color.withValues(alpha: 0.3 * progress)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 20; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 3 + 1;
      
      canvas.drawCircle(
        Offset(x, y + (1 - progress) * 100),
        radius * progress,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlesPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
