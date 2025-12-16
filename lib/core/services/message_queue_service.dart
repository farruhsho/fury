import 'dart:async';
import 'dart:collection';
import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../features/chat/data/models/message_model.dart';

/// Message Queue Service for offline message handling
/// 
/// Features:
/// - Queue messages when offline
/// - Persist queue to disk using Hive
/// - Automatic retry with exponential backoff
/// - Sync queue when connection restored
class MessageQueueService {
  static const String _boxName = 'message_queue';
  static const int _maxRetries = 5;
  static const Duration _baseRetryDelay = Duration(seconds: 2);
  
  Box<Map>? _box;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;
  
  // Pending messages queue
  final Queue<QueuedMessage> _queue = Queue();
  
  // Callback for sending messages
  Future<bool> Function(String chatId, MessageModel message)? onSendMessage;
  
  // Status callbacks
  void Function(QueuedMessage)? onMessageQueued;
  void Function(QueuedMessage)? onMessageSent;
  void Function(QueuedMessage, String error)? onMessageFailed;
  
  bool _isProcessing = false;
  bool _isOnline = true;

  /// Initialize the queue service
  Future<void> init() async {
    _box = await Hive.openBox<Map>(_boxName);
    
    // Load persisted queue
    await _loadPersistedQueue();
    
    // Listen to connectivity changes (handle both old and new API)
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (dynamic result) {
        if (result is List<ConnectivityResult>) {
          _handleConnectivityChange(result);
        } else if (result is ConnectivityResult) {
          _handleConnectivityChange([result]);
        }
      },
    );
    
    // Check initial connectivity
    final dynamic result = await _connectivity.checkConnectivity();
    if (result is List<ConnectivityResult>) {
      _isOnline = result.any((r) => r != ConnectivityResult.none);
    } else if (result is ConnectivityResult) {
      _isOnline = result != ConnectivityResult.none;
    }
    
    // Start processing if online
    if (_isOnline) {
      _processQueue();
    }
  }
  
  Future<void> _loadPersistedQueue() async {
    final keys = _box?.keys ?? [];
    
    for (final key in keys) {
      final data = _box?.get(key);
      if (data != null) {
        try {
          final queuedMessage = QueuedMessage.fromJson(Map<String, dynamic>.from(data));
          _queue.add(queuedMessage);
        } catch (e) {
          // Remove corrupted entry
          await _box?.delete(key);
        }
      }
    }
  }
  
  void _handleConnectivityChange(List<ConnectivityResult> results) {
    final wasOnline = _isOnline;
    _isOnline = results.any((r) => r != ConnectivityResult.none);
    
    if (!wasOnline && _isOnline) {
      // Connection restored, process queue
      _processQueue();
    }
  }
  
  /// Queue a message for sending
  Future<void> queueMessage({
    required String chatId,
    required MessageModel message,
  }) async {
    final queuedMessage = QueuedMessage(
      id: message.id,
      chatId: chatId,
      message: message,
      queuedAt: DateTime.now(),
      retryCount: 0,
    );
    
    // Add to in-memory queue
    _queue.add(queuedMessage);
    
    // Persist to disk
    await _box?.put(message.id, queuedMessage.toJson());
    
    onMessageQueued?.call(queuedMessage);
    
    // Try to process immediately if online
    if (_isOnline && !_isProcessing) {
      _processQueue();
    }
  }
  
  /// Process the message queue
  Future<void> _processQueue() async {
    if (_isProcessing || _queue.isEmpty || !_isOnline) {
      return;
    }
    
    _isProcessing = true;
    
    while (_queue.isNotEmpty && _isOnline) {
      final queuedMessage = _queue.first;
      
      try {
        // Attempt to send
        final success = await onSendMessage?.call(
          queuedMessage.chatId,
          queuedMessage.message,
        ) ?? false;
        
        if (success) {
          // Remove from queue
          _queue.removeFirst();
          await _box?.delete(queuedMessage.id);
          onMessageSent?.call(queuedMessage);
        } else {
          await _handleRetry(queuedMessage);
        }
      } catch (e) {
        await _handleRetry(queuedMessage, e.toString());
      }
    }
    
    _isProcessing = false;
  }
  
  Future<void> _handleRetry(QueuedMessage queuedMessage, [String? error]) async {
    if (queuedMessage.retryCount >= _maxRetries) {
      // Max retries reached, mark as failed
      _queue.removeFirst();
      await _box?.delete(queuedMessage.id);
      onMessageFailed?.call(queuedMessage, error ?? 'Max retries exceeded');
      return;
    }
    
    // Update retry count
    final updatedMessage = queuedMessage.copyWith(
      retryCount: queuedMessage.retryCount + 1,
      lastRetryAt: DateTime.now(),
    );
    
    // Remove and re-add to end of queue
    _queue.removeFirst();
    _queue.add(updatedMessage);
    
    // Update persisted version
    await _box?.put(updatedMessage.id, updatedMessage.toJson());
    
    // Calculate exponential backoff delay
    final delay = _baseRetryDelay * (1 << updatedMessage.retryCount);
    
    // Wait before next retry
    await Future.delayed(delay);
  }
  
  /// Get current queue status
  QueueStatus get status => QueueStatus(
    pendingCount: _queue.length,
    isProcessing: _isProcessing,
    isOnline: _isOnline,
    oldestMessageAt: _queue.isNotEmpty ? _queue.first.queuedAt : null,
  );
  
  /// Get all queued messages
  List<QueuedMessage> get queuedMessages => _queue.toList();
  
  /// Remove a message from queue
  Future<void> removeFromQueue(String messageId) async {
    _queue.removeWhere((m) => m.id == messageId);
    await _box?.delete(messageId);
  }
  
  /// Clear entire queue
  Future<void> clearQueue() async {
    _queue.clear();
    await _box?.clear();
  }
  
  /// Force retry all messages
  Future<void> retryAll() async {
    if (_isOnline) {
      _processQueue();
    }
  }
  
  /// Dispose resources
  Future<void> dispose() async {
    await _connectivitySubscription?.cancel();
    await _box?.close();
  }
}

