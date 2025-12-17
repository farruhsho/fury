import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/message_entity.dart';
import '../bloc/message_bloc/message_bloc.dart';

class MessageBubble extends StatelessWidget {
  final MessageEntity message;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  // Check if message is a location message (format: location:lat,lng)
  bool get _isLocationMessage {
    final text = message.text ?? '';
    return text.startsWith('location:') && text.contains(',');
  }

  // Parse coordinates from location message
  (double lat, double lng)? get _coordinates {
    if (!_isLocationMessage) return null;
    try {
      final coords = (message.text ?? '').replaceFirst('location:', '').split(',');
      return (double.parse(coords[0]), double.parse(coords[1]));
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : AppColors.surfaceLight,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppSpacing.radiusLg),
            topRight: const Radius.circular(AppSpacing.radiusLg),
            bottomLeft: isMe ? const Radius.circular(AppSpacing.radiusLg) : Radius.zero,
            bottomRight: isMe ? Radius.zero : const Radius.circular(AppSpacing.radiusLg),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Forwarded label
            if (message.forwardedFrom != null) ...[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.reply,
                    size: 12,
                    color: isMe ? Colors.white60 : AppColors.textSecondaryLight,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Forwarded',
                    style: AppTypography.caption.copyWith(
                      color: isMe ? Colors.white60 : AppColors.textSecondaryLight,
                      fontStyle: FontStyle.italic,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
            ],
            _isLocationMessage 
                ? _buildLocationContent(context) 
                : Text(
                    message.text ?? '',
                    style: AppTypography.bodyMedium.copyWith(
                      color: isMe ? Colors.white : AppColors.textPrimaryLight,
                    ),
                  ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Edited label
                if (message.editedAt != null) ...[
                  Text(
                    'edited',
                    style: AppTypography.caption.copyWith(
                      color: isMe ? Colors.white60 : AppColors.textSecondaryLight,
                      fontStyle: FontStyle.italic,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
                Text(
                  DateFormat.Hm().format(message.createdAt),
                  style: AppTypography.caption.copyWith(
                    color: isMe ? Colors.white.withValues(alpha: 0.7) : AppColors.textSecondaryLight,
                    fontSize: 10,
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  _buildStatusIcon(context),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationContent(BuildContext context) {
    final coords = _coordinates;
    if (coords == null) {
      return Text(
        message.text ?? '',
        style: AppTypography.bodyMedium.copyWith(
          color: isMe ? Colors.white : AppColors.textPrimaryLight,
        ),
      );
    }

    return InkWell(
      onTap: () => _showMapChooser(context, coords.$1, coords.$2),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (isMe ? Colors.white : AppColors.primary).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on,
              color: isMe ? Colors.white : AppColors.primary,
              size: 24,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '📍 Местоположение',
                  style: AppTypography.bodyMedium.copyWith(
                    color: isMe ? Colors.white : AppColors.textPrimaryLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Нажмите чтобы открыть',
                  style: AppTypography.caption.copyWith(
                    color: isMe ? Colors.white70 : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.open_in_new,
              color: isMe ? Colors.white70 : AppColors.textSecondaryLight,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showMapChooser(BuildContext context, double lat, double lng) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Открыть карту',
              style: AppTypography.h3,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _MapOption(
                  icon: Icons.map,
                  label: 'Google Maps',
                  color: Colors.blue,
                  onTap: () {
                    Navigator.pop(context);
                    _openGoogleMaps(lat, lng);
                  },
                ),
                _MapOption(
                  icon: Icons.map_outlined,
                  label: 'Yandex Maps',
                  color: Colors.red,
                  onTap: () {
                    Navigator.pop(context);
                    _openYandexMaps(lat, lng);
                  },
                ),
                _MapOption(
                  icon: Icons.copy,
                  label: 'Копировать',
                  color: Colors.grey,
                  onTap: () {
                    Navigator.pop(context);
                    _copyCoordinates(context, lat, lng);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _openGoogleMaps(double lat, double lng) async {
    final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _openYandexMaps(double lat, double lng) async {
    final url = Uri.parse('https://yandex.com/maps/?pt=$lng,$lat&z=15&l=map');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _copyCoordinates(BuildContext context, double lat, double lng) {
    // Copy to clipboard functionality would go here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Координаты: $lat, $lng')),
    );
  }

  Widget _buildStatusIcon(BuildContext context) {
    IconData icon;
    Color color;
    
    switch (message.status) {
      case MessageStatus.sending:
        icon = Icons.access_time;
        color = Colors.white.withValues(alpha: 0.5);
        break;
      case MessageStatus.sent:
        icon = Icons.done;
        color = Colors.white.withValues(alpha: 0.7);
        break;
      case MessageStatus.delivered:
        icon = Icons.done_all;
        color = Colors.white.withValues(alpha: 0.7);
        break;
      case MessageStatus.read:
        icon = Icons.done_all;
        color = Colors.lightBlueAccent;
        break;
      case MessageStatus.failed:
        icon = Icons.error_outline;
        color = Colors.red.shade300;
        break;
    }
    

    
    final iconWidget = Icon(icon, size: 14, color: color);
    
    if (message.status == MessageStatus.failed) {
      return GestureDetector(
        onTap: () {
          context.read<MessageBloc>().add(MessageEvent.retryMessage(message.id));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Retrying sending message...'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        child: iconWidget,
      );
    }
    
    return iconWidget;
  }
}

class _MapOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _MapOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
                color: color.withValues(alpha: 0.1),
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
}
