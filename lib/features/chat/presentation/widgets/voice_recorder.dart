import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import '../../../../app/theme/app_colors.dart';

/// Voice message recorder widget with waveform visualization
/// FIXED: Now uses actual audio recording
class VoiceRecorder extends StatefulWidget {
  final Function(File audioFile, int durationMs, List<double> waveform) onRecordingComplete;
  final VoidCallback? onCancel;
  final Duration maxDuration;
  final Duration minDuration;

  const VoiceRecorder({
    super.key,
    required this.onRecordingComplete,
    this.onCancel,
    this.maxDuration = const Duration(minutes: 5),
    this.minDuration = const Duration(milliseconds: 500),
  });

  @override
  State<VoiceRecorder> createState() => _VoiceRecorderState();
}

class _VoiceRecorderState extends State<VoiceRecorder> with TickerProviderStateMixin {
  final AudioRecorder _audioRecorder = AudioRecorder();
  
  bool _isRecording = false;
  bool _isLocked = false;
  bool _isCancelling = false;
  bool _hasPermission = false;
  Duration _recordingDuration = Duration.zero;
  Timer? _durationTimer;
  final List<double> _waveform = [];
  String? _recordingPath;
  late AnimationController _pulseController;
  late AnimationController _trashController;
  StreamSubscription<Amplitude>? _amplitudeSubscription;

