// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return _MessageModel.fromJson(json);
}

/// @nodoc
mixin _$MessageModel {
  String get id => throw _privateConstructorUsedError;
  String get chatId => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  MessageType get type => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  List<AttachmentModel>? get attachments => throw _privateConstructorUsedError;
  MessageModel? get replyTo => throw _privateConstructorUsedError;
  String? get forwardedFrom => throw _privateConstructorUsedError;
  List<ReactionModel> get reactions => throw _privateConstructorUsedError;
  MessageStatus get status => throw _privateConstructorUsedError;
  Map<String, String> get readBy => throw _privateConstructorUsedError;
  Map<String, String> get deliveredTo => throw _privateConstructorUsedError;
  DateTime? get editedAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  List<String> get deletedBy =>
      throw _privateConstructorUsedError; // User IDs who deleted this message for themselves
  bool get isPinned => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  LinkPreviewModel? get linkPreview => throw _privateConstructorUsedError;
  LocationModel? get location => throw _privateConstructorUsedError;
  ContactModel? get contact => throw _privateConstructorUsedError;
  PollModel? get poll => throw _privateConstructorUsedError;
  VoiceNoteModel? get voiceNote => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageModelCopyWith<MessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageModelCopyWith<$Res> {
  factory $MessageModelCopyWith(
          MessageModel value, $Res Function(MessageModel) then) =
      _$MessageModelCopyWithImpl<$Res, MessageModel>;
  @useResult
  $Res call(
      {String id,
      String chatId,
      String senderId,
      MessageType type,
      String? text,
      List<AttachmentModel>? attachments,
      MessageModel? replyTo,
      String? forwardedFrom,
      List<ReactionModel> reactions,
      MessageStatus status,
      Map<String, String> readBy,
      Map<String, String> deliveredTo,
      DateTime? editedAt,
      DateTime? deletedAt,
      bool isDeleted,
      List<String> deletedBy,
      bool isPinned,
      DateTime createdAt,
      LinkPreviewModel? linkPreview,
      LocationModel? location,
      ContactModel? contact,
      PollModel? poll,
      VoiceNoteModel? voiceNote});

  $MessageModelCopyWith<$Res>? get replyTo;
  $LinkPreviewModelCopyWith<$Res>? get linkPreview;
  $LocationModelCopyWith<$Res>? get location;
  $ContactModelCopyWith<$Res>? get contact;
  $PollModelCopyWith<$Res>? get poll;
  $VoiceNoteModelCopyWith<$Res>? get voiceNote;
}

/// @nodoc
class _$MessageModelCopyWithImpl<$Res, $Val extends MessageModel>
    implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatId = null,
    Object? senderId = null,
    Object? type = null,
    Object? text = freezed,
    Object? attachments = freezed,
    Object? replyTo = freezed,
    Object? forwardedFrom = freezed,
    Object? reactions = null,
    Object? status = null,
    Object? readBy = null,
    Object? deliveredTo = null,
    Object? editedAt = freezed,
    Object? deletedAt = freezed,
    Object? isDeleted = null,
    Object? deletedBy = null,
    Object? isPinned = null,
    Object? createdAt = null,
    Object? linkPreview = freezed,
    Object? location = freezed,
    Object? contact = freezed,
    Object? poll = freezed,
    Object? voiceNote = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<AttachmentModel>?,
      replyTo: freezed == replyTo
          ? _value.replyTo
          : replyTo // ignore: cast_nullable_to_non_nullable
              as MessageModel?,
      forwardedFrom: freezed == forwardedFrom
          ? _value.forwardedFrom
          : forwardedFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      reactions: null == reactions
          ? _value.reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as List<ReactionModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MessageStatus,
      readBy: null == readBy
          ? _value.readBy
          : readBy // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      deliveredTo: null == deliveredTo
          ? _value.deliveredTo
          : deliveredTo // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      editedAt: freezed == editedAt
          ? _value.editedAt
          : editedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      deletedBy: null == deletedBy
          ? _value.deletedBy
          : deletedBy // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      linkPreview: freezed == linkPreview
          ? _value.linkPreview
          : linkPreview // ignore: cast_nullable_to_non_nullable
              as LinkPreviewModel?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationModel?,
      contact: freezed == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as ContactModel?,
      poll: freezed == poll
          ? _value.poll
          : poll // ignore: cast_nullable_to_non_nullable
              as PollModel?,
      voiceNote: freezed == voiceNote
          ? _value.voiceNote
          : voiceNote // ignore: cast_nullable_to_non_nullable
              as VoiceNoteModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MessageModelCopyWith<$Res>? get replyTo {
    if (_value.replyTo == null) {
      return null;
    }

    return $MessageModelCopyWith<$Res>(_value.replyTo!, (value) {
      return _then(_value.copyWith(replyTo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LinkPreviewModelCopyWith<$Res>? get linkPreview {
    if (_value.linkPreview == null) {
      return null;
    }

    return $LinkPreviewModelCopyWith<$Res>(_value.linkPreview!, (value) {
      return _then(_value.copyWith(linkPreview: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationModelCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $LocationModelCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ContactModelCopyWith<$Res>? get contact {
    if (_value.contact == null) {
      return null;
    }

    return $ContactModelCopyWith<$Res>(_value.contact!, (value) {
      return _then(_value.copyWith(contact: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PollModelCopyWith<$Res>? get poll {
    if (_value.poll == null) {
      return null;
    }

    return $PollModelCopyWith<$Res>(_value.poll!, (value) {
      return _then(_value.copyWith(poll: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $VoiceNoteModelCopyWith<$Res>? get voiceNote {
    if (_value.voiceNote == null) {
      return null;
    }

    return $VoiceNoteModelCopyWith<$Res>(_value.voiceNote!, (value) {
      return _then(_value.copyWith(voiceNote: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MessageModelImplCopyWith<$Res>
    implements $MessageModelCopyWith<$Res> {
  factory _$$MessageModelImplCopyWith(
          _$MessageModelImpl value, $Res Function(_$MessageModelImpl) then) =
      __$$MessageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String chatId,
      String senderId,
      MessageType type,
      String? text,
      List<AttachmentModel>? attachments,
      MessageModel? replyTo,
      String? forwardedFrom,
      List<ReactionModel> reactions,
      MessageStatus status,
      Map<String, String> readBy,
      Map<String, String> deliveredTo,
      DateTime? editedAt,
      DateTime? deletedAt,
      bool isDeleted,
      List<String> deletedBy,
      bool isPinned,
      DateTime createdAt,
      LinkPreviewModel? linkPreview,
      LocationModel? location,
      ContactModel? contact,
      PollModel? poll,
      VoiceNoteModel? voiceNote});

  @override
  $MessageModelCopyWith<$Res>? get replyTo;
  @override
  $LinkPreviewModelCopyWith<$Res>? get linkPreview;
  @override
  $LocationModelCopyWith<$Res>? get location;
  @override
  $ContactModelCopyWith<$Res>? get contact;
  @override
  $PollModelCopyWith<$Res>? get poll;
  @override
  $VoiceNoteModelCopyWith<$Res>? get voiceNote;
}

/// @nodoc
class __$$MessageModelImplCopyWithImpl<$Res>
    extends _$MessageModelCopyWithImpl<$Res, _$MessageModelImpl>
    implements _$$MessageModelImplCopyWith<$Res> {
  __$$MessageModelImplCopyWithImpl(
      _$MessageModelImpl _value, $Res Function(_$MessageModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatId = null,
    Object? senderId = null,
    Object? type = null,
    Object? text = freezed,
    Object? attachments = freezed,
    Object? replyTo = freezed,
    Object? forwardedFrom = freezed,
    Object? reactions = null,
    Object? status = null,
    Object? readBy = null,
    Object? deliveredTo = null,
    Object? editedAt = freezed,
    Object? deletedAt = freezed,
    Object? isDeleted = null,
    Object? deletedBy = null,
    Object? isPinned = null,
    Object? createdAt = null,
    Object? linkPreview = freezed,
    Object? location = freezed,
    Object? contact = freezed,
    Object? poll = freezed,
    Object? voiceNote = freezed,
  }) {
    return _then(_$MessageModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<AttachmentModel>?,
      replyTo: freezed == replyTo
          ? _value.replyTo
          : replyTo // ignore: cast_nullable_to_non_nullable
              as MessageModel?,
      forwardedFrom: freezed == forwardedFrom
          ? _value.forwardedFrom
          : forwardedFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      reactions: null == reactions
          ? _value._reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as List<ReactionModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MessageStatus,
      readBy: null == readBy
          ? _value._readBy
          : readBy // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      deliveredTo: null == deliveredTo
          ? _value._deliveredTo
          : deliveredTo // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      editedAt: freezed == editedAt
          ? _value.editedAt
          : editedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      deletedBy: null == deletedBy
          ? _value._deletedBy
          : deletedBy // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      linkPreview: freezed == linkPreview
          ? _value.linkPreview
          : linkPreview // ignore: cast_nullable_to_non_nullable
              as LinkPreviewModel?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationModel?,
      contact: freezed == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as ContactModel?,
      poll: freezed == poll
          ? _value.poll
          : poll // ignore: cast_nullable_to_non_nullable
              as PollModel?,
      voiceNote: freezed == voiceNote
          ? _value.voiceNote
          : voiceNote // ignore: cast_nullable_to_non_nullable
              as VoiceNoteModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageModelImpl implements _MessageModel {
  const _$MessageModelImpl(
      {required this.id,
      required this.chatId,
      required this.senderId,
      required this.type,
      this.text,
      final List<AttachmentModel>? attachments,
      this.replyTo,
      this.forwardedFrom,
      final List<ReactionModel> reactions = const [],
      this.status = MessageStatus.sending,
      final Map<String, String> readBy = const {},
      final Map<String, String> deliveredTo = const {},
      this.editedAt,
      this.deletedAt,
      this.isDeleted = false,
      final List<String> deletedBy = const [],
      this.isPinned = false,
      required this.createdAt,
      this.linkPreview,
      this.location,
      this.contact,
      this.poll,
      this.voiceNote})
      : _attachments = attachments,
        _reactions = reactions,
        _readBy = readBy,
        _deliveredTo = deliveredTo,
        _deletedBy = deletedBy;

  factory _$MessageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageModelImplFromJson(json);

  @override
  final String id;
  @override
  final String chatId;
  @override
  final String senderId;
  @override
  final MessageType type;
  @override
  final String? text;
  final List<AttachmentModel>? _attachments;
  @override
  List<AttachmentModel>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final MessageModel? replyTo;
  @override
  final String? forwardedFrom;
  final List<ReactionModel> _reactions;
  @override
  @JsonKey()
  List<ReactionModel> get reactions {
    if (_reactions is EqualUnmodifiableListView) return _reactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reactions);
  }

  @override
  @JsonKey()
  final MessageStatus status;
  final Map<String, String> _readBy;
  @override
  @JsonKey()
  Map<String, String> get readBy {
    if (_readBy is EqualUnmodifiableMapView) return _readBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_readBy);
  }

  final Map<String, String> _deliveredTo;
  @override
  @JsonKey()
  Map<String, String> get deliveredTo {
    if (_deliveredTo is EqualUnmodifiableMapView) return _deliveredTo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_deliveredTo);
  }

  @override
  final DateTime? editedAt;
  @override
  final DateTime? deletedAt;
  @override
  @JsonKey()
  final bool isDeleted;
  final List<String> _deletedBy;
  @override
  @JsonKey()
  List<String> get deletedBy {
    if (_deletedBy is EqualUnmodifiableListView) return _deletedBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deletedBy);
  }

// User IDs who deleted this message for themselves
  @override
  @JsonKey()
  final bool isPinned;
  @override
  final DateTime createdAt;
  @override
  final LinkPreviewModel? linkPreview;
  @override
  final LocationModel? location;
  @override
  final ContactModel? contact;
  @override
  final PollModel? poll;
  @override
  final VoiceNoteModel? voiceNote;

  @override
  String toString() {
    return 'MessageModel(id: $id, chatId: $chatId, senderId: $senderId, type: $type, text: $text, attachments: $attachments, replyTo: $replyTo, forwardedFrom: $forwardedFrom, reactions: $reactions, status: $status, readBy: $readBy, deliveredTo: $deliveredTo, editedAt: $editedAt, deletedAt: $deletedAt, isDeleted: $isDeleted, deletedBy: $deletedBy, isPinned: $isPinned, createdAt: $createdAt, linkPreview: $linkPreview, location: $location, contact: $contact, poll: $poll, voiceNote: $voiceNote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            (identical(other.replyTo, replyTo) || other.replyTo == replyTo) &&
            (identical(other.forwardedFrom, forwardedFrom) ||
                other.forwardedFrom == forwardedFrom) &&
            const DeepCollectionEquality()
                .equals(other._reactions, _reactions) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._readBy, _readBy) &&
            const DeepCollectionEquality()
                .equals(other._deliveredTo, _deliveredTo) &&
            (identical(other.editedAt, editedAt) ||
                other.editedAt == editedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            const DeepCollectionEquality()
                .equals(other._deletedBy, _deletedBy) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.linkPreview, linkPreview) ||
                other.linkPreview == linkPreview) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.poll, poll) || other.poll == poll) &&
            (identical(other.voiceNote, voiceNote) ||
                other.voiceNote == voiceNote));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        chatId,
        senderId,
        type,
        text,
        const DeepCollectionEquality().hash(_attachments),
        replyTo,
        forwardedFrom,
        const DeepCollectionEquality().hash(_reactions),
        status,
        const DeepCollectionEquality().hash(_readBy),
        const DeepCollectionEquality().hash(_deliveredTo),
        editedAt,
        deletedAt,
        isDeleted,
        const DeepCollectionEquality().hash(_deletedBy),
        isPinned,
        createdAt,
        linkPreview,
        location,
        contact,
        poll,
        voiceNote
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      __$$MessageModelImplCopyWithImpl<_$MessageModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageModelImplToJson(
      this,
    );
  }
}

abstract class _MessageModel implements MessageModel {
  const factory _MessageModel(
      {required final String id,
      required final String chatId,
      required final String senderId,
      required final MessageType type,
      final String? text,
      final List<AttachmentModel>? attachments,
      final MessageModel? replyTo,
      final String? forwardedFrom,
      final List<ReactionModel> reactions,
      final MessageStatus status,
      final Map<String, String> readBy,
      final Map<String, String> deliveredTo,
      final DateTime? editedAt,
      final DateTime? deletedAt,
      final bool isDeleted,
      final List<String> deletedBy,
      final bool isPinned,
      required final DateTime createdAt,
      final LinkPreviewModel? linkPreview,
      final LocationModel? location,
      final ContactModel? contact,
      final PollModel? poll,
      final VoiceNoteModel? voiceNote}) = _$MessageModelImpl;

  factory _MessageModel.fromJson(Map<String, dynamic> json) =
      _$MessageModelImpl.fromJson;

  @override
  String get id;
  @override
  String get chatId;
  @override
  String get senderId;
  @override
  MessageType get type;
  @override
  String? get text;
  @override
  List<AttachmentModel>? get attachments;
  @override
  MessageModel? get replyTo;
  @override
  String? get forwardedFrom;
  @override
  List<ReactionModel> get reactions;
  @override
  MessageStatus get status;
  @override
  Map<String, String> get readBy;
  @override
  Map<String, String> get deliveredTo;
  @override
  DateTime? get editedAt;
  @override
  DateTime? get deletedAt;
  @override
  bool get isDeleted;
  @override
  List<String> get deletedBy;
  @override // User IDs who deleted this message for themselves
  bool get isPinned;
  @override
  DateTime get createdAt;
  @override
  LinkPreviewModel? get linkPreview;
  @override
  LocationModel? get location;
  @override
  ContactModel? get contact;
  @override
  PollModel? get poll;
  @override
  VoiceNoteModel? get voiceNote;
  @override
  @JsonKey(ignore: true)
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttachmentModel _$AttachmentModelFromJson(Map<String, dynamic> json) {
  return _AttachmentModel.fromJson(json);
}

/// @nodoc
mixin _$AttachmentModel {
  String get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get localPath => throw _privateConstructorUsedError;
  AttachmentType get type => throw _privateConstructorUsedError;
  String get mimeType => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  String? get thumbnailLocalPath => throw _privateConstructorUsedError;
  String? get fileName => throw _privateConstructorUsedError;
  int? get width => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;
  String? get blurHash => throw _privateConstructorUsedError;
  UploadStatus get uploadStatus => throw _privateConstructorUsedError;
  double? get uploadProgress => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttachmentModelCopyWith<AttachmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachmentModelCopyWith<$Res> {
  factory $AttachmentModelCopyWith(
          AttachmentModel value, $Res Function(AttachmentModel) then) =
      _$AttachmentModelCopyWithImpl<$Res, AttachmentModel>;
  @useResult
  $Res call(
      {String id,
      String url,
      String localPath,
      AttachmentType type,
      String mimeType,
      int size,
      String? thumbnailUrl,
      String? thumbnailLocalPath,
      String? fileName,
      int? width,
      int? height,
      int? duration,
      String? blurHash,
      UploadStatus uploadStatus,
      double? uploadProgress});
}

/// @nodoc
class _$AttachmentModelCopyWithImpl<$Res, $Val extends AttachmentModel>
    implements $AttachmentModelCopyWith<$Res> {
  _$AttachmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? localPath = null,
    Object? type = null,
    Object? mimeType = null,
    Object? size = null,
    Object? thumbnailUrl = freezed,
    Object? thumbnailLocalPath = freezed,
    Object? fileName = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? duration = freezed,
    Object? blurHash = freezed,
    Object? uploadStatus = null,
    Object? uploadProgress = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      localPath: null == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AttachmentType,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailLocalPath: freezed == thumbnailLocalPath
          ? _value.thumbnailLocalPath
          : thumbnailLocalPath // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      blurHash: freezed == blurHash
          ? _value.blurHash
          : blurHash // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadStatus: null == uploadStatus
          ? _value.uploadStatus
          : uploadStatus // ignore: cast_nullable_to_non_nullable
              as UploadStatus,
      uploadProgress: freezed == uploadProgress
          ? _value.uploadProgress
          : uploadProgress // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttachmentModelImplCopyWith<$Res>
    implements $AttachmentModelCopyWith<$Res> {
  factory _$$AttachmentModelImplCopyWith(_$AttachmentModelImpl value,
          $Res Function(_$AttachmentModelImpl) then) =
      __$$AttachmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String url,
      String localPath,
      AttachmentType type,
      String mimeType,
      int size,
      String? thumbnailUrl,
      String? thumbnailLocalPath,
      String? fileName,
      int? width,
      int? height,
      int? duration,
      String? blurHash,
      UploadStatus uploadStatus,
      double? uploadProgress});
}

/// @nodoc
class __$$AttachmentModelImplCopyWithImpl<$Res>
    extends _$AttachmentModelCopyWithImpl<$Res, _$AttachmentModelImpl>
    implements _$$AttachmentModelImplCopyWith<$Res> {
  __$$AttachmentModelImplCopyWithImpl(
      _$AttachmentModelImpl _value, $Res Function(_$AttachmentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? localPath = null,
    Object? type = null,
    Object? mimeType = null,
    Object? size = null,
    Object? thumbnailUrl = freezed,
    Object? thumbnailLocalPath = freezed,
    Object? fileName = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? duration = freezed,
    Object? blurHash = freezed,
    Object? uploadStatus = null,
    Object? uploadProgress = freezed,
  }) {
    return _then(_$AttachmentModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      localPath: null == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AttachmentType,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailLocalPath: freezed == thumbnailLocalPath
          ? _value.thumbnailLocalPath
          : thumbnailLocalPath // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      blurHash: freezed == blurHash
          ? _value.blurHash
          : blurHash // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadStatus: null == uploadStatus
          ? _value.uploadStatus
          : uploadStatus // ignore: cast_nullable_to_non_nullable
              as UploadStatus,
      uploadProgress: freezed == uploadProgress
          ? _value.uploadProgress
          : uploadProgress // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttachmentModelImpl implements _AttachmentModel {
  const _$AttachmentModelImpl(
      {required this.id,
      required this.url,
      required this.localPath,
      required this.type,
      required this.mimeType,
      required this.size,
      this.thumbnailUrl,
      this.thumbnailLocalPath,
      this.fileName,
      this.width,
      this.height,
      this.duration,
      this.blurHash,
      this.uploadStatus = UploadStatus.pending,
      this.uploadProgress});

  factory _$AttachmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttachmentModelImplFromJson(json);

  @override
  final String id;
  @override
  final String url;
  @override
  final String localPath;
  @override
  final AttachmentType type;
  @override
  final String mimeType;
  @override
  final int size;
  @override
  final String? thumbnailUrl;
  @override
  final String? thumbnailLocalPath;
  @override
  final String? fileName;
  @override
  final int? width;
  @override
  final int? height;
  @override
  final int? duration;
  @override
  final String? blurHash;
  @override
  @JsonKey()
  final UploadStatus uploadStatus;
  @override
  final double? uploadProgress;

  @override
  String toString() {
    return 'AttachmentModel(id: $id, url: $url, localPath: $localPath, type: $type, mimeType: $mimeType, size: $size, thumbnailUrl: $thumbnailUrl, thumbnailLocalPath: $thumbnailLocalPath, fileName: $fileName, width: $width, height: $height, duration: $duration, blurHash: $blurHash, uploadStatus: $uploadStatus, uploadProgress: $uploadProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttachmentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.localPath, localPath) ||
                other.localPath == localPath) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.thumbnailLocalPath, thumbnailLocalPath) ||
                other.thumbnailLocalPath == thumbnailLocalPath) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.blurHash, blurHash) ||
                other.blurHash == blurHash) &&
            (identical(other.uploadStatus, uploadStatus) ||
                other.uploadStatus == uploadStatus) &&
            (identical(other.uploadProgress, uploadProgress) ||
                other.uploadProgress == uploadProgress));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      url,
      localPath,
      type,
      mimeType,
      size,
      thumbnailUrl,
      thumbnailLocalPath,
      fileName,
      width,
      height,
      duration,
      blurHash,
      uploadStatus,
      uploadProgress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttachmentModelImplCopyWith<_$AttachmentModelImpl> get copyWith =>
      __$$AttachmentModelImplCopyWithImpl<_$AttachmentModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttachmentModelImplToJson(
      this,
    );
  }
}

abstract class _AttachmentModel implements AttachmentModel {
  const factory _AttachmentModel(
      {required final String id,
      required final String url,
      required final String localPath,
      required final AttachmentType type,
      required final String mimeType,
      required final int size,
      final String? thumbnailUrl,
      final String? thumbnailLocalPath,
      final String? fileName,
      final int? width,
      final int? height,
      final int? duration,
      final String? blurHash,
      final UploadStatus uploadStatus,
      final double? uploadProgress}) = _$AttachmentModelImpl;

  factory _AttachmentModel.fromJson(Map<String, dynamic> json) =
      _$AttachmentModelImpl.fromJson;

  @override
  String get id;
  @override
  String get url;
  @override
  String get localPath;
  @override
  AttachmentType get type;
  @override
  String get mimeType;
  @override
  int get size;
  @override
  String? get thumbnailUrl;
  @override
  String? get thumbnailLocalPath;
  @override
  String? get fileName;
  @override
  int? get width;
  @override
  int? get height;
  @override
  int? get duration;
  @override
  String? get blurHash;
  @override
  UploadStatus get uploadStatus;
  @override
  double? get uploadProgress;
  @override
  @JsonKey(ignore: true)
  _$$AttachmentModelImplCopyWith<_$AttachmentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReactionModel _$ReactionModelFromJson(Map<String, dynamic> json) {
  return _ReactionModel.fromJson(json);
}

/// @nodoc
mixin _$ReactionModel {
  String get emoji => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReactionModelCopyWith<ReactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReactionModelCopyWith<$Res> {
  factory $ReactionModelCopyWith(
          ReactionModel value, $Res Function(ReactionModel) then) =
      _$ReactionModelCopyWithImpl<$Res, ReactionModel>;
  @useResult
  $Res call({String emoji, String userId, DateTime createdAt});
}

/// @nodoc
class _$ReactionModelCopyWithImpl<$Res, $Val extends ReactionModel>
    implements $ReactionModelCopyWith<$Res> {
  _$ReactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emoji = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      emoji: null == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReactionModelImplCopyWith<$Res>
    implements $ReactionModelCopyWith<$Res> {
  factory _$$ReactionModelImplCopyWith(
          _$ReactionModelImpl value, $Res Function(_$ReactionModelImpl) then) =
      __$$ReactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String emoji, String userId, DateTime createdAt});
}

/// @nodoc
class __$$ReactionModelImplCopyWithImpl<$Res>
    extends _$ReactionModelCopyWithImpl<$Res, _$ReactionModelImpl>
    implements _$$ReactionModelImplCopyWith<$Res> {
  __$$ReactionModelImplCopyWithImpl(
      _$ReactionModelImpl _value, $Res Function(_$ReactionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emoji = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_$ReactionModelImpl(
      emoji: null == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReactionModelImpl implements _ReactionModel {
  const _$ReactionModelImpl(
      {required this.emoji, required this.userId, required this.createdAt});

  factory _$ReactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReactionModelImplFromJson(json);

  @override
  final String emoji;
  @override
  final String userId;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'ReactionModel(emoji: $emoji, userId: $userId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReactionModelImpl &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, emoji, userId, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReactionModelImplCopyWith<_$ReactionModelImpl> get copyWith =>
      __$$ReactionModelImplCopyWithImpl<_$ReactionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReactionModelImplToJson(
      this,
    );
  }
}

abstract class _ReactionModel implements ReactionModel {
  const factory _ReactionModel(
      {required final String emoji,
      required final String userId,
      required final DateTime createdAt}) = _$ReactionModelImpl;

  factory _ReactionModel.fromJson(Map<String, dynamic> json) =
      _$ReactionModelImpl.fromJson;

  @override
  String get emoji;
  @override
  String get userId;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ReactionModelImplCopyWith<_$ReactionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VoiceNoteModel _$VoiceNoteModelFromJson(Map<String, dynamic> json) {
  return _VoiceNoteModel.fromJson(json);
}

/// @nodoc
mixin _$VoiceNoteModel {
  String get url => throw _privateConstructorUsedError;
  String get localPath => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  List<double> get waveform => throw _privateConstructorUsedError;
  bool get isPlayed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoiceNoteModelCopyWith<VoiceNoteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoiceNoteModelCopyWith<$Res> {
  factory $VoiceNoteModelCopyWith(
          VoiceNoteModel value, $Res Function(VoiceNoteModel) then) =
      _$VoiceNoteModelCopyWithImpl<$Res, VoiceNoteModel>;
  @useResult
  $Res call(
      {String url,
      String localPath,
      int duration,
      List<double> waveform,
      bool isPlayed});
}

/// @nodoc
class _$VoiceNoteModelCopyWithImpl<$Res, $Val extends VoiceNoteModel>
    implements $VoiceNoteModelCopyWith<$Res> {
  _$VoiceNoteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? localPath = null,
    Object? duration = null,
    Object? waveform = null,
    Object? isPlayed = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      localPath: null == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      waveform: null == waveform
          ? _value.waveform
          : waveform // ignore: cast_nullable_to_non_nullable
              as List<double>,
      isPlayed: null == isPlayed
          ? _value.isPlayed
          : isPlayed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoiceNoteModelImplCopyWith<$Res>
    implements $VoiceNoteModelCopyWith<$Res> {
  factory _$$VoiceNoteModelImplCopyWith(_$VoiceNoteModelImpl value,
          $Res Function(_$VoiceNoteModelImpl) then) =
      __$$VoiceNoteModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url,
      String localPath,
      int duration,
      List<double> waveform,
      bool isPlayed});
}

/// @nodoc
class __$$VoiceNoteModelImplCopyWithImpl<$Res>
    extends _$VoiceNoteModelCopyWithImpl<$Res, _$VoiceNoteModelImpl>
    implements _$$VoiceNoteModelImplCopyWith<$Res> {
  __$$VoiceNoteModelImplCopyWithImpl(
      _$VoiceNoteModelImpl _value, $Res Function(_$VoiceNoteModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? localPath = null,
    Object? duration = null,
    Object? waveform = null,
    Object? isPlayed = null,
  }) {
    return _then(_$VoiceNoteModelImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      localPath: null == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      waveform: null == waveform
          ? _value._waveform
          : waveform // ignore: cast_nullable_to_non_nullable
              as List<double>,
      isPlayed: null == isPlayed
          ? _value.isPlayed
          : isPlayed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoiceNoteModelImpl implements _VoiceNoteModel {
  const _$VoiceNoteModelImpl(
      {required this.url,
      required this.localPath,
      required this.duration,
      required final List<double> waveform,
      this.isPlayed = false})
      : _waveform = waveform;

  factory _$VoiceNoteModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoiceNoteModelImplFromJson(json);

  @override
  final String url;
  @override
  final String localPath;
  @override
  final int duration;
  final List<double> _waveform;
  @override
  List<double> get waveform {
    if (_waveform is EqualUnmodifiableListView) return _waveform;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_waveform);
  }

  @override
  @JsonKey()
  final bool isPlayed;

  @override
  String toString() {
    return 'VoiceNoteModel(url: $url, localPath: $localPath, duration: $duration, waveform: $waveform, isPlayed: $isPlayed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoiceNoteModelImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.localPath, localPath) ||
                other.localPath == localPath) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality().equals(other._waveform, _waveform) &&
            (identical(other.isPlayed, isPlayed) ||
                other.isPlayed == isPlayed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url, localPath, duration,
      const DeepCollectionEquality().hash(_waveform), isPlayed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VoiceNoteModelImplCopyWith<_$VoiceNoteModelImpl> get copyWith =>
      __$$VoiceNoteModelImplCopyWithImpl<_$VoiceNoteModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoiceNoteModelImplToJson(
      this,
    );
  }
}

abstract class _VoiceNoteModel implements VoiceNoteModel {
  const factory _VoiceNoteModel(
      {required final String url,
      required final String localPath,
      required final int duration,
      required final List<double> waveform,
      final bool isPlayed}) = _$VoiceNoteModelImpl;

  factory _VoiceNoteModel.fromJson(Map<String, dynamic> json) =
      _$VoiceNoteModelImpl.fromJson;

  @override
  String get url;
  @override
  String get localPath;
  @override
  int get duration;
  @override
  List<double> get waveform;
  @override
  bool get isPlayed;
  @override
  @JsonKey(ignore: true)
  _$$VoiceNoteModelImplCopyWith<_$VoiceNoteModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LinkPreviewModel _$LinkPreviewModelFromJson(Map<String, dynamic> json) {
  return _LinkPreviewModel.fromJson(json);
}

/// @nodoc
mixin _$LinkPreviewModel {
  String get url => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get siteName => throw _privateConstructorUsedError;
  String? get favicon => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LinkPreviewModelCopyWith<LinkPreviewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinkPreviewModelCopyWith<$Res> {
  factory $LinkPreviewModelCopyWith(
          LinkPreviewModel value, $Res Function(LinkPreviewModel) then) =
      _$LinkPreviewModelCopyWithImpl<$Res, LinkPreviewModel>;
  @useResult
  $Res call(
      {String url,
      String? title,
      String? description,
      String? imageUrl,
      String? siteName,
      String? favicon});
}

/// @nodoc
class _$LinkPreviewModelCopyWithImpl<$Res, $Val extends LinkPreviewModel>
    implements $LinkPreviewModelCopyWith<$Res> {
  _$LinkPreviewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? title = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? siteName = freezed,
    Object? favicon = freezed,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      siteName: freezed == siteName
          ? _value.siteName
          : siteName // ignore: cast_nullable_to_non_nullable
              as String?,
      favicon: freezed == favicon
          ? _value.favicon
          : favicon // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LinkPreviewModelImplCopyWith<$Res>
    implements $LinkPreviewModelCopyWith<$Res> {
  factory _$$LinkPreviewModelImplCopyWith(_$LinkPreviewModelImpl value,
          $Res Function(_$LinkPreviewModelImpl) then) =
      __$$LinkPreviewModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url,
      String? title,
      String? description,
      String? imageUrl,
      String? siteName,
      String? favicon});
}

/// @nodoc
class __$$LinkPreviewModelImplCopyWithImpl<$Res>
    extends _$LinkPreviewModelCopyWithImpl<$Res, _$LinkPreviewModelImpl>
    implements _$$LinkPreviewModelImplCopyWith<$Res> {
  __$$LinkPreviewModelImplCopyWithImpl(_$LinkPreviewModelImpl _value,
      $Res Function(_$LinkPreviewModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? title = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? siteName = freezed,
    Object? favicon = freezed,
  }) {
    return _then(_$LinkPreviewModelImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      siteName: freezed == siteName
          ? _value.siteName
          : siteName // ignore: cast_nullable_to_non_nullable
              as String?,
      favicon: freezed == favicon
          ? _value.favicon
          : favicon // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LinkPreviewModelImpl implements _LinkPreviewModel {
  const _$LinkPreviewModelImpl(
      {required this.url,
      this.title,
      this.description,
      this.imageUrl,
      this.siteName,
      this.favicon});

  factory _$LinkPreviewModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LinkPreviewModelImplFromJson(json);

  @override
  final String url;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? imageUrl;
  @override
  final String? siteName;
  @override
  final String? favicon;

  @override
  String toString() {
    return 'LinkPreviewModel(url: $url, title: $title, description: $description, imageUrl: $imageUrl, siteName: $siteName, favicon: $favicon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkPreviewModelImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.siteName, siteName) ||
                other.siteName == siteName) &&
            (identical(other.favicon, favicon) || other.favicon == favicon));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, url, title, description, imageUrl, siteName, favicon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkPreviewModelImplCopyWith<_$LinkPreviewModelImpl> get copyWith =>
      __$$LinkPreviewModelImplCopyWithImpl<_$LinkPreviewModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LinkPreviewModelImplToJson(
      this,
    );
  }
}

abstract class _LinkPreviewModel implements LinkPreviewModel {
  const factory _LinkPreviewModel(
      {required final String url,
      final String? title,
      final String? description,
      final String? imageUrl,
      final String? siteName,
      final String? favicon}) = _$LinkPreviewModelImpl;

  factory _LinkPreviewModel.fromJson(Map<String, dynamic> json) =
      _$LinkPreviewModelImpl.fromJson;

  @override
  String get url;
  @override
  String? get title;
  @override
  String? get description;
  @override
  String? get imageUrl;
  @override
  String? get siteName;
  @override
  String? get favicon;
  @override
  @JsonKey(ignore: true)
  _$$LinkPreviewModelImplCopyWith<_$LinkPreviewModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) {
  return _LocationModel.fromJson(json);
}

/// @nodoc
mixin _$LocationModel {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationModelCopyWith<LocationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationModelCopyWith<$Res> {
  factory $LocationModelCopyWith(
          LocationModel value, $Res Function(LocationModel) then) =
      _$LocationModelCopyWithImpl<$Res, LocationModel>;
  @useResult
  $Res call({double latitude, double longitude, String? address, String? name});
}

/// @nodoc
class _$LocationModelCopyWithImpl<$Res, $Val extends LocationModel>
    implements $LocationModelCopyWith<$Res> {
  _$LocationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? address = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationModelImplCopyWith<$Res>
    implements $LocationModelCopyWith<$Res> {
  factory _$$LocationModelImplCopyWith(
          _$LocationModelImpl value, $Res Function(_$LocationModelImpl) then) =
      __$$LocationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double latitude, double longitude, String? address, String? name});
}

/// @nodoc
class __$$LocationModelImplCopyWithImpl<$Res>
    extends _$LocationModelCopyWithImpl<$Res, _$LocationModelImpl>
    implements _$$LocationModelImplCopyWith<$Res> {
  __$$LocationModelImplCopyWithImpl(
      _$LocationModelImpl _value, $Res Function(_$LocationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? address = freezed,
    Object? name = freezed,
  }) {
    return _then(_$LocationModelImpl(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationModelImpl implements _LocationModel {
  const _$LocationModelImpl(
      {required this.latitude,
      required this.longitude,
      this.address,
      this.name});

  factory _$LocationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationModelImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String? address;
  @override
  final String? name;

  @override
  String toString() {
    return 'LocationModel(latitude: $latitude, longitude: $longitude, address: $address, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationModelImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, latitude, longitude, address, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationModelImplCopyWith<_$LocationModelImpl> get copyWith =>
      __$$LocationModelImplCopyWithImpl<_$LocationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationModelImplToJson(
      this,
    );
  }
}

abstract class _LocationModel implements LocationModel {
  const factory _LocationModel(
      {required final double latitude,
      required final double longitude,
      final String? address,
      final String? name}) = _$LocationModelImpl;

  factory _LocationModel.fromJson(Map<String, dynamic> json) =
      _$LocationModelImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String? get address;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$LocationModelImplCopyWith<_$LocationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContactModel _$ContactModelFromJson(Map<String, dynamic> json) {
  return _ContactModel.fromJson(json);
}

/// @nodoc
mixin _$ContactModel {
  String get name => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContactModelCopyWith<ContactModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactModelCopyWith<$Res> {
  factory $ContactModelCopyWith(
          ContactModel value, $Res Function(ContactModel) then) =
      _$ContactModelCopyWithImpl<$Res, ContactModel>;
  @useResult
  $Res call({String name, String phoneNumber, String? avatarUrl});
}

/// @nodoc
class _$ContactModelCopyWithImpl<$Res, $Val extends ContactModel>
    implements $ContactModelCopyWith<$Res> {
  _$ContactModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? phoneNumber = null,
    Object? avatarUrl = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContactModelImplCopyWith<$Res>
    implements $ContactModelCopyWith<$Res> {
  factory _$$ContactModelImplCopyWith(
          _$ContactModelImpl value, $Res Function(_$ContactModelImpl) then) =
      __$$ContactModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String phoneNumber, String? avatarUrl});
}

/// @nodoc
class __$$ContactModelImplCopyWithImpl<$Res>
    extends _$ContactModelCopyWithImpl<$Res, _$ContactModelImpl>
    implements _$$ContactModelImplCopyWith<$Res> {
  __$$ContactModelImplCopyWithImpl(
      _$ContactModelImpl _value, $Res Function(_$ContactModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? phoneNumber = null,
    Object? avatarUrl = freezed,
  }) {
    return _then(_$ContactModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactModelImpl implements _ContactModel {
  const _$ContactModelImpl(
      {required this.name, required this.phoneNumber, this.avatarUrl});

  factory _$ContactModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContactModelImplFromJson(json);

  @override
  final String name;
  @override
  final String phoneNumber;
  @override
  final String? avatarUrl;

  @override
  String toString() {
    return 'ContactModel(name: $name, phoneNumber: $phoneNumber, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, phoneNumber, avatarUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactModelImplCopyWith<_$ContactModelImpl> get copyWith =>
      __$$ContactModelImplCopyWithImpl<_$ContactModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactModelImplToJson(
      this,
    );
  }
}

abstract class _ContactModel implements ContactModel {
  const factory _ContactModel(
      {required final String name,
      required final String phoneNumber,
      final String? avatarUrl}) = _$ContactModelImpl;

  factory _ContactModel.fromJson(Map<String, dynamic> json) =
      _$ContactModelImpl.fromJson;

  @override
  String get name;
  @override
  String get phoneNumber;
  @override
  String? get avatarUrl;
  @override
  @JsonKey(ignore: true)
  _$$ContactModelImplCopyWith<_$ContactModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PollModel _$PollModelFromJson(Map<String, dynamic> json) {
  return _PollModel.fromJson(json);
}

/// @nodoc
mixin _$PollModel {
  String get question => throw _privateConstructorUsedError;
  List<PollOption> get options => throw _privateConstructorUsedError;
  bool get allowMultipleAnswers => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  Map<String, List<String>> get votes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PollModelCopyWith<PollModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollModelCopyWith<$Res> {
  factory $PollModelCopyWith(PollModel value, $Res Function(PollModel) then) =
      _$PollModelCopyWithImpl<$Res, PollModel>;
  @useResult
  $Res call(
      {String question,
      List<PollOption> options,
      bool allowMultipleAnswers,
      DateTime? expiresAt,
      Map<String, List<String>> votes});
}

/// @nodoc
class _$PollModelCopyWithImpl<$Res, $Val extends PollModel>
    implements $PollModelCopyWith<$Res> {
  _$PollModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? options = null,
    Object? allowMultipleAnswers = null,
    Object? expiresAt = freezed,
    Object? votes = null,
  }) {
    return _then(_value.copyWith(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<PollOption>,
      allowMultipleAnswers: null == allowMultipleAnswers
          ? _value.allowMultipleAnswers
          : allowMultipleAnswers // ignore: cast_nullable_to_non_nullable
              as bool,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      votes: null == votes
          ? _value.votes
          : votes // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PollModelImplCopyWith<$Res>
    implements $PollModelCopyWith<$Res> {
  factory _$$PollModelImplCopyWith(
          _$PollModelImpl value, $Res Function(_$PollModelImpl) then) =
      __$$PollModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String question,
      List<PollOption> options,
      bool allowMultipleAnswers,
      DateTime? expiresAt,
      Map<String, List<String>> votes});
}

/// @nodoc
class __$$PollModelImplCopyWithImpl<$Res>
    extends _$PollModelCopyWithImpl<$Res, _$PollModelImpl>
    implements _$$PollModelImplCopyWith<$Res> {
  __$$PollModelImplCopyWithImpl(
      _$PollModelImpl _value, $Res Function(_$PollModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? options = null,
    Object? allowMultipleAnswers = null,
    Object? expiresAt = freezed,
    Object? votes = null,
  }) {
    return _then(_$PollModelImpl(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<PollOption>,
      allowMultipleAnswers: null == allowMultipleAnswers
          ? _value.allowMultipleAnswers
          : allowMultipleAnswers // ignore: cast_nullable_to_non_nullable
              as bool,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      votes: null == votes
          ? _value._votes
          : votes // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PollModelImpl implements _PollModel {
  const _$PollModelImpl(
      {required this.question,
      required final List<PollOption> options,
      this.allowMultipleAnswers = false,
      this.expiresAt,
      final Map<String, List<String>> votes = const {}})
      : _options = options,
        _votes = votes;

  factory _$PollModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollModelImplFromJson(json);

  @override
  final String question;
  final List<PollOption> _options;
  @override
  List<PollOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  @JsonKey()
  final bool allowMultipleAnswers;
  @override
  final DateTime? expiresAt;
  final Map<String, List<String>> _votes;
  @override
  @JsonKey()
  Map<String, List<String>> get votes {
    if (_votes is EqualUnmodifiableMapView) return _votes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_votes);
  }

  @override
  String toString() {
    return 'PollModel(question: $question, options: $options, allowMultipleAnswers: $allowMultipleAnswers, expiresAt: $expiresAt, votes: $votes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollModelImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.allowMultipleAnswers, allowMultipleAnswers) ||
                other.allowMultipleAnswers == allowMultipleAnswers) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            const DeepCollectionEquality().equals(other._votes, _votes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      question,
      const DeepCollectionEquality().hash(_options),
      allowMultipleAnswers,
      expiresAt,
      const DeepCollectionEquality().hash(_votes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PollModelImplCopyWith<_$PollModelImpl> get copyWith =>
      __$$PollModelImplCopyWithImpl<_$PollModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PollModelImplToJson(
      this,
    );
  }
}

abstract class _PollModel implements PollModel {
  const factory _PollModel(
      {required final String question,
      required final List<PollOption> options,
      final bool allowMultipleAnswers,
      final DateTime? expiresAt,
      final Map<String, List<String>> votes}) = _$PollModelImpl;

  factory _PollModel.fromJson(Map<String, dynamic> json) =
      _$PollModelImpl.fromJson;

  @override
  String get question;
  @override
  List<PollOption> get options;
  @override
  bool get allowMultipleAnswers;
  @override
  DateTime? get expiresAt;
  @override
  Map<String, List<String>> get votes;
  @override
  @JsonKey(ignore: true)
  _$$PollModelImplCopyWith<_$PollModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PollOption _$PollOptionFromJson(Map<String, dynamic> json) {
  return _PollOption.fromJson(json);
}

/// @nodoc
mixin _$PollOption {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  int get voteCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PollOptionCopyWith<PollOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollOptionCopyWith<$Res> {
  factory $PollOptionCopyWith(
          PollOption value, $Res Function(PollOption) then) =
      _$PollOptionCopyWithImpl<$Res, PollOption>;
  @useResult
  $Res call({String id, String text, int voteCount});
}

/// @nodoc
class _$PollOptionCopyWithImpl<$Res, $Val extends PollOption>
    implements $PollOptionCopyWith<$Res> {
  _$PollOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? voteCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PollOptionImplCopyWith<$Res>
    implements $PollOptionCopyWith<$Res> {
  factory _$$PollOptionImplCopyWith(
          _$PollOptionImpl value, $Res Function(_$PollOptionImpl) then) =
      __$$PollOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String text, int voteCount});
}

/// @nodoc
class __$$PollOptionImplCopyWithImpl<$Res>
    extends _$PollOptionCopyWithImpl<$Res, _$PollOptionImpl>
    implements _$$PollOptionImplCopyWith<$Res> {
  __$$PollOptionImplCopyWithImpl(
      _$PollOptionImpl _value, $Res Function(_$PollOptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? voteCount = null,
  }) {
    return _then(_$PollOptionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PollOptionImpl implements _PollOption {
  const _$PollOptionImpl(
      {required this.id, required this.text, this.voteCount = 0});

  factory _$PollOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollOptionImplFromJson(json);

  @override
  final String id;
  @override
  final String text;
  @override
  @JsonKey()
  final int voteCount;

  @override
  String toString() {
    return 'PollOption(id: $id, text: $text, voteCount: $voteCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, text, voteCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PollOptionImplCopyWith<_$PollOptionImpl> get copyWith =>
      __$$PollOptionImplCopyWithImpl<_$PollOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PollOptionImplToJson(
      this,
    );
  }
}

abstract class _PollOption implements PollOption {
  const factory _PollOption(
      {required final String id,
      required final String text,
      final int voteCount}) = _$PollOptionImpl;

  factory _PollOption.fromJson(Map<String, dynamic> json) =
      _$PollOptionImpl.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  int get voteCount;
  @override
  @JsonKey(ignore: true)
  _$$PollOptionImplCopyWith<_$PollOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
