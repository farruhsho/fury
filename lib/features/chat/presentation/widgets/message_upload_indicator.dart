import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/message_entity.dart';

/// Widget that displays upload progress for pending messages
/// 
/// Shows different states:
/// - Uploading: Progress bar with cancel option
/// - Pending: Clock icon with "Sending..." text
/// - Failed: Error icon with retry button
class MessageUploadIndicator extends StatelessWidget {
  final MessageStatus status;
  final double? progress; // 0.0 to 1.0 for upload progress
  final VoidCallback? onRetry;
  final VoidCallback? onCancel;

  const MessageUploadIndicator({
    super.key,
    required this.status,
    this.progress,
    this.onRetry,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case MessageStatus.sending:
        return _buildSendingIndicator(context);
      case MessageStatus.failed:
        return _buildFailedIndicator(context);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildSendingIndicator(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (progress != null) ...[
            // Upload progress bar
            SizedBox(
              width: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 4,
                  backgroundColor: Colors.grey.withValues(alpha: 0.3),
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${(progress! * 100).toInt()}%',
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ] else ...[
            // Simple pending indicator
            const SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),
            const SizedBox(width: 6),
            const Text(
              'Sending...',
              style: TextStyle(
                fontSize: 10,
                color: AppColors.primary,
              ),
            ),
          ],
          if (onCancel != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onCancel,
              child: const Icon(
                Icons.close,
                size: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFailedIndicator(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline,
            size: 14,
            color: Colors.red,
          ),
          const SizedBox(width: 6),
          const Text(
            'Failed to send',
            style: TextStyle(
              fontSize: 10,
              color: Colors.red,
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onRetry,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Retry',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// A wrapper that adds upload indicator overlay to any message bubble
class MessageWithUploadIndicator extends StatelessWidget {
  final Widget child;
  final MessageStatus status;
  final double? uploadProgress;
  final VoidCallback? onRetry;
  final VoidCallback? onCancel;

  const MessageWithUploadIndicator({
    super.key,
    required this.child,
    required this.status,
    this.uploadProgress,
    this.onRetry,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final shouldShowIndicator = status == MessageStatus.sending || 
                                 status == MessageStatus.failed;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Message bubble with optional overlay
        Stack(
          children: [
            // Original message bubble
            child,
            
            // Overlay for uploading state
            if (status == MessageStatus.sending && uploadProgress != null)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          value: uploadProgress,
                          strokeWidth: 3,
                          valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        
        // Status indicator below bubble
        if (shouldShowIndicator)
          MessageUploadIndicator(
            status: status,
            progress: uploadProgress,
            onRetry: onRetry,
            onCancel: onCancel,
          ),
      ],
    );
  }
}

/// Upload progress tracker for file uploads
class UploadProgressTracker {
  final Map<String, double> _progress = {};
  final Map<String, void Function(double)> _listeners = {};
  
  /// Update progress for a message
  void updateProgress(String messageId, double progress) {
    _progress[messageId] = progress;
    _listeners[messageId]?.call(progress);
  }
  
  /// Get current progress for a message
  double? getProgress(String messageId) => _progress[messageId];
  
  /// Add progress listener for a message
  void addListener(String messageId, void Function(double) listener) {
    _listeners[messageId] = listener;
  }
  
  /// Remove progress listener
  void removeListener(String messageId) {
    _listeners.remove(messageId);
  }
  
  /// Mark upload as complete
  void complete(String messageId) {
    _progress.remove(messageId);
    _listeners.remove(messageId);
  }
  
  /// Clear all progress
  void clear() {
    _progress.clear();
    _listeners.clear();
  }
}
