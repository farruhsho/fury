import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/message_entity.dart';

/// Reply preview widget - shown above message input when replying
class ReplyPreview extends StatelessWidget {
  final String senderName;
  final String? senderPhone;
  final String messageText;
  final Color? accentColor;
  final VoidCallback onCancel;

  const ReplyPreview({
    super.key,
    required this.senderName,
    this.senderPhone,
    required this.messageText,
    this.accentColor,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? AppColors.primary;
    
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        border: Border(
          top: BorderSide(color: AppColors.surfaceLight, width: 1),
        ),
      ),
      child: Row(
        children: [
          // Colored accent bar
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          // Reply content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      senderName,
                      style: AppTypography.bodyMedium.copyWith(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (senderPhone != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        senderPhone!,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  messageText,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Cancel button
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            color: AppColors.textSecondaryLight,
            onPressed: onCancel,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }
}

/// Voice message reply indicator (shows when replying to voice message)
class VoiceReplyPreview extends StatelessWidget {
  final String senderName;
  final String? senderPhone;
  final Duration duration;
  final VoidCallback onCancel;

  const VoiceReplyPreview({
    super.key,
    required this.senderName,
    this.senderPhone,
    required this.duration,
    required this.onCancel,
  });

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        border: Border(
          top: BorderSide(color: AppColors.surfaceLight, width: 1),
        ),
      ),
      child: Row(
        children: [
          // Colored accent bar
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          // Voice icon
          Icon(Icons.mic, color: AppColors.primary, size: 20),
          const SizedBox(width: 8),
          // Reply content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      senderName,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (senderPhone != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        senderPhone!,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Голосовое сообщение: (${_formatDuration(duration)})',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          // Cancel button
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            color: AppColors.textSecondaryLight,
            onPressed: onCancel,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }
}

/// Attachment menu - shown when pressing the attachment button
class AttachmentMenu extends StatelessWidget {
  final VoidCallback onGallery;
  final VoidCallback onCamera;
  final VoidCallback onLocation;
  final VoidCallback onContact;
  final VoidCallback onDocument;
  final VoidCallback onAudio;
  final VoidCallback? onPoll;
  final VoidCallback? onEvent;

  const AttachmentMenu({
    super.key,
    required this.onGallery,
    required this.onCamera,
    required this.onLocation,
    required this.onContact,
    required this.onDocument,
    required this.onAudio,
    this.onPoll,
    this.onEvent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.textSecondaryLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // First row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAttachmentButton(
                icon: Icons.photo_library,
                label: 'Галерея',
                color: const Color(0xFF7C4DFF),
                onTap: onGallery,
              ),
              _buildAttachmentButton(
                icon: Icons.camera_alt,
                label: 'Камера',
                color: const Color(0xFFE91E63),
                onTap: onCamera,
              ),
              _buildAttachmentButton(
                icon: Icons.location_on,
                label: 'Местоположен...',
                color: const Color(0xFF4CAF50),
                onTap: onLocation,
              ),
              _buildAttachmentButton(
                icon: Icons.person,
                label: 'Контакт',
                color: const Color(0xFF2196F3),
                onTap: onContact,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          // Second row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAttachmentButton(
                icon: Icons.insert_drive_file,
                label: 'Документ',
                color: const Color(0xFF5C6BC0),
                onTap: onDocument,
              ),
              _buildAttachmentButton(
                icon: Icons.headset,
                label: 'Аудио',
                color: const Color(0xFFFF9800),
                onTap: onAudio,
              ),
              if (onPoll != null)
                _buildAttachmentButton(
                  icon: Icons.poll,
                  label: 'Опрос',
                  color: const Color(0xFF009688),
                  onTap: onPoll!,
                )
              else
                const SizedBox(width: 70),
              if (onEvent != null)
                _buildAttachmentButton(
                  icon: Icons.event,
                  label: 'Мероприятие',
                  color: const Color(0xFFE53935),
                  onTap: onEvent!,
                )
              else
                const SizedBox(width: 70),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }

  Widget _buildAttachmentButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondaryLight,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  static void show(BuildContext context, AttachmentMenu menu) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => menu,
    );
  }
}
