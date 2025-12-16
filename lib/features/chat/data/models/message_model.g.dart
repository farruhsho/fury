// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      id: json['id'] as String,
      chatId: json['chatId'] as String,
      senderId: json['senderId'] as String,
      type: $enumDecode(_$MessageTypeEnumMap, json['type']),
      text: json['text'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      replyTo: json['replyTo'] == null
          ? null
          : MessageModel.fromJson(json['replyTo'] as Map<String, dynamic>),
      forwardedFrom: json['forwardedFrom'] as String?,
      reactions: (json['reactions'] as List<dynamic>?)
              ?.map((e) => ReactionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']) ??
          MessageStatus.sending,
      readBy: (json['readBy'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      deliveredTo: (json['deliveredTo'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      editedAt: json['editedAt'] == null
          ? null
          : DateTime.parse(json['editedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      isDeleted: json['isDeleted'] as bool? ?? false,
      deletedBy: (json['deletedBy'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isPinned: json['isPinned'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      linkPreview: json['linkPreview'] == null
          ? null
          : LinkPreviewModel.fromJson(
              json['linkPreview'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      contact: json['contact'] == null
          ? null
          : ContactModel.fromJson(json['contact'] as Map<String, dynamic>),
      poll: json['poll'] == null
          ? null
          : PollModel.fromJson(json['poll'] as Map<String, dynamic>),
      voiceNote: json['voiceNote'] == null
          ? null
          : VoiceNoteModel.fromJson(json['voiceNote'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatId': instance.chatId,
      'senderId': instance.senderId,
      'type': _$MessageTypeEnumMap[instance.type]!,
      'text': instance.text,
      'attachments': instance.attachments,
      'replyTo': instance.replyTo,
      'forwardedFrom': instance.forwardedFrom,
      'reactions': instance.reactions,
      'status': _$MessageStatusEnumMap[instance.status]!,
      'readBy': instance.readBy,
      'deliveredTo': instance.deliveredTo,
      'editedAt': instance.editedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'isDeleted': instance.isDeleted,
      'deletedBy': instance.deletedBy,
      'isPinned': instance.isPinned,
      'createdAt': instance.createdAt.toIso8601String(),
      'linkPreview': instance.linkPreview,
      'location': instance.location,
      'contact': instance.contact,
      'poll': instance.poll,
      'voiceNote': instance.voiceNote,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.video: 'video',
  MessageType.audio: 'audio',
  MessageType.voice: 'voice',
  MessageType.document: 'document',
  MessageType.location: 'location',
  MessageType.contact: 'contact',
  MessageType.sticker: 'sticker',
  MessageType.gif: 'gif',
  MessageType.poll: 'poll',
  MessageType.system: 'system',
};

const _$MessageStatusEnumMap = {
  MessageStatus.sending: 'sending',
  MessageStatus.sent: 'sent',
  MessageStatus.delivered: 'delivered',
  MessageStatus.read: 'read',
  MessageStatus.failed: 'failed',
};

_$AttachmentModelImpl _$$AttachmentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AttachmentModelImpl(
      id: json['id'] as String,
      url: json['url'] as String,
      localPath: json['localPath'] as String,
      type: $enumDecode(_$AttachmentTypeEnumMap, json['type']),
      mimeType: json['mimeType'] as String,
      size: (json['size'] as num).toInt(),
      thumbnailUrl: json['thumbnailUrl'] as String?,
      thumbnailLocalPath: json['thumbnailLocalPath'] as String?,
      fileName: json['fileName'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      blurHash: json['blurHash'] as String?,
      uploadStatus:
          $enumDecodeNullable(_$UploadStatusEnumMap, json['uploadStatus']) ??
              UploadStatus.pending,
      uploadProgress: (json['uploadProgress'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$AttachmentModelImplToJson(
        _$AttachmentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'localPath': instance.localPath,
      'type': _$AttachmentTypeEnumMap[instance.type]!,
      'mimeType': instance.mimeType,
      'size': instance.size,
      'thumbnailUrl': instance.thumbnailUrl,
      'thumbnailLocalPath': instance.thumbnailLocalPath,
      'fileName': instance.fileName,
      'width': instance.width,
      'height': instance.height,
      'duration': instance.duration,
      'blurHash': instance.blurHash,
      'uploadStatus': _$UploadStatusEnumMap[instance.uploadStatus]!,
      'uploadProgress': instance.uploadProgress,
    };

const _$AttachmentTypeEnumMap = {
  AttachmentType.image: 'image',
  AttachmentType.video: 'video',
  AttachmentType.audio: 'audio',
  AttachmentType.document: 'document',
};

const _$UploadStatusEnumMap = {
  UploadStatus.pending: 'pending',
  UploadStatus.uploading: 'uploading',
  UploadStatus.completed: 'completed',
  UploadStatus.failed: 'failed',
};

_$ReactionModelImpl _$$ReactionModelImplFromJson(Map<String, dynamic> json) =>
    _$ReactionModelImpl(
      emoji: json['emoji'] as String,
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ReactionModelImplToJson(_$ReactionModelImpl instance) =>
    <String, dynamic>{
      'emoji': instance.emoji,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$VoiceNoteModelImpl _$$VoiceNoteModelImplFromJson(Map<String, dynamic> json) =>
    _$VoiceNoteModelImpl(
      url: json['url'] as String,
      localPath: json['localPath'] as String,
      duration: (json['duration'] as num).toInt(),
      waveform: (json['waveform'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      isPlayed: json['isPlayed'] as bool? ?? false,
    );

Map<String, dynamic> _$$VoiceNoteModelImplToJson(
        _$VoiceNoteModelImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'localPath': instance.localPath,
      'duration': instance.duration,
      'waveform': instance.waveform,
      'isPlayed': instance.isPlayed,
    };

_$LinkPreviewModelImpl _$$LinkPreviewModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LinkPreviewModelImpl(
      url: json['url'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      siteName: json['siteName'] as String?,
      favicon: json['favicon'] as String?,
    );

Map<String, dynamic> _$$LinkPreviewModelImplToJson(
        _$LinkPreviewModelImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'siteName': instance.siteName,
      'favicon': instance.favicon,
    };

_$LocationModelImpl _$$LocationModelImplFromJson(Map<String, dynamic> json) =>
    _$LocationModelImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$LocationModelImplToJson(_$LocationModelImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'name': instance.name,
    };

_$ContactModelImpl _$$ContactModelImplFromJson(Map<String, dynamic> json) =>
    _$ContactModelImpl(
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$$ContactModelImplToJson(_$ContactModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'avatarUrl': instance.avatarUrl,
    };

_$PollModelImpl _$$PollModelImplFromJson(Map<String, dynamic> json) =>
    _$PollModelImpl(
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => PollOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      allowMultipleAnswers: json['allowMultipleAnswers'] as bool? ?? false,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      votes: (json['votes'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k, (e as List<dynamic>).map((e) => e as String).toList()),
          ) ??
          const {},
    );

Map<String, dynamic> _$$PollModelImplToJson(_$PollModelImpl instance) =>
    <String, dynamic>{
      'question': instance.question,
      'options': instance.options,
      'allowMultipleAnswers': instance.allowMultipleAnswers,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'votes': instance.votes,
    };

_$PollOptionImpl _$$PollOptionImplFromJson(Map<String, dynamic> json) =>
    _$PollOptionImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      voteCount: (json['voteCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PollOptionImplToJson(_$PollOptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'voteCount': instance.voteCount,
    };
