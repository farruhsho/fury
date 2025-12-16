// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get avatarThumbnailUrl => throw _privateConstructorUsedError;
  bool get isOnline => throw _privateConstructorUsedError;
  DateTime? get lastSeen => throw _privateConstructorUsedError;
  PrivacySettings get privacySettings => throw _privateConstructorUsedError;
  NotificationSettings get notificationSettings =>
      throw _privateConstructorUsedError;
  String? get pushToken => throw _privateConstructorUsedError;
  String? get voipToken => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<String> get blockedUserIds => throw _privateConstructorUsedError;
  UserStatus get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String id,
      String? email,
      String? phoneNumber,
      String? username,
      String? displayName,
      String? bio,
      String? avatarUrl,
      String? avatarThumbnailUrl,
      bool isOnline,
      DateTime? lastSeen,
      PrivacySettings privacySettings,
      NotificationSettings notificationSettings,
      String? pushToken,
      String? voipToken,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<String> blockedUserIds,
      UserStatus status});

  $PrivacySettingsCopyWith<$Res> get privacySettings;
  $NotificationSettingsCopyWith<$Res> get notificationSettings;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? username = freezed,
    Object? displayName = freezed,
    Object? bio = freezed,
    Object? avatarUrl = freezed,
    Object? avatarThumbnailUrl = freezed,
    Object? isOnline = null,
    Object? lastSeen = freezed,
    Object? privacySettings = null,
    Object? notificationSettings = null,
    Object? pushToken = freezed,
    Object? voipToken = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? blockedUserIds = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarThumbnailUrl: freezed == avatarThumbnailUrl
          ? _value.avatarThumbnailUrl
          : avatarThumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      privacySettings: null == privacySettings
          ? _value.privacySettings
          : privacySettings // ignore: cast_nullable_to_non_nullable
              as PrivacySettings,
      notificationSettings: null == notificationSettings
          ? _value.notificationSettings
          : notificationSettings // ignore: cast_nullable_to_non_nullable
              as NotificationSettings,
      pushToken: freezed == pushToken
          ? _value.pushToken
          : pushToken // ignore: cast_nullable_to_non_nullable
              as String?,
      voipToken: freezed == voipToken
          ? _value.voipToken
          : voipToken // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      blockedUserIds: null == blockedUserIds
          ? _value.blockedUserIds
          : blockedUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UserStatus,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PrivacySettingsCopyWith<$Res> get privacySettings {
    return $PrivacySettingsCopyWith<$Res>(_value.privacySettings, (value) {
      return _then(_value.copyWith(privacySettings: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NotificationSettingsCopyWith<$Res> get notificationSettings {
    return $NotificationSettingsCopyWith<$Res>(_value.notificationSettings,
        (value) {
      return _then(_value.copyWith(notificationSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? email,
      String? phoneNumber,
      String? username,
      String? displayName,
      String? bio,
      String? avatarUrl,
      String? avatarThumbnailUrl,
      bool isOnline,
      DateTime? lastSeen,
      PrivacySettings privacySettings,
      NotificationSettings notificationSettings,
      String? pushToken,
      String? voipToken,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<String> blockedUserIds,
      UserStatus status});

  @override
  $PrivacySettingsCopyWith<$Res> get privacySettings;
  @override
  $NotificationSettingsCopyWith<$Res> get notificationSettings;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? username = freezed,
    Object? displayName = freezed,
    Object? bio = freezed,
    Object? avatarUrl = freezed,
    Object? avatarThumbnailUrl = freezed,
    Object? isOnline = null,
    Object? lastSeen = freezed,
    Object? privacySettings = null,
    Object? notificationSettings = null,
    Object? pushToken = freezed,
    Object? voipToken = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? blockedUserIds = null,
    Object? status = null,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarThumbnailUrl: freezed == avatarThumbnailUrl
          ? _value.avatarThumbnailUrl
          : avatarThumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      privacySettings: null == privacySettings
          ? _value.privacySettings
          : privacySettings // ignore: cast_nullable_to_non_nullable
              as PrivacySettings,
      notificationSettings: null == notificationSettings
          ? _value.notificationSettings
          : notificationSettings // ignore: cast_nullable_to_non_nullable
              as NotificationSettings,
      pushToken: freezed == pushToken
          ? _value.pushToken
          : pushToken // ignore: cast_nullable_to_non_nullable
              as String?,
      voipToken: freezed == voipToken
          ? _value.voipToken
          : voipToken // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      blockedUserIds: null == blockedUserIds
          ? _value._blockedUserIds
          : blockedUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UserStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.id,
      this.email,
      this.phoneNumber,
      this.username,
      this.displayName,
      this.bio,
      this.avatarUrl,
      this.avatarThumbnailUrl,
      this.isOnline = false,
      this.lastSeen,
      this.privacySettings = const PrivacySettings(),
      this.notificationSettings = const NotificationSettings(),
      this.pushToken,
      this.voipToken,
      this.createdAt,
      this.updatedAt,
      final List<String> blockedUserIds = const [],
      this.status = UserStatus.active})
      : _blockedUserIds = blockedUserIds;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? email;
  @override
  final String? phoneNumber;
  @override
  final String? username;
  @override
  final String? displayName;
  @override
  final String? bio;
  @override
  final String? avatarUrl;
  @override
  final String? avatarThumbnailUrl;
  @override
  @JsonKey()
  final bool isOnline;
  @override
  final DateTime? lastSeen;
  @override
  @JsonKey()
  final PrivacySettings privacySettings;
  @override
  @JsonKey()
  final NotificationSettings notificationSettings;
  @override
  final String? pushToken;
  @override
  final String? voipToken;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  final List<String> _blockedUserIds;
  @override
  @JsonKey()
  List<String> get blockedUserIds {
    if (_blockedUserIds is EqualUnmodifiableListView) return _blockedUserIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blockedUserIds);
  }

  @override
  @JsonKey()
  final UserStatus status;

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, phoneNumber: $phoneNumber, username: $username, displayName: $displayName, bio: $bio, avatarUrl: $avatarUrl, avatarThumbnailUrl: $avatarThumbnailUrl, isOnline: $isOnline, lastSeen: $lastSeen, privacySettings: $privacySettings, notificationSettings: $notificationSettings, pushToken: $pushToken, voipToken: $voipToken, createdAt: $createdAt, updatedAt: $updatedAt, blockedUserIds: $blockedUserIds, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.avatarThumbnailUrl, avatarThumbnailUrl) ||
                other.avatarThumbnailUrl == avatarThumbnailUrl) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen) &&
            (identical(other.privacySettings, privacySettings) ||
                other.privacySettings == privacySettings) &&
            (identical(other.notificationSettings, notificationSettings) ||
                other.notificationSettings == notificationSettings) &&
            (identical(other.pushToken, pushToken) ||
                other.pushToken == pushToken) &&
            (identical(other.voipToken, voipToken) ||
                other.voipToken == voipToken) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality()
                .equals(other._blockedUserIds, _blockedUserIds) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      phoneNumber,
      username,
      displayName,
      bio,
      avatarUrl,
      avatarThumbnailUrl,
      isOnline,
      lastSeen,
      privacySettings,
      notificationSettings,
      pushToken,
      voipToken,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_blockedUserIds),
      status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String id,
      final String? email,
      final String? phoneNumber,
      final String? username,
      final String? displayName,
      final String? bio,
      final String? avatarUrl,
      final String? avatarThumbnailUrl,
      final bool isOnline,
      final DateTime? lastSeen,
      final PrivacySettings privacySettings,
      final NotificationSettings notificationSettings,
      final String? pushToken,
      final String? voipToken,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final List<String> blockedUserIds,
      final UserStatus status}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get email;
  @override
  String? get phoneNumber;
  @override
  String? get username;
  @override
  String? get displayName;
  @override
  String? get bio;
  @override
  String? get avatarUrl;
  @override
  String? get avatarThumbnailUrl;
  @override
  bool get isOnline;
  @override
  DateTime? get lastSeen;
  @override
  PrivacySettings get privacySettings;
  @override
  NotificationSettings get notificationSettings;
  @override
  String? get pushToken;
  @override
  String? get voipToken;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  List<String> get blockedUserIds;
  @override
  UserStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PrivacySettings _$PrivacySettingsFromJson(Map<String, dynamic> json) {
  return _PrivacySettings.fromJson(json);
}

