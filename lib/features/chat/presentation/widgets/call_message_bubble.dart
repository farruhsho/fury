import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../calls/domain/entities/call_entity.dart';

/// Widget to display call history messages in chat
/// Shows: caller name, call type, status (answered/missed/declined), and duration
class CallMessageBubble extends StatelessWidget {
  final CallEntity call;
  final bool isMe; // true = I made the call (outgoing)
  final String otherUserName;
  final VoidCallback? onCallBack;

  const CallMessageBubble({
    super.key,
    required this.call,
    required this.isMe,
    required this.otherUserName,
    this.onCallBack,
  });

  // Call type icon
  IconData get _callIcon {
    final isVideo = call.type == CallType.video || call.type == CallType.groupVideo;
    return isVideo ? Icons.videocam : Icons.call;
  }

  // Status color
  Color get _statusColor {
    switch (call.status) {
      case CallStatus.ended:
        return Colors.green;
      case CallStatus.missed:
        return Colors.red;
      case CallStatus.declined:
        return Colors.orange;
      case CallStatus.failed:
        return Colors.red.shade700;
      default:
        return Colors.grey;
    }
  }

  // Direction icon - arrows showing in/out
  IconData get _directionIcon {
    if (call.status == CallStatus.missed) {
      return isMe ? Icons.call_missed_outgoing : Icons.call_missed;
    }
    return isMe ? Icons.call_made : Icons.call_received;
  }

  // Clear status text
  String get _statusText {
    final isVideo = call.type == CallType.video || call.type == CallType.groupVideo;
    final callTypeText = isVideo ? 'Видеозвонок' : 'Голосовой звонок';
    
    switch (call.status) {
      case CallStatus.ended:
        if (isMe) return '$callTypeText → $otherUserName';
        return '$callTypeText ← $otherUserName';
      case CallStatus.missed:
        if (isMe) return 'Не отвечен: $otherUserName';
        return 'Пропущенный от $otherUserName';
      case CallStatus.declined:
        if (isMe) return 'Отклонено: $otherUserName';
        return 'Отклонённый от $otherUserName';
      case CallStatus.failed:
        return 'Не удалось позвонить';
      default:
        return callTypeText;
    }
  }

  // Format duration nicely
  String _formatDuration(int seconds) {
    if (seconds <= 0) return '';
    if (seconds < 60) return '$seconds сек';
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    if (minutes < 60) {
      return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    }
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return '${hours}:${remainingMinutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isAnswered = call.status == CallStatus.ended && call.duration > 0;
    final isMissedOrDeclined = call.status == CallStatus.missed || call.status == CallStatus.declined;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        decoration: BoxDecoration(
          color: isDark 
              ? AppColors.surfaceDark.withOpacity(0.7)
              : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _statusColor.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _statusColor.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Call icon with status
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _statusColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _callIcon,
                    color: _statusColor,
                    size: 26,
                  ),
                ),
                // Direction arrow
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: _statusColor, width: 1.5),
                    ),
                    child: Icon(
                      _directionIcon,
                      size: 12,
                      color: _statusColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.md),
            
            // Call info
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Status text with name
                  Text(
                    _statusText,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : AppColors.textPrimaryLight,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                  // Duration and time row
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Status badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: _statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          isAnswered ? 'Принят' : 
                          (isMissedOrDeclined ? (isMe ? 'Нет ответа' : 'Пропущен') : 'Ошибка'),
                          style: TextStyle(
                            color: _statusColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      
                      // Duration if answered
                      if (isAnswered) ...[
                        const SizedBox(width: 8),
                        Icon(Icons.timer_outlined, size: 14, color: Colors.grey),
                        const SizedBox(width: 2),
                        Text(
                          _formatDuration(call.duration),
                          style: AppTypography.caption.copyWith(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                      
                      const SizedBox(width: 8),
                      Icon(Icons.access_time, size: 12, color: Colors.grey),
                      const SizedBox(width: 2),
                      Text(
                        DateFormat.Hm().format(call.createdAt),
                        style: AppTypography.caption.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: AppSpacing.sm),
            
            // Call back button
            Material(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: onCallBack,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    _callIcon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
