// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return _ChatModel.fromJson(json);
}

/// @nodoc
mixin _$ChatModel {
  String get id => throw _privateConstructorUsedError;
  ChatType get type => throw _privateConstructorUsedError;
  List<String> get participantIds => throw _privateConstructorUsedError;
  Map<String, ParticipantInfo> get participants =>
      throw _privateConstructorUsedError;
  String? get name =>
      throw _privateConstructorUsedError; // Direct name field for group chats (from Firestore root)
  String? get avatarUrl =>
      throw _privateConstructorUsedError; // Direct avatar field for group chats (from Firestore root)
  MessageModel? get lastMessage => throw _privateConstructorUsedError;
  Map<String, int> get unreadCounts => throw _privateConstructorUsedError;
  Map<String, String> get lastReadTimestamps =>
      throw _privateConstructorUsedError;
  Map<String, bool> get typingStatus => throw _privateConstructorUsedError;
  Map<String, bool> get mutedBy => throw _privateConstructorUsedError;
  Map<String, String> get pinnedBy => throw _privateConstructorUsedError;
  Map<String, String> get archivedBy => throw _privateConstructorUsedError;
  GroupInfoModel? get groupInfo => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get draftMessage => throw _privateConstructorUsedError;
  List<String> get pinnedMessageIds => throw _privateConstructorUsedError;
  EncryptionInfo? get encryptionInfo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatModelCopyWith<ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatModelCopyWith<$Res> {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) then) =
      _$ChatModelCopyWithImpl<$Res, ChatModel>;
  @useResult
  $Res call(
      {String id,
      ChatType type,
      List<String> participantIds,
      Map<String, ParticipantInfo> participants,
      String? name,
      String? avatarUrl,
      MessageModel? lastMessage,
      Map<String, int> unreadCounts,
      Map<String, String> lastReadTimestamps,
      Map<String, bool> typingStatus,
      Map<String, bool> mutedBy,
      Map<String, String> pinnedBy,
      Map<String, String> archivedBy,
      GroupInfoModel? groupInfo,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? draftMessage,
      List<String> pinnedMessageIds,
      EncryptionInfo? encryptionInfo});

  $MessageModelCopyWith<$Res>? get lastMessage;
  $GroupInfoModelCopyWith<$Res>? get groupInfo;
  $EncryptionInfoCopyWith<$Res>? get encryptionInfo;
}

