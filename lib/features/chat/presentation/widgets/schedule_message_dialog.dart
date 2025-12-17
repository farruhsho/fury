import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Dialog for scheduling a message to be sent later
class ScheduleMessageDialog extends StatefulWidget {
  final String? messageText;
  final Function(DateTime scheduledTime) onSchedule;

  const ScheduleMessageDialog({
    super.key,
    this.messageText,
    required this.onSchedule,
  });

  static Future<DateTime?> show({
    required BuildContext context,
    String? messageText,
  }) async {
    return showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ScheduleMessageDialog(
        messageText: messageText,
        onSchedule: (time) => Navigator.pop(context, time),
      ),
    );
  }

  @override
  State<ScheduleMessageDialog> createState() => _ScheduleMessageDialogState();
}

class _ScheduleMessageDialogState extends State<ScheduleMessageDialog> {
  DateTime _selectedDate = DateTime.now().add(const Duration(hours: 1));
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _showCustomPicker = false;

  @override
  Widget build(BuildContext context) {
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
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.schedule_send, color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Schedule Message',
                  style: AppTypography.h3,
                ),
              ],
            ),
          ),
          
          if (widget.messageText != null)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.message, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.messageText!,
                      style: AppTypography.bodySmall.copyWith(color: Colors.grey[700]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          
          const SizedBox(height: 16),
          const Divider(height: 1),
          
          if (!_showCustomPicker) ...[
            // Quick options
            _quickOption(
              context,
              'In 1 hour',
              DateTime.now().add(const Duration(hours: 1)),
            ),
            _quickOption(
              context,
              'This evening (8 PM)',
              _getTimeToday(20, 0),
            ),
            _quickOption(
              context,
              'Tomorrow morning (9 AM)',
              _getTimeTomorrow(9, 0),
            ),
            _quickOption(
              context,
              'Tomorrow evening (8 PM)',
              _getTimeTomorrow(20, 0),
            ),
            
            const Divider(height: 1),
            
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.calendar_month, size: 20),
              ),
              title: const Text('Pick date & time'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                setState(() => _showCustomPicker = true);
              },
            ),
          ] else ...[
            // Custom date/time picker
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Date picker
                  InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null && mounted) {
                        setState(() => _selectedDate = date);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, color: AppColors.primary),
                          const SizedBox(width: 12),
                          Text(
                            DateFormat('EEEE, MMM d, y').format(_selectedDate),
                            style: AppTypography.bodyMedium,
                          ),
                          const Spacer(),
                          const Icon(Icons.edit, size: 16, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Time picker
                  InkWell(
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                      );
                      if (time != null && mounted) {
                        setState(() => _selectedTime = time);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time, color: AppColors.primary),
                          const SizedBox(width: 12),
                          Text(
                            _selectedTime.format(context),
                            style: AppTypography.bodyMedium,
                          ),
                          const Spacer(),
                          const Icon(Icons.edit, size: 16, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() => _showCustomPicker = false);
                          },
                          child: const Text('Back'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final scheduledTime = DateTime(
                              _selectedDate.year,
                              _selectedDate.month,
                              _selectedDate.day,
                              _selectedTime.hour,
                              _selectedTime.minute,
                            );
                            
                            if (scheduledTime.isBefore(DateTime.now())) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please select a future time')),
                              );
                              return;
                            }
                            
                            widget.onSchedule(scheduledTime);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Schedule'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
        ],
      ),
    );
  }

  Widget _quickOption(BuildContext context, String label, DateTime time) {
    final formattedTime = DateFormat('EEE, MMM d • h:mm a').format(time);
    
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.schedule, color: AppColors.primary, size: 20),
      ),
      title: Text(label, style: AppTypography.bodyMedium),
      subtitle: Text(
        formattedTime,
        style: AppTypography.caption.copyWith(color: Colors.grey),
      ),
      onTap: () => widget.onSchedule(time),
    );
  }

  DateTime _getTimeToday(int hour, int minute) {
    final now = DateTime.now();
    var time = DateTime(now.year, now.month, now.day, hour, minute);
    if (time.isBefore(now)) {
      time = time.add(const Duration(days: 1));
    }
    return time;
  }

  DateTime _getTimeTomorrow(int hour, int minute) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return DateTime(tomorrow.year, tomorrow.month, tomorrow.day, hour, minute);
  }
}
