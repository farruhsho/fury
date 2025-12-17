import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Smart actions menu that suggests quick actions based on message content
class SmartActionsMenu extends StatelessWidget {
  final String messageText;
  final VoidCallback? onCreateReminder;
  final VoidCallback? onAddToCalendar;
  final VoidCallback? onSaveContact;
  final VoidCallback? onOpenMap;
  final VoidCallback? onOpenLink;
  final VoidCallback? onTranslate;
  final VoidCallback? onCopy;

  const SmartActionsMenu({
    super.key,
    required this.messageText,
    this.onCreateReminder,
    this.onAddToCalendar,
    this.onSaveContact,
    this.onOpenMap,
    this.onTranslate,
    this.onOpenLink,
    this.onCopy,
  });

  static Future<void> show({
    required BuildContext context,
    required String messageText,
    VoidCallback? onCreateReminder,
    VoidCallback? onAddToCalendar,
    VoidCallback? onSaveContact,
    VoidCallback? onOpenMap,
    VoidCallback? onOpenLink,
    VoidCallback? onTranslate,
    VoidCallback? onCopy,
  }) async {
    HapticFeedback.lightImpact();
    
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SmartActionsMenu(
        messageText: messageText,
        onCreateReminder: onCreateReminder,
        onAddToCalendar: onAddToCalendar,
        onSaveContact: onSaveContact,
        onOpenMap: onOpenMap,
        onOpenLink: onOpenLink,
        onTranslate: onTranslate,
        onCopy: onCopy,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final detectedEntities = _analyzeMessage(messageText);
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.auto_awesome, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Smart Actions',
                      style: AppTypography.h3,
                    ),
                    if (detectedEntities.isNotEmpty)
                      Text(
                        'Detected: ${detectedEntities.join(", ")}',
                        style: AppTypography.caption.copyWith(color: Colors.grey),
                      ),
                  ],
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // Always show these actions
          _actionTile(
            context,
            icon: Icons.copy,
            label: 'Copy text',
            onTap: () {
              Clipboard.setData(ClipboardData(text: messageText));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Copied to clipboard')),
              );
              onCopy?.call();
            },
          ),
          
          _actionTile(
            context,
            icon: Icons.translate,
            label: 'Translate',
            onTap: () {
              Navigator.pop(context);
              onTranslate?.call();
            },
          ),
          
          // Context-sensitive actions
          if (_containsPhoneNumber(messageText))
            _actionTile(
              context,
              icon: Icons.contact_phone,
              label: 'Save as contact',
              subtitle: _extractPhoneNumber(messageText),
              onTap: () {
                Navigator.pop(context);
                onSaveContact?.call();
              },
            ),
          
          if (_containsEmail(messageText))
            _actionTile(
              context,
              icon: Icons.email,
              label: 'Send email',
              subtitle: _extractEmail(messageText),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          
          if (_containsUrl(messageText))
            _actionTile(
              context,
              icon: Icons.open_in_browser,
              label: 'Open link',
              subtitle: _extractUrl(messageText),
              onTap: () {
                Navigator.pop(context);
                onOpenLink?.call();
              },
            ),
          
          if (_containsAddress(messageText))
            _actionTile(
              context,
              icon: Icons.map,
              label: 'Open in Maps',
              onTap: () {
                Navigator.pop(context);
                onOpenMap?.call();
              },
            ),
          
          if (_containsDateTime(messageText))
            _actionTile(
              context,
              icon: Icons.calendar_today,
              label: 'Add to calendar',
              onTap: () {
                Navigator.pop(context);
                onAddToCalendar?.call();
              },
            ),
          
          _actionTile(
            context,
            icon: Icons.alarm_add,
            label: 'Create reminder',
            onTap: () {
              Navigator.pop(context);
              onCreateReminder?.call();
            },
          ),
          
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
        ],
      ),
    );
  }

  Widget _actionTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: AppColors.textPrimaryLight),
      ),
      title: Text(label, style: AppTypography.bodyMedium),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: AppTypography.caption.copyWith(color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      onTap: onTap,
    );
  }

  List<String> _analyzeMessage(String text) {
    final entities = <String>[];
    
    if (_containsPhoneNumber(text)) entities.add('Phone');
    if (_containsEmail(text)) entities.add('Email');
    if (_containsUrl(text)) entities.add('Link');
    if (_containsAddress(text)) entities.add('Address');
    if (_containsDateTime(text)) entities.add('Date/Time');
    
    return entities;
  }

  bool _containsPhoneNumber(String text) {
    return RegExp(r'[\+]?[(]?[0-9]{1,3}[)]?[-\s\.]?[(]?[0-9]{1,3}[)]?[-\s\.]?[0-9]{4,6}').hasMatch(text);
  }

  String? _extractPhoneNumber(String text) {
    final match = RegExp(r'[\+]?[(]?[0-9]{1,3}[)]?[-\s\.]?[(]?[0-9]{1,3}[)]?[-\s\.]?[0-9]{4,6}').firstMatch(text);
    return match?.group(0);
  }

  bool _containsEmail(String text) {
    return RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}').hasMatch(text);
  }

  String? _extractEmail(String text) {
    final match = RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}').firstMatch(text);
    return match?.group(0);
  }

  bool _containsUrl(String text) {
    return RegExp(r'https?://[^\s]+').hasMatch(text);
  }

  String? _extractUrl(String text) {
    final match = RegExp(r'https?://[^\s]+').firstMatch(text);
    return match?.group(0);
  }

  bool _containsAddress(String text) {
    // Basic address detection (street, city patterns)
    return RegExp(r'\d+\s+\w+\s+(street|st|avenue|ave|road|rd|drive|dr|lane|ln|blvd|boulevard)', 
      caseSensitive: false).hasMatch(text);
  }

  bool _containsDateTime(String text) {
    // Date/time patterns
    return RegExp(r'\b(\d{1,2}[\/\-]\d{1,2}[\/\-]\d{2,4}|\d{1,2}:\d{2}|today|tomorrow|monday|tuesday|wednesday|thursday|friday|saturday|sunday)\b', 
      caseSensitive: false).hasMatch(text);
  }
}
