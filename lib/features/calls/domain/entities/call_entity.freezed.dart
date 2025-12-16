// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CallEntity _$CallEntityFromJson(Map<String, dynamic> json) {
  return _CallEntity.fromJson(json);
}

/// @nodoc
mixin _$CallEntity {
  String get id => throw _privateConstructorUsedError;
  String get chatId => throw _privateConstructorUsedError;
  String get callerId => throw _privateConstructorUsedError;
  String get callerName => throw _privateConstructorUsedError;
  String? get callerAvatarUrl => throw _privateConstructorUsedError;
  List<String> get participantIds => throw _privateConstructorUsedError;
  CallType get type => throw _privateConstructorUsedError;
  CallStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get answeredAt => throw _privateConstructorUsedError;
  DateTime? get endedAt => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  CallEndReason? get endReason => throw _privateConstructorUsedError;
  String? get offer => throw _privateConstructorUsedError;
  String? get answer => throw _privateConstructorUsedError;
  List<IceCandidateEntity> get iceCandidates =>
      throw _privateConstructorUsedError;
  CallQuality? get quality => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CallEntityCopyWith<CallEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallEntityCopyWith<$Res> {
  factory $CallEntityCopyWith(
          CallEntity value, $Res Function(CallEntity) then) =
      _$CallEntityCopyWithImpl<$Res, CallEntity>;
  @useResult
  $Res call(
      {String id,
      String chatId,
      String callerId,
      String callerName,
      String? callerAvatarUrl,
      List<String> participantIds,
      CallType type,
      CallStatus status,
      DateTime createdAt,
      DateTime? answeredAt,
      DateTime? endedAt,
      int duration,
      CallEndReason? endReason,
      String? offer,
      String? answer,
      List<IceCandidateEntity> iceCandidates,
      CallQuality? quality});

  $CallQualityCopyWith<$Res>? get quality;
}

/// @nodoc
class _$CallEntityCopyWithImpl<$Res, $Val extends CallEntity>
    implements $CallEntityCopyWith<$Res> {
  _$CallEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatId = null,
    Object? callerId = null,
    Object? callerName = null,
    Object? callerAvatarUrl = freezed,
    Object? participantIds = null,
    Object? type = null,
    Object? status = null,
    Object? createdAt = null,
    Object? answeredAt = freezed,
    Object? endedAt = freezed,
    Object? duration = null,
    Object? endReason = freezed,
    Object? offer = freezed,
    Object? answer = freezed,
    Object? iceCandidates = null,
    Object? quality = freezed,
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
      callerId: null == callerId
          ? _value.callerId
          : callerId // ignore: cast_nullable_to_non_nullable
              as String,
      callerName: null == callerName
          ? _value.callerName
          : callerName // ignore: cast_nullable_to_non_nullable
              as String,
      callerAvatarUrl: freezed == callerAvatarUrl
          ? _value.callerAvatarUrl
          : callerAvatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      participantIds: null == participantIds
          ? _value.participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CallType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CallStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      answeredAt: freezed == answeredAt
          ? _value.answeredAt
          : answeredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endedAt: freezed == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      endReason: freezed == endReason
          ? _value.endReason
          : endReason // ignore: cast_nullable_to_non_nullable
              as CallEndReason?,
      offer: freezed == offer
          ? _value.offer
          : offer // ignore: cast_nullable_to_non_nullable
              as String?,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String?,
      iceCandidates: null == iceCandidates
          ? _value.iceCandidates
          : iceCandidates // ignore: cast_nullable_to_non_nullable
              as List<IceCandidateEntity>,
      quality: freezed == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as CallQuality?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CallQualityCopyWith<$Res>? get quality {
    if (_value.quality == null) {
      return null;
    }

    return $CallQualityCopyWith<$Res>(_value.quality!, (value) {
      return _then(_value.copyWith(quality: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CallEntityImplCopyWith<$Res>
    implements $CallEntityCopyWith<$Res> {
  factory _$$CallEntityImplCopyWith(
          _$CallEntityImpl value, $Res Function(_$CallEntityImpl) then) =
      __$$CallEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String chatId,
      String callerId,
      String callerName,
      String? callerAvatarUrl,
      List<String> participantIds,
      CallType type,
      CallStatus status,
      DateTime createdAt,
      DateTime? answeredAt,
      DateTime? endedAt,
      int duration,
      CallEndReason? endReason,
      String? offer,
      String? answer,
      List<IceCandidateEntity> iceCandidates,
      CallQuality? quality});

  @override
  $CallQualityCopyWith<$Res>? get quality;
}

/// @nodoc
class __$$CallEntityImplCopyWithImpl<$Res>
    extends _$CallEntityCopyWithImpl<$Res, _$CallEntityImpl>
    implements _$$CallEntityImplCopyWith<$Res> {
  __$$CallEntityImplCopyWithImpl(
      _$CallEntityImpl _value, $Res Function(_$CallEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatId = null,
    Object? callerId = null,
    Object? callerName = null,
    Object? callerAvatarUrl = freezed,
    Object? participantIds = null,
    Object? type = null,
    Object? status = null,
    Object? createdAt = null,
    Object? answeredAt = freezed,
    Object? endedAt = freezed,
    Object? duration = null,
    Object? endReason = freezed,
    Object? offer = freezed,
    Object? answer = freezed,
    Object? iceCandidates = null,
    Object? quality = freezed,
  }) {
    return _then(_$CallEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      callerId: null == callerId
          ? _value.callerId
          : callerId // ignore: cast_nullable_to_non_nullable
              as String,
      callerName: null == callerName
          ? _value.callerName
          : callerName // ignore: cast_nullable_to_non_nullable
              as String,
      callerAvatarUrl: freezed == callerAvatarUrl
          ? _value.callerAvatarUrl
          : callerAvatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      participantIds: null == participantIds
          ? _value._participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CallType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CallStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      answeredAt: freezed == answeredAt
          ? _value.answeredAt
          : answeredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endedAt: freezed == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      endReason: freezed == endReason
          ? _value.endReason
          : endReason // ignore: cast_nullable_to_non_nullable
              as CallEndReason?,
      offer: freezed == offer
          ? _value.offer
          : offer // ignore: cast_nullable_to_non_nullable
              as String?,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String?,
      iceCandidates: null == iceCandidates
          ? _value._iceCandidates
          : iceCandidates // ignore: cast_nullable_to_non_nullable
              as List<IceCandidateEntity>,
      quality: freezed == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as CallQuality?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CallEntityImpl implements _CallEntity {
  const _$CallEntityImpl(
      {required this.id,
      required this.chatId,
      required this.callerId,
      required this.callerName,
      this.callerAvatarUrl,
      required final List<String> participantIds,
      required this.type,
      required this.status,
      required this.createdAt,
      this.answeredAt,
      this.endedAt,
      this.duration = 0,
      this.endReason,
      this.offer,
      this.answer,
      final List<IceCandidateEntity> iceCandidates = const [],
      this.quality})
      : _participantIds = participantIds,
        _iceCandidates = iceCandidates;

  factory _$CallEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String chatId;
  @override
  final String callerId;
  @override
  final String callerName;
  @override
  final String? callerAvatarUrl;
  final List<String> _participantIds;
  @override
  List<String> get participantIds {
    if (_participantIds is EqualUnmodifiableListView) return _participantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantIds);
  }

  @override
  final CallType type;
  @override
  final CallStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime? answeredAt;
  @override
  final DateTime? endedAt;
  @override
  @JsonKey()
  final int duration;
  @override
  final CallEndReason? endReason;
  @override
  final String? offer;
  @override
  final String? answer;
  final List<IceCandidateEntity> _iceCandidates;
  @override
  @JsonKey()
  List<IceCandidateEntity> get iceCandidates {
    if (_iceCandidates is EqualUnmodifiableListView) return _iceCandidates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_iceCandidates);
  }

  @override
  final CallQuality? quality;

  @override
  String toString() {
    return 'CallEntity(id: $id, chatId: $chatId, callerId: $callerId, callerName: $callerName, callerAvatarUrl: $callerAvatarUrl, participantIds: $participantIds, type: $type, status: $status, createdAt: $createdAt, answeredAt: $answeredAt, endedAt: $endedAt, duration: $duration, endReason: $endReason, offer: $offer, answer: $answer, iceCandidates: $iceCandidates, quality: $quality)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.callerId, callerId) ||
                other.callerId == callerId) &&
            (identical(other.callerName, callerName) ||
                other.callerName == callerName) &&
            (identical(other.callerAvatarUrl, callerAvatarUrl) ||
                other.callerAvatarUrl == callerAvatarUrl) &&
            const DeepCollectionEquality()
                .equals(other._participantIds, _participantIds) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.answeredAt, answeredAt) ||
                other.answeredAt == answeredAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.endReason, endReason) ||
                other.endReason == endReason) &&
            (identical(other.offer, offer) || other.offer == offer) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            const DeepCollectionEquality()
                .equals(other._iceCandidates, _iceCandidates) &&
            (identical(other.quality, quality) || other.quality == quality));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      chatId,
      callerId,
      callerName,
      callerAvatarUrl,
      const DeepCollectionEquality().hash(_participantIds),
      type,
      status,
      createdAt,
      answeredAt,
      endedAt,
      duration,
      endReason,
      offer,
      answer,
      const DeepCollectionEquality().hash(_iceCandidates),
      quality);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CallEntityImplCopyWith<_$CallEntityImpl> get copyWith =>
      __$$CallEntityImplCopyWithImpl<_$CallEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CallEntityImplToJson(
      this,
    );
  }
}

