import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Widget for sharing invite links to groups and channels
class InviteLinkSheet extends StatelessWidget {
  final String name;
  final String inviteLink;
  final String inviteCode;
  final bool isChannel;

  const InviteLinkSheet({
    super.key,
    required this.name,
    required this.inviteLink,
    required this.inviteCode,
    this.isChannel = false,
  });

  void _copyLink(BuildContext context) {
    Clipboard.setData(ClipboardData(text: inviteLink));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Ссылка скопирована!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _shareLink(BuildContext context) {
    final type = isChannel ? 'канал' : 'группу';
    Share.share(
      'Присоединяйтесь к ${isChannel ? 'каналу' : 'группе'} "$name" в Fury!\n\n$inviteLink',
      subject: 'Приглашение в $type "$name"',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          
          // Icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isChannel ? Icons.campaign : Icons.group,
              size: 48,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          
          // Title
          Text(
            'Пригласить в ${isChannel ? 'канал' : 'группу'}',
            style: AppTypography.h3.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          
          Text(
            name,
            style: AppTypography.bodyLarge.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          
          // Invite Link Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ссылка-приглашение',
                  style: AppTypography.caption.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        inviteLink,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: AppColors.primary),
                      onPressed: () => _copyLink(context),
                      tooltip: 'Копировать',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Action Buttons
          Row(
            children: [
              // Copy Button
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _copyLink(context),
                  icon: const Icon(Icons.copy),
                  label: const Text('Копировать'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
              // Share Button
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _shareLink(context),
                  icon: const Icon(Icons.share),
                  label: const Text('Поделиться'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // QR Code hint
          TextButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('QR-код скоро будет доступен')),
              );
            },
            icon: const Icon(Icons.qr_code),
            label: const Text('Показать QR-код'),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  /// Static method to show the invite link sheet
  static void show({
    required BuildContext context,
    required String name,
    required String inviteLink,
    required String inviteCode,
    bool isChannel = false,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => InviteLinkSheet(
        name: name,
        inviteLink: inviteLink,
        inviteCode: inviteCode,
        isChannel: isChannel,
      ),
    );
  }
}
