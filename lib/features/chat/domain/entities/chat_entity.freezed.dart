// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatEntity {
  String get id => throw _privateConstructorUsedError;
  ChatType get type => throw _privateConstructorUsedError;
  List<String> get participantIds => throw _privateConstructorUsedError;
  Map<String, ChatParticipantEntity> get participants =>
      throw _privateConstructorUsedError;
  MessageEntity? get lastMessage => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatEntityCopyWith<ChatEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatEntityCopyWith<$Res> {
  factory $ChatEntityCopyWith(
          ChatEntity value, $Res Function(ChatEntity) then) =
      _$ChatEntityCopyWithImpl<$Res, ChatEntity>;
  @useResult
  $Res call(
      {String id,
      ChatType type,
      List<String> participantIds,
      Map<String, ChatParticipantEntity> participants,
      MessageEntity? lastMessage,
      int unreadCount,
      String? name,
      String? imageUrl,
      DateTime? createdAt,
      DateTime? updatedAt});

  $MessageEntityCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$ChatEntityCopyWithImpl<$Res, $Val extends ChatEntity>
    implements $ChatEntityCopyWith<$Res> {
  _$ChatEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? participantIds = null,
    Object? participants = null,
    Object? lastMessage = freezed,
    Object? unreadCount = null,
    Object? name = freezed,
    Object? imageUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChatType,
      participantIds: null == participantIds
          ? _value.participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as Map<String, ChatParticipantEntity>,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as MessageEntity?,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MessageEntityCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $MessageEntityCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatEntityImplCopyWith<$Res>
    implements $ChatEntityCopyWith<$Res> {
  factory _$$ChatEntityImplCopyWith(
          _$ChatEntityImpl value, $Res Function(_$ChatEntityImpl) then) =
      __$$ChatEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      ChatType type,
      List<String> participantIds,
      Map<String, ChatParticipantEntity> participants,
      MessageEntity? lastMessage,
      int unreadCount,
      String? name,
      String? imageUrl,
      DateTime? createdAt,
      DateTime? updatedAt});

  @override
  $MessageEntityCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$ChatEntityImplCopyWithImpl<$Res>
    extends _$ChatEntityCopyWithImpl<$Res, _$ChatEntityImpl>
    implements _$$ChatEntityImplCopyWith<$Res> {
  __$$ChatEntityImplCopyWithImpl(
      _$ChatEntityImpl _value, $Res Function(_$ChatEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? participantIds = null,
    Object? participants = null,
    Object? lastMessage = freezed,
    Object? unreadCount = null,
    Object? name = freezed,
    Object? imageUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ChatEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChatType,
      participantIds: null == participantIds
          ? _value._participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      participants: null == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as Map<String, ChatParticipantEntity>,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as MessageEntity?,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$ChatEntityImpl implements _ChatEntity {
  const _$ChatEntityImpl(
      {required this.id,
      required this.type,
      required final List<String> participantIds,
      required final Map<String, ChatParticipantEntity> participants,
      this.lastMessage,
      this.unreadCount = 0,
      this.name,
      this.imageUrl,
      this.createdAt,
      this.updatedAt})
      : _participantIds = participantIds,
        _participants = participants;

  @override
  final String id;
  @override
  final ChatType type;
  final List<String> _participantIds;
  @override
  List<String> get participantIds {
    if (_participantIds is EqualUnmodifiableListView) return _participantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantIds);
  }

  final Map<String, ChatParticipantEntity> _participants;
  @override
  Map<String, ChatParticipantEntity> get participants {
    if (_participants is EqualUnmodifiableMapView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_participants);
  }

  @override
  final MessageEntity? lastMessage;
  @override
  @JsonKey()
  final int unreadCount;
  @override
  final String? name;
  @override
  final String? imageUrl;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ChatEntity(id: $id, type: $type, participantIds: $participantIds, participants: $participants, lastMessage: $lastMessage, unreadCount: $unreadCount, name: $name, imageUrl: $imageUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._participantIds, _participantIds) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      const DeepCollectionEquality().hash(_participantIds),
      const DeepCollectionEquality().hash(_participants),
      lastMessage,
      unreadCount,
      name,
      imageUrl,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatEntityImplCopyWith<_$ChatEntityImpl> get copyWith =>
      __$$ChatEntityImplCopyWithImpl<_$ChatEntityImpl>(this, _$identity);
}

abstract class _ChatEntity implements ChatEntity {
  const factory _ChatEntity(
      {required final String id,
      required final ChatType type,
      required final List<String> participantIds,
      required final Map<String, ChatParticipantEntity> participants,
      final MessageEntity? lastMessage,
      final int unreadCount,
      final String? name,
      final String? imageUrl,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$ChatEntityImpl;

  @override
  String get id;
  @override
  ChatType get type;
  @override
  List<String> get participantIds;
  @override
  Map<String, ChatParticipantEntity> get participants;
  @override
  MessageEntity? get lastMessage;
  @override
  int get unreadCount;
  @override
  String? get name;
  @override
  String? get imageUrl;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ChatEntityImplCopyWith<_$ChatEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ChatParticipantEntity {
  String get userId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  bool get isOnline => throw _privateConstructorUsedError;
  DateTime? get lastSeen => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatParticipantEntityCopyWith<ChatParticipantEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatParticipantEntityCopyWith<$Res> {
  factory $ChatParticipantEntityCopyWith(ChatParticipantEntity value,
          $Res Function(ChatParticipantEntity) then) =
      _$ChatParticipantEntityCopyWithImpl<$Res, ChatParticipantEntity>;
  @useResult
  $Res call(
      {String userId,
      String displayName,
      String? avatarUrl,
      bool isOnline,
      DateTime? lastSeen});
}

/// @nodoc
class _$ChatParticipantEntityCopyWithImpl<$Res,
        $Val extends ChatParticipantEntity>
    implements $ChatParticipantEntityCopyWith<$Res> {
  _$ChatParticipantEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? isOnline = null,
    Object? lastSeen = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatParticipantEntityImplCopyWith<$Res>
    implements $ChatParticipantEntityCopyWith<$Res> {
  factory _$$ChatParticipantEntityImplCopyWith(
          _$ChatParticipantEntityImpl value,
          $Res Function(_$ChatParticipantEntityImpl) then) =
      __$$ChatParticipantEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String displayName,
      String? avatarUrl,
      bool isOnline,
      DateTime? lastSeen});
}

/// @nodoc
class __$$ChatParticipantEntityImplCopyWithImpl<$Res>
    extends _$ChatParticipantEntityCopyWithImpl<$Res,
        _$ChatParticipantEntityImpl>
    implements _$$ChatParticipantEntityImplCopyWith<$Res> {
  __$$ChatParticipantEntityImplCopyWithImpl(_$ChatParticipantEntityImpl _value,
      $Res Function(_$ChatParticipantEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? isOnline = null,
    Object? lastSeen = freezed,
  }) {
    return _then(_$ChatParticipantEntityImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$ChatParticipantEntityImpl implements _ChatParticipantEntity {
  const _$ChatParticipantEntityImpl(
      {required this.userId,
      required this.displayName,
      this.avatarUrl,
      this.isOnline = false,
      this.lastSeen});

  @override
  final String userId;
  @override
  final String displayName;
  @override
  final String? avatarUrl;
  @override
  @JsonKey()
  final bool isOnline;
  @override
  final DateTime? lastSeen;

  @override
  String toString() {
    return 'ChatParticipantEntity(userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, isOnline: $isOnline, lastSeen: $lastSeen)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatParticipantEntityImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, userId, displayName, avatarUrl, isOnline, lastSeen);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatParticipantEntityImplCopyWith<_$ChatParticipantEntityImpl>
      get copyWith => __$$ChatParticipantEntityImplCopyWithImpl<
          _$ChatParticipantEntityImpl>(this, _$identity);
}

abstract class _ChatParticipantEntity implements ChatParticipantEntity {
  const factory _ChatParticipantEntity(
      {required final String userId,
      required final String displayName,
      final String? avatarUrl,
      final bool isOnline,
      final DateTime? lastSeen}) = _$ChatParticipantEntityImpl;

  @override
  String get userId;
  @override
  String get displayName;
  @override
  String? get avatarUrl;
  @override
  bool get isOnline;
  @override
  DateTime? get lastSeen;
  @override
  @JsonKey(ignore: true)
  _$$ChatParticipantEntityImplCopyWith<_$ChatParticipantEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
