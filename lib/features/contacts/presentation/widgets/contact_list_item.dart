import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../domain/entities/contact_entity.dart';

class ContactListItem extends StatelessWidget {
  final ContactEntity contact;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const ContactListItem({
    super.key,
    required this.contact,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            backgroundImage: contact.avatarUrl != null
                ? NetworkImage(contact.avatarUrl!)
                : null,
            child: contact.avatarUrl == null
                ? Text(
                    contact.displayName[0].toUpperCase(),
                    style: AppTypography.h3.copyWith(color: AppColors.primary),
                  )
                : null,
          ),
          if (contact.isOnline == true)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
      title: Text(
        contact.displayName,
        style: AppTypography.bodyLarge.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        contact.bio ?? contact.phoneNumber,
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.textSecondaryLight,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
