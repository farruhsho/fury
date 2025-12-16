import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

/// Enhanced Message Status Indicator showing sending/sent/delivered/read states
class MessageStatusIndicator extends StatelessWidget {
  final String status;
  final Map<String, dynamic>? readBy;
  final bool isMe;
  final double size;

  const MessageStatusIndicator({
    super.key,
    required this.status,
    this.readBy,
    this.isMe = true,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    if (!isMe) return const SizedBox.shrink();

    switch (status.toLowerCase()) {
      case 'sending':
        return _buildClock();
      case 'sent':
        return _buildSingleCheck(Colors.grey);
      case 'delivered':
        return _buildDoubleCheck(Colors.grey);
      case 'read':
        return _buildDoubleCheck(AppColors.primary);
      case 'failed':
        return _buildFailed();
      default:
        return _buildSingleCheck(Colors.grey);
    }
  }

  Widget _buildClock() {
    return SizedBox(
      width: size,
      height: size,
      child: Icon(
        Icons.access_time,
        size: size - 2,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildSingleCheck(Color color) {
    return Icon(
      Icons.check,
      size: size,
      color: color,
    );
  }

  Widget _buildDoubleCheck(Color color) {
    return SizedBox(
      width: size + 8,
      height: size,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Icon(
              Icons.check,
              size: size,
              color: color,
            ),
          ),
          Positioned(
            left: 8,
            child: Icon(
              Icons.check,
              size: size,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFailed() {
    return Icon(
      Icons.error_outline,
      size: size,
      color: Colors.red,
    );
  }
}

/// Message status with real-time updates
class LiveMessageStatus extends StatelessWidget {
  final String messageId;
  final String chatId;
  final String senderId;
  final String currentUserId;
  final String status;
  final Map<String, dynamic>? readBy;
  final double size;

  const LiveMessageStatus({
    super.key,
    required this.messageId,
    required this.chatId,
    required this.senderId,
    required this.currentUserId,
    required this.status,
    this.readBy,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    // Only show for sender's own messages
    if (senderId != currentUserId) {
      return const SizedBox.shrink();
    }

    // Calculate actual status based on readBy map
    String actualStatus = status;
    
    if (readBy != null && readBy!.isNotEmpty) {
      // Check if any other user has read the message
      final otherReaders = readBy!.keys.where((k) => k != currentUserId);
      if (otherReaders.isNotEmpty) {
        actualStatus = 'read';
      }
    }

    return MessageStatusIndicator(
      status: actualStatus,
      readBy: readBy,
      isMe: true,
      size: size,
    );
  }
}

/// Status enum for message states
enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
  failed;

  String get displayName {
    switch (this) {
      case MessageStatus.sending:
        return 'Sending...';
      case MessageStatus.sent:
        return 'Sent';
      case MessageStatus.delivered:
        return 'Delivered';
      case MessageStatus.read:
        return 'Read';
      case MessageStatus.failed:
        return 'Failed';
    }
  }

  static MessageStatus fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'sending':
        return MessageStatus.sending;
      case 'sent':
        return MessageStatus.sent;
      case 'delivered':
        return MessageStatus.delivered;
      case 'read':
        return MessageStatus.read;
      case 'failed':
        return MessageStatus.failed;
      default:
        return MessageStatus.sent;
    }
  }
}
