import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/errors/error_handler.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/usecases/get_messages_usecase.dart';
import '../../../domain/usecases/mark_messages_as_read_usecase.dart';
import '../../../domain/usecases/send_message_usecase.dart';
import '../../../domain/usecases/send_attachment_usecase.dart';
import '../../../domain/usecases/edit_message_usecase.dart';
import '../../../domain/usecases/delete_message_usecase.dart';
import '../../../domain/usecases/react_to_message_usecase.dart';
import '../../../domain/usecases/retry_message_usecase.dart';

part 'message_event.dart';
part 'message_state.dart';
part 'message_bloc.freezed.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final SendAttachmentUseCase sendAttachmentUseCase;
  final MarkMessagesAsReadUseCase markMessagesAsReadUseCase;
  final EditMessageUseCase editMessageUseCase;
  final DeleteMessageUseCase deleteMessageUseCase;
  final ReactToMessageUseCase reactToMessageUseCase;
  final RetryMessageUseCase retryMessageUseCase;

  String? _currentChatId;

  MessageBloc({
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
    required this.sendAttachmentUseCase,
    required this.markMessagesAsReadUseCase,
    required this.editMessageUseCase,
    required this.deleteMessageUseCase,
    required this.reactToMessageUseCase,
    required this.retryMessageUseCase,
  }) : super(const MessageState.initial()) {
    on<_LoadMessages>(_onLoadMessages);
    on<_SendMessage>(_onSendMessage);
    on<_SendAttachment>(_onSendAttachment);
    on<_SendVoiceMessage>(_onSendVoiceMessage);
    on<_MarkAsRead>(_onMarkAsRead);
    on<_EditMessage>(_onEditMessage);
    on<_DeleteMessage>(_onDeleteMessage);
    on<_ReactToMessage>(_onReactToMessage);
    on<_ForwardMessage>(_onForwardMessage);
    on<_SearchMessages>(_onSearchMessages);
    on<_PinMessage>(_onPinMessage);
    on<_UnpinMessage>(_onUnpinMessage);
    on<_RetryMessage>(_onRetryMessage);
  }

  Future<void> _onLoadMessages(_LoadMessages event, Emitter<MessageState> emit) async {
    print('📨 [MESSAGE_BLOC] Loading messages for chat: ${event.chatId}');
    emit(const MessageState.loading());
    _currentChatId = event.chatId;
    
    await emit.forEach(
      getMessagesUseCase(event.chatId),
      onData: (result) => result.fold(
        (failure) {
          print('❌ [MESSAGE_BLOC] Error loading messages: ${ErrorHandler.getUserMessage(failure)}');
          return MessageState.error(ErrorHandler.getUserMessage(failure));
        },
        (messages) {
          print('✅ [MESSAGE_BLOC] Loaded ${messages.length} messages');
          return MessageState.loaded(messages);
        },
      ),
      onError: (error, stackTrace) {
        print('❌ [MESSAGE_BLOC] Stream error: $error');
        return MessageState.error(error.toString());
      },
    );
  }

  Future<void> _onSendMessage(_SendMessage event, Emitter<MessageState> emit) async {
    print('📤 [MESSAGE_BLOC] Sending message to chat: ${event.chatId}');
    print('📤 [MESSAGE_BLOC] Text: ${event.text}');
    
    final result = await sendMessageUseCase(
      chatId: event.chatId,
      text: event.text,
      replyToId: event.replyTo,
    );

    result.fold(
      (failure) {
        print('❌ [MESSAGE_BLOC] Failed to send message: ${ErrorHandler.getUserMessage(failure)}');
        emit(MessageState.error(ErrorHandler.getUserMessage(failure)));
      },
      (_) {
        print('✅ [MESSAGE_BLOC] Message sent successfully');
        // Success. The stream will update the UI.
      },
    );
  }

  Future<void> _onSendAttachment(_SendAttachment event, Emitter<MessageState> emit) async {
    // Convert string type to AttachmentType enum
    final attachmentType = _parseAttachmentType(event.type);
    
    final result = await sendAttachmentUseCase(
      chatId: event.chatId,
      file: event.file,
      type: attachmentType,
      replyToId: event.replyTo,
    );

    result.fold(
      (failure) => emit(MessageState.error(ErrorHandler.getUserMessage(failure))),
      (_) {},
    );
  }

  Future<void> _onSendVoiceMessage(_SendVoiceMessage event, Emitter<MessageState> emit) async {
    // Use attachment usecase with audio type
    final result = await sendAttachmentUseCase(
      chatId: event.chatId,
      file: event.audioFile,
      type: AttachmentType.audio,
      replyToId: null,
    );

    result.fold(
      (failure) => emit(MessageState.error(ErrorHandler.getUserMessage(failure))),
      (_) {},
    );
  }

  Future<void> _onMarkAsRead(_MarkAsRead event, Emitter<MessageState> emit) async {
    final result = await markMessagesAsReadUseCase(event.chatId);
    
    result.fold(
      (failure) {
        // Silently fail for read receipts
      },
      (_) {},
    );
  }

  Future<void> _onEditMessage(_EditMessage event, Emitter<MessageState> emit) async {
    if (_currentChatId == null) return;
    
    final result = await editMessageUseCase(
      chatId: _currentChatId!,
      messageId: event.messageId,
      newText: event.newText,
    );

    result.fold(
      (failure) => emit(MessageState.error(ErrorHandler.getUserMessage(failure))),
      (_) {},
    );
  }

  Future<void> _onDeleteMessage(_DeleteMessage event, Emitter<MessageState> emit) async {
    if (_currentChatId == null) return;
    
    final result = await deleteMessageUseCase(
      chatId: _currentChatId!,
      messageId: event.messageId,
      deleteForEveryone: event.forEveryone,
    );

    result.fold(
      (failure) => emit(MessageState.error(ErrorHandler.getUserMessage(failure))),
      (_) {},
    );
  }

  Future<void> _onReactToMessage(_ReactToMessage event, Emitter<MessageState> emit) async {
    if (_currentChatId == null) return;
    
    final result = await reactToMessageUseCase(
      chatId: _currentChatId!,
      messageId: event.messageId,
      emoji: event.emoji,
    );

    result.fold(
      (failure) => emit(MessageState.error(ErrorHandler.getUserMessage(failure))),
      (_) {},
    );
  }

  Future<void> _onForwardMessage(_ForwardMessage event, Emitter<MessageState> emit) async {
    if (_currentChatId == null) return;
    
    // Forward message to each target chat
    for (final targetChatId in event.targetChatIds) {
      final result = await sendMessageUseCase(
        chatId: targetChatId,
        text: '[Forwarded] ${event.originalText}',
        replyToId: null,
      );
      
      result.fold(
        (failure) => debugPrint('❌ Forward to $targetChatId failed'),
        (_) => debugPrint('✅ Forwarded to $targetChatId'),
      );
    }
  }

  Future<void> _onSearchMessages(_SearchMessages event, Emitter<MessageState> emit) async {
    // Search is handled client-side in ChatSearchWidget
    // This event could be used for server-side search if needed
    debugPrint('🔍 [MESSAGE_BLOC] Search query: ${event.query}');
  }

  Future<void> _onPinMessage(_PinMessage event, Emitter<MessageState> emit) async {
    if (_currentChatId == null) return;
    
    try {
      await editMessageUseCase.pinMessage(
        chatId: _currentChatId!,
        messageId: event.messageId,
      );
      debugPrint('📌 [MESSAGE_BLOC] Message pinned: ${event.messageId}');
    } catch (e) {
      emit(MessageState.error('Failed to pin message: $e'));
    }
  }

  Future<void> _onUnpinMessage(_UnpinMessage event, Emitter<MessageState> emit) async {
    if (_currentChatId == null) return;
    
    try {
      await editMessageUseCase.unpinMessage(
        chatId: _currentChatId!,
        messageId: event.messageId,
      );
      debugPrint('📌 [MESSAGE_BLOC] Message unpinned: ${event.messageId}');
    } catch (e) {
      emit(MessageState.error('Failed to unpin message: $e'));
    } catch (e) {
      emit(MessageState.error('Failed to unpin message: $e'));
    }
  }

  Future<void> _onRetryMessage(_RetryMessage event, Emitter<MessageState> emit) async {
    final result = await retryMessageUseCase(event.messageId);
    
    result.fold(
      (failure) => emit(MessageState.error(ErrorHandler.getUserMessage(failure))),
      (_) => debugPrint('✅ Retrying message ${event.messageId}'),
    );
  }

  AttachmentType _parseAttachmentType(String type) {
    switch (type.toLowerCase()) {
      case 'image':
        return AttachmentType.image;
      case 'video':
        return AttachmentType.video;
      case 'audio':
        return AttachmentType.audio;
      case 'document':
      default:
        return AttachmentType.document;
    }
  }
}
