import 'package:flutter/material.dart';

/// Network quality levels
enum CallQuality {
  excellent,
  good,
  fair,
  poor,
  disconnected,
}

/// A widget that displays call quality indicator with animated bars
/// 
/// Shows 1-4 bars based on connection quality, with color coding:
/// - Green: Excellent/Good
/// - Yellow: Fair
/// - Red: Poor/Disconnected
class CallQualityIndicator extends StatefulWidget {
  final CallQuality quality;
  final double size;
  final bool showLabel;
  final bool animate;

  const CallQualityIndicator({
    super.key,
    required this.quality,
    this.size = 24,
    this.showLabel = false,
    this.animate = true,
  });

  @override
  State<CallQualityIndicator> createState() => _CallQualityIndicatorState();
}

class _CallQualityIndicatorState extends State<CallQualityIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    
    if (widget.animate && widget.quality == CallQuality.poor) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(CallQualityIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.quality != oldWidget.quality) {
      if (widget.animate && widget.quality == CallQuality.poor) {
        _pulseController.repeat(reverse: true);
      } else {
        _pulseController.stop();
        _pulseController.value = 1.0;
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  int get _activeBars {
    switch (widget.quality) {
      case CallQuality.excellent:
        return 4;
      case CallQuality.good:
        return 3;
      case CallQuality.fair:
        return 2;
      case CallQuality.poor:
        return 1;
      case CallQuality.disconnected:
        return 0;
    }
  }

  Color get _color {
    switch (widget.quality) {
      case CallQuality.excellent:
      case CallQuality.good:
        return Colors.green;
      case CallQuality.fair:
        return Colors.orange;
      case CallQuality.poor:
      case CallQuality.disconnected:
        return Colors.red;
    }
  }

  String get _label {
    switch (widget.quality) {
      case CallQuality.excellent:
        return 'Excellent';
      case CallQuality.good:
        return 'Good';
      case CallQuality.fair:
        return 'Fair';
      case CallQuality.poor:
        return 'Poor';
      case CallQuality.disconnected:
        return 'Disconnected';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: widget.quality == CallQuality.poor 
              ? _pulseAnimation.value 
              : 1.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Signal bars
              _buildBars(),
              
              // Optional label
              if (widget.showLabel) ...[
                const SizedBox(width: 6),
                Text(
                  _label,
                  style: TextStyle(
                    fontSize: widget.size * 0.5,
                    color: _color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildBars() {
    final barWidth = widget.size / 6;
    final maxHeight = widget.size;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(4, (index) {
        final isActive = index < _activeBars;
        final height = maxHeight * (0.25 + (index * 0.25));
        
        return Padding(
          padding: EdgeInsets.only(right: index < 3 ? 2 : 0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            width: barWidth,
            height: height,
            decoration: BoxDecoration(
              color: isActive
                  ? _color
                  : Colors.grey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(barWidth / 2),
            ),
          ),
        );
      }),
    );
  }
}

/// A more detailed call quality display with stats
class CallQualityDetails extends StatelessWidget {
  final CallQuality quality;
  final int? latencyMs;
  final double? packetLossPercent;
  final int? jitterMs;
  final String? codec;

  const CallQualityDetails({
    super.key,
    required this.quality,
    this.latencyMs,
    this.packetLossPercent,
    this.jitterMs,
    this.codec,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CallQualityIndicator(quality: quality, size: 20),
              const SizedBox(width: 8),
              Text(
                'Connection Quality',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.white24),
          const SizedBox(height: 12),
          
          if (latencyMs != null)
            _buildStatRow('Latency', '$latencyMs ms', _getLatencyColor(latencyMs!)),
          
          if (packetLossPercent != null)
            _buildStatRow(
              'Packet Loss', 
              '${packetLossPercent!.toStringAsFixed(1)}%',
              _getPacketLossColor(packetLossPercent!),
            ),
          
          if (jitterMs != null)
            _buildStatRow('Jitter', '$jitterMs ms', _getJitterColor(jitterMs!)),
          
          if (codec != null)
            _buildStatRow('Codec', codec!, Colors.white70),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getLatencyColor(int ms) {
    if (ms < 100) return Colors.green;
    if (ms < 200) return Colors.orange;
    return Colors.red;
  }

  Color _getPacketLossColor(double percent) {
    if (percent < 1) return Colors.green;
    if (percent < 5) return Colors.orange;
    return Colors.red;
  }

  Color _getJitterColor(int ms) {
    if (ms < 30) return Colors.green;
    if (ms < 50) return Colors.orange;
    return Colors.red;
  }
}

/// Helper to calculate call quality from WebRTC stats
CallQuality calculateCallQuality({
  required int latencyMs,
  required double packetLossPercent,
  int? jitterMs,
}) {
  // Score from 0-100
  int score = 100;
  
  // Latency penalty
  if (latencyMs > 300) {
    score -= 40;
  } else if (latencyMs > 200) {
    score -= 25;
  } else if (latencyMs > 100) {
    score -= 10;
  }
  
  // Packet loss penalty
  if (packetLossPercent > 10) {
    score -= 50;
  } else if (packetLossPercent > 5) {
    score -= 30;
  } else if (packetLossPercent > 1) {
    score -= 15;
  }
  
  // Jitter penalty
  if (jitterMs != null) {
    if (jitterMs > 100) {
      score -= 20;
    } else if (jitterMs > 50) {
      score -= 10;
    }
  }
  
  // Map score to quality
  if (score >= 80) return CallQuality.excellent;
  if (score >= 60) return CallQuality.good;
  if (score >= 40) return CallQuality.fair;
  if (score >= 20) return CallQuality.poor;
  return CallQuality.disconnected;
}
