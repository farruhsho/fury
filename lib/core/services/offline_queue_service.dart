import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';


import '../../features/chat/domain/repositories/chat_repository.dart';
import '../../features/chat/domain/entities/message_entity.dart' show AttachmentType;

class OfflineQueueService {
  static const String _boxName = 'offline_messages';
  static const int _maxRetries = 5;
  
  Box? _box;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;
  bool _isProcessing = false;
  
  // Stream controller to broadcast queue updates to UI
  final _queueController = StreamController<List<Map<String, dynamic>>>.broadcast();
  Stream<List<Map<String, dynamic>>> get queueStream => _queueController.stream;
  
  // Dependencies
  ChatRepository? _chatRepository;

  // Set repository lazily or via setter to avoid circular dependency in di
  void setChatRepository(ChatRepository repo) {
    _chatRepository = repo;
  }

  Future<void> init() async {
    try {
      if (!Hive.isBoxOpen(_boxName)) {
        _box = await Hive.openBox(_boxName);
      } else {
        _box = Hive.box(_boxName);
      }
      
      // Emit initial state
      _emitQueueUpdate();
      
      // Check for unsent messages immediately if online
      _processQueue();
      
      // Listen for connectivity changes
      _connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
        if (result == ConnectivityResult.mobile || 
            result == ConnectivityResult.wifi || 
            result == ConnectivityResult.ethernet) {
          debugPrint('🌐 [OFFLINE_QUEUE] Online! Processing queue...');
          _processQueue();
        }
      });
    } catch (e) {
      debugPrint('❌ [OFFLINE_QUEUE] Failed to init: $e');
    }
  }

  Future<void> addMessage({
    required String chatId,
    required String text,
    required String senderId,
    String? replyToId,
  }) async {
    await _addRequest({
      'id': const Uuid().v4(),
      'chatId': chatId,
      'text': text,
      'senderId': senderId,
      'replyToId': replyToId,
      'timestamp': DateTime.now().toIso8601String(),
      'type': 'text',
      'status': 'sending', // sending, failed
      'retryCount': 0,
    });
  }

  Future<void> addAttachmentMessage({
    required String chatId,
    required String filePath,
    required AttachmentType attachmentType,
    String? replyToId,
  }) async {
    await _addRequest({
      'id': const Uuid().v4(),
      'chatId': chatId,
      'filePath': filePath,
      'attachmentTypeIndex': attachmentType.index,
      'replyToId': replyToId,
      'timestamp': DateTime.now().toIso8601String(),
      'type': 'attachment',
      'status': 'sending', // sending, failed
      'retryCount': 0,
    });
  }

  Future<void> _addRequest(Map<String, dynamic> data) async {
    try {
      if (_box == null) await init();
      // Use message ID as key for easier updates
      await _box?.put(data['id'], data);
      debugPrint('📦 [OFFLINE_QUEUE] Added ${data['type']} to queue. Total: ${_box?.length}');
      _emitQueueUpdate();
      _processQueue();
    } catch (e) {
      debugPrint('❌ [OFFLINE_QUEUE] Failed to add request: $e');
    }
  }
  
  /// Manually retry a specific message
  Future<void> retryMessage(String messageId) async {
    if (_box == null) return;
    
    final data = _box!.get(messageId);
    if (data != null) {
      final map = Map<String, dynamic>.from(data is String ? jsonDecode(data) : data);
      
      // Reset retry count and status
      map['retryCount'] = 0;
      map['status'] = 'sending';
      
      await _box!.put(messageId, map);
      _emitQueueUpdate();
      _processQueue();
    }
  }
  
  /// Delete a message from the queue
  Future<void> deleteMessage(String messageId) async {
    await _box?.delete(messageId);
    _emitQueueUpdate();
  }

  void _emitQueueUpdate() {
    if (_box == null) return;
    
    final messages = _box!.values.map((e) {
      return Map<String, dynamic>.from(e is String ? jsonDecode(e) : e);
    }).toList();
    
    // Sort by timestamp
    messages.sort((a, b) {
      final t1 = DateTime.tryParse(a['timestamp'] ?? '') ?? DateTime.now();
      final t2 = DateTime.tryParse(b['timestamp'] ?? '') ?? DateTime.now();
      return t2.compareTo(t1); // Newest first
    });
    
    _queueController.add(messages);
  }

  Future<void> _processQueue() async {
    if (_isProcessing || _box == null || _box!.isEmpty || _chatRepository == null) return;
    
    // Check connectivity first
    // Check connectivity first
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return;
    }

    _isProcessing = true;
    
    try {
      // Get all keys
      final keys = _box!.keys.toList();
      
      for (final key in keys) {
        try {
          final data = _box!.get(key);
          if (data == null) continue;
          
          final map = Map<String, dynamic>.from(data is String ? jsonDecode(data) : data);
          
          // Skip messages that have failed max times (wait for user to retry)
          if (map['status'] == 'failed') continue;
          
          if (map['type'] == 'text') {
            await _processTextMessage(map, key);
          } else if (map['type'] == 'attachment') {
            await _processAttachmentMessage(map, key);
          }
        } catch (e) {
          debugPrint('❌ [OFFLINE_QUEUE] Error processing message at key $key: $e');
        }
      }
    } catch (e) {
      debugPrint('❌ [OFFLINE_QUEUE] Queue processing loop error: $e');
    } finally {
      _isProcessing = false;
    }
  }
  
  Future<void> _processTextMessage(Map<String, dynamic> map, dynamic key) async {
    debugPrint('📤 [OFFLINE_QUEUE] Sending message ${map['id']}...');
    
    final result = await _chatRepository!.sendMessage(
      chatId: map['chatId'],
      text: map['text'],
      replyToId: map['replyToId'],
    );
    
    await _handleResult(result, key, map);
  }
  
  Future<void> _processAttachmentMessage(Map<String, dynamic> map, dynamic key) async {
    debugPrint('📤 [OFFLINE_QUEUE] Sending attachment ${map['id']}...');
    
    final filePath = map['filePath'] as String;
    final file = File(filePath);
    
    if (!file.existsSync()) {
      debugPrint('❌ [OFFLINE_QUEUE] File not found: $filePath. Deleting from queue.');
      await _box!.delete(key);
      _emitQueueUpdate();
      return;
    }
    
    final typeIndex = map['attachmentTypeIndex'] as int;
    final type = AttachmentType.values[typeIndex];
    
    final result = await _chatRepository!.sendAttachmentMessage(
      chatId: map['chatId'],
      file: file,
      type: type,
      replyToId: map['replyToId'],
    );
    
    await _handleResult(result, key, map);
  }
  
  Future<void> _handleResult(dynamic result, dynamic key, Map<String, dynamic> map) async {
    await result.fold(
      (failure) async {
        debugPrint('❌ [OFFLINE_QUEUE] Failed to send ${map['id']}: ${failure.message}');
        
        // Increment retry count
        final retryCount = (map['retryCount'] ?? 0) + 1;
        map['retryCount'] = retryCount;
        
        if (retryCount >= _maxRetries) {
          map['status'] = 'failed';
          debugPrint('❌ [OFFLINE_QUEUE] Max retries reached for ${map['id']}');
        }
        
        await _box!.put(key, map);
        _emitQueueUpdate();
      },
      (_) async {
        debugPrint('✅ [OFFLINE_QUEUE] Sent ${map['id']} successfully!');
        await _box!.delete(key);
        _emitQueueUpdate();
      },
    );
  }
  
  void dispose() {
    _connectivitySubscription?.cancel();
    _queueController.close();
  }
}
