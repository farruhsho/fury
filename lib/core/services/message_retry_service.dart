import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive/hive.dart';

/// Service for handling failed message retries and offline queue
class MessageRetryService {
  static const String _boxName = 'failed_messages';
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  
  final Queue<FailedMessage> _retryQueue = Queue();
  Timer? _retryTimer;
  bool _isProcessing = false;

  /// Initialize the service and load pending messages
  Future<void> init() async {
    try {
      final box = await Hive.openBox<Map>(_boxName);
      
      // Load failed messages from local storage
      for (var i = 0; i < box.length; i++) {
        final data = box.getAt(i);
        if (data != null) {
          _retryQueue.add(FailedMessage.fromMap(Map<String, dynamic>.from(data)));
        }
      }
      
      print('📤 [RETRY] Loaded ${_retryQueue.length} pending messages');
      
      // Start retry timer
      _startRetryTimer();
    } catch (e) {
      print('❌ [RETRY] Failed to init: $e');
    }
  }

  void _startRetryTimer() {
    _retryTimer?.cancel();
    _retryTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _processQueue();
    });
  }

  /// Add a failed message to the retry queue
  Future<void> addToQueue(FailedMessage message) async {
    _retryQueue.add(message);
    
    // Persist to local storage
    try {
      final box = await Hive.openBox<Map>(_boxName);
      await box.add(message.toMap());
    } catch (e) {
      print('❌ [RETRY] Failed to persist message: $e');
    }
    
    print('📤 [RETRY] Added message to queue: ${message.id}');
  }

  /// Process the retry queue
  Future<void> _processQueue() async {
    if (_isProcessing || _retryQueue.isEmpty) return;
    
    _isProcessing = true;
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      _isProcessing = false;
      return;
    }

    print('📤 [RETRY] Processing ${_retryQueue.length} messages...');

    final successfulIds = <String>[];

    for (final message in _retryQueue.toList()) {
      try {
        if (message.retryCount >= 5) {
          // Max retries reached, mark as permanently failed
          print('❌ [RETRY] Max retries for ${message.id}');
          continue;
        }

        bool success = false;

        if (message.type == FailedMessageType.text) {
          success = await _retryTextMessage(message);
        } else if (message.type == FailedMessageType.attachment) {
          success = await _retryAttachment(message);
        }

        if (success) {
          successfulIds.add(message.id);
          print('✅ [RETRY] Sent ${message.id}');
        } else {
          message.retryCount++;
        }
      } catch (e) {
        print('❌ [RETRY] Error processing ${message.id}: $e');
        message.retryCount++;
      }
    }

    // Remove successful messages
    _retryQueue.removeWhere((m) => successfulIds.contains(m.id));
    
    // Update local storage
    try {
      final box = await Hive.openBox<Map>(_boxName);
      await box.clear();
      for (final msg in _retryQueue) {
        await box.add(msg.toMap());
      }
    } catch (e) {
      print('❌ [RETRY] Failed to update storage: $e');
    }

    _isProcessing = false;
  }

  Future<bool> _retryTextMessage(FailedMessage message) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return false;

      await _firestore
          .collection('chats')
          .doc(message.chatId)
          .collection('messages')
          .doc(message.id)
          .set({
        'senderId': userId,
        'text': message.text,
        'type': 'text',
        'status': 'sent',
        'createdAt': FieldValue.serverTimestamp(),
        'replyToId': message.replyToId,
      });

      return true;
    } catch (e) {
      print('❌ [RETRY] Text send failed: $e');
      return false;
    }
  }

  Future<bool> _retryAttachment(FailedMessage message) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null || message.filePath == null) return false;

      final file = File(message.filePath!);
      if (!await file.exists()) {
        print('❌ [RETRY] File not found: ${message.filePath}');
        return false;
      }

      // Upload file
      final ref = _storage.ref()
          .child('chats')
          .child(message.chatId)
          .child('${DateTime.now().millisecondsSinceEpoch}_${message.fileName}');

      await ref.putFile(file);
      final url = await ref.getDownloadURL();

      // Create message
      await _firestore
          .collection('chats')
          .doc(message.chatId)
          .collection('messages')
          .doc(message.id)
          .set({
        'senderId': userId,
        'type': message.attachmentType,
        'status': 'sent',
        'createdAt': FieldValue.serverTimestamp(),
        'attachments': [
          {
            'url': url,
            'type': message.attachmentType,
            'name': message.fileName,
          }
        ],
      });

      return true;
    } catch (e) {
      print('❌ [RETRY] Attachment upload failed: $e');
      return false;
    }
  }

  /// Manually retry all failed messages
  Future<void> retryAll() async {
    await _processQueue();
  }

  /// Get pending message count
  int get pendingCount => _retryQueue.length;

  /// Get all pending messages for UI
  List<FailedMessage> get pendingMessages => _retryQueue.toList();

  /// Remove a message from queue
  Future<void> removeFromQueue(String messageId) async {
    _retryQueue.removeWhere((m) => m.id == messageId);
    
    try {
      final box = await Hive.openBox<Map>(_boxName);
      await box.clear();
      for (final msg in _retryQueue) {
        await box.add(msg.toMap());
      }
    } catch (e) {
      print('❌ [RETRY] Failed to update storage: $e');
    }
  }

  void dispose() {
    _retryTimer?.cancel();
  }
}

enum FailedMessageType { text, attachment }

class FailedMessage {
  final String id;
  final String chatId;
  final FailedMessageType type;
  final String? text;
  final String? filePath;
  final String? fileName;
  final String? attachmentType;
  final String? replyToId;
  int retryCount;
  final DateTime createdAt;

  FailedMessage({
    required this.id,
    required this.chatId,
    required this.type,
    this.text,
    this.filePath,
    this.fileName,
    this.attachmentType,
    this.replyToId,
    this.retryCount = 0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
    'id': id,
    'chatId': chatId,
    'type': type.name,
    'text': text,
    'filePath': filePath,
    'fileName': fileName,
    'attachmentType': attachmentType,
    'replyToId': replyToId,
    'retryCount': retryCount,
    'createdAt': createdAt.toIso8601String(),
  };

  factory FailedMessage.fromMap(Map<String, dynamic> map) => FailedMessage(
    id: map['id'] as String,
    chatId: map['chatId'] as String,
    type: FailedMessageType.values.byName(map['type'] as String),
    text: map['text'] as String?,
    filePath: map['filePath'] as String?,
    fileName: map['fileName'] as String?,
    attachmentType: map['attachmentType'] as String?,
    replyToId: map['replyToId'] as String?,
    retryCount: map['retryCount'] as int? ?? 0,
    createdAt: DateTime.tryParse(map['createdAt'] as String? ?? '') ?? DateTime.now(),
  );
}
