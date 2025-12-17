import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';

/// Voice recording widget with swipe gestures
/// - Swipe left to cancel
/// - Swipe up to lock recording
class VoiceRecordingWidget extends StatefulWidget {
  final VoidCallback onCancel;
  final VoidCallback onSend;
  final VoidCallback onLock;
  final ValueChanged<bool> onPause;
  final bool isLocked;
  final bool isPaused;

  const VoiceRecordingWidget({
    super.key,
    required this.onCancel,
    required this.onSend,
    required this.onLock,
    required this.onPause,
    this.isLocked = false,
    this.isPaused = false,
  });

  @override
  State<VoiceRecordingWidget> createState() => _VoiceRecordingWidgetState();
}

class _VoiceRecordingWidgetState extends State<VoiceRecordingWidget>
    with SingleTickerProviderStateMixin {
  Duration _duration = Duration.zero;
  Timer? _timer;
  late AnimationController _waveController;
  List<double> _waveform = [];

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..repeat(reverse: true);
    _startTimer();
    _generateWaveform();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _waveController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!widget.isPaused) {
        setState(() {
          _duration += const Duration(seconds: 1);
        });
      }
    });
  }

  void _generateWaveform() {
    // Generate random waveform bars for visualization
    setState(() {
      _waveform = List.generate(30, (i) => 0.3 + (i % 5) * 0.15);
    });
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString();
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLocked) {
      return _buildLockedRecording();
    }
    return _buildSlideRecording();
  }

  /// Locked recording mode - shows controls
  Widget _buildLockedRecording() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      color: AppColors.surfaceDark,
      child: Row(
        children: [
          // Delete button
          IconButton(
            icon: const Icon(Icons.delete_outline),
            color: Colors.red.shade400,
            onPressed: widget.onCancel,
          ),
          const Spacer(),
          // Timer
          Text(
            _formatDuration(_duration),
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          // Waveform
          Expanded(
            child: AnimatedBuilder(
              animation: _waveController,
              builder: (context, _) => _buildWaveform(),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          // Pause/Resume button
          IconButton(
            icon: Icon(widget.isPaused ? Icons.play_arrow : Icons.pause),
            color: AppColors.textPrimaryLight,
            onPressed: () => widget.onPause(!widget.isPaused),
          ),
          // Send button
          GestureDetector(
            onTap: widget.onSend,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  /// Sliding recording mode (hold to record)
  Widget _buildSlideRecording() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      color: AppColors.surfaceDark,
      child: Row(
        children: [
          // Recording indicator
          AnimatedBuilder(
            animation: _waveController,
            builder: (context, _) => Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.5 + _waveController.value * 0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          // Timer
          Text(
            _formatDuration(_duration),
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textPrimaryLight,
            ),
          ),
          const Spacer(),
          // Waveform
          SizedBox(
            width: 100,
            child: AnimatedBuilder(
              animation: _waveController,
              builder: (context, _) => _buildWaveformCompact(),
            ),
          ),
          const Spacer(),
          // Slide to cancel hint
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.chevron_left,
                color: AppColors.textSecondaryLight,
                size: 16,
              ),
              Text(
                'Отмена',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWaveform() {
    return SizedBox(
      height: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _waveform.take(20).map((h) {
          return Container(
            width: 3,
            height: 32 * h * (0.7 + _waveController.value * 0.3),
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(1.5),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildWaveformCompact() {
    return SizedBox(
      height: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _waveform.take(15).map((h) {
          return Container(
            width: 2,
            height: 24 * h * (0.7 + _waveController.value * 0.3),
            margin: const EdgeInsets.symmetric(horizontal: 0.5),
            decoration: BoxDecoration(
              color: AppColors.textSecondaryLight,
              borderRadius: BorderRadius.circular(1),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Voice recording button with gestures
class VoiceRecordButton extends StatefulWidget {
  final VoidCallback onStartRecording;
  final VoidCallback onStopRecording;
  final VoidCallback onCancelRecording;
  final VoidCallback onLockRecording;
  final bool isRecording;

  const VoiceRecordButton({
    super.key,
    required this.onStartRecording,
    required this.onStopRecording,
    required this.onCancelRecording,
    required this.onLockRecording,
    this.isRecording = false,
  });

  @override
  State<VoiceRecordButton> createState() => _VoiceRecordButtonState();
}

class _VoiceRecordButtonState extends State<VoiceRecordButton> {
  double _dragX = 0;
  double _dragY = 0;
  bool _isLockThresholdReached = false;
  bool _isCancelThresholdReached = false;

  static const double _cancelThreshold = -100;
  static const double _lockThreshold = -80;

  void _onPanStart(DragStartDetails details) {
    widget.onStartRecording();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragX += details.delta.dx;
      _dragY += details.delta.dy;
      
      _isCancelThresholdReached = _dragX < _cancelThreshold;
      _isLockThresholdReached = _dragY < _lockThreshold;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_isCancelThresholdReached) {
      widget.onCancelRecording();
    } else if (_isLockThresholdReached) {
      widget.onLockRecording();
    } else {
      widget.onStopRecording();
    }
    
    setState(() {
      _dragX = 0;
      _dragY = 0;
      _isCancelThresholdReached = false;
      _isLockThresholdReached = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Lock indicator
        if (widget.isRecording && !_isLockThresholdReached)
          Positioned(
            bottom: 60,
            right: 0,
            child: AnimatedOpacity(
              opacity: _dragY < -20 ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 150),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      color: _dragY < _lockThreshold 
                          ? AppColors.primary 
                          : AppColors.textSecondaryLight,
                      size: 20,
                    ),
                    const SizedBox(height: 4),
                    const Icon(
                      Icons.keyboard_arrow_up,
                      color: AppColors.textSecondaryLight,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        
        // Record button
        GestureDetector(
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          child: Transform.translate(
            offset: widget.isRecording 
                ? Offset(_dragX.clamp(-150, 0), _dragY.clamp(-100, 0))
                : Offset.zero,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: widget.isRecording ? 56 : 48,
              height: widget.isRecording ? 56 : 48,
              decoration: BoxDecoration(
                color: _isCancelThresholdReached 
                    ? Colors.red.shade400
                    : AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: widget.isRecording
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.4),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                _isCancelThresholdReached ? Icons.delete : Icons.mic,
                color: Colors.white,
                size: widget.isRecording ? 28 : 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