/// @nodoc
class _$ChatModelCopyWithImpl<$Res, $Val extends ChatModel>
    implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._value, this._then);

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
    Object? name = freezed,
    Object? avatarUrl = freezed,
    Object? lastMessage = freezed,
    Object? unreadCounts = null,
    Object? lastReadTimestamps = null,
    Object? typingStatus = null,
    Object? mutedBy = null,
    Object? pinnedBy = null,
    Object? archivedBy = null,
    Object? groupInfo = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? draftMessage = freezed,
    Object? pinnedMessageIds = null,
    Object? encryptionInfo = freezed,
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
              as Map<String, ParticipantInfo>,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as MessageModel?,
      unreadCounts: null == unreadCounts
          ? _value.unreadCounts
          : unreadCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      lastReadTimestamps: null == lastReadTimestamps
          ? _value.lastReadTimestamps
          : lastReadTimestamps // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      typingStatus: null == typingStatus
          ? _value.typingStatus
          : typingStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      mutedBy: null == mutedBy
          ? _value.mutedBy
          : mutedBy // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      pinnedBy: null == pinnedBy
          ? _value.pinnedBy
          : pinnedBy // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      archivedBy: null == archivedBy
          ? _value.archivedBy
          : archivedBy // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      groupInfo: freezed == groupInfo
          ? _value.groupInfo
          : groupInfo // ignore: cast_nullable_to_non_nullable
              as GroupInfoModel?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      draftMessage: freezed == draftMessage
          ? _value.draftMessage
          : draftMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      pinnedMessageIds: null == pinnedMessageIds
          ? _value.pinnedMessageIds
          : pinnedMessageIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      encryptionInfo: freezed == encryptionInfo
          ? _value.encryptionInfo
          : encryptionInfo // ignore: cast_nullable_to_non_nullable
              as EncryptionInfo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MessageModelCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $MessageModelCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GroupInfoModelCopyWith<$Res>? get groupInfo {
    if (_value.groupInfo == null) {
      return null;
    }

    return $GroupInfoModelCopyWith<$Res>(_value.groupInfo!, (value) {
      return _then(_value.copyWith(groupInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EncryptionInfoCopyWith<$Res>? get encryptionInfo {
    if (_value.encryptionInfo == null) {
      return null;
    }

    return $EncryptionInfoCopyWith<$Res>(_value.encryptionInfo!, (value) {
      return _then(_value.copyWith(encryptionInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatModelImplCopyWith<$Res>
    implements $ChatModelCopyWith<$Res> {
  factory _$$ChatModelImplCopyWith(
          _$ChatModelImpl value, $Res Function(_$ChatModelImpl) then) =
      __$$ChatModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      ChatType type,
      List<String> participantIds,
      Map<String, ParticipantInfo> participants,
      String? name,
      String? avatarUrl,
      MessageModel? lastMessage,
      Map<String, int> unreadCounts,
      Map<String, String> lastReadTimestamps,
      Map<String, bool> typingStatus,
      Map<String, bool> mutedBy,
      Map<String, String> pinnedBy,
      Map<String, String> archivedBy,
      GroupInfoModel? groupInfo,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? draftMessage,
      List<String> pinnedMessageIds,
      EncryptionInfo? encryptionInfo});

  @override
  $MessageModelCopyWith<$Res>? get lastMessage;
  @override
  $GroupInfoModelCopyWith<$Res>? get groupInfo;
  @override
  $EncryptionInfoCopyWith<$Res>? get encryptionInfo;
}

/// @nodoc
class __$$ChatModelImplCopyWithImpl<$Res>
    extends _$ChatModelCopyWithImpl<$Res, _$ChatModelImpl>
    implements _$$ChatModelImplCopyWith<$Res> {
  __$$ChatModelImplCopyWithImpl(
      _$ChatModelImpl _value, $Res Function(_$ChatModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? participantIds = null,
    Object? participants = null,
    Object? name = freezed,
    Object? avatarUrl = freezed,
    Object? lastMessage = freezed,
    Object? unreadCounts = null,
    Object? lastReadTimestamps = null,
    Object? typingStatus = null,
    Object? mutedBy = null,
    Object? pinnedBy = null,
    Object? archivedBy = null,
    Object? groupInfo = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? draftMessage = freezed,
    Object? pinnedMessageIds = null,
    Object? encryptionInfo = freezed,
  }) {
    return _then(_$ChatModelImpl(
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
              as Map<String, ParticipantInfo>,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as MessageModel?,
      unreadCounts: null == unreadCounts
          ? _value._unreadCounts
          : unreadCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      lastReadTimestamps: null == lastReadTimestamps
          ? _value._lastReadTimestamps
          : lastReadTimestamps // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      typingStatus: null == typingStatus
          ? _value._typingStatus
          : typingStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      mutedBy: null == mutedBy
          ? _value._mutedBy
          : mutedBy // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      pinnedBy: null == pinnedBy
          ? _value._pinnedBy
          : pinnedBy // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      archivedBy: null == archivedBy
          ? _value._archivedBy
          : archivedBy // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      groupInfo: freezed == groupInfo
          ? _value.groupInfo
          : groupInfo // ignore: cast_nullable_to_non_nullable
              as GroupInfoModel?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      draftMessage: freezed == draftMessage
          ? _value.draftMessage
          : draftMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      pinnedMessageIds: null == pinnedMessageIds
          ? _value._pinnedMessageIds
          : pinnedMessageIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      encryptionInfo: freezed == encryptionInfo
          ? _value.encryptionInfo
          : encryptionInfo // ignore: cast_nullable_to_non_nullable
              as EncryptionInfo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatModelImpl implements _ChatModel {
  const _$ChatModelImpl(
      {required this.id,
      required this.type,
      required final List<String> participantIds,
      required final Map<String, ParticipantInfo> participants,
      this.name,
      this.avatarUrl,
      this.lastMessage,
      final Map<String, int> unreadCounts = const {},
      final Map<String, String> lastReadTimestamps = const {},
      final Map<String, bool> typingStatus = const {},
      final Map<String, bool> mutedBy = const {},
      final Map<String, String> pinnedBy = const {},
      final Map<String, String> archivedBy = const {},
      this.groupInfo,
      this.createdAt,
      this.updatedAt,
      this.draftMessage,
      final List<String> pinnedMessageIds = const [],
      this.encryptionInfo})
      : _participantIds = participantIds,
        _participants = participants,
        _unreadCounts = unreadCounts,
        _lastReadTimestamps = lastReadTimestamps,
        _typingStatus = typingStatus,
        _mutedBy = mutedBy,
        _pinnedBy = pinnedBy,
        _archivedBy = archivedBy,
        _pinnedMessageIds = pinnedMessageIds;

  factory _$ChatModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatModelImplFromJson(json);

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

  final Map<String, ParticipantInfo> _participants;
  @override
  Map<String, ParticipantInfo> get participants {
    if (_participants is EqualUnmodifiableMapView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_participants);
  }

  @override
  final String? name;
// Direct name field for group chats (from Firestore root)
  @override
  final String? avatarUrl;
// Direct avatar field for group chats (from Firestore root)
  @override
  final MessageModel? lastMessage;
  final Map<String, int> _unreadCounts;
  @override
  @JsonKey()
  Map<String, int> get unreadCounts {
    if (_unreadCounts is EqualUnmodifiableMapView) return _unreadCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_unreadCounts);
  }

  final Map<String, String> _lastReadTimestamps;
  @override
  @JsonKey()
  Map<String, String> get lastReadTimestamps {
    if (_lastReadTimestamps is EqualUnmodifiableMapView)
      return _lastReadTimestamps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_lastReadTimestamps);
  }

  final Map<String, bool> _typingStatus;
  @override
  @JsonKey()
  Map<String, bool> get typingStatus {
    if (_typingStatus is EqualUnmodifiableMapView) return _typingStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_typingStatus);
  }

  final Map<String, bool> _mutedBy;
  @override
  @JsonKey()
  Map<String, bool> get mutedBy {
    if (_mutedBy is EqualUnmodifiableMapView) return _mutedBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_mutedBy);
  }

  final Map<String, String> _pinnedBy;
  @override
  @JsonKey()
  Map<String, String> get pinnedBy {
    if (_pinnedBy is EqualUnmodifiableMapView) return _pinnedBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_pinnedBy);
  }

  final Map<String, String> _archivedBy;
  @override
  @JsonKey()
  Map<String, String> get archivedBy {
    if (_archivedBy is EqualUnmodifiableMapView) return _archivedBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_archivedBy);
  }

  @override
  final GroupInfoModel? groupInfo;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? draftMessage;
  final List<String> _pinnedMessageIds;
  @override
  @JsonKey()
  List<String> get pinnedMessageIds {
    if (_pinnedMessageIds is EqualUnmodifiableListView)
      return _pinnedMessageIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pinnedMessageIds);
  }

  @override
  final EncryptionInfo? encryptionInfo;

  @override
  String toString() {
    return 'ChatModel(id: $id, type: $type, participantIds: $participantIds, participants: $participants, name: $name, avatarUrl: $avatarUrl, lastMessage: $lastMessage, unreadCounts: $unreadCounts, lastReadTimestamps: $lastReadTimestamps, typingStatus: $typingStatus, mutedBy: $mutedBy, pinnedBy: $pinnedBy, archivedBy: $archivedBy, groupInfo: $groupInfo, createdAt: $createdAt, updatedAt: $updatedAt, draftMessage: $draftMessage, pinnedMessageIds: $pinnedMessageIds, encryptionInfo: $encryptionInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._participantIds, _participantIds) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            const DeepCollectionEquality()
                .equals(other._unreadCounts, _unreadCounts) &&
            const DeepCollectionEquality()
                .equals(other._lastReadTimestamps, _lastReadTimestamps) &&
            const DeepCollectionEquality()
                .equals(other._typingStatus, _typingStatus) &&
            const DeepCollectionEquality().equals(other._mutedBy, _mutedBy) &&
            const DeepCollectionEquality().equals(other._pinnedBy, _pinnedBy) &&
            const DeepCollectionEquality()
                .equals(other._archivedBy, _archivedBy) &&
            (identical(other.groupInfo, groupInfo) ||
                other.groupInfo == groupInfo) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.draftMessage, draftMessage) ||
                other.draftMessage == draftMessage) &&
            const DeepCollectionEquality()
                .equals(other._pinnedMessageIds, _pinnedMessageIds) &&
            (identical(other.encryptionInfo, encryptionInfo) ||
                other.encryptionInfo == encryptionInfo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        type,
        const DeepCollectionEquality().hash(_participantIds),
        const DeepCollectionEquality().hash(_participants),
        name,
        avatarUrl,
        lastMessage,
        const DeepCollectionEquality().hash(_unreadCounts),
        const DeepCollectionEquality().hash(_lastReadTimestamps),
        const DeepCollectionEquality().hash(_typingStatus),
        const DeepCollectionEquality().hash(_mutedBy),
        const DeepCollectionEquality().hash(_pinnedBy),
        const DeepCollectionEquality().hash(_archivedBy),
        groupInfo,
        createdAt,
        updatedAt,
        draftMessage,
        const DeepCollectionEquality().hash(_pinnedMessageIds),
        encryptionInfo
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatModelImplCopyWith<_$ChatModelImpl> get copyWith =>
      __$$ChatModelImplCopyWithImpl<_$ChatModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatModelImplToJson(
      this,
    );
  }
}

abstract class _ChatModel implements ChatModel {
  const factory _ChatModel(
      {required final String id,
      required final ChatType type,
      required final List<String> participantIds,
      required final Map<String, ParticipantInfo> participants,
      final String? name,
      final String? avatarUrl,
      final MessageModel? lastMessage,
      final Map<String, int> unreadCounts,
      final Map<String, String> lastReadTimestamps,
      final Map<String, bool> typingStatus,
      final Map<String, bool> mutedBy,
      final Map<String, String> pinnedBy,
      final Map<String, String> archivedBy,
      final GroupInfoModel? groupInfo,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final String? draftMessage,
      final List<String> pinnedMessageIds,
      final EncryptionInfo? encryptionInfo}) = _$ChatModelImpl;

  factory _ChatModel.fromJson(Map<String, dynamic> json) =
      _$ChatModelImpl.fromJson;

  @override
  String get id;
  @override
  ChatType get type;
  @override
  List<String> get participantIds;
  @override
  Map<String, ParticipantInfo> get participants;
  @override
  String? get name;
  @override // Direct name field for group chats (from Firestore root)
  String? get avatarUrl;
  @override // Direct avatar field for group chats (from Firestore root)
  MessageModel? get lastMessage;
  @override
  Map<String, int> get unreadCounts;
  @override
  Map<String, String> get lastReadTimestamps;
  @override
  Map<String, bool> get typingStatus;
  @override
  Map<String, bool> get mutedBy;
  @override
  Map<String, String> get pinnedBy;
  @override
  Map<String, String> get archivedBy;
  @override
  GroupInfoModel? get groupInfo;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  String? get draftMessage;
  @override
  List<String> get pinnedMessageIds;
  @override
  EncryptionInfo? get encryptionInfo;
  @override
  @JsonKey(ignore: true)
  _$$ChatModelImplCopyWith<_$ChatModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ParticipantInfo _$ParticipantInfoFromJson(Map<String, dynamic> json) {
  return _ParticipantInfo.fromJson(json);
}

/// @nodoc
mixin _$ParticipantInfo {
  String get userId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  bool get isOnline => throw _privateConstructorUsedError;
  DateTime? get lastSeen => throw _privateConstructorUsedError;
  GroupRole get role => throw _privateConstructorUsedError;
  DateTime? get joinedAt => throw _privateConstructorUsedError;
  String? get addedBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParticipantInfoCopyWith<ParticipantInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParticipantInfoCopyWith<$Res> {
  factory $ParticipantInfoCopyWith(
          ParticipantInfo value, $Res Function(ParticipantInfo) then) =
      _$ParticipantInfoCopyWithImpl<$Res, ParticipantInfo>;
  @useResult
  $Res call(
      {String userId,
      String displayName,
      String? avatarUrl,
      String? phoneNumber,
      bool isOnline,
      DateTime? lastSeen,
      GroupRole role,
      DateTime? joinedAt,
      String? addedBy});
}

/// @nodoc
class _$ParticipantInfoCopyWithImpl<$Res, $Val extends ParticipantInfo>
    implements $ParticipantInfoCopyWith<$Res> {
  _$ParticipantInfoCopyWithImpl(this._value, this._then);

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
    Object? phoneNumber = freezed,
    Object? isOnline = null,
    Object? lastSeen = freezed,
    Object? role = null,
    Object? joinedAt = freezed,
    Object? addedBy = freezed,
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
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as GroupRole,
      joinedAt: freezed == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      addedBy: freezed == addedBy
          ? _value.addedBy
          : addedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParticipantInfoImplCopyWith<$Res>
    implements $ParticipantInfoCopyWith<$Res> {
  factory _$$ParticipantInfoImplCopyWith(_$ParticipantInfoImpl value,
          $Res Function(_$ParticipantInfoImpl) then) =
      __$$ParticipantInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String displayName,
      String? avatarUrl,
      String? phoneNumber,
      bool isOnline,
      DateTime? lastSeen,
      GroupRole role,
      DateTime? joinedAt,
      String? addedBy});
}

/// @nodoc
class __$$ParticipantInfoImplCopyWithImpl<$Res>
    extends _$ParticipantInfoCopyWithImpl<$Res, _$ParticipantInfoImpl>
    implements _$$ParticipantInfoImplCopyWith<$Res> {
  __$$ParticipantInfoImplCopyWithImpl(
      _$ParticipantInfoImpl _value, $Res Function(_$ParticipantInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? phoneNumber = freezed,
    Object? isOnline = null,
    Object? lastSeen = freezed,
    Object? role = null,
    Object? joinedAt = freezed,
    Object? addedBy = freezed,
  }) {
    return _then(_$ParticipantInfoImpl(
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
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as GroupRole,
      joinedAt: freezed == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      addedBy: freezed == addedBy
          ? _value.addedBy
          : addedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParticipantInfoImpl implements _ParticipantInfo {
  const _$ParticipantInfoImpl(
      {required this.userId,
      required this.displayName,
      this.avatarUrl,
      this.phoneNumber,
      this.isOnline = false,
      this.lastSeen,
      this.role = GroupRole.member,
      this.joinedAt,
      this.addedBy});

  factory _$ParticipantInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParticipantInfoImplFromJson(json);

  @override
  final String userId;
  @override
  final String displayName;
  @override
  final String? avatarUrl;
  @override
  final String? phoneNumber;
  @override
  @JsonKey()
  final bool isOnline;
  @override
  final DateTime? lastSeen;
  @override
  @JsonKey()
  final GroupRole role;
  @override
  final DateTime? joinedAt;
  @override
  final String? addedBy;

  @override
  String toString() {
    return 'ParticipantInfo(userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, phoneNumber: $phoneNumber, isOnline: $isOnline, lastSeen: $lastSeen, role: $role, joinedAt: $joinedAt, addedBy: $addedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParticipantInfoImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.addedBy, addedBy) || other.addedBy == addedBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, displayName, avatarUrl,
      phoneNumber, isOnline, lastSeen, role, joinedAt, addedBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParticipantInfoImplCopyWith<_$ParticipantInfoImpl> get copyWith =>
      __$$ParticipantInfoImplCopyWithImpl<_$ParticipantInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParticipantInfoImplToJson(
      this,
    );
  }
}

abstract class _ParticipantInfo implements ParticipantInfo {
  const factory _ParticipantInfo(
      {required final String userId,
      required final String displayName,
      final String? avatarUrl,
      final String? phoneNumber,
      final bool isOnline,
      final DateTime? lastSeen,
      final GroupRole role,
      final DateTime? joinedAt,
      final String? addedBy}) = _$ParticipantInfoImpl;

  factory _ParticipantInfo.fromJson(Map<String, dynamic> json) =
      _$ParticipantInfoImpl.fromJson;

  @override
  String get userId;
  @override
  String get displayName;
  @override
  String? get avatarUrl;
  @override
  String? get phoneNumber;
  @override
  bool get isOnline;
  @override
  DateTime? get lastSeen;
  @override
  GroupRole get role;
  @override
  DateTime? get joinedAt;
  @override
  String? get addedBy;
  @override
  @JsonKey(ignore: true)
  _$$ParticipantInfoImplCopyWith<_$ParticipantInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GroupInfoModel _$GroupInfoModelFromJson(Map<String, dynamic> json) {
  return _GroupInfoModel.fromJson(json);
}

/// @nodoc
mixin _$GroupInfoModel {
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  GroupSettings get settings => throw _privateConstructorUsedError;
  String? get inviteLink => throw _privateConstructorUsedError;
  DateTime? get inviteLinkExpiry => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupInfoModelCopyWith<GroupInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupInfoModelCopyWith<$Res> {
  factory $GroupInfoModelCopyWith(
          GroupInfoModel value, $Res Function(GroupInfoModel) then) =
      _$GroupInfoModelCopyWithImpl<$Res, GroupInfoModel>;
  @useResult
  $Res call(
      {String name,
      String? description,
      String? avatarUrl,
      String createdBy,
      DateTime createdAt,
      GroupSettings settings,
      String? inviteLink,
      DateTime? inviteLinkExpiry});

  $GroupSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class _$GroupInfoModelCopyWithImpl<$Res, $Val extends GroupInfoModel>
    implements $GroupInfoModelCopyWith<$Res> {
  _$GroupInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? avatarUrl = freezed,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? settings = null,
    Object? inviteLink = freezed,
    Object? inviteLinkExpiry = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as GroupSettings,
      inviteLink: freezed == inviteLink
          ? _value.inviteLink
          : inviteLink // ignore: cast_nullable_to_non_nullable
              as String?,
      inviteLinkExpiry: freezed == inviteLinkExpiry
          ? _value.inviteLinkExpiry
          : inviteLinkExpiry // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GroupSettingsCopyWith<$Res> get settings {
    return $GroupSettingsCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GroupInfoModelImplCopyWith<$Res>
    implements $GroupInfoModelCopyWith<$Res> {
  factory _$$GroupInfoModelImplCopyWith(_$GroupInfoModelImpl value,
          $Res Function(_$GroupInfoModelImpl) then) =
      __$$GroupInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? description,
      String? avatarUrl,
      String createdBy,
      DateTime createdAt,
      GroupSettings settings,
      String? inviteLink,
      DateTime? inviteLinkExpiry});

  @override
  $GroupSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class __$$GroupInfoModelImplCopyWithImpl<$Res>
    extends _$GroupInfoModelCopyWithImpl<$Res, _$GroupInfoModelImpl>
    implements _$$GroupInfoModelImplCopyWith<$Res> {
  __$$GroupInfoModelImplCopyWithImpl(
      _$GroupInfoModelImpl _value, $Res Function(_$GroupInfoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? avatarUrl = freezed,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? settings = null,
    Object? inviteLink = freezed,
    Object? inviteLinkExpiry = freezed,
  }) {
    return _then(_$GroupInfoModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as GroupSettings,
      inviteLink: freezed == inviteLink
          ? _value.inviteLink
          : inviteLink // ignore: cast_nullable_to_non_nullable
              as String?,
      inviteLinkExpiry: freezed == inviteLinkExpiry
          ? _value.inviteLinkExpiry
          : inviteLinkExpiry // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupInfoModelImpl implements _GroupInfoModel {
  const _$GroupInfoModelImpl(
      {required this.name,
      this.description,
      this.avatarUrl,
      required this.createdBy,
      required this.createdAt,
      this.settings = const GroupSettings(),
      this.inviteLink,
      this.inviteLinkExpiry});

  factory _$GroupInfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupInfoModelImplFromJson(json);

  @override
  final String name;
  @override
  final String? description;
  @override
  final String? avatarUrl;
  @override
  final String createdBy;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final GroupSettings settings;
  @override
  final String? inviteLink;
  @override
  final DateTime? inviteLinkExpiry;

  @override
  String toString() {
    return 'GroupInfoModel(name: $name, description: $description, avatarUrl: $avatarUrl, createdBy: $createdBy, createdAt: $createdAt, settings: $settings, inviteLink: $inviteLink, inviteLinkExpiry: $inviteLinkExpiry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupInfoModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.inviteLink, inviteLink) ||
                other.inviteLink == inviteLink) &&
            (identical(other.inviteLinkExpiry, inviteLinkExpiry) ||
                other.inviteLinkExpiry == inviteLinkExpiry));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, description, avatarUrl,
      createdBy, createdAt, settings, inviteLink, inviteLinkExpiry);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupInfoModelImplCopyWith<_$GroupInfoModelImpl> get copyWith =>
      __$$GroupInfoModelImplCopyWithImpl<_$GroupInfoModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupInfoModelImplToJson(
      this,
    );
  }
}

abstract class _GroupInfoModel implements GroupInfoModel {
  const factory _GroupInfoModel(
      {required final String name,
      final String? description,
      final String? avatarUrl,
      required final String createdBy,
      required final DateTime createdAt,
      final GroupSettings settings,
      final String? inviteLink,
      final DateTime? inviteLinkExpiry}) = _$GroupInfoModelImpl;

  factory _GroupInfoModel.fromJson(Map<String, dynamic> json) =
      _$GroupInfoModelImpl.fromJson;

  @override
  String get name;
  @override
  String? get description;
  @override
  String? get avatarUrl;
  @override
  String get createdBy;
  @override
  DateTime get createdAt;
  @override
  GroupSettings get settings;
  @override
  String? get inviteLink;
  @override
  DateTime? get inviteLinkExpiry;
  @override
  @JsonKey(ignore: true)
  _$$GroupInfoModelImplCopyWith<_$GroupInfoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GroupSettings _$GroupSettingsFromJson(Map<String, dynamic> json) {
  return _GroupSettings.fromJson(json);
}

/// @nodoc
mixin _$GroupSettings {
  bool get membersCanAddMembers => throw _privateConstructorUsedError;
  bool get membersCanEditInfo => throw _privateConstructorUsedError;
  bool get membersCanSendMessages => throw _privateConstructorUsedError;
  bool get approvalRequired => throw _privateConstructorUsedError;
  int get maxMembers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupSettingsCopyWith<GroupSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupSettingsCopyWith<$Res> {
  factory $GroupSettingsCopyWith(
          GroupSettings value, $Res Function(GroupSettings) then) =
      _$GroupSettingsCopyWithImpl<$Res, GroupSettings>;
  @useResult
  $Res call(
      {bool membersCanAddMembers,
      bool membersCanEditInfo,
      bool membersCanSendMessages,
      bool approvalRequired,
      int maxMembers});
}

/// @nodoc
class _$GroupSettingsCopyWithImpl<$Res, $Val extends GroupSettings>
    implements $GroupSettingsCopyWith<$Res> {
  _$GroupSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? membersCanAddMembers = null,
    Object? membersCanEditInfo = null,
    Object? membersCanSendMessages = null,
    Object? approvalRequired = null,
    Object? maxMembers = null,
  }) {
    return _then(_value.copyWith(
      membersCanAddMembers: null == membersCanAddMembers
          ? _value.membersCanAddMembers
          : membersCanAddMembers // ignore: cast_nullable_to_non_nullable
              as bool,
      membersCanEditInfo: null == membersCanEditInfo
          ? _value.membersCanEditInfo
          : membersCanEditInfo // ignore: cast_nullable_to_non_nullable
              as bool,
      membersCanSendMessages: null == membersCanSendMessages
          ? _value.membersCanSendMessages
          : membersCanSendMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      approvalRequired: null == approvalRequired
          ? _value.approvalRequired
          : approvalRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      maxMembers: null == maxMembers
          ? _value.maxMembers
          : maxMembers // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupSettingsImplCopyWith<$Res>
    implements $GroupSettingsCopyWith<$Res> {
  factory _$$GroupSettingsImplCopyWith(
          _$GroupSettingsImpl value, $Res Function(_$GroupSettingsImpl) then) =
      __$$GroupSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool membersCanAddMembers,
      bool membersCanEditInfo,
      bool membersCanSendMessages,
      bool approvalRequired,
      int maxMembers});
}

/// @nodoc
class __$$GroupSettingsImplCopyWithImpl<$Res>
    extends _$GroupSettingsCopyWithImpl<$Res, _$GroupSettingsImpl>
    implements _$$GroupSettingsImplCopyWith<$Res> {
  __$$GroupSettingsImplCopyWithImpl(
      _$GroupSettingsImpl _value, $Res Function(_$GroupSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? membersCanAddMembers = null,
    Object? membersCanEditInfo = null,
    Object? membersCanSendMessages = null,
    Object? approvalRequired = null,
    Object? maxMembers = null,
  }) {
    return _then(_$GroupSettingsImpl(
      membersCanAddMembers: null == membersCanAddMembers
          ? _value.membersCanAddMembers
          : membersCanAddMembers // ignore: cast_nullable_to_non_nullable
              as bool,
      membersCanEditInfo: null == membersCanEditInfo
          ? _value.membersCanEditInfo
          : membersCanEditInfo // ignore: cast_nullable_to_non_nullable
              as bool,
      membersCanSendMessages: null == membersCanSendMessages
          ? _value.membersCanSendMessages
          : membersCanSendMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      approvalRequired: null == approvalRequired
          ? _value.approvalRequired
          : approvalRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      maxMembers: null == maxMembers
          ? _value.maxMembers
          : maxMembers // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupSettingsImpl implements _GroupSettings {
  const _$GroupSettingsImpl(
      {this.membersCanAddMembers = true,
      this.membersCanEditInfo = true,
      this.membersCanSendMessages = true,
      this.approvalRequired = false,
      this.maxMembers = 256});

  factory _$GroupSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool membersCanAddMembers;
  @override
  @JsonKey()
  final bool membersCanEditInfo;
  @override
  @JsonKey()
  final bool membersCanSendMessages;
  @override
  @JsonKey()
  final bool approvalRequired;
  @override
  @JsonKey()
  final int maxMembers;

  @override
  String toString() {
    return 'GroupSettings(membersCanAddMembers: $membersCanAddMembers, membersCanEditInfo: $membersCanEditInfo, membersCanSendMessages: $membersCanSendMessages, approvalRequired: $approvalRequired, maxMembers: $maxMembers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupSettingsImpl &&
            (identical(other.membersCanAddMembers, membersCanAddMembers) ||
                other.membersCanAddMembers == membersCanAddMembers) &&
            (identical(other.membersCanEditInfo, membersCanEditInfo) ||
                other.membersCanEditInfo == membersCanEditInfo) &&
            (identical(other.membersCanSendMessages, membersCanSendMessages) ||
                other.membersCanSendMessages == membersCanSendMessages) &&
            (identical(other.approvalRequired, approvalRequired) ||
                other.approvalRequired == approvalRequired) &&
            (identical(other.maxMembers, maxMembers) ||
                other.maxMembers == maxMembers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, membersCanAddMembers,
      membersCanEditInfo, membersCanSendMessages, approvalRequired, maxMembers);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupSettingsImplCopyWith<_$GroupSettingsImpl> get copyWith =>
      __$$GroupSettingsImplCopyWithImpl<_$GroupSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupSettingsImplToJson(
      this,
    );
  }
}

abstract class _GroupSettings implements GroupSettings {
  const factory _GroupSettings(
      {final bool membersCanAddMembers,
      final bool membersCanEditInfo,
      final bool membersCanSendMessages,
      final bool approvalRequired,
      final int maxMembers}) = _$GroupSettingsImpl;

  factory _GroupSettings.fromJson(Map<String, dynamic> json) =
      _$GroupSettingsImpl.fromJson;

  @override
  bool get membersCanAddMembers;
  @override
  bool get membersCanEditInfo;
  @override
  bool get membersCanSendMessages;
  @override
  bool get approvalRequired;
  @override
  int get maxMembers;
  @override
  @JsonKey(ignore: true)
  _$$GroupSettingsImplCopyWith<_$GroupSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EncryptionInfo _$EncryptionInfoFromJson(Map<String, dynamic> json) {
  return _EncryptionInfo.fromJson(json);
}

/// @nodoc
mixin _$EncryptionInfo {
  String get sessionId => throw _privateConstructorUsedError;
  String get publicKey => throw _privateConstructorUsedError;
  DateTime? get keyRotatedAt => throw _privateConstructorUsedError;
  bool get isEnabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EncryptionInfoCopyWith<EncryptionInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EncryptionInfoCopyWith<$Res> {
  factory $EncryptionInfoCopyWith(
          EncryptionInfo value, $Res Function(EncryptionInfo) then) =
      _$EncryptionInfoCopyWithImpl<$Res, EncryptionInfo>;
  @useResult
  $Res call(
      {String sessionId,
      String publicKey,
      DateTime? keyRotatedAt,
      bool isEnabled});
}

/// @nodoc
class _$EncryptionInfoCopyWithImpl<$Res, $Val extends EncryptionInfo>
    implements $EncryptionInfoCopyWith<$Res> {
  _$EncryptionInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? publicKey = null,
    Object? keyRotatedAt = freezed,
    Object? isEnabled = null,
  }) {
    return _then(_value.copyWith(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      keyRotatedAt: freezed == keyRotatedAt
          ? _value.keyRotatedAt
          : keyRotatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EncryptionInfoImplCopyWith<$Res>
    implements $EncryptionInfoCopyWith<$Res> {
  factory _$$EncryptionInfoImplCopyWith(_$EncryptionInfoImpl value,
          $Res Function(_$EncryptionInfoImpl) then) =
      __$$EncryptionInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sessionId,
      String publicKey,
      DateTime? keyRotatedAt,
      bool isEnabled});
}

/// @nodoc
class __$$EncryptionInfoImplCopyWithImpl<$Res>
    extends _$EncryptionInfoCopyWithImpl<$Res, _$EncryptionInfoImpl>
    implements _$$EncryptionInfoImplCopyWith<$Res> {
  __$$EncryptionInfoImplCopyWithImpl(
      _$EncryptionInfoImpl _value, $Res Function(_$EncryptionInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? publicKey = null,
    Object? keyRotatedAt = freezed,
    Object? isEnabled = null,
  }) {
    return _then(_$EncryptionInfoImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      keyRotatedAt: freezed == keyRotatedAt
          ? _value.keyRotatedAt
          : keyRotatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EncryptionInfoImpl implements _EncryptionInfo {
  const _$EncryptionInfoImpl(
      {required this.sessionId,
      required this.publicKey,
      this.keyRotatedAt,
      this.isEnabled = true});

  factory _$EncryptionInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$EncryptionInfoImplFromJson(json);

  @override
  final String sessionId;
  @override
  final String publicKey;
  @override
  final DateTime? keyRotatedAt;
  @override
  @JsonKey()
  final bool isEnabled;

  @override
  String toString() {
    return 'EncryptionInfo(sessionId: $sessionId, publicKey: $publicKey, keyRotatedAt: $keyRotatedAt, isEnabled: $isEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EncryptionInfoImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey) &&
            (identical(other.keyRotatedAt, keyRotatedAt) ||
                other.keyRotatedAt == keyRotatedAt) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, sessionId, publicKey, keyRotatedAt, isEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EncryptionInfoImplCopyWith<_$EncryptionInfoImpl> get copyWith =>
      __$$EncryptionInfoImplCopyWithImpl<_$EncryptionInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EncryptionInfoImplToJson(
      this,
    );
  }
}

abstract class _EncryptionInfo implements EncryptionInfo {
  const factory _EncryptionInfo(
      {required final String sessionId,
      required final String publicKey,
      final DateTime? keyRotatedAt,
      final bool isEnabled}) = _$EncryptionInfoImpl;

  factory _EncryptionInfo.fromJson(Map<String, dynamic> json) =
      _$EncryptionInfoImpl.fromJson;

  @override
  String get sessionId;
  @override
  String get publicKey;
  @override
  DateTime? get keyRotatedAt;
  @override
  bool get isEnabled;
  @override
  @JsonKey(ignore: true)
  _$$EncryptionInfoImplCopyWith<_$EncryptionInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
