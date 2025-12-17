import 'package:flutter/material.dart';

part 'disappearing_messages_state.dart';

/// Settings for disappearing messages in a chat
enum DisappearingDuration {
  off,
  minutes5,
  hours1,
  hours24,
  days7,
  days30;

  String get displayName {
    switch (this) {
      case DisappearingDuration.off:
        return 'Off';
      case DisappearingDuration.minutes5:
        return '5 minutes';
      case DisappearingDuration.hours1:
        return '1 hour';
      case DisappearingDuration.hours24:
        return '24 hours';
      case DisappearingDuration.days7:
        return '7 days';
      case DisappearingDuration.days30:
        return '30 days';
    }
  }

  Duration? get duration {
    switch (this) {
      case DisappearingDuration.off:
        return null;
      case DisappearingDuration.minutes5:
        return const Duration(minutes: 5);
      case DisappearingDuration.hours1:
        return const Duration(hours: 1);
      case DisappearingDuration.hours24:
        return const Duration(hours: 24);
      case DisappearingDuration.days7:
        return const Duration(days: 7);
      case DisappearingDuration.days30:
        return const Duration(days: 30);
    }
  }

  int? get seconds {
    return duration?.inSeconds;
  }
}

/// Widget for selecting disappearing message duration
class DisappearingMessagesPicker extends StatelessWidget {
  final DisappearingDuration currentDuration;
  final ValueChanged<DisappearingDuration> onDurationChanged;

  const DisappearingMessagesPicker({
    super.key,
    required this.currentDuration,
    required this.onDurationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Disappearing Messages',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'When enabled, messages will be deleted for everyone after the selected time.',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        ...DisappearingDuration.values.map((duration) {
          final isSelected = duration == currentDuration;
          return ListTile(
            leading: Radio<DisappearingDuration>(
              value: duration,
              groupValue: currentDuration,
              onChanged: (value) {
                if (value != null) {
                  onDurationChanged(value);
                }
              },
            ),
            title: Text(duration.displayName),
            trailing: isSelected
                ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                : null,
            onTap: () => onDurationChanged(duration),
          );
        }),
      ],
    );
  }
}

/// Bottom sheet for disappearing messages settings
void showDisappearingMessagesSheet({
  required BuildContext context,
  required DisappearingDuration currentDuration,
  required ValueChanged<DisappearingDuration> onDurationChanged,
}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => DisappearingMessagesPicker(
      currentDuration: currentDuration,
      onDurationChanged: (duration) {
        onDurationChanged(duration);
        Navigator.pop(context);
      },
    ),
  );
}

/// Mixin for handling disappearing message logic in a chat
mixin DisappearingMessagesMixin {
  /// Calculate when a message should be deleted
  DateTime? calculateDeleteTime(
    DateTime sentAt,
    DisappearingDuration duration,
  ) {
    final durationValue = duration.duration;
    if (durationValue == null) return null;
    return sentAt.add(durationValue);
  }

  /// Check if a message should be visible
  bool isMessageVisible(
    DateTime sentAt,
    DisappearingDuration duration,
  ) {
    final deleteTime = calculateDeleteTime(sentAt, duration);
    if (deleteTime == null) return true;
    return DateTime.now().isBefore(deleteTime);
  }

  /// Get remaining time before message disappears
  Duration? getRemainingTime(
    DateTime sentAt,
    DisappearingDuration duration,
  ) {
    final deleteTime = calculateDeleteTime(sentAt, duration);
    if (deleteTime == null) return null;
    
    final remaining = deleteTime.difference(DateTime.now());
    return remaining.isNegative ? Duration.zero : remaining;
  }
}
