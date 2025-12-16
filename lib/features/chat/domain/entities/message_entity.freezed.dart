// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MessageEntity {
  String get id => throw _privateConstructorUsedError;
  String get chatId => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  MessageType get type => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  List<AttachmentEntity>? get attachments => throw _privateConstructorUsedError;
  MessageEntity? get replyTo => throw _privateConstructorUsedError;
  String? get forwardedFrom => throw _privateConstructorUsedError;
  List<ReactionEntity> get reactions => throw _privateConstructorUsedError;
  MessageStatus get status => throw _privateConstructorUsedError;
  bool get isPinned => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get editedAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessageEntityCopyWith<MessageEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageEntityCopyWith<$Res> {
  factory $MessageEntityCopyWith(
          MessageEntity value, $Res Function(MessageEntity) then) =
      _$MessageEntityCopyWithImpl<$Res, MessageEntity>;
  @useResult
  $Res call(
      {String id,
      String chatId,
      String senderId,
      MessageType type,
      String? text,
      List<AttachmentEntity>? attachments,
      MessageEntity? replyTo,
      String? forwardedFrom,
      List<ReactionEntity> reactions,
      MessageStatus status,
      bool isPinned,
      DateTime createdAt,
      DateTime? editedAt,
      DateTime? deletedAt});

  $MessageEntityCopyWith<$Res>? get replyTo;
}

