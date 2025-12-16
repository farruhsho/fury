// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CallEntityImpl _$$CallEntityImplFromJson(Map<String, dynamic> json) =>
    _$CallEntityImpl(
      id: json['id'] as String,
      chatId: json['chatId'] as String,
      callerId: json['callerId'] as String,
      callerName: json['callerName'] as String,
      callerAvatarUrl: json['callerAvatarUrl'] as String?,
      participantIds: (json['participantIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      type: $enumDecode(_$CallTypeEnumMap, json['type']),
      status: $enumDecode(_$CallStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      answeredAt: json['answeredAt'] == null
          ? null
          : DateTime.parse(json['answeredAt'] as String),
      endedAt: json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      endReason: $enumDecodeNullable(_$CallEndReasonEnumMap, json['endReason']),
      offer: json['offer'] as String?,
      answer: json['answer'] as String?,
      iceCandidates: (json['iceCandidates'] as List<dynamic>?)
              ?.map(
                  (e) => IceCandidateEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      quality: json['quality'] == null
          ? null
          : CallQuality.fromJson(json['quality'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CallEntityImplToJson(_$CallEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatId': instance.chatId,
      'callerId': instance.callerId,
      'callerName': instance.callerName,
      'callerAvatarUrl': instance.callerAvatarUrl,
      'participantIds': instance.participantIds,
      'type': _$CallTypeEnumMap[instance.type]!,
      'status': _$CallStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'answeredAt': instance.answeredAt?.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
      'duration': instance.duration,
      'endReason': _$CallEndReasonEnumMap[instance.endReason],
      'offer': instance.offer,
      'answer': instance.answer,
      'iceCandidates': instance.iceCandidates,
      'quality': instance.quality,
    };

const _$CallTypeEnumMap = {
  CallType.voice: 'voice',
  CallType.video: 'video',
  CallType.groupVoice: 'groupVoice',
  CallType.groupVideo: 'groupVideo',
};

const _$CallStatusEnumMap = {
  CallStatus.initiating: 'initiating',
  CallStatus.ringing: 'ringing',
  CallStatus.connecting: 'connecting',
  CallStatus.active: 'active',
  CallStatus.connected: 'connected',
  CallStatus.reconnecting: 'reconnecting',
  CallStatus.ended: 'ended',
  CallStatus.failed: 'failed',
  CallStatus.missed: 'missed',
  CallStatus.declined: 'declined',
  CallStatus.busy: 'busy',
};

const _$CallEndReasonEnumMap = {
  CallEndReason.completed: 'completed',
  CallEndReason.declined: 'declined',
  CallEndReason.busy: 'busy',
  CallEndReason.noAnswer: 'noAnswer',
  CallEndReason.networkError: 'networkError',
  CallEndReason.cancelled: 'cancelled',
  CallEndReason.failed: 'failed',
};

_$IceCandidateEntityImpl _$$IceCandidateEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$IceCandidateEntityImpl(
      candidate: json['candidate'] as String,
      sdpMid: json['sdpMid'] as String,
      sdpMLineIndex: (json['sdpMLineIndex'] as num).toInt(),
    );

Map<String, dynamic> _$$IceCandidateEntityImplToJson(
        _$IceCandidateEntityImpl instance) =>
    <String, dynamic>{
      'candidate': instance.candidate,
      'sdpMid': instance.sdpMid,
      'sdpMLineIndex': instance.sdpMLineIndex,
    };

_$CallQualityImpl _$$CallQualityImplFromJson(Map<String, dynamic> json) =>
    _$CallQualityImpl(
      packetLoss: (json['packetLoss'] as num?)?.toInt() ?? 0,
      jitter: (json['jitter'] as num?)?.toInt() ?? 0,
      roundTripTime: (json['roundTripTime'] as num?)?.toInt() ?? 0,
      connectionType: json['connectionType'] as String? ?? 'unknown',
      bitrate: (json['bitrate'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$CallQualityImplToJson(_$CallQualityImpl instance) =>
    <String, dynamic>{
      'packetLoss': instance.packetLoss,
      'jitter': instance.jitter,
      'roundTripTime': instance.roundTripTime,
      'connectionType': instance.connectionType,
      'bitrate': instance.bitrate,
    };
