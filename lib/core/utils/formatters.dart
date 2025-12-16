import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Formatters for dates, times, and other data
class Formatters {
  /// Format date time to time string (HH:mm)
  static String formatTime(DateTime dateTime) {
    return DateFormat.Hm().format(dateTime);
  }
  
  /// Format date time to date string (MMM dd, yyyy)
  static String formatDate(DateTime dateTime) {
    return DateFormat.yMMMd().format(dateTime);
  }
  
  /// Format date time to full string (MMM dd, yyyy HH:mm)
  static String formatDateTime(DateTime dateTime) {
    return DateFormat.yMMMd().add_Hm().format(dateTime);
  }
  
  /// Format date time to chat list format
  /// - Today: HH:mm
  /// - Yesterday: Yesterday
  /// - This week: Day name
  /// - Older: MMM dd
  static String formatChatListTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    if (messageDate == today) {
      return formatTime(dateTime);
    } else if (messageDate == yesterday) {
      return 'Yesterday';
    } else if (now.difference(messageDate).inDays < 7) {
      return DateFormat.E().format(dateTime);
    } else if (now.year == dateTime.year) {
      return DateFormat.MMMd().format(dateTime);
    } else {
      return DateFormat.yMMMd().format(dateTime);
    }
  }
  
  /// Format date time to message timestamp
  /// - Today: HH:mm
  /// - Yesterday: Yesterday HH:mm
  /// - Older: MMM dd HH:mm
  static String formatMessageTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    if (messageDate == today) {
      return formatTime(dateTime);
    } else if (messageDate == yesterday) {
      return 'Yesterday ${formatTime(dateTime)}';
    } else {
      return '${DateFormat.MMMd().format(dateTime)} ${formatTime(dateTime)}';
    }
  }
  
  /// Format date time to relative time (e.g., "2 hours ago")
  static String formatRelativeTime(DateTime dateTime) {
    return timeago.format(dateTime);
  }
  
  /// Format last seen time
  static String formatLastSeen(DateTime? lastSeen) {
    if (lastSeen == null) {
      return 'Last seen recently';
    }
    
    final now = DateTime.now();
    final difference = now.difference(lastSeen);
    
    if (difference.inMinutes < 1) {
      return 'Last seen just now';
    } else if (difference.inMinutes < 60) {
      return 'Last seen ${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      return 'Last seen ${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      return 'Last seen ${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else {
      return 'Last seen ${formatDate(lastSeen)}';
    }
  }
  
  /// Format file size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }
  
  /// Format duration (for voice messages, calls)
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }
  
  /// Format phone number
  static String formatPhoneNumber(String phoneNumber) {
    // Remove all non-digit characters
    final digits = phoneNumber.replaceAll(RegExp(r'\D'), '');
    
    if (digits.isEmpty) {
      return phoneNumber;
    }
    
    // Format based on length
    if (digits.length <= 10) {
      // Format as (XXX) XXX-XXXX
      if (digits.length == 10) {
        return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
      }
      return phoneNumber;
    } else {
      // International format: +X XXX XXX XXXX
      return '+${digits.substring(0, digits.length - 10)} ${digits.substring(digits.length - 10, digits.length - 7)} ${digits.substring(digits.length - 7, digits.length - 4)} ${digits.substring(digits.length - 4)}';
    }
  }
  
  /// Format member count
  static String formatMemberCount(int count) {
    if (count < 1000) {
      return count.toString();
    } else if (count < 1000000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    }
  }
  
  /// Format unread count
  static String formatUnreadCount(int count) {
    if (count < 100) {
      return count.toString();
    } else {
      return '99+';
    }
  }
}