/// @nodoc
class _$MessageEntityCopyWithImpl<$Res, $Val extends MessageEntity>
    implements $MessageEntityCopyWith<$Res> {
  _$MessageEntityCopyWithImpl(this._value, this._then);

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
    Object? isPinned = null,
    Object? createdAt = null,
    Object? editedAt = freezed,
    Object? deletedAt = freezed,
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
              as List<AttachmentEntity>?,
      replyTo: freezed == replyTo
          ? _value.replyTo
          : replyTo // ignore: cast_nullable_to_non_nullable
              as MessageEntity?,
      forwardedFrom: freezed == forwardedFrom
          ? _value.forwardedFrom
          : forwardedFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      reactions: null == reactions
          ? _value.reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as List<ReactionEntity>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MessageStatus,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      editedAt: freezed == editedAt
          ? _value.editedAt
          : editedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MessageEntityCopyWith<$Res>? get replyTo {
    if (_value.replyTo == null) {
      return null;
    }

    return $MessageEntityCopyWith<$Res>(_value.replyTo!, (value) {
      return _then(_value.copyWith(replyTo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MessageEntityImplCopyWith<$Res>
    implements $MessageEntityCopyWith<$Res> {
  factory _$$MessageEntityImplCopyWith(
          _$MessageEntityImpl value, $Res Function(_$MessageEntityImpl) then) =
      __$$MessageEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String chatId,
      String senderId,
      MessageType type,
      String? text,
      List<AttachmentEntity>? attachments,
      MessageEntity? replyTo,
      String? forwardedFrom,
      List<ReactionEntity> reactions,
      MessageStatus status,
      bool isPinned,
      DateTime createdAt,
      DateTime? editedAt,
      DateTime? deletedAt});

  @override
  $MessageEntityCopyWith<$Res>? get replyTo;
}

/// @nodoc
class __$$MessageEntityImplCopyWithImpl<$Res>
    extends _$MessageEntityCopyWithImpl<$Res, _$MessageEntityImpl>
    implements _$$MessageEntityImplCopyWith<$Res> {
  __$$MessageEntityImplCopyWithImpl(
      _$MessageEntityImpl _value, $Res Function(_$MessageEntityImpl) _then)
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
    Object? isPinned = null,
    Object? createdAt = null,
    Object? editedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_$MessageEntityImpl(
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
              as List<AttachmentEntity>?,
      replyTo: freezed == replyTo
          ? _value.replyTo
          : replyTo // ignore: cast_nullable_to_non_nullable
              as MessageEntity?,
      forwardedFrom: freezed == forwardedFrom
          ? _value.forwardedFrom
          : forwardedFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      reactions: null == reactions
          ? _value._reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as List<ReactionEntity>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MessageStatus,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      editedAt: freezed == editedAt
          ? _value.editedAt
          : editedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$MessageEntityImpl implements _MessageEntity {
  const _$MessageEntityImpl(
      {required this.id,
      required this.chatId,
      required this.senderId,
      required this.type,
      this.text,
      final List<AttachmentEntity>? attachments,
      this.replyTo,
      this.forwardedFrom,
      final List<ReactionEntity> reactions = const [],
      this.status = MessageStatus.sending,
      this.isPinned = false,
      required this.createdAt,
      this.editedAt,
      this.deletedAt})
      : _attachments = attachments,
        _reactions = reactions;

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
  final List<AttachmentEntity>? _attachments;
  @override
  List<AttachmentEntity>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final MessageEntity? replyTo;
  @override
  final String? forwardedFrom;
  final List<ReactionEntity> _reactions;
  @override
  @JsonKey()
  List<ReactionEntity> get reactions {
    if (_reactions is EqualUnmodifiableListView) return _reactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reactions);
  }

  @override
  @JsonKey()
  final MessageStatus status;
  @override
  @JsonKey()
  final bool isPinned;
  @override
  final DateTime createdAt;
  @override
  final DateTime? editedAt;
  @override
  final DateTime? deletedAt;

  @override
  String toString() {
    return 'MessageEntity(id: $id, chatId: $chatId, senderId: $senderId, type: $type, text: $text, attachments: $attachments, replyTo: $replyTo, forwardedFrom: $forwardedFrom, reactions: $reactions, status: $status, isPinned: $isPinned, createdAt: $createdAt, editedAt: $editedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageEntityImpl &&
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
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.editedAt, editedAt) ||
                other.editedAt == editedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @override
  int get hashCode => Object.hash(
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
      isPinned,
      createdAt,
      editedAt,
      deletedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageEntityImplCopyWith<_$MessageEntityImpl> get copyWith =>
      __$$MessageEntityImplCopyWithImpl<_$MessageEntityImpl>(this, _$identity);
}

abstract class _MessageEntity implements MessageEntity {
  const factory _MessageEntity(
      {required final String id,
      required final String chatId,
      required final String senderId,
      required final MessageType type,
      final String? text,
      final List<AttachmentEntity>? attachments,
      final MessageEntity? replyTo,
      final String? forwardedFrom,
      final List<ReactionEntity> reactions,
      final MessageStatus status,
      final bool isPinned,
      required final DateTime createdAt,
      final DateTime? editedAt,
      final DateTime? deletedAt}) = _$MessageEntityImpl;

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
  List<AttachmentEntity>? get attachments;
  @override
  MessageEntity? get replyTo;
  @override
  String? get forwardedFrom;
  @override
  List<ReactionEntity> get reactions;
  @override
  MessageStatus get status;
  @override
  bool get isPinned;
  @override
  DateTime get createdAt;
  @override
  DateTime? get editedAt;
  @override
  DateTime? get deletedAt;
  @override
  @JsonKey(ignore: true)
  _$$MessageEntityImplCopyWith<_$MessageEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AttachmentEntity {
  String get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  AttachmentType get type => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  String? get fileName => throw _privateConstructorUsedError;
  int? get size => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AttachmentEntityCopyWith<AttachmentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachmentEntityCopyWith<$Res> {
  factory $AttachmentEntityCopyWith(
          AttachmentEntity value, $Res Function(AttachmentEntity) then) =
      _$AttachmentEntityCopyWithImpl<$Res, AttachmentEntity>;
  @useResult
  $Res call(
      {String id,
      String url,
      AttachmentType type,
      String? thumbnailUrl,
      String? fileName,
      int? size});
}

/// @nodoc
class _$AttachmentEntityCopyWithImpl<$Res, $Val extends AttachmentEntity>
    implements $AttachmentEntityCopyWith<$Res> {
  _$AttachmentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? type = null,
    Object? thumbnailUrl = freezed,
    Object? fileName = freezed,
    Object? size = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AttachmentType,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttachmentEntityImplCopyWith<$Res>
    implements $AttachmentEntityCopyWith<$Res> {
  factory _$$AttachmentEntityImplCopyWith(_$AttachmentEntityImpl value,
          $Res Function(_$AttachmentEntityImpl) then) =
      __$$AttachmentEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String url,
      AttachmentType type,
      String? thumbnailUrl,
      String? fileName,
      int? size});
}

/// @nodoc
class __$$AttachmentEntityImplCopyWithImpl<$Res>
    extends _$AttachmentEntityCopyWithImpl<$Res, _$AttachmentEntityImpl>
    implements _$$AttachmentEntityImplCopyWith<$Res> {
  __$$AttachmentEntityImplCopyWithImpl(_$AttachmentEntityImpl _value,
      $Res Function(_$AttachmentEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? type = null,
    Object? thumbnailUrl = freezed,
    Object? fileName = freezed,
    Object? size = freezed,
  }) {
    return _then(_$AttachmentEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AttachmentType,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$AttachmentEntityImpl implements _AttachmentEntity {
  const _$AttachmentEntityImpl(
      {required this.id,
      required this.url,
      required this.type,
      this.thumbnailUrl,
      this.fileName,
      this.size});

  @override
  final String id;
  @override
  final String url;
  @override
  final AttachmentType type;
  @override
  final String? thumbnailUrl;
  @override
  final String? fileName;
  @override
  final int? size;

  @override
  String toString() {
    return 'AttachmentEntity(id: $id, url: $url, type: $type, thumbnailUrl: $thumbnailUrl, fileName: $fileName, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttachmentEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.size, size) || other.size == size));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, url, type, thumbnailUrl, fileName, size);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttachmentEntityImplCopyWith<_$AttachmentEntityImpl> get copyWith =>
      __$$AttachmentEntityImplCopyWithImpl<_$AttachmentEntityImpl>(
          this, _$identity);
}

abstract class _AttachmentEntity implements AttachmentEntity {
  const factory _AttachmentEntity(
      {required final String id,
      required final String url,
      required final AttachmentType type,
      final String? thumbnailUrl,
      final String? fileName,
      final int? size}) = _$AttachmentEntityImpl;

  @override
  String get id;
  @override
  String get url;
  @override
  AttachmentType get type;
  @override
  String? get thumbnailUrl;
  @override
  String? get fileName;
  @override
  int? get size;
  @override
  @JsonKey(ignore: true)
  _$$AttachmentEntityImplCopyWith<_$AttachmentEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReactionEntity {
  String get emoji => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReactionEntityCopyWith<ReactionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReactionEntityCopyWith<$Res> {
  factory $ReactionEntityCopyWith(
          ReactionEntity value, $Res Function(ReactionEntity) then) =
      _$ReactionEntityCopyWithImpl<$Res, ReactionEntity>;
  @useResult
  $Res call({String emoji, String userId, DateTime createdAt});
}

/// @nodoc
class _$ReactionEntityCopyWithImpl<$Res, $Val extends ReactionEntity>
    implements $ReactionEntityCopyWith<$Res> {
  _$ReactionEntityCopyWithImpl(this._value, this._then);

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
abstract class _$$ReactionEntityImplCopyWith<$Res>
    implements $ReactionEntityCopyWith<$Res> {
  factory _$$ReactionEntityImplCopyWith(_$ReactionEntityImpl value,
          $Res Function(_$ReactionEntityImpl) then) =
      __$$ReactionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String emoji, String userId, DateTime createdAt});
}

/// @nodoc
class __$$ReactionEntityImplCopyWithImpl<$Res>
    extends _$ReactionEntityCopyWithImpl<$Res, _$ReactionEntityImpl>
    implements _$$ReactionEntityImplCopyWith<$Res> {
  __$$ReactionEntityImplCopyWithImpl(
      _$ReactionEntityImpl _value, $Res Function(_$ReactionEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emoji = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_$ReactionEntityImpl(
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

class _$ReactionEntityImpl implements _ReactionEntity {
  const _$ReactionEntityImpl(
      {required this.emoji, required this.userId, required this.createdAt});

  @override
  final String emoji;
  @override
  final String userId;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'ReactionEntity(emoji: $emoji, userId: $userId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReactionEntityImpl &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, emoji, userId, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReactionEntityImplCopyWith<_$ReactionEntityImpl> get copyWith =>
      __$$ReactionEntityImplCopyWithImpl<_$ReactionEntityImpl>(
          this, _$identity);
}

abstract class _ReactionEntity implements ReactionEntity {
  const factory _ReactionEntity(
      {required final String emoji,
      required final String userId,
      required final DateTime createdAt}) = _$ReactionEntityImpl;

  @override
  String get emoji;
  @override
  String get userId;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ReactionEntityImplCopyWith<_$ReactionEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
