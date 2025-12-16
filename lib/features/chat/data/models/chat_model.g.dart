// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatModelImpl _$$ChatModelImplFromJson(Map<String, dynamic> json) =>
    _$ChatModelImpl(
      id: json['id'] as String,
      type: $enumDecode(_$ChatTypeEnumMap, json['type']),
      participantIds: (json['participantIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      participants: (json['participants'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, ParticipantInfo.fromJson(e as Map<String, dynamic>)),
      ),
      name: json['name'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      lastMessage: json['lastMessage'] == null
          ? null
          : MessageModel.fromJson(json['lastMessage'] as Map<String, dynamic>),
      unreadCounts: (json['unreadCounts'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      lastReadTimestamps:
          (json['lastReadTimestamps'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as String),
              ) ??
              const {},
      typingStatus: (json['typingStatus'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const {},
      mutedBy: (json['mutedBy'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const {},
      pinnedBy: (json['pinnedBy'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      archivedBy: (json['archivedBy'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      groupInfo: json['groupInfo'] == null
          ? null
          : GroupInfoModel.fromJson(json['groupInfo'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      draftMessage: json['draftMessage'] as String?,
      pinnedMessageIds: (json['pinnedMessageIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      encryptionInfo: json['encryptionInfo'] == null
          ? null
          : EncryptionInfo.fromJson(
              json['encryptionInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChatModelImplToJson(_$ChatModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ChatTypeEnumMap[instance.type]!,
      'participantIds': instance.participantIds,
      'participants': instance.participants,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'lastMessage': instance.lastMessage,
      'unreadCounts': instance.unreadCounts,
      'lastReadTimestamps': instance.lastReadTimestamps,
      'typingStatus': instance.typingStatus,
      'mutedBy': instance.mutedBy,
      'pinnedBy': instance.pinnedBy,
      'archivedBy': instance.archivedBy,
      'groupInfo': instance.groupInfo,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'draftMessage': instance.draftMessage,
      'pinnedMessageIds': instance.pinnedMessageIds,
      'encryptionInfo': instance.encryptionInfo,
    };

const _$ChatTypeEnumMap = {
  ChatType.private: 'private',
  ChatType.group: 'group',
  ChatType.channel: 'channel',
};

_$ParticipantInfoImpl _$$ParticipantInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$ParticipantInfoImpl(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      isOnline: json['isOnline'] as bool? ?? false,
      lastSeen: json['lastSeen'] == null
          ? null
          : DateTime.parse(json['lastSeen'] as String),
      role: $enumDecodeNullable(_$GroupRoleEnumMap, json['role']) ??
          GroupRole.member,
      joinedAt: json['joinedAt'] == null
          ? null
          : DateTime.parse(json['joinedAt'] as String),
      addedBy: json['addedBy'] as String?,
    );

Map<String, dynamic> _$$ParticipantInfoImplToJson(
        _$ParticipantInfoImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'phoneNumber': instance.phoneNumber,
      'isOnline': instance.isOnline,
      'lastSeen': instance.lastSeen?.toIso8601String(),
      'role': _$GroupRoleEnumMap[instance.role]!,
      'joinedAt': instance.joinedAt?.toIso8601String(),
      'addedBy': instance.addedBy,
    };

const _$GroupRoleEnumMap = {
  GroupRole.owner: 'owner',
  GroupRole.admin: 'admin',
  GroupRole.member: 'member',
};

_$GroupInfoModelImpl _$$GroupInfoModelImplFromJson(Map<String, dynamic> json) =>
    _$GroupInfoModelImpl(
      name: json['name'] as String,
      description: json['description'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      createdBy: json['createdBy'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      settings: json['settings'] == null
          ? const GroupSettings()
          : GroupSettings.fromJson(json['settings'] as Map<String, dynamic>),
      inviteLink: json['inviteLink'] as String?,
      inviteLinkExpiry: json['inviteLinkExpiry'] == null
          ? null
          : DateTime.parse(json['inviteLinkExpiry'] as String),
    );

Map<String, dynamic> _$$GroupInfoModelImplToJson(
        _$GroupInfoModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'avatarUrl': instance.avatarUrl,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt.toIso8601String(),
      'settings': instance.settings,
      'inviteLink': instance.inviteLink,
      'inviteLinkExpiry': instance.inviteLinkExpiry?.toIso8601String(),
    };

_$GroupSettingsImpl _$$GroupSettingsImplFromJson(Map<String, dynamic> json) =>
    _$GroupSettingsImpl(
      membersCanAddMembers: json['membersCanAddMembers'] as bool? ?? true,
      membersCanEditInfo: json['membersCanEditInfo'] as bool? ?? true,
      membersCanSendMessages: json['membersCanSendMessages'] as bool? ?? true,
      approvalRequired: json['approvalRequired'] as bool? ?? false,
      maxMembers: (json['maxMembers'] as num?)?.toInt() ?? 256,
    );

Map<String, dynamic> _$$GroupSettingsImplToJson(_$GroupSettingsImpl instance) =>
    <String, dynamic>{
      'membersCanAddMembers': instance.membersCanAddMembers,
      'membersCanEditInfo': instance.membersCanEditInfo,
      'membersCanSendMessages': instance.membersCanSendMessages,
      'approvalRequired': instance.approvalRequired,
      'maxMembers': instance.maxMembers,
    };

_$EncryptionInfoImpl _$$EncryptionInfoImplFromJson(Map<String, dynamic> json) =>
    _$EncryptionInfoImpl(
      sessionId: json['sessionId'] as String,
      publicKey: json['publicKey'] as String,
      keyRotatedAt: json['keyRotatedAt'] == null
          ? null
          : DateTime.parse(json['keyRotatedAt'] as String),
      isEnabled: json['isEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$$EncryptionInfoImplToJson(
        _$EncryptionInfoImpl instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'publicKey': instance.publicKey,
      'keyRotatedAt': instance.keyRotatedAt?.toIso8601String(),
      'isEnabled': instance.isEnabled,
    };
