part of 'chat_bloc.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState.initial() = _Initial;
  const factory ChatState.loading() = _Loading;
  const factory ChatState.loaded(List<ChatEntity> chats) = _Loaded;
  const factory ChatState.error(String message) = _Error;
  const factory ChatState.chatCreated(String chatId) = _ChatCreated;
}
