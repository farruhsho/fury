import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../../../../app/theme/app_colors.dart';

/// Video circle recording widget with live camera preview
/// Shows real-time camera feed in a circular preview while recording
class VideoCircleRecorder extends StatefulWidget {
  final Function(File videoFile, int durationMs) onComplete;
  final VoidCallback onCancel;
  final bool isLocked;
  final Function(bool)? onLockChanged;

  const VideoCircleRecorder({
    super.key,
    required this.onComplete,
    required this.onCancel,
    this.isLocked = false,
    this.onLockChanged,
  });

  @override
  State<VideoCircleRecorder> createState() => _VideoCircleRecorderState();
}

class _VideoCircleRecorderState extends State<VideoCircleRecorder>
    with TickerProviderStateMixin {
  CameraController? _cameraController;
  bool _isCameraReady = false;
  bool _isRecording = false;
  bool _isLocked = false;
  bool _isCancelling = false;
  Duration _duration = Duration.zero;
  Timer? _durationTimer;
  String? _videoPath;

  // Animation controllers
  late AnimationController _pulseController;
  late AnimationController _trashController;
  late AnimationController _progressController;

  // Drag for gestures
  double _dragX = 0;
  double _dragY = 0;
  final double _cancelThreshold = -100;
  final double _lockThreshold = -80;

  @override
  void initState() {
    super.initState();
    _isLocked = widget.isLocked;

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _trashController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: const Duration(minutes: 1), // Max 1 minute video
      vsync: this,
    );

    _initCamera();
  }

  Future<void> _initCamera() async {
    // Video circle recording is not supported on web platform
    if (kIsWeb) {
      debugPrint('⚠️ [VIDEO_CIRCLE] Not supported on web platform');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video recording is not available on web')),
        );
      }
      widget.onCancel();
      return;
    }

    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        debugPrint('No cameras available');
        return;
      }

      // Prefer front camera for video circle (like selfie)
      final frontCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: true,
      );

      await _cameraController!.initialize();
      
      if (mounted) {
        setState(() => _isCameraReady = true);
        _startRecording();
      }
    } catch (e) {
      debugPrint('Camera init error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка камеры: $e')),
        );
      }
    }
  }

  Future<void> _startRecording() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      // Get path for video
      final tempDir = await getTemporaryDirectory();
      _videoPath = '${tempDir.path}/video_circle_${const Uuid().v4()}.mp4';

      await _cameraController!.startVideoRecording();
      
      setState(() => _isRecording = true);
      _pulseController.repeat(reverse: true);
      _progressController.forward();

      // Duration timer
      _durationTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        setState(() {
          _duration += const Duration(milliseconds: 100);
        });

        // Haptic every second
        if (_duration.inMilliseconds % 1000 == 0) {
          try {
            HapticFeedback.selectionClick();
          } catch (_) {}
        }

        // Max duration 60 seconds
        if (_duration.inSeconds >= 60) {
          _sendRecording();
        }
      });

      debugPrint('🎥 Video recording started');
    } catch (e) {
      debugPrint('❌ Error starting video: $e');
      widget.onCancel();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_isLocked) return;

    setState(() {
      _dragX += details.delta.dx;
      _dragY += details.delta.dy;
      _dragX = _dragX.clamp(_cancelThreshold * 1.5, 0);
      _dragY = _dragY.clamp(_lockThreshold * 1.5, 0);
    });

    // Check for lock
    if (_dragY < _lockThreshold && !_isLocked) {
      _lockRecording();
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_isLocked) return;

    if (_dragX < _cancelThreshold) {
      _cancelRecording();
    } else {
      setState(() {
        _dragX = 0;
        _dragY = 0;
      });
    }
  }

  void _lockRecording() {
    HapticFeedback.mediumImpact();
    setState(() {
      _isLocked = true;
      _dragX = 0;
      _dragY = 0;
    });
    widget.onLockChanged?.call(true);
  }

  Future<void> _cancelRecording() async {
    HapticFeedback.heavyImpact();
    setState(() => _isCancelling = true);

    await _trashController.forward();
    _durationTimer?.cancel();
    _pulseController.stop();
    _progressController.stop();

    try {
      if (_cameraController != null && _cameraController!.value.isRecordingVideo) {
        await _cameraController!.stopVideoRecording();
      }
    } catch (_) {}

    // Delete video file if exists
    if (_videoPath != null) {
      try {
        final file = File(_videoPath!);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (_) {}
    }

    widget.onCancel();
  }

  Future<void> _sendRecording() async {
    _durationTimer?.cancel();
    _pulseController.stop();
    _progressController.stop();

    try {
      if (_cameraController != null && _cameraController!.value.isRecordingVideo) {
        final videoFile = await _cameraController!.stopVideoRecording();
        
        widget.onComplete(
          File(videoFile.path),
          _duration.inMilliseconds,
        );
      }
    } catch (e) {
      debugPrint('Error stopping video: $e');
      widget.onCancel();
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _durationTimer?.cancel();
    _pulseController.dispose();
    _trashController.dispose();
    _progressController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isCancelling) {
      return _buildCancelAnimation();
    }

    return GestureDetector(
      onPanUpdate: _handleDragUpdate,
      onPanEnd: _handleDragEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            // Cancel indicator (swipe left)
            if (!_isLocked)
              Opacity(
                opacity: (_dragX.abs() / _cancelThreshold.abs()).clamp(0, 1),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.delete_outline, color: Colors.red, size: 24),
                    const SizedBox(width: 4),
                    Text('Отмена', style: TextStyle(color: Colors.red, fontSize: 12)),
                  ],
                ),
              ),

            // Camera preview circle
            Transform.translate(
              offset: Offset(_dragX * 0.3, 0),
              child: _buildCameraPreview(),
            ),

            const Spacer(),

            // Duration
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Recording indicator
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.5 + _pulseController.value * 0.5),
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDuration(_duration),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Lock indicator or Send/Cancel buttons
            if (_isLocked)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.red,
                    onPressed: _cancelRecording,
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: AppColors.primary,
                    onPressed: _sendRecording,
                  ),
                ],
              )
            else
              _buildLockIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraPreview() {
    final size = 100.0; // Bigger preview

    return Stack(
      alignment: Alignment.center,
      children: [
        // Progress ring
        SizedBox(
          width: size + 10,
          height: size + 10,
          child: AnimatedBuilder(
            animation: _progressController,
            builder: (context, child) {
              return CustomPaint(
                painter: _CircularProgressPainter(
                  progress: _progressController.value,
                  color: Colors.red,
                  strokeWidth: 4,
                ),
              );
            },
          ),
        ),

        // Camera preview in circle - properly scaled
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.red, width: 2),
          ),
          child: ClipOval(
            child: _isCameraReady && _cameraController != null
                ? OverflowBox(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: size,
                        height: size * _cameraController!.value.aspectRatio,
                        child: Transform.scale(
                          scaleX: -1, // Mirror front camera
                          child: CameraPreview(_cameraController!),
                        ),
                      ),
                    ),
                  )
                : Container(
                    color: Colors.grey.shade800,
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                  ),
          ),
        ),

        // Recording dot overlay
        Positioned(
          top: 0,
          right: 0,
          child: AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(_pulseController.value * 0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        
        // Send button always visible at bottom
        Positioned(
          bottom: -20,
          child: GestureDetector(
            onTap: _sendRecording,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLockIndicator() {
    final lockProgress = (_dragY.abs() / _lockThreshold.abs()).clamp(0.0, 1.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          lockProgress > 0.5 ? Icons.lock : Icons.lock_open,
          size: 20,
          color: Colors.white.withOpacity(0.5 + lockProgress * 0.5),
        ),
        const SizedBox(height: 2),
        Transform.translate(
          offset: Offset(0, -_dragY * 0.3),
          child: Icon(
            Icons.keyboard_arrow_up,
            size: 16,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }

  Widget _buildCancelAnimation() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ScaleTransition(
          scale: Tween(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(parent: _trashController, curve: Curves.easeIn),
          ),
          child: RotationTransition(
            turns: Tween(begin: 0.0, end: 0.25).animate(_trashController),
            child: Icon(Icons.delete, size: 48, color: Colors.red.shade400),
          ),
        ),
      ),
    );
  }
}

/// Circular progress painter for recording duration
class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _CircularProgressPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background circle
    final bgPaint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
