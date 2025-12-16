import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_entity.freezed.dart';
part 'call_entity.g.dart';

/// Represents a voice/video call
@freezed
class CallEntity with _$CallEntity {
  const factory CallEntity({
    required String id,
    required String chatId,
    required String callerId,
    required String callerName,
    String? callerAvatarUrl,
    required List<String> participantIds,
    required CallType type,
    required CallStatus status,
    required DateTime createdAt,
    DateTime? answeredAt,
    DateTime? endedAt,
    @Default(0) int duration,
    CallEndReason? endReason,
    String? offer,
    String? answer,
    @Default([]) List<IceCandidateEntity> iceCandidates,
    CallQuality? quality,
  }) = _CallEntity;

  factory CallEntity.fromJson(Map<String, dynamic> json) => 
      _$CallEntityFromJson(json);
}

/// Type of call
enum CallType {
  @JsonValue('voice')
  voice,
  @JsonValue('video')
  video,
  @JsonValue('groupVoice')
  groupVoice,
  @JsonValue('groupVideo')
  groupVideo,
}

/// Current status of the call
enum CallStatus {
  @JsonValue('initiating')
  initiating,
  @JsonValue('ringing')
  ringing,
  @JsonValue('connecting')
  connecting,
  @JsonValue('active')
  active,
  @JsonValue('connected')
  connected,
  @JsonValue('reconnecting')
  reconnecting,
  @JsonValue('ended')
  ended,
  @JsonValue('failed')
  failed,
  @JsonValue('missed')
  missed,
  @JsonValue('declined')
  declined,
  @JsonValue('busy')
  busy,
}

/// Reason for call ending
enum CallEndReason {
  @JsonValue('completed')
  completed,
  @JsonValue('declined')
  declined,
  @JsonValue('busy')
  busy,
  @JsonValue('noAnswer')
  noAnswer,
  @JsonValue('networkError')
  networkError,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('failed')
  failed,
}

/// ICE candidate for WebRTC connection
@freezed
class IceCandidateEntity with _$IceCandidateEntity {
  const factory IceCandidateEntity({
    required String candidate,
    required String sdpMid,
    required int sdpMLineIndex,
  }) = _IceCandidateEntity;

  factory IceCandidateEntity.fromJson(Map<String, dynamic> json) => 
      _$IceCandidateEntityFromJson(json);
}

/// Call quality metrics
@freezed
class CallQuality with _$CallQuality {
  const factory CallQuality({
    @Default(0) int packetLoss,
    @Default(0) int jitter,
    @Default(0) int roundTripTime,
    @Default('unknown') String connectionType,
    @Default(0) int bitrate,
  }) = _CallQuality;

  factory CallQuality.fromJson(Map<String, dynamic> json) => 
      _$CallQualityFromJson(json);
}