/// @nodoc
mixin _$PrivacySettings {
  PrivacyOption get lastSeen => throw _privateConstructorUsedError;
  PrivacyOption get profilePhoto => throw _privateConstructorUsedError;
  PrivacyOption get about => throw _privateConstructorUsedError;
  PrivacyOption get status => throw _privateConstructorUsedError;
  PrivacyOption get groups => throw _privateConstructorUsedError;
  bool get readReceipts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PrivacySettingsCopyWith<PrivacySettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrivacySettingsCopyWith<$Res> {
  factory $PrivacySettingsCopyWith(
          PrivacySettings value, $Res Function(PrivacySettings) then) =
      _$PrivacySettingsCopyWithImpl<$Res, PrivacySettings>;
  @useResult
  $Res call(
      {PrivacyOption lastSeen,
      PrivacyOption profilePhoto,
      PrivacyOption about,
      PrivacyOption status,
      PrivacyOption groups,
      bool readReceipts});
}

/// @nodoc
class _$PrivacySettingsCopyWithImpl<$Res, $Val extends PrivacySettings>
    implements $PrivacySettingsCopyWith<$Res> {
  _$PrivacySettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastSeen = null,
    Object? profilePhoto = null,
    Object? about = null,
    Object? status = null,
    Object? groups = null,
    Object? readReceipts = null,
  }) {
    return _then(_value.copyWith(
      lastSeen: null == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as PrivacyOption,
      profilePhoto: null == profilePhoto
          ? _value.profilePhoto
          : profilePhoto // ignore: cast_nullable_to_non_nullable
              as PrivacyOption,
      about: null == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as PrivacyOption,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PrivacyOption,
      groups: null == groups
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as PrivacyOption,
      readReceipts: null == readReceipts
          ? _value.readReceipts
          : readReceipts // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrivacySettingsImplCopyWith<$Res>
    implements $PrivacySettingsCopyWith<$Res> {
  factory _$$PrivacySettingsImplCopyWith(_$PrivacySettingsImpl value,
          $Res Function(_$PrivacySettingsImpl) then) =
      __$$PrivacySettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PrivacyOption lastSeen,
      PrivacyOption profilePhoto,
      PrivacyOption about,
      PrivacyOption status,
      PrivacyOption groups,
      bool readReceipts});
}

/// @nodoc
class __$$PrivacySettingsImplCopyWithImpl<$Res>
    extends _$PrivacySettingsCopyWithImpl<$Res, _$PrivacySettingsImpl>
    implements _$$PrivacySettingsImplCopyWith<$Res> {
  __$$PrivacySettingsImplCopyWithImpl(
      _$PrivacySettingsImpl _value, $Res Function(_$PrivacySettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastSeen = null,
    Object? profilePhoto = null,
    Object? about = null,
    Object? status = null,
    Object? groups = null,
    Object? readReceipts = null,
  }) {
    return _then(_$PrivacySettingsImpl(
      lastSeen: null == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as PrivacyOption,
      profilePhoto: null == profilePhoto
          ? _value.profilePhoto
          : profilePhoto // ignore: cast_nullable_to_non_nullable
              as PrivacyOption,
      about: null == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as PrivacyOption,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PrivacyOption,
      groups: null == groups
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as PrivacyOption,
      readReceipts: null == readReceipts
          ? _value.readReceipts
          : readReceipts // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrivacySettingsImpl implements _PrivacySettings {
  const _$PrivacySettingsImpl(
      {this.lastSeen = PrivacyOption.everyone,
      this.profilePhoto = PrivacyOption.everyone,
      this.about = PrivacyOption.everyone,
      this.status = PrivacyOption.everyone,
      this.groups = PrivacyOption.everyone,
      this.readReceipts = true});

  factory _$PrivacySettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrivacySettingsImplFromJson(json);

  @override
  @JsonKey()
  final PrivacyOption lastSeen;
  @override
  @JsonKey()
  final PrivacyOption profilePhoto;
  @override
  @JsonKey()
  final PrivacyOption about;
  @override
  @JsonKey()
  final PrivacyOption status;
  @override
  @JsonKey()
  final PrivacyOption groups;
  @override
  @JsonKey()
  final bool readReceipts;

  @override
  String toString() {
    return 'PrivacySettings(lastSeen: $lastSeen, profilePhoto: $profilePhoto, about: $about, status: $status, groups: $groups, readReceipts: $readReceipts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrivacySettingsImpl &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen) &&
            (identical(other.profilePhoto, profilePhoto) ||
                other.profilePhoto == profilePhoto) &&
            (identical(other.about, about) || other.about == about) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.groups, groups) || other.groups == groups) &&
            (identical(other.readReceipts, readReceipts) ||
                other.readReceipts == readReceipts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, lastSeen, profilePhoto, about, status, groups, readReceipts);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrivacySettingsImplCopyWith<_$PrivacySettingsImpl> get copyWith =>
      __$$PrivacySettingsImplCopyWithImpl<_$PrivacySettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrivacySettingsImplToJson(
      this,
    );
  }
}

abstract class _PrivacySettings implements PrivacySettings {
  const factory _PrivacySettings(
      {final PrivacyOption lastSeen,
      final PrivacyOption profilePhoto,
      final PrivacyOption about,
      final PrivacyOption status,
      final PrivacyOption groups,
      final bool readReceipts}) = _$PrivacySettingsImpl;

  factory _PrivacySettings.fromJson(Map<String, dynamic> json) =
      _$PrivacySettingsImpl.fromJson;

  @override
  PrivacyOption get lastSeen;
  @override
  PrivacyOption get profilePhoto;
  @override
  PrivacyOption get about;
  @override
  PrivacyOption get status;
  @override
  PrivacyOption get groups;
  @override
  bool get readReceipts;
  @override
  @JsonKey(ignore: true)
  _$$PrivacySettingsImplCopyWith<_$PrivacySettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationSettings _$NotificationSettingsFromJson(Map<String, dynamic> json) {
  return _NotificationSettings.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettings {
  bool get enabled => throw _privateConstructorUsedError;
  bool get sound => throw _privateConstructorUsedError;
  bool get vibration => throw _privateConstructorUsedError;
  bool get showPreview => throw _privateConstructorUsedError;
  bool get messageNotifications => throw _privateConstructorUsedError;
  bool get groupNotifications => throw _privateConstructorUsedError;
  bool get callNotifications => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationSettingsCopyWith<NotificationSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsCopyWith<$Res> {
  factory $NotificationSettingsCopyWith(NotificationSettings value,
          $Res Function(NotificationSettings) then) =
      _$NotificationSettingsCopyWithImpl<$Res, NotificationSettings>;
  @useResult
  $Res call(
      {bool enabled,
      bool sound,
      bool vibration,
      bool showPreview,
      bool messageNotifications,
      bool groupNotifications,
      bool callNotifications});
}

/// @nodoc
class _$NotificationSettingsCopyWithImpl<$Res,
        $Val extends NotificationSettings>
    implements $NotificationSettingsCopyWith<$Res> {
  _$NotificationSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? sound = null,
    Object? vibration = null,
    Object? showPreview = null,
    Object? messageNotifications = null,
    Object? groupNotifications = null,
    Object? callNotifications = null,
  }) {
    return _then(_value.copyWith(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      sound: null == sound
          ? _value.sound
          : sound // ignore: cast_nullable_to_non_nullable
              as bool,
      vibration: null == vibration
          ? _value.vibration
          : vibration // ignore: cast_nullable_to_non_nullable
              as bool,
      showPreview: null == showPreview
          ? _value.showPreview
          : showPreview // ignore: cast_nullable_to_non_nullable
              as bool,
      messageNotifications: null == messageNotifications
          ? _value.messageNotifications
          : messageNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      groupNotifications: null == groupNotifications
          ? _value.groupNotifications
          : groupNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      callNotifications: null == callNotifications
          ? _value.callNotifications
          : callNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationSettingsImplCopyWith<$Res>
    implements $NotificationSettingsCopyWith<$Res> {
  factory _$$NotificationSettingsImplCopyWith(_$NotificationSettingsImpl value,
          $Res Function(_$NotificationSettingsImpl) then) =
      __$$NotificationSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool enabled,
      bool sound,
      bool vibration,
      bool showPreview,
      bool messageNotifications,
      bool groupNotifications,
      bool callNotifications});
}

/// @nodoc
class __$$NotificationSettingsImplCopyWithImpl<$Res>
    extends _$NotificationSettingsCopyWithImpl<$Res, _$NotificationSettingsImpl>
    implements _$$NotificationSettingsImplCopyWith<$Res> {
  __$$NotificationSettingsImplCopyWithImpl(_$NotificationSettingsImpl _value,
      $Res Function(_$NotificationSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? sound = null,
    Object? vibration = null,
    Object? showPreview = null,
    Object? messageNotifications = null,
    Object? groupNotifications = null,
    Object? callNotifications = null,
  }) {
    return _then(_$NotificationSettingsImpl(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      sound: null == sound
          ? _value.sound
          : sound // ignore: cast_nullable_to_non_nullable
              as bool,
      vibration: null == vibration
          ? _value.vibration
          : vibration // ignore: cast_nullable_to_non_nullable
              as bool,
      showPreview: null == showPreview
          ? _value.showPreview
          : showPreview // ignore: cast_nullable_to_non_nullable
              as bool,
      messageNotifications: null == messageNotifications
          ? _value.messageNotifications
          : messageNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      groupNotifications: null == groupNotifications
          ? _value.groupNotifications
          : groupNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      callNotifications: null == callNotifications
          ? _value.callNotifications
          : callNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsImpl implements _NotificationSettings {
  const _$NotificationSettingsImpl(
      {this.enabled = true,
      this.sound = true,
      this.vibration = true,
      this.showPreview = true,
      this.messageNotifications = true,
      this.groupNotifications = true,
      this.callNotifications = true});

  factory _$NotificationSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool enabled;
  @override
  @JsonKey()
  final bool sound;
  @override
  @JsonKey()
  final bool vibration;
  @override
  @JsonKey()
  final bool showPreview;
  @override
  @JsonKey()
  final bool messageNotifications;
  @override
  @JsonKey()
  final bool groupNotifications;
  @override
  @JsonKey()
  final bool callNotifications;

  @override
  String toString() {
    return 'NotificationSettings(enabled: $enabled, sound: $sound, vibration: $vibration, showPreview: $showPreview, messageNotifications: $messageNotifications, groupNotifications: $groupNotifications, callNotifications: $callNotifications)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.sound, sound) || other.sound == sound) &&
            (identical(other.vibration, vibration) ||
                other.vibration == vibration) &&
            (identical(other.showPreview, showPreview) ||
                other.showPreview == showPreview) &&
            (identical(other.messageNotifications, messageNotifications) ||
                other.messageNotifications == messageNotifications) &&
            (identical(other.groupNotifications, groupNotifications) ||
                other.groupNotifications == groupNotifications) &&
            (identical(other.callNotifications, callNotifications) ||
                other.callNotifications == callNotifications));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled, sound, vibration,
      showPreview, messageNotifications, groupNotifications, callNotifications);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsImplCopyWith<_$NotificationSettingsImpl>
      get copyWith =>
          __$$NotificationSettingsImplCopyWithImpl<_$NotificationSettingsImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsImplToJson(
      this,
    );
  }
}

abstract class _NotificationSettings implements NotificationSettings {
  const factory _NotificationSettings(
      {final bool enabled,
      final bool sound,
      final bool vibration,
      final bool showPreview,
      final bool messageNotifications,
      final bool groupNotifications,
      final bool callNotifications}) = _$NotificationSettingsImpl;

  factory _NotificationSettings.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsImpl.fromJson;

  @override
  bool get enabled;
  @override
  bool get sound;
  @override
  bool get vibration;
  @override
  bool get showPreview;
  @override
  bool get messageNotifications;
  @override
  bool get groupNotifications;
  @override
  bool get callNotifications;
  @override
  @JsonKey(ignore: true)
  _$$NotificationSettingsImplCopyWith<_$NotificationSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