  // Drag logic
  double _dragX = 0;
  final double _cancelThreshold = -100;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _trashController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _checkPermissions();
  }

  @override
  void dispose() {
    _durationTimer?.cancel();
    _amplitudeSubscription?.cancel();
    _pulseController.dispose();
    _trashController.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  Future<void> _checkPermissions() async {
    _hasPermission = await _audioRecorder.hasPermission();
    if (!_hasPermission) {
      final status = await Permission.microphone.request();
      _hasPermission = status.isGranted;
    }
  }

  Future<void> _startRecording() async {
    // Voice recording is not supported on web platform
    if (kIsWeb) {
      debugPrint('⚠️ [VOICE_RECORDER] Not supported on web platform');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Voice recording is not available on web')),
        );
      }
      return;
    }

    if (!_hasPermission) {
      await _checkPermissions();
      if (!_hasPermission) return;
    }

    HapticFeedback.mediumImpact();

    final tempDir = await getTemporaryDirectory();
    final fileName = 'voice_${const Uuid().v4()}.m4a';
    _recordingPath = '${tempDir.path}/$fileName';

    try {
      await _audioRecorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc, bitRate: 128000, sampleRate: 44100),
        path: _recordingPath!,
      );

      setState(() {
        _isRecording = true;
        _isLocked = false;
        _isCancelling = false;
        _recordingDuration = Duration.zero;
        _waveform.clear();
        _dragX = 0;
      });

      _pulseController.repeat(reverse: true);
      
      _amplitudeSubscription = _audioRecorder.onAmplitudeChanged(const Duration(milliseconds: 100)).listen((amplitude) {
        if (mounted) {
          setState(() {
            final normalized = ((amplitude.current + 60) / 60).clamp(0.0, 1.0);
            _waveform.add(normalized);
          });
        }
      });

      _durationTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (mounted) {
          setState(() {
            _recordingDuration += const Duration(milliseconds: 100);
          });
          
          if (_recordingDuration >= widget.maxDuration) {
            _stopAndSend();
          }
          
          if (_recordingDuration.inMilliseconds % 1000 == 0) {
            HapticFeedback.selectionClick();
          }
        }
      });

    } catch (e) {
      debugPrint('❌ [VOICE_RECORDER] Start failed: $e');
    }
  }

  Future<void> _stopAndSend() async {
    if (!_isRecording) return;
    
    _durationTimer?.cancel();
    _amplitudeSubscription?.cancel();
    _pulseController.stop();

    if (_recordingDuration < widget.minDuration) {
      _cancelRecording();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Recording too short')));
      }
      return;
    }

    try {
      final path = await _audioRecorder.stop();
      setState(() => _isRecording = false);
      HapticFeedback.heavyImpact();

      if (path != null) {
        final file = File(path);
        if (await file.exists()) {
          widget.onRecordingComplete(file, _recordingDuration.inMilliseconds, _waveform.toList());
        }
      }
    } catch (e) {
      debugPrint('❌ Stop failed: $e');
    }
  }

  Future<void> _cancelRecording() async {
    if (!_isRecording) return;
    
    HapticFeedback.heavyImpact();
    setState(() => _isCancelling = true); // Trigger trash animation

    await _trashController.forward();
    
    _durationTimer?.cancel();
    _amplitudeSubscription?.cancel();
    _pulseController.stop();

    try {
      await _audioRecorder.stop();
    } catch (_) {}

    if (_recordingPath != null) {
      final file = File(_recordingPath!);
      if (await file.exists()) await file.delete();
    }
    
    setState(() {
      _isRecording = false;
      _isCancelling = false;
      _isLocked = false;
      _waveform.clear();
      _dragX = 0;
    });
    _trashController.reset();

    widget.onCancel?.call();
  }



  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    if (_isCancelling) return _buildTrashAnimation();
    if (!_isRecording) return _buildIdleButton();

    return GestureDetector(
      onLongPress: _startRecording,
      onLongPressMoveUpdate: (details) {
         if (_isLocked) return;
         
         // Slide left to cancel
         setState(() {
           _dragX += details.localOffsetFromOrigin.dx - _dragX; // simplified tracking, relative to start
         });
         
         // Actually onLongPressMoveUpdate doesn't give deltas nicely for this
         // Using simpler horizontal drag logic:
         if (details.localOffsetFromOrigin.dx < _cancelThreshold) {
            _cancelRecording();
         }
      },
      onLongPressEnd: (_) {
        if (!_isLocked) _stopAndSend();
      },
      child: _buildRecordingUI(),
    );
  }

  Widget _buildIdleButton() {
    return GestureDetector(
      onLongPress: _startRecording,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
             BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: const Icon(Icons.mic, color: Colors.white, size: 24),
      ),
    );
  }

  Widget _buildRecordingUI() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: FuryColors.recording.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: FuryColors.recording.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Slide to cancel Area
          Opacity(
             opacity: (_dragX.abs() / _cancelThreshold.abs()).clamp(0.0, 1.0),
             child: const Row(children: [
               Icon(Icons.arrow_back_ios, size: 12, color: Colors.red),
               Text('Slide to cancel', style: TextStyle(color: Colors.red, fontSize: 12)),
             ])
          ),
          
          if (_dragX > _cancelThreshold / 2) ...[
             const SizedBox(width: 8),
             // Duration & Viz
             Text(_formatDuration(_recordingDuration), 
               style: const TextStyle(fontWeight: FontWeight.w600, color: FuryColors.recording)),
             const SizedBox(width: 8),
             SizedBox(
                height: 30, width: 60,
                child: CustomPaint(
                  painter: _WaveformPainter(
                     waveform: _waveform.length > 30 ? _waveform.sublist(_waveform.length - 30) : _waveform,
                     color: FuryColors.recording,
                  ),
                ),
             ),
          ],
          
          const SizedBox(width: 8),
          
          // The Mic Icon "Button" that user is holding
          Transform.translate(
             offset: Offset(_dragX, 0),
             child: Container(
               padding: const EdgeInsets.all(12),
               decoration: BoxDecoration(
                 color: FuryColors.recording,
                 shape: BoxShape.circle,
                 boxShadow: [
                    BoxShadow(color: FuryColors.recording.withValues(alpha: 0.5), blurRadius: 10, spreadRadius: 2),
                 ],
               ),
               child: const Icon(Icons.mic, color: Colors.white, size: 24),
             ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrashAnimation() {
    return FadeTransition(
      opacity: _trashController,
      child: const Icon(Icons.delete_forever, color: Colors.red, size: 32),
    );
  }
}

class _WaveformPainter extends CustomPainter {
  final List<double> waveform;
  final Color color;
  _WaveformPainter({required this.waveform, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..strokeWidth = 2..strokeCap = StrokeCap.round;
    final width = size.width / 30; // ~30 bars capacity
    
    for (int i = 0; i < waveform.length; i++) {
        final h = waveform[i] * size.height;
        final x = i * width;
        canvas.drawLine(Offset(x, (size.height - h)/2), Offset(x, (size.height + h)/2), paint);
    }
  }
  @override
  bool shouldRepaint(covariant _WaveformPainter old) => true;
}
