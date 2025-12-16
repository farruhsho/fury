import 'package:freezed_annotation/freezed_annotation.dart';
import 'message_entity.dart';

part 'chat_entity.freezed.dart';

@freezed
class ChatEntity with _$ChatEntity {
  const factory ChatEntity({
    required String id,
    required ChatType type,
    required List<String> participantIds,
    required Map<String, ChatParticipantEntity> participants,
    MessageEntity? lastMessage,
    @Default(0) int unreadCount,
    String? name,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ChatEntity;
}

enum ChatType {
  private,
  group,
  channel,
}


@freezed
class ChatParticipantEntity with _$ChatParticipantEntity {
  const factory ChatParticipantEntity({
    required String userId,
    required String displayName,
    String? avatarUrl,
    @Default(false) bool isOnline,
    DateTime? lastSeen,
  }) = _ChatParticipantEntity;
}