abstract class _CallEntity implements CallEntity {
  const factory _CallEntity(
      {required final String id,
      required final String chatId,
      required final String callerId,
      required final String callerName,
      final String? callerAvatarUrl,
      required final List<String> participantIds,
      required final CallType type,
      required final CallStatus status,
      required final DateTime createdAt,
      final DateTime? answeredAt,
      final DateTime? endedAt,
      final int duration,
      final CallEndReason? endReason,
      final String? offer,
      final String? answer,
      final List<IceCandidateEntity> iceCandidates,
      final CallQuality? quality}) = _$CallEntityImpl;

  factory _CallEntity.fromJson(Map<String, dynamic> json) =
      _$CallEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get chatId;
  @override
  String get callerId;
  @override
  String get callerName;
  @override
  String? get callerAvatarUrl;
  @override
  List<String> get participantIds;
  @override
  CallType get type;
  @override
  CallStatus get status;
  @override
  DateTime get createdAt;
  @override
  DateTime? get answeredAt;
  @override
  DateTime? get endedAt;
  @override
  int get duration;
  @override
  CallEndReason? get endReason;
  @override
  String? get offer;
  @override
  String? get answer;
  @override
  List<IceCandidateEntity> get iceCandidates;
  @override
  CallQuality? get quality;
  @override
  @JsonKey(ignore: true)
  _$$CallEntityImplCopyWith<_$CallEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IceCandidateEntity _$IceCandidateEntityFromJson(Map<String, dynamic> json) {
  return _IceCandidateEntity.fromJson(json);
}

/// @nodoc
mixin _$IceCandidateEntity {
  String get candidate => throw _privateConstructorUsedError;
  String get sdpMid => throw _privateConstructorUsedError;
  int get sdpMLineIndex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IceCandidateEntityCopyWith<IceCandidateEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IceCandidateEntityCopyWith<$Res> {
  factory $IceCandidateEntityCopyWith(
          IceCandidateEntity value, $Res Function(IceCandidateEntity) then) =
      _$IceCandidateEntityCopyWithImpl<$Res, IceCandidateEntity>;
  @useResult
  $Res call({String candidate, String sdpMid, int sdpMLineIndex});
}

/// @nodoc
class _$IceCandidateEntityCopyWithImpl<$Res, $Val extends IceCandidateEntity>
    implements $IceCandidateEntityCopyWith<$Res> {
  _$IceCandidateEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? candidate = null,
    Object? sdpMid = null,
    Object? sdpMLineIndex = null,
  }) {
    return _then(_value.copyWith(
      candidate: null == candidate
          ? _value.candidate
          : candidate // ignore: cast_nullable_to_non_nullable
              as String,
      sdpMid: null == sdpMid
          ? _value.sdpMid
          : sdpMid // ignore: cast_nullable_to_non_nullable
              as String,
      sdpMLineIndex: null == sdpMLineIndex
          ? _value.sdpMLineIndex
          : sdpMLineIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IceCandidateEntityImplCopyWith<$Res>
    implements $IceCandidateEntityCopyWith<$Res> {
  factory _$$IceCandidateEntityImplCopyWith(_$IceCandidateEntityImpl value,
          $Res Function(_$IceCandidateEntityImpl) then) =
      __$$IceCandidateEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String candidate, String sdpMid, int sdpMLineIndex});
}

/// @nodoc
class __$$IceCandidateEntityImplCopyWithImpl<$Res>
    extends _$IceCandidateEntityCopyWithImpl<$Res, _$IceCandidateEntityImpl>
    implements _$$IceCandidateEntityImplCopyWith<$Res> {
  __$$IceCandidateEntityImplCopyWithImpl(_$IceCandidateEntityImpl _value,
      $Res Function(_$IceCandidateEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? candidate = null,
    Object? sdpMid = null,
    Object? sdpMLineIndex = null,
  }) {
    return _then(_$IceCandidateEntityImpl(
      candidate: null == candidate
          ? _value.candidate
          : candidate // ignore: cast_nullable_to_non_nullable
              as String,
      sdpMid: null == sdpMid
          ? _value.sdpMid
          : sdpMid // ignore: cast_nullable_to_non_nullable
              as String,
      sdpMLineIndex: null == sdpMLineIndex
          ? _value.sdpMLineIndex
          : sdpMLineIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IceCandidateEntityImpl implements _IceCandidateEntity {
  const _$IceCandidateEntityImpl(
      {required this.candidate,
      required this.sdpMid,
      required this.sdpMLineIndex});

  factory _$IceCandidateEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$IceCandidateEntityImplFromJson(json);

  @override
  final String candidate;
  @override
  final String sdpMid;
  @override
  final int sdpMLineIndex;

  @override
  String toString() {
    return 'IceCandidateEntity(candidate: $candidate, sdpMid: $sdpMid, sdpMLineIndex: $sdpMLineIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IceCandidateEntityImpl &&
            (identical(other.candidate, candidate) ||
                other.candidate == candidate) &&
            (identical(other.sdpMid, sdpMid) || other.sdpMid == sdpMid) &&
            (identical(other.sdpMLineIndex, sdpMLineIndex) ||
                other.sdpMLineIndex == sdpMLineIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, candidate, sdpMid, sdpMLineIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IceCandidateEntityImplCopyWith<_$IceCandidateEntityImpl> get copyWith =>
      __$$IceCandidateEntityImplCopyWithImpl<_$IceCandidateEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IceCandidateEntityImplToJson(
      this,
    );
  }
}

abstract class _IceCandidateEntity implements IceCandidateEntity {
  const factory _IceCandidateEntity(
      {required final String candidate,
      required final String sdpMid,
      required final int sdpMLineIndex}) = _$IceCandidateEntityImpl;

  factory _IceCandidateEntity.fromJson(Map<String, dynamic> json) =
      _$IceCandidateEntityImpl.fromJson;

  @override
  String get candidate;
  @override
  String get sdpMid;
  @override
  int get sdpMLineIndex;
  @override
  @JsonKey(ignore: true)
  _$$IceCandidateEntityImplCopyWith<_$IceCandidateEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CallQuality _$CallQualityFromJson(Map<String, dynamic> json) {
  return _CallQuality.fromJson(json);
}

/// @nodoc
mixin _$CallQuality {
  int get packetLoss => throw _privateConstructorUsedError;
  int get jitter => throw _privateConstructorUsedError;
  int get roundTripTime => throw _privateConstructorUsedError;
  String get connectionType => throw _privateConstructorUsedError;
  int get bitrate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CallQualityCopyWith<CallQuality> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallQualityCopyWith<$Res> {
  factory $CallQualityCopyWith(
          CallQuality value, $Res Function(CallQuality) then) =
      _$CallQualityCopyWithImpl<$Res, CallQuality>;
  @useResult
  $Res call(
      {int packetLoss,
      int jitter,
      int roundTripTime,
      String connectionType,
      int bitrate});
}

/// @nodoc
class _$CallQualityCopyWithImpl<$Res, $Val extends CallQuality>
    implements $CallQualityCopyWith<$Res> {
  _$CallQualityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packetLoss = null,
    Object? jitter = null,
    Object? roundTripTime = null,
    Object? connectionType = null,
    Object? bitrate = null,
  }) {
    return _then(_value.copyWith(
      packetLoss: null == packetLoss
          ? _value.packetLoss
          : packetLoss // ignore: cast_nullable_to_non_nullable
              as int,
      jitter: null == jitter
          ? _value.jitter
          : jitter // ignore: cast_nullable_to_non_nullable
              as int,
      roundTripTime: null == roundTripTime
          ? _value.roundTripTime
          : roundTripTime // ignore: cast_nullable_to_non_nullable
              as int,
      connectionType: null == connectionType
          ? _value.connectionType
          : connectionType // ignore: cast_nullable_to_non_nullable
              as String,
      bitrate: null == bitrate
          ? _value.bitrate
          : bitrate // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CallQualityImplCopyWith<$Res>
    implements $CallQualityCopyWith<$Res> {
  factory _$$CallQualityImplCopyWith(
          _$CallQualityImpl value, $Res Function(_$CallQualityImpl) then) =
      __$$CallQualityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int packetLoss,
      int jitter,
      int roundTripTime,
      String connectionType,
      int bitrate});
}

/// @nodoc
class __$$CallQualityImplCopyWithImpl<$Res>
    extends _$CallQualityCopyWithImpl<$Res, _$CallQualityImpl>
    implements _$$CallQualityImplCopyWith<$Res> {
  __$$CallQualityImplCopyWithImpl(
      _$CallQualityImpl _value, $Res Function(_$CallQualityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packetLoss = null,
    Object? jitter = null,
    Object? roundTripTime = null,
    Object? connectionType = null,
    Object? bitrate = null,
  }) {
    return _then(_$CallQualityImpl(
      packetLoss: null == packetLoss
          ? _value.packetLoss
          : packetLoss // ignore: cast_nullable_to_non_nullable
              as int,
      jitter: null == jitter
          ? _value.jitter
          : jitter // ignore: cast_nullable_to_non_nullable
              as int,
      roundTripTime: null == roundTripTime
          ? _value.roundTripTime
          : roundTripTime // ignore: cast_nullable_to_non_nullable
              as int,
      connectionType: null == connectionType
          ? _value.connectionType
          : connectionType // ignore: cast_nullable_to_non_nullable
              as String,
      bitrate: null == bitrate
          ? _value.bitrate
          : bitrate // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CallQualityImpl implements _CallQuality {
  const _$CallQualityImpl(
      {this.packetLoss = 0,
      this.jitter = 0,
      this.roundTripTime = 0,
      this.connectionType = 'unknown',
      this.bitrate = 0});

  factory _$CallQualityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallQualityImplFromJson(json);

  @override
  @JsonKey()
  final int packetLoss;
  @override
  @JsonKey()
  final int jitter;
  @override
  @JsonKey()
  final int roundTripTime;
  @override
  @JsonKey()
  final String connectionType;
  @override
  @JsonKey()
  final int bitrate;

  @override
  String toString() {
    return 'CallQuality(packetLoss: $packetLoss, jitter: $jitter, roundTripTime: $roundTripTime, connectionType: $connectionType, bitrate: $bitrate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallQualityImpl &&
            (identical(other.packetLoss, packetLoss) ||
                other.packetLoss == packetLoss) &&
            (identical(other.jitter, jitter) || other.jitter == jitter) &&
            (identical(other.roundTripTime, roundTripTime) ||
                other.roundTripTime == roundTripTime) &&
            (identical(other.connectionType, connectionType) ||
                other.connectionType == connectionType) &&
            (identical(other.bitrate, bitrate) || other.bitrate == bitrate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, packetLoss, jitter, roundTripTime, connectionType, bitrate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CallQualityImplCopyWith<_$CallQualityImpl> get copyWith =>
      __$$CallQualityImplCopyWithImpl<_$CallQualityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CallQualityImplToJson(
      this,
    );
  }
}

abstract class _CallQuality implements CallQuality {
  const factory _CallQuality(
      {final int packetLoss,
      final int jitter,
      final int roundTripTime,
      final String connectionType,
      final int bitrate}) = _$CallQualityImpl;

  factory _CallQuality.fromJson(Map<String, dynamic> json) =
      _$CallQualityImpl.fromJson;

  @override
  int get packetLoss;
  @override
  int get jitter;
  @override
  int get roundTripTime;
  @override
  String get connectionType;
  @override
  int get bitrate;
  @override
  @JsonKey(ignore: true)
  _$$CallQualityImplCopyWith<_$CallQualityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
