part of 'message_bloc.dart';

@freezed
class MessageEvent with _$MessageEvent {
  const factory MessageEvent.loadMessages(String chatId) = _LoadMessages;
  
  const factory MessageEvent.sendMessage({
    required String chatId,
    required String text,
    String? replyTo,
  }) = _SendMessage;
  
  const factory MessageEvent.sendAttachment({
    required String chatId,
    required File file,
    required String type,
    File? thumbnail,
    String? replyTo,
  }) = _SendAttachment;
  
  const factory MessageEvent.sendVoiceMessage({
    required String chatId,
    required File audioFile,
    required int duration,
    required List<double> waveform,
  }) = _SendVoiceMessage;
  
  const factory MessageEvent.markAsRead(String chatId) = _MarkAsRead;
  
  const factory MessageEvent.editMessage({
    required String messageId,
    required String newText,
  }) = _EditMessage;
  
  const factory MessageEvent.deleteMessage({
    required String messageId,
    @Default(false) bool forEveryone,
  }) = _DeleteMessage;
  
  const factory MessageEvent.forwardMessage({
    required String messageId,
    required String originalText,
    required List<String> targetChatIds,
  }) = _ForwardMessage;
  
  const factory MessageEvent.reactToMessage({
    required String messageId,
    required String emoji,
  }) = _ReactToMessage;
  
  const factory MessageEvent.searchMessages({
    required String chatId,
    required String query,
  }) = _SearchMessages;
  
  const factory MessageEvent.pinMessage(String messageId) = _PinMessage;
  
  const factory MessageEvent.unpinMessage(String messageId) = _UnpinMessage;
  
  const factory MessageEvent.retryMessage(String messageId) = _RetryMessage;
}