/// Represents a message in the queue
class QueuedMessage {
  final String id;
  final String chatId;
  final MessageModel message;
  final DateTime queuedAt;
  final int retryCount;
  final DateTime? lastRetryAt;
  
  const QueuedMessage({
    required this.id,
    required this.chatId,
    required this.message,
    required this.queuedAt,
    this.retryCount = 0,
    this.lastRetryAt,
  });
  
  QueuedMessage copyWith({
    String? id,
    String? chatId,
    MessageModel? message,
    DateTime? queuedAt,
    int? retryCount,
    DateTime? lastRetryAt,
  }) {
    return QueuedMessage(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      message: message ?? this.message,
      queuedAt: queuedAt ?? this.queuedAt,
      retryCount: retryCount ?? this.retryCount,
      lastRetryAt: lastRetryAt ?? this.lastRetryAt,
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'chatId': chatId,
    'message': message.toJson(),
    'queuedAt': queuedAt.toIso8601String(),
    'retryCount': retryCount,
    'lastRetryAt': lastRetryAt?.toIso8601String(),
  };
  
  factory QueuedMessage.fromJson(Map<String, dynamic> json) {
    return QueuedMessage(
      id: json['id'] as String,
      chatId: json['chatId'] as String,
      message: MessageModel.fromJson(json['message'] as Map<String, dynamic>),
      queuedAt: DateTime.parse(json['queuedAt'] as String),
      retryCount: json['retryCount'] as int? ?? 0,
      lastRetryAt: json['lastRetryAt'] != null 
          ? DateTime.parse(json['lastRetryAt'] as String)
          : null,
    );
  }
}

/// Queue status information
class QueueStatus {
  final int pendingCount;
  final bool isProcessing;
  final bool isOnline;
  final DateTime? oldestMessageAt;
  
  const QueueStatus({
    required this.pendingCount,
    required this.isProcessing,
    required this.isOnline,
    this.oldestMessageAt,
  });
  
  bool get hasPendingMessages => pendingCount > 0;
}
