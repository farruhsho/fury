part of 'message_bloc.dart';

@freezed
class MessageState with _$MessageState {
  const factory MessageState.initial() = _Initial;
  const factory MessageState.loading() = _Loading;
  const factory MessageState.loaded(List<MessageEntity> messages) = _Loaded;
  const factory MessageState.error(String message) = _Error;
}
