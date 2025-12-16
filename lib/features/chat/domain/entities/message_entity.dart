import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_entity.freezed.dart';

@freezed
class MessageEntity with _$MessageEntity {
  const factory MessageEntity({
    required String id,
    required String chatId,
    required String senderId,
    required MessageType type,
    String? text,
    List<AttachmentEntity>? attachments,
    MessageEntity? replyTo,
    String? forwardedFrom,
    @Default([]) List<ReactionEntity> reactions,
    @Default(MessageStatus.sending) MessageStatus status,
    @Default(false) bool isPinned,
    required DateTime createdAt,
    DateTime? editedAt,
    DateTime? deletedAt,
  }) = _MessageEntity;
}

enum MessageType {
  text,
  image,
  video,
  audio,
  document,
  location,
  contact,
}

enum AttachmentType {
  image,
  video,
  audio,
  document,
}

enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
  failed,
}


@freezed
class AttachmentEntity with _$AttachmentEntity {
  const factory AttachmentEntity({
    required String id,
    required String url,
    required AttachmentType type,
    String? thumbnailUrl,
    String? fileName,
    int? size,
  }) = _AttachmentEntity;
}

@freezed
class ReactionEntity with _$ReactionEntity {
  const factory ReactionEntity({
    required String emoji,
    required String userId,
    required DateTime createdAt,
  }) = _ReactionEntity;
}
