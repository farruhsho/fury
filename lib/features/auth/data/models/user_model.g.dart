// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      username: json['username'] as String?,
      displayName: json['displayName'] as String?,
      bio: json['bio'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      avatarThumbnailUrl: json['avatarThumbnailUrl'] as String?,
      isOnline: json['isOnline'] as bool? ?? false,
      lastSeen: json['lastSeen'] == null
          ? null
          : DateTime.parse(json['lastSeen'] as String),
      privacySettings: json['privacySettings'] == null
          ? const PrivacySettings()
          : PrivacySettings.fromJson(
              json['privacySettings'] as Map<String, dynamic>),
      notificationSettings: json['notificationSettings'] == null
          ? const NotificationSettings()
          : NotificationSettings.fromJson(
              json['notificationSettings'] as Map<String, dynamic>),
      pushToken: json['pushToken'] as String?,
      voipToken: json['voipToken'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      blockedUserIds: (json['blockedUserIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      status: $enumDecodeNullable(_$UserStatusEnumMap, json['status']) ??
          UserStatus.active,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'username': instance.username,
      'displayName': instance.displayName,
      'bio': instance.bio,
      'avatarUrl': instance.avatarUrl,
      'avatarThumbnailUrl': instance.avatarThumbnailUrl,
      'isOnline': instance.isOnline,
      'lastSeen': instance.lastSeen?.toIso8601String(),
      'privacySettings': instance.privacySettings,
      'notificationSettings': instance.notificationSettings,
      'pushToken': instance.pushToken,
      'voipToken': instance.voipToken,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'blockedUserIds': instance.blockedUserIds,
      'status': _$UserStatusEnumMap[instance.status]!,
    };

const _$UserStatusEnumMap = {
  UserStatus.active: 'active',
  UserStatus.suspended: 'suspended',
  UserStatus.deleted: 'deleted',
};

_$PrivacySettingsImpl _$$PrivacySettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$PrivacySettingsImpl(
      lastSeen: $enumDecodeNullable(_$PrivacyOptionEnumMap, json['lastSeen']) ??
          PrivacyOption.everyone,
      profilePhoto:
          $enumDecodeNullable(_$PrivacyOptionEnumMap, json['profilePhoto']) ??
              PrivacyOption.everyone,
      about: $enumDecodeNullable(_$PrivacyOptionEnumMap, json['about']) ??
          PrivacyOption.everyone,
      status: $enumDecodeNullable(_$PrivacyOptionEnumMap, json['status']) ??
          PrivacyOption.everyone,
      groups: $enumDecodeNullable(_$PrivacyOptionEnumMap, json['groups']) ??
          PrivacyOption.everyone,
      readReceipts: json['readReceipts'] as bool? ?? true,
    );

Map<String, dynamic> _$$PrivacySettingsImplToJson(
        _$PrivacySettingsImpl instance) =>
    <String, dynamic>{
      'lastSeen': _$PrivacyOptionEnumMap[instance.lastSeen]!,
      'profilePhoto': _$PrivacyOptionEnumMap[instance.profilePhoto]!,
      'about': _$PrivacyOptionEnumMap[instance.about]!,
      'status': _$PrivacyOptionEnumMap[instance.status]!,
      'groups': _$PrivacyOptionEnumMap[instance.groups]!,
      'readReceipts': instance.readReceipts,
    };

const _$PrivacyOptionEnumMap = {
  PrivacyOption.everyone: 'everyone',
  PrivacyOption.contacts: 'contacts',
  PrivacyOption.nobody: 'nobody',
};

_$NotificationSettingsImpl _$$NotificationSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationSettingsImpl(
      enabled: json['enabled'] as bool? ?? true,
      sound: json['sound'] as bool? ?? true,
      vibration: json['vibration'] as bool? ?? true,
      showPreview: json['showPreview'] as bool? ?? true,
      messageNotifications: json['messageNotifications'] as bool? ?? true,
      groupNotifications: json['groupNotifications'] as bool? ?? true,
      callNotifications: json['callNotifications'] as bool? ?? true,
    );

Map<String, dynamic> _$$NotificationSettingsImplToJson(
        _$NotificationSettingsImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'sound': instance.sound,
      'vibration': instance.vibration,
      'showPreview': instance.showPreview,
      'messageNotifications': instance.messageNotifications,
      'groupNotifications': instance.groupNotifications,
      'callNotifications': instance.callNotifications,
    };
