import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Audio message player widget with playback speed control
class AudioMessagePlayer extends StatefulWidget {
  final String audioUrl;
  final int durationMs;
  final List<double>? waveform;
  final bool isMe;

  const AudioMessagePlayer({
    super.key,
    required this.audioUrl,
    required this.durationMs,
    this.waveform,
    this.isMe = false,
  });

  @override
  State<AudioMessagePlayer> createState() => _AudioMessagePlayerState();
}

class _AudioMessagePlayerState extends State<AudioMessagePlayer> {
  late AudioPlayer _player;
  bool _isPlaying = false;
  bool _isLoading = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  double _speed = 1.0;
  StreamSubscription<PlayerState>? _playerStateSubscription;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration?>? _durationSubscription;

  static const List<double> _speeds = [0.5, 1.0, 1.5, 2.0];

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _duration = Duration(milliseconds: widget.durationMs);
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    try {
      _playerStateSubscription = _player.playerStateStream.listen((state) {
        if (mounted) {
          setState(() {
            _isPlaying = state.playing;
            _isLoading = state.processingState == ProcessingState.loading ||
                state.processingState == ProcessingState.buffering;
          });
          
          // Reset when completed
          if (state.processingState == ProcessingState.completed) {
            _player.seek(Duration.zero);
            _player.pause();
          }
        }
      });

      _positionSubscription = _player.positionStream.listen((position) {
        if (mounted) {
          setState(() => _position = position);
        }
      });

      _durationSubscription = _player.durationStream.listen((duration) {
        if (mounted && duration != null) {
          setState(() => _duration = duration);
        }
      });
    } catch (e) {
      debugPrint('Error initializing audio player: $e');
    }
  }

  @override
  void dispose() {
    _playerStateSubscription?.cancel();
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _player.dispose();
    super.dispose();
  }

  Future<void> _togglePlay() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      try {
        if (_player.audioSource == null) {
          setState(() => _isLoading = true);
          await _player.setUrl(widget.audioUrl);
        }
        await _player.play();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ошибка воспроизведения: $e')),
          );
        }
      }
    }
  }

  void _changeSpeed() {
    final currentIndex = _speeds.indexOf(_speed);
    final nextIndex = (currentIndex + 1) % _speeds.length;
    setState(() => _speed = _speeds[nextIndex]);
    _player.setSpeed(_speed);
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.isMe ? Colors.white : AppColors.primary;
    final secondaryColor = widget.isMe ? Colors.white70 : Colors.grey;
    final progress = _duration.inMilliseconds > 0
        ? _position.inMilliseconds / _duration.inMilliseconds
        : 0.0;

    return Container(
      width: 220,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          // Play/Pause button
          GestureDetector(
            onTap: _togglePlay,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: _isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(primaryColor),
                      ),
                    )
                  : Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: primaryColor,
                      size: 24,
                    ),
            ),
          ),
          const SizedBox(width: 8),

          // Waveform/Progress
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Waveform visualization
                SizedBox(
                  height: 24,
                  child: widget.waveform != null && widget.waveform!.isNotEmpty
                      ? CustomPaint(
                          size: const Size(double.infinity, 24),
                          painter: _WaveformProgressPainter(
                            waveform: widget.waveform!,
                            progress: progress,
                            activeColor: primaryColor,
                            inactiveColor: secondaryColor.withValues(alpha: 0.3),
                          ),
                        )
                      : SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 3,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 5,
                            ),
                            overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 12,
                            ),
                            activeTrackColor: primaryColor,
                            inactiveTrackColor: secondaryColor.withValues(alpha: 0.3),
                            thumbColor: primaryColor,
                          ),
                          child: Slider(
                            value: progress.clamp(0.0, 1.0),
                            onChanged: (value) {
                              final position = Duration(
                                milliseconds:
                                    (value * _duration.inMilliseconds).toInt(),
                              );
                              _player.seek(position);
                            },
                          ),
                        ),
                ),
                
                // Duration and speed
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _isPlaying
                          ? _formatDuration(_position)
                          : _formatDuration(_duration),
                      style: AppTypography.caption.copyWith(
                        color: secondaryColor,
                        fontSize: 10,
                      ),
                    ),
                    GestureDetector(
                      onTap: _changeSpeed,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${_speed}x',
                          style: AppTypography.caption.copyWith(
                            color: primaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Waveform painter with progress indicator
class _WaveformProgressPainter extends CustomPainter {
  final List<double> waveform;
  final double progress;
  final Color activeColor;
  final Color inactiveColor;

  _WaveformProgressPainter({
    required this.waveform,
    required this.progress,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (waveform.isEmpty) return;

    final barWidth = size.width / waveform.length;
    final maxHeight = size.height / 2;
    final progressIndex = (progress * waveform.length).floor();

    for (int i = 0; i < waveform.length; i++) {
      final x = i * barWidth + barWidth / 2;
      final barHeight = waveform[i].clamp(0.1, 1.0) * maxHeight;
      final isActive = i <= progressIndex;

      final paint = Paint()
        ..color = isActive ? activeColor : inactiveColor
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(
        Offset(x, size.height / 2 - barHeight),
        Offset(x, size.height / 2 + barHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _WaveformProgressPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        waveform.length != oldDelegate.waveform.length;
  }
}
