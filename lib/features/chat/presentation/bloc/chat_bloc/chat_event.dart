part of 'chat_bloc.dart';

@freezed
class ChatEvent with _$ChatEvent {
  const factory ChatEvent.loadChats() = _LoadChats;
  const factory ChatEvent.createChat({
    required List<String> participantIds,
    required ChatType type,
    String? groupName,
  }) = _CreateChat;
}
