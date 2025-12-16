import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String id,
    required String chatId,
    required String senderId,
    required MessageType type,
    String? text,
    List<AttachmentModel>? attachments,
    MessageModel? replyTo,
    String? forwardedFrom,
    @Default([]) List<ReactionModel> reactions,
    @Default(MessageStatus.sending) MessageStatus status,
    @Default({}) Map<String, String> readBy,
    @Default({}) Map<String, String> deliveredTo,
    DateTime? editedAt,
    DateTime? deletedAt,
    @Default(false) bool isDeleted,
    @Default([]) List<String> deletedBy, // User IDs who deleted this message for themselves
    @Default(false) bool isPinned,
    required DateTime createdAt,
    LinkPreviewModel? linkPreview,
    LocationModel? location,
    ContactModel? contact,
    PollModel? poll,
    VoiceNoteModel? voiceNote,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) => 
      _$MessageModelFromJson(json);
      
  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    // Helper function to parse date that might be Timestamp or String
    String? parseDate(dynamic value) {
      if (value == null) return null;
      if (value is Timestamp) return value.toDate().toIso8601String();
      if (value is String) return value;
      return null;
    }
    
    return MessageModel.fromJson({
      ...data,
      'id': doc.id,
      'createdAt': parseDate(data['createdAt']) ?? DateTime.now().toIso8601String(),
      'editedAt': parseDate(data['editedAt']),
      'editedAt': parseDate(data['editedAt']),
      'deletedAt': parseDate(data['deletedAt']),
      'deletedBy': List<String>.from(data['deletedBy'] ?? []),
    });
  }
}

enum MessageType {
  @JsonValue('text')
  text,
  @JsonValue('image')
  image,
  @JsonValue('video')
  video,
  @JsonValue('audio')
  audio,
  @JsonValue('voice')
  voice,
  @JsonValue('document')
  document,
  @JsonValue('location')
  location,
  @JsonValue('contact')
  contact,
  @JsonValue('sticker')
  sticker,
  @JsonValue('gif')
  gif,
  @JsonValue('poll')
  poll,
  @JsonValue('system')
  system,
}

enum MessageStatus {
  @JsonValue('sending')
  sending,
  @JsonValue('sent')
  sent,
  @JsonValue('delivered')
  delivered,
  @JsonValue('read')
  read,
  @JsonValue('failed')
  failed,
}

@freezed
class AttachmentModel with _$AttachmentModel {
  const factory AttachmentModel({
    required String id,
    required String url,
    required String localPath,
    required AttachmentType type,
    required String mimeType,
    required int size,
    String? thumbnailUrl,
    String? thumbnailLocalPath,
    String? fileName,
    int? width,
    int? height,
    int? duration,
    String? blurHash,
    @Default(UploadStatus.pending) UploadStatus uploadStatus,
    double? uploadProgress,
  }) = _AttachmentModel;

  factory AttachmentModel.fromJson(Map<String, dynamic> json) => 
      _$AttachmentModelFromJson(json);
}

enum AttachmentType {
  @JsonValue('image')
  image,
  @JsonValue('video')
  video,
  @JsonValue('audio')
  audio,
  @JsonValue('document')
  document,
}

enum UploadStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('uploading')
  uploading,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
}

@freezed
class ReactionModel with _$ReactionModel {
  const factory ReactionModel({
    required String emoji,
    required String userId,
    required DateTime createdAt,
  }) = _ReactionModel;

  factory ReactionModel.fromJson(Map<String, dynamic> json) => 
      _$ReactionModelFromJson(json);
}

@freezed
class VoiceNoteModel with _$VoiceNoteModel {
  const factory VoiceNoteModel({
    required String url,
    required String localPath,
    required int duration,
    required List<double> waveform,
    @Default(false) bool isPlayed,
  }) = _VoiceNoteModel;

  factory VoiceNoteModel.fromJson(Map<String, dynamic> json) => 
      _$VoiceNoteModelFromJson(json);
}

@freezed
class LinkPreviewModel with _$LinkPreviewModel {
  const factory LinkPreviewModel({
    required String url,
    String? title,
    String? description,
    String? imageUrl,
    String? siteName,
    String? favicon,
  }) = _LinkPreviewModel;

  factory LinkPreviewModel.fromJson(Map<String, dynamic> json) => 
      _$LinkPreviewModelFromJson(json);
}

@freezed
class LocationModel with _$LocationModel {
  const factory LocationModel({
    required double latitude,
    required double longitude,
    String? address,
    String? name,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) => 
      _$LocationModelFromJson(json);
}

@freezed
class ContactModel with _$ContactModel {
  const factory ContactModel({
    required String name,
    required String phoneNumber,
    String? avatarUrl,
  }) = _ContactModel;

  factory ContactModel.fromJson(Map<String, dynamic> json) => 
      _$ContactModelFromJson(json);
}

@freezed
class PollModel with _$PollModel {
  const factory PollModel({
    required String question,
    required List<PollOption> options,
    @Default(false) bool allowMultipleAnswers,
    DateTime? expiresAt,
    @Default({}) Map<String, List<String>> votes,
  }) = _PollModel;

  factory PollModel.fromJson(Map<String, dynamic> json) => 
      _$PollModelFromJson(json);
}

@freezed
class PollOption with _$PollOption {
  const factory PollOption({
    required String id,
    required String text,
    @Default(0) int voteCount,
  }) = _PollOption;

  factory PollOption.fromJson(Map<String, dynamic> json) => 
      _$PollOptionFromJson(json);
}
