import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Advanced recording widget with swipe gestures for voice/video messages
/// Supports:
/// - Hold to record voice/video
/// - Swipe left to cancel (with trash animation)
/// - Swipe up to lock recording
/// - Video circle (round video messages)
class RecordingWidget extends StatefulWidget {
  final RecordingType type;
  final Function(File file, int durationMs, List<double>? waveform) onComplete;
  final VoidCallback onCancel;
  final bool isLocked;
  final Function(bool)? onLockChanged;

  const RecordingWidget({
    super.key,
    required this.type,
    required this.onComplete,
    required this.onCancel,
    this.isLocked = false,
    this.onLockChanged,
  });

  @override
  State<RecordingWidget> createState() => _RecordingWidgetState();
}

enum RecordingType { voice, videoCircle }

class _RecordingWidgetState extends State<RecordingWidget> 
    with TickerProviderStateMixin {
  // Recording state
  bool _isRecording = false;
  bool _isLocked = false;
  bool _isCancelling = false;
  Duration _duration = Duration.zero;
  Timer? _durationTimer;
  String? _recordingPath;
  
  // Animation controllers
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late AnimationController _trashController;
  late AnimationController _lockController;
  
  // Waveform for voice
  final List<double> _waveform = [];
  
  // Audio recorder for voice messages
  AudioRecorder? _audioRecorder;
  StreamSubscription<Amplitude>? _amplitudeSubscription;
  
  // Drag position
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
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _trashController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _lockController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _startRecording();
  }

  @override
  void dispose() {
    _durationTimer?.cancel();
    _amplitudeSubscription?.cancel();
    _audioRecorder?.dispose();
    _pulseController.dispose();
    _slideController.dispose();
    _trashController.dispose();
    _lockController.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    try {
      if (!kIsWeb) {
        try {
          final tempDir = await getTemporaryDirectory();
          final ext = widget.type == RecordingType.voice ? 'm4a' : 'mp4';
          _recordingPath = '${tempDir.path}/recording_${const Uuid().v4()}.$ext';
        } catch (e) {
          print('📁 [RECORDING] path_provider not available, using fallback');
          _recordingPath = '/tmp/recording_${const Uuid().v4()}.${widget.type == RecordingType.voice ? 'm4a' : 'mp4'}';
        }
      } else {
        _recordingPath = 'recording_${const Uuid().v4()}.${widget.type == RecordingType.voice ? 'm4a' : 'mp4'}';
      }
      
      // Start actual audio recording for voice messages
      if (widget.type == RecordingType.voice && !kIsWeb) {
        _audioRecorder = AudioRecorder();
        if (await _audioRecorder!.hasPermission()) {
          await _audioRecorder!.start(
            const RecordConfig(
              encoder: AudioEncoder.aacLc,
              bitRate: 128000,
              sampleRate: 44100,
            ),
            path: _recordingPath!,
          );
          
          // Listen to amplitude for real waveform
          _amplitudeSubscription = _audioRecorder!.onAmplitudeChanged(
            const Duration(milliseconds: 100),
          ).listen((amplitude) {
            if (mounted) {
              setState(() {
                final normalized = ((amplitude.current + 60) / 60).clamp(0.0, 1.0);
                _waveform.add(normalized);
              });
            }
          });
        }
      }
      
      if (!mounted) return;
      setState(() => _isRecording = true);
      _pulseController.repeat(reverse: true);
      HapticFeedback.mediumImpact();
      
      // Start duration timer
      _durationTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        setState(() {
          _duration += const Duration(milliseconds: 100);
        });
        
        // Haptic every second
        if (_duration.inMilliseconds % 1000 == 0 && !kIsWeb) {
          HapticFeedback.selectionClick();
        }
      });
      
      print('🎤 [RECORDING] Started ${widget.type.name} recording');
      
    } catch (e) {
      print('❌ [RECORDING] Error starting: $e');
      if (mounted) {
        widget.onCancel();
      }
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_isLocked) return;
    
    setState(() {
      _dragX += details.delta.dx;
      _dragY += details.delta.dy;
      
      // Clamp values
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
      // Snap back
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
    _lockController.forward();
    widget.onLockChanged?.call(true);
  }

  Future<void> _cancelRecording() async {
    HapticFeedback.heavyImpact();
    setState(() => _isCancelling = true);
    
    await _trashController.forward();
    
    // Delete recording file
    if (_recordingPath != null) {
      try {
        final file = File(_recordingPath!);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        print('Warning: Could not delete recording file: $e');
      }
    }
    
    widget.onCancel();
  }

  Future<void> _sendRecording() async {
    _durationTimer?.cancel();
    _amplitudeSubscription?.cancel();
    _pulseController.stop();
    
    // Check minimum duration
    if (_duration.inMilliseconds < 500) {
      print('⚠️ [RECORDING] Too short, cancelling');
      _cancelRecording();
      return;
    }
    
    // Stop actual recording
    String? finalPath;
    if (_audioRecorder != null) {
      try {
        finalPath = await _audioRecorder!.stop();
        await _audioRecorder!.dispose();
        _audioRecorder = null;
      } catch (e) {
        print('❌ [RECORDING] Error stopping: $e');
      }
    }
    
    HapticFeedback.heavyImpact();
    
    final path = finalPath ?? _recordingPath;
    if (path != null) {
      final file = File(path);
      if (await file.exists()) {
        widget.onComplete(
          file,
          _duration.inMilliseconds,
          widget.type == RecordingType.voice ? _waveform.toList() : null,
        );
      } else {
        print('❌ [RECORDING] File does not exist: $path');
        widget.onCancel();
      }
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    if (_isCancelling) {
      return _buildCancellingAnimation();
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          // Slide hint (swipe left to cancel)
          if (!_isLocked)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Opacity(
                opacity: (_dragX.abs() / _cancelThreshold.abs()).clamp(0, 1),
                child: Row(
                  children: [
                    ScaleTransition(
                      scale: Tween(begin: 0.5, end: 1.2).animate(
                        CurvedAnimation(
                          parent: _trashController,
                          curve: Curves.easeOut,
                        ),
                      ),
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.red.shade700,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red.shade700),
                    ),
                  ],
                ),
              ),
            ),
          
          // Main content
          Transform.translate(
            offset: Offset(_dragX, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Recording indicator
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(
                          0.5 + (_pulseController.value * 0.5),
                        ),
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
                
                // Duration
                Text(
                  _formatDuration(_duration),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
                
                // Waveform or video preview
                if (widget.type == RecordingType.voice)
                  Expanded(
                    child: Container(
                      height: 32,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomPaint(
                        painter: _WaveformPainter(
                          waveform: _waveform.length > 50
                              ? _waveform.sublist(_waveform.length - 50)
                              : _waveform,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.red, width: 3),
                        ),
                        child: const Icon(
                          Icons.videocam,
                          color: Colors.red,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                
                // Lock indicator or Send button
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
        ],
      ),
    );
  }

  Widget _buildLockIndicator() {
    final lockProgress = (_dragY.abs() / _lockThreshold.abs()).clamp(0.0, 1.0);
    
    return Container(
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            lockProgress > 0.5 ? Icons.lock : Icons.lock_open,
            size: 20,
            color: Colors.red.withOpacity(0.5 + (lockProgress * 0.5)),
          ),
          const SizedBox(height: 2),
          Transform.translate(
            offset: Offset(0, -_dragY * 0.3),
            child: Icon(
              Icons.keyboard_arrow_up,
              size: 16,
              color: Colors.red.shade300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancellingAnimation() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ScaleTransition(
          scale: Tween(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(
              parent: _trashController,
              curve: Curves.easeIn,
            ),
          ),
          child: RotationTransition(
            turns: Tween(begin: 0.0, end: 0.25).animate(_trashController),
            child: Icon(
              Icons.delete,
              size: 48,
              color: Colors.red.shade400,
            ),
          ),
        ),
      ),
    );
  }
}

/// Waveform painter for voice recording visualization
class _WaveformPainter extends CustomPainter {
  final List<double> waveform;
  final Color color;

  _WaveformPainter({required this.waveform, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (waveform.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final barWidth = size.width / waveform.length;
    final maxHeight = size.height / 2;

    for (int i = 0; i < waveform.length; i++) {
      final x = i * barWidth + barWidth / 2;
      final barHeight = waveform[i] * maxHeight;
      
      canvas.drawLine(
        Offset(x, size.height / 2 - barHeight),
        Offset(x, size.height / 2 + barHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _WaveformPainter oldDelegate) {
    return waveform.length != oldDelegate.waveform.length;
  }
}

/// Camera button with hold-to-record video circle functionality
class CameraRecordButton extends StatefulWidget {
  final VoidCallback onTap;
  final Function(File videoFile, int durationMs)? onVideoRecorded;
  final VoidCallback? onRecordingStart;
  final VoidCallback? onRecordingCancel;
  final Color color;
  final double size;

  const CameraRecordButton({
    super.key,
    required this.onTap,
    this.onVideoRecorded,
    this.onRecordingStart,
    this.onRecordingCancel,
    this.color = AppColors.primary,
    this.size = 44,
  });

  @override
  State<CameraRecordButton> createState() => _CameraRecordButtonState();
}

class _CameraRecordButtonState extends State<CameraRecordButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  bool _isRecording = false;
  Timer? _holdTimer;
  late AnimationController _scaleController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
      lowerBound: 0.9,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _holdTimer?.cancel();
    _scaleController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _scaleController.reverse();
    
    // Start a timer for hold detection
    _holdTimer = Timer(const Duration(milliseconds: 300), () {
      if (_isPressed) {
        _startVideoRecording();
      }
    });
  }

  void _onTapUp(TapUpDetails details) {
    _holdTimer?.cancel();
    _scaleController.forward();
    
    if (!_isRecording) {
      // Was a tap, not a hold
      widget.onTap();
    }
    
    setState(() => _isPressed = false);
  }

  void _onTapCancel() {
    _holdTimer?.cancel();
    _scaleController.forward();
    
    // Schedule state update for after the current frame to avoid
    // calling setState while the widget tree is locked
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() => _isPressed = false);
      
      if (_isRecording) {
        widget.onRecordingCancel?.call();
        setState(() => _isRecording = false);
      }
    });
  }

  void _startVideoRecording() {
    HapticFeedback.mediumImpact();
    setState(() => _isRecording = true);
    widget.onRecordingStart?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleController,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: _isRecording ? Colors.red : widget.color,
            shape: BoxShape.circle,
            boxShadow: _isPressed
                ? [
                    BoxShadow(
                      color: (_isRecording ? Colors.red : widget.color)
                          .withOpacity(0.4),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Icon(
            _isRecording ? Icons.stop : Icons.camera_alt,
            color: Colors.white,
            size: widget.size * 0.5,
          ),
        ),
      ),
    );
  }
}

/// Media picker bottom sheet with one-time view option
class MediaPickerSheet extends StatelessWidget {
  final Function(XFile image, {bool isOneTime}) onImagePicked;
  final Function(XFile video, {bool isOneTime}) onVideoPicked;
  final VoidCallback? onLocationTap;
  final VoidCallback? onCameraTap;

  const MediaPickerSheet({
    super.key,
    required this.onImagePicked,
    required this.onVideoPicked,
    this.onLocationTap,
    this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          
          // Title
          const Text(
            'Share Media',
            style: AppTypography.h3,
          ),
          const SizedBox(height: 20),
          
          // Options grid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOption(
                context,
                icon: Icons.camera_alt,
                label: 'Camera',
                color: Colors.pink,
                onTap: () {
                  Navigator.pop(context);
                  onCameraTap?.call();
                },
              ),
              _buildOption(
                context,
                icon: Icons.photo,
                label: 'Photo',
                color: Colors.purple,
                onTap: () => _pickImage(context, false),
              ),
              _buildOption(
                context,
                icon: Icons.videocam,
                label: 'Video',
                color: Colors.red,
                onTap: () => _pickVideo(context, false),
              ),
              _buildOption(
                context,
                icon: Icons.location_on,
                label: 'Location',
                color: Colors.green,
                onTap: () {
                  Navigator.pop(context);
                  onLocationTap?.call();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // One-time view options
          const Divider(),
          const SizedBox(height: 8),
          Text(
            'Disappearing Media',
            style: AppTypography.caption.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOption(
                context,
                icon: Icons.visibility_off,
                label: 'Photo (1x)',
                color: Colors.orange,
                onTap: () => _pickImage(context, true),
              ),
              _buildOption(
                context,
                icon: Icons.videocam_off,
                label: 'Video (1x)',
                color: Colors.deepOrange,
                onTap: () => _pickVideo(context, true),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTypography.caption,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context, bool isOneTime) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null && context.mounted) {
      Navigator.pop(context);
      onImagePicked(image, isOneTime: isOneTime);
    }
  }

  Future<void> _pickVideo(BuildContext context, bool isOneTime) async {
    final picker = ImagePicker();
    final video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null && context.mounted) {
      Navigator.pop(context);
      onVideoPicked(video, isOneTime: isOneTime);
    }
  }
}
