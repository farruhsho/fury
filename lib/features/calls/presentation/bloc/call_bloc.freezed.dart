// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CallEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId, String recipientId,
            String recipientName, CallType callType)
        initiateCall,
    required TResult Function(String callId) answerCall,
    required TResult Function(String callId) declineCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() toggleSpeaker,
    required TResult Function(CallEntity incomingCallData) incomingCall,
    required TResult Function(CallStatus status) callStatusChanged,
    required TResult Function(MediaStream stream) remoteStreamReceived,
    required TResult Function(
            int latencyMs, double packetLossPercent, int jitterMs, int duration)
        updateStats,
    required TResult Function(VideoQuality quality) setVideoQuality,
    required TResult Function(AudioSettings settings) updateAudioSettings,
    required TResult Function(List<String> participantIds) addParticipants,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult? Function(String callId)? answerCall,
    TResult? Function(String callId)? declineCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? toggleSpeaker,
    TResult? Function(CallEntity incomingCallData)? incomingCall,
    TResult? Function(CallStatus status)? callStatusChanged,
    TResult? Function(MediaStream stream)? remoteStreamReceived,
    TResult? Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult? Function(VideoQuality quality)? setVideoQuality,
    TResult? Function(AudioSettings settings)? updateAudioSettings,
    TResult? Function(List<String> participantIds)? addParticipants,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult Function(String callId)? answerCall,
    TResult Function(String callId)? declineCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? toggleSpeaker,
    TResult Function(CallEntity incomingCallData)? incomingCall,
    TResult Function(CallStatus status)? callStatusChanged,
    TResult Function(MediaStream stream)? remoteStreamReceived,
    TResult Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult Function(VideoQuality quality)? setVideoQuality,
    TResult Function(AudioSettings settings)? updateAudioSettings,
    TResult Function(List<String> participantIds)? addParticipants,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_AnswerCall value) answerCall,
    required TResult Function(_DeclineCall value) declineCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_CallStatusChanged value) callStatusChanged,
    required TResult Function(_RemoteStreamReceived value) remoteStreamReceived,
    required TResult Function(_UpdateStats value) updateStats,
    required TResult Function(_SetVideoQuality value) setVideoQuality,
    required TResult Function(_UpdateAudioSettings value) updateAudioSettings,
    required TResult Function(_AddParticipants value) addParticipants,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_AnswerCall value)? answerCall,
    TResult? Function(_DeclineCall value)? declineCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_CallStatusChanged value)? callStatusChanged,
    TResult? Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult? Function(_UpdateStats value)? updateStats,
    TResult? Function(_SetVideoQuality value)? setVideoQuality,
    TResult? Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult? Function(_AddParticipants value)? addParticipants,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_AnswerCall value)? answerCall,
    TResult Function(_DeclineCall value)? declineCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_CallStatusChanged value)? callStatusChanged,
    TResult Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult Function(_UpdateStats value)? updateStats,
    TResult Function(_SetVideoQuality value)? setVideoQuality,
    TResult Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult Function(_AddParticipants value)? addParticipants,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallEventCopyWith<$Res> {
  factory $CallEventCopyWith(CallEvent value, $Res Function(CallEvent) then) =
      _$CallEventCopyWithImpl<$Res, CallEvent>;
}

/// @nodoc
class _$CallEventCopyWithImpl<$Res, $Val extends CallEvent>
    implements $CallEventCopyWith<$Res> {
  _$CallEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitiateCallImplCopyWith<$Res> {
  factory _$$InitiateCallImplCopyWith(
          _$InitiateCallImpl value, $Res Function(_$InitiateCallImpl) then) =
      __$$InitiateCallImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String chatId,
      String recipientId,
      String recipientName,
      CallType callType});
}

/// @nodoc
class __$$InitiateCallImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$InitiateCallImpl>
    implements _$$InitiateCallImplCopyWith<$Res> {
  __$$InitiateCallImplCopyWithImpl(
      _$InitiateCallImpl _value, $Res Function(_$InitiateCallImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
    Object? recipientId = null,
    Object? recipientName = null,
    Object? callType = null,
  }) {
    return _then(_$InitiateCallImpl(
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      recipientId: null == recipientId
          ? _value.recipientId
          : recipientId // ignore: cast_nullable_to_non_nullable
              as String,
      recipientName: null == recipientName
          ? _value.recipientName
          : recipientName // ignore: cast_nullable_to_non_nullable
              as String,
      callType: null == callType
          ? _value.callType
          : callType // ignore: cast_nullable_to_non_nullable
              as CallType,
    ));
  }
}

/// @nodoc

class _$InitiateCallImpl with DiagnosticableTreeMixin implements _InitiateCall {
  const _$InitiateCallImpl(
      {required this.chatId,
      required this.recipientId,
      required this.recipientName,
      this.callType = CallType.voice});

  @override
  final String chatId;
  @override
  final String recipientId;
  @override
  final String recipientName;
  @override
  @JsonKey()
  final CallType callType;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.initiateCall(chatId: $chatId, recipientId: $recipientId, recipientName: $recipientName, callType: $callType)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallEvent.initiateCall'))
      ..add(DiagnosticsProperty('chatId', chatId))
      ..add(DiagnosticsProperty('recipientId', recipientId))
      ..add(DiagnosticsProperty('recipientName', recipientName))
      ..add(DiagnosticsProperty('callType', callType));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitiateCallImpl &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.recipientName, recipientName) ||
                other.recipientName == recipientName) &&
            (identical(other.callType, callType) ||
                other.callType == callType));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, chatId, recipientId, recipientName, callType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitiateCallImplCopyWith<_$InitiateCallImpl> get copyWith =>
      __$$InitiateCallImplCopyWithImpl<_$InitiateCallImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId, String recipientId,
            String recipientName, CallType callType)
        initiateCall,
    required TResult Function(String callId) answerCall,
    required TResult Function(String callId) declineCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() toggleSpeaker,
    required TResult Function(CallEntity incomingCallData) incomingCall,
    required TResult Function(CallStatus status) callStatusChanged,
    required TResult Function(MediaStream stream) remoteStreamReceived,
    required TResult Function(
            int latencyMs, double packetLossPercent, int jitterMs, int duration)
        updateStats,
    required TResult Function(VideoQuality quality) setVideoQuality,
    required TResult Function(AudioSettings settings) updateAudioSettings,
    required TResult Function(List<String> participantIds) addParticipants,
  }) {
    return initiateCall(chatId, recipientId, recipientName, callType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult? Function(String callId)? answerCall,
    TResult? Function(String callId)? declineCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? toggleSpeaker,
    TResult? Function(CallEntity incomingCallData)? incomingCall,
    TResult? Function(CallStatus status)? callStatusChanged,
    TResult? Function(MediaStream stream)? remoteStreamReceived,
    TResult? Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult? Function(VideoQuality quality)? setVideoQuality,
    TResult? Function(AudioSettings settings)? updateAudioSettings,
    TResult? Function(List<String> participantIds)? addParticipants,
  }) {
    return initiateCall?.call(chatId, recipientId, recipientName, callType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult Function(String callId)? answerCall,
    TResult Function(String callId)? declineCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? toggleSpeaker,
    TResult Function(CallEntity incomingCallData)? incomingCall,
    TResult Function(CallStatus status)? callStatusChanged,
    TResult Function(MediaStream stream)? remoteStreamReceived,
    TResult Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult Function(VideoQuality quality)? setVideoQuality,
    TResult Function(AudioSettings settings)? updateAudioSettings,
    TResult Function(List<String> participantIds)? addParticipants,
    required TResult orElse(),
  }) {
    if (initiateCall != null) {
      return initiateCall(chatId, recipientId, recipientName, callType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_AnswerCall value) answerCall,
    required TResult Function(_DeclineCall value) declineCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_CallStatusChanged value) callStatusChanged,
    required TResult Function(_RemoteStreamReceived value) remoteStreamReceived,
    required TResult Function(_UpdateStats value) updateStats,
    required TResult Function(_SetVideoQuality value) setVideoQuality,
    required TResult Function(_UpdateAudioSettings value) updateAudioSettings,
    required TResult Function(_AddParticipants value) addParticipants,
  }) {
    return initiateCall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_AnswerCall value)? answerCall,
    TResult? Function(_DeclineCall value)? declineCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_CallStatusChanged value)? callStatusChanged,
    TResult? Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult? Function(_UpdateStats value)? updateStats,
    TResult? Function(_SetVideoQuality value)? setVideoQuality,
    TResult? Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult? Function(_AddParticipants value)? addParticipants,
  }) {
    return initiateCall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_AnswerCall value)? answerCall,
    TResult Function(_DeclineCall value)? declineCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_CallStatusChanged value)? callStatusChanged,
    TResult Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult Function(_UpdateStats value)? updateStats,
    TResult Function(_SetVideoQuality value)? setVideoQuality,
    TResult Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult Function(_AddParticipants value)? addParticipants,
    required TResult orElse(),
  }) {
    if (initiateCall != null) {
      return initiateCall(this);
    }
    return orElse();
  }
}

abstract class _InitiateCall implements CallEvent {
  const factory _InitiateCall(
      {required final String chatId,
      required final String recipientId,
      required final String recipientName,
      final CallType callType}) = _$InitiateCallImpl;

  String get chatId;
  String get recipientId;
  String get recipientName;
  CallType get callType;
  @JsonKey(ignore: true)
  _$$InitiateCallImplCopyWith<_$InitiateCallImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AnswerCallImplCopyWith<$Res> {
  factory _$$AnswerCallImplCopyWith(
          _$AnswerCallImpl value, $Res Function(_$AnswerCallImpl) then) =
      __$$AnswerCallImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String callId});
}

/// @nodoc
class __$$AnswerCallImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$AnswerCallImpl>
    implements _$$AnswerCallImplCopyWith<$Res> {
  __$$AnswerCallImplCopyWithImpl(
      _$AnswerCallImpl _value, $Res Function(_$AnswerCallImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callId = null,
  }) {
    return _then(_$AnswerCallImpl(
      null == callId
          ? _value.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AnswerCallImpl with DiagnosticableTreeMixin implements _AnswerCall {
  const _$AnswerCallImpl(this.callId);

  @override
  final String callId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.answerCall(callId: $callId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallEvent.answerCall'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnswerCallImpl &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnswerCallImplCopyWith<_$AnswerCallImpl> get copyWith =>
      __$$AnswerCallImplCopyWithImpl<_$AnswerCallImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId, String recipientId,
            String recipientName, CallType callType)
        initiateCall,
    required TResult Function(String callId) answerCall,
    required TResult Function(String callId) declineCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() toggleSpeaker,
    required TResult Function(CallEntity incomingCallData) incomingCall,
    required TResult Function(CallStatus status) callStatusChanged,
    required TResult Function(MediaStream stream) remoteStreamReceived,
    required TResult Function(
            int latencyMs, double packetLossPercent, int jitterMs, int duration)
        updateStats,
    required TResult Function(VideoQuality quality) setVideoQuality,
    required TResult Function(AudioSettings settings) updateAudioSettings,
    required TResult Function(List<String> participantIds) addParticipants,
  }) {
    return answerCall(callId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult? Function(String callId)? answerCall,
    TResult? Function(String callId)? declineCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? toggleSpeaker,
    TResult? Function(CallEntity incomingCallData)? incomingCall,
    TResult? Function(CallStatus status)? callStatusChanged,
    TResult? Function(MediaStream stream)? remoteStreamReceived,
    TResult? Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult? Function(VideoQuality quality)? setVideoQuality,
    TResult? Function(AudioSettings settings)? updateAudioSettings,
    TResult? Function(List<String> participantIds)? addParticipants,
  }) {
    return answerCall?.call(callId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult Function(String callId)? answerCall,
    TResult Function(String callId)? declineCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? toggleSpeaker,
    TResult Function(CallEntity incomingCallData)? incomingCall,
    TResult Function(CallStatus status)? callStatusChanged,
    TResult Function(MediaStream stream)? remoteStreamReceived,
    TResult Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult Function(VideoQuality quality)? setVideoQuality,
    TResult Function(AudioSettings settings)? updateAudioSettings,
    TResult Function(List<String> participantIds)? addParticipants,
    required TResult orElse(),
  }) {
    if (answerCall != null) {
      return answerCall(callId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_AnswerCall value) answerCall,
    required TResult Function(_DeclineCall value) declineCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_CallStatusChanged value) callStatusChanged,
    required TResult Function(_RemoteStreamReceived value) remoteStreamReceived,
    required TResult Function(_UpdateStats value) updateStats,
    required TResult Function(_SetVideoQuality value) setVideoQuality,
    required TResult Function(_UpdateAudioSettings value) updateAudioSettings,
    required TResult Function(_AddParticipants value) addParticipants,
  }) {
    return answerCall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_AnswerCall value)? answerCall,
    TResult? Function(_DeclineCall value)? declineCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_CallStatusChanged value)? callStatusChanged,
    TResult? Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult? Function(_UpdateStats value)? updateStats,
    TResult? Function(_SetVideoQuality value)? setVideoQuality,
    TResult? Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult? Function(_AddParticipants value)? addParticipants,
  }) {
    return answerCall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_AnswerCall value)? answerCall,
    TResult Function(_DeclineCall value)? declineCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_CallStatusChanged value)? callStatusChanged,
    TResult Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult Function(_UpdateStats value)? updateStats,
    TResult Function(_SetVideoQuality value)? setVideoQuality,
    TResult Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult Function(_AddParticipants value)? addParticipants,
    required TResult orElse(),
  }) {
    if (answerCall != null) {
      return answerCall(this);
    }
    return orElse();
  }
}

abstract class _AnswerCall implements CallEvent {
  const factory _AnswerCall(final String callId) = _$AnswerCallImpl;

  String get callId;
  @JsonKey(ignore: true)
  _$$AnswerCallImplCopyWith<_$AnswerCallImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeclineCallImplCopyWith<$Res> {
  factory _$$DeclineCallImplCopyWith(
          _$DeclineCallImpl value, $Res Function(_$DeclineCallImpl) then) =
      __$$DeclineCallImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String callId});
}

/// @nodoc
class __$$DeclineCallImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$DeclineCallImpl>
    implements _$$DeclineCallImplCopyWith<$Res> {
  __$$DeclineCallImplCopyWithImpl(
      _$DeclineCallImpl _value, $Res Function(_$DeclineCallImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callId = null,
  }) {
    return _then(_$DeclineCallImpl(
      null == callId
          ? _value.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeclineCallImpl with DiagnosticableTreeMixin implements _DeclineCall {
  const _$DeclineCallImpl(this.callId);

  @override
  final String callId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.declineCall(callId: $callId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallEvent.declineCall'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeclineCallImpl &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeclineCallImplCopyWith<_$DeclineCallImpl> get copyWith =>
      __$$DeclineCallImplCopyWithImpl<_$DeclineCallImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId, String recipientId,
            String recipientName, CallType callType)
        initiateCall,
    required TResult Function(String callId) answerCall,
    required TResult Function(String callId) declineCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() toggleSpeaker,
    required TResult Function(CallEntity incomingCallData) incomingCall,
    required TResult Function(CallStatus status) callStatusChanged,
    required TResult Function(MediaStream stream) remoteStreamReceived,
    required TResult Function(
            int latencyMs, double packetLossPercent, int jitterMs, int duration)
        updateStats,
    required TResult Function(VideoQuality quality) setVideoQuality,
    required TResult Function(AudioSettings settings) updateAudioSettings,
    required TResult Function(List<String> participantIds) addParticipants,
  }) {
    return declineCall(callId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult? Function(String callId)? answerCall,
    TResult? Function(String callId)? declineCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? toggleSpeaker,
    TResult? Function(CallEntity incomingCallData)? incomingCall,
    TResult? Function(CallStatus status)? callStatusChanged,
    TResult? Function(MediaStream stream)? remoteStreamReceived,
    TResult? Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult? Function(VideoQuality quality)? setVideoQuality,
    TResult? Function(AudioSettings settings)? updateAudioSettings,
    TResult? Function(List<String> participantIds)? addParticipants,
  }) {
    return declineCall?.call(callId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult Function(String callId)? answerCall,
    TResult Function(String callId)? declineCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? toggleSpeaker,
    TResult Function(CallEntity incomingCallData)? incomingCall,
    TResult Function(CallStatus status)? callStatusChanged,
    TResult Function(MediaStream stream)? remoteStreamReceived,
    TResult Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult Function(VideoQuality quality)? setVideoQuality,
    TResult Function(AudioSettings settings)? updateAudioSettings,
    TResult Function(List<String> participantIds)? addParticipants,
    required TResult orElse(),
  }) {
    if (declineCall != null) {
      return declineCall(callId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_AnswerCall value) answerCall,
    required TResult Function(_DeclineCall value) declineCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_CallStatusChanged value) callStatusChanged,
    required TResult Function(_RemoteStreamReceived value) remoteStreamReceived,
    required TResult Function(_UpdateStats value) updateStats,
    required TResult Function(_SetVideoQuality value) setVideoQuality,
    required TResult Function(_UpdateAudioSettings value) updateAudioSettings,
    required TResult Function(_AddParticipants value) addParticipants,
  }) {
    return declineCall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_AnswerCall value)? answerCall,
    TResult? Function(_DeclineCall value)? declineCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_CallStatusChanged value)? callStatusChanged,
    TResult? Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult? Function(_UpdateStats value)? updateStats,
    TResult? Function(_SetVideoQuality value)? setVideoQuality,
    TResult? Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult? Function(_AddParticipants value)? addParticipants,
  }) {
    return declineCall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_AnswerCall value)? answerCall,
    TResult Function(_DeclineCall value)? declineCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_CallStatusChanged value)? callStatusChanged,
    TResult Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult Function(_UpdateStats value)? updateStats,
    TResult Function(_SetVideoQuality value)? setVideoQuality,
    TResult Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult Function(_AddParticipants value)? addParticipants,
    required TResult orElse(),
  }) {
    if (declineCall != null) {
      return declineCall(this);
    }
    return orElse();
  }
}

abstract class _DeclineCall implements CallEvent {
  const factory _DeclineCall(final String callId) = _$DeclineCallImpl;

  String get callId;
  @JsonKey(ignore: true)
  _$$DeclineCallImplCopyWith<_$DeclineCallImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EndCallImplCopyWith<$Res> {
  factory _$$EndCallImplCopyWith(
          _$EndCallImpl value, $Res Function(_$EndCallImpl) then) =
      __$$EndCallImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EndCallImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$EndCallImpl>
    implements _$$EndCallImplCopyWith<$Res> {
  __$$EndCallImplCopyWithImpl(
      _$EndCallImpl _value, $Res Function(_$EndCallImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$EndCallImpl with DiagnosticableTreeMixin implements _EndCall {
  const _$EndCallImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.endCall()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'CallEvent.endCall'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EndCallImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId, String recipientId,
            String recipientName, CallType callType)
        initiateCall,
    required TResult Function(String callId) answerCall,
    required TResult Function(String callId) declineCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() toggleSpeaker,
    required TResult Function(CallEntity incomingCallData) incomingCall,
    required TResult Function(CallStatus status) callStatusChanged,
    required TResult Function(MediaStream stream) remoteStreamReceived,
    required TResult Function(
            int latencyMs, double packetLossPercent, int jitterMs, int duration)
        updateStats,
    required TResult Function(VideoQuality quality) setVideoQuality,
    required TResult Function(AudioSettings settings) updateAudioSettings,
    required TResult Function(List<String> participantIds) addParticipants,
  }) {
    return endCall();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult? Function(String callId)? answerCall,
    TResult? Function(String callId)? declineCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? toggleSpeaker,
    TResult? Function(CallEntity incomingCallData)? incomingCall,
    TResult? Function(CallStatus status)? callStatusChanged,
    TResult? Function(MediaStream stream)? remoteStreamReceived,
    TResult? Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult? Function(VideoQuality quality)? setVideoQuality,
    TResult? Function(AudioSettings settings)? updateAudioSettings,
    TResult? Function(List<String> participantIds)? addParticipants,
  }) {
    return endCall?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult Function(String callId)? answerCall,
    TResult Function(String callId)? declineCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? toggleSpeaker,
    TResult Function(CallEntity incomingCallData)? incomingCall,
    TResult Function(CallStatus status)? callStatusChanged,
    TResult Function(MediaStream stream)? remoteStreamReceived,
    TResult Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult Function(VideoQuality quality)? setVideoQuality,
    TResult Function(AudioSettings settings)? updateAudioSettings,
    TResult Function(List<String> participantIds)? addParticipants,
    required TResult orElse(),
  }) {
    if (endCall != null) {
      return endCall();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_AnswerCall value) answerCall,
    required TResult Function(_DeclineCall value) declineCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_CallStatusChanged value) callStatusChanged,
    required TResult Function(_RemoteStreamReceived value) remoteStreamReceived,
    required TResult Function(_UpdateStats value) updateStats,
    required TResult Function(_SetVideoQuality value) setVideoQuality,
    required TResult Function(_UpdateAudioSettings value) updateAudioSettings,
    required TResult Function(_AddParticipants value) addParticipants,
  }) {
    return endCall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_AnswerCall value)? answerCall,
    TResult? Function(_DeclineCall value)? declineCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_CallStatusChanged value)? callStatusChanged,
    TResult? Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult? Function(_UpdateStats value)? updateStats,
    TResult? Function(_SetVideoQuality value)? setVideoQuality,
    TResult? Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult? Function(_AddParticipants value)? addParticipants,
  }) {
    return endCall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_AnswerCall value)? answerCall,
    TResult Function(_DeclineCall value)? declineCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_CallStatusChanged value)? callStatusChanged,
    TResult Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult Function(_UpdateStats value)? updateStats,
    TResult Function(_SetVideoQuality value)? setVideoQuality,
    TResult Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult Function(_AddParticipants value)? addParticipants,
    required TResult orElse(),
  }) {
    if (endCall != null) {
      return endCall(this);
    }
    return orElse();
  }
}

abstract class _EndCall implements CallEvent {
  const factory _EndCall() = _$EndCallImpl;
}

/// @nodoc
abstract class _$$ToggleMuteImplCopyWith<$Res> {
  factory _$$ToggleMuteImplCopyWith(
          _$ToggleMuteImpl value, $Res Function(_$ToggleMuteImpl) then) =
      __$$ToggleMuteImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ToggleMuteImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$ToggleMuteImpl>
    implements _$$ToggleMuteImplCopyWith<$Res> {
  __$$ToggleMuteImplCopyWithImpl(
      _$ToggleMuteImpl _value, $Res Function(_$ToggleMuteImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ToggleMuteImpl with DiagnosticableTreeMixin implements _ToggleMute {
  const _$ToggleMuteImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.toggleMute()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'CallEvent.toggleMute'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ToggleMuteImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId, String recipientId,
            String recipientName, CallType callType)
        initiateCall,
    required TResult Function(String callId) answerCall,
    required TResult Function(String callId) declineCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() toggleSpeaker,
    required TResult Function(CallEntity incomingCallData) incomingCall,
    required TResult Function(CallStatus status) callStatusChanged,
    required TResult Function(MediaStream stream) remoteStreamReceived,
    required TResult Function(
            int latencyMs, double packetLossPercent, int jitterMs, int duration)
        updateStats,
    required TResult Function(VideoQuality quality) setVideoQuality,
    required TResult Function(AudioSettings settings) updateAudioSettings,
    required TResult Function(List<String> participantIds) addParticipants,
  }) {
    return toggleMute();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult? Function(String callId)? answerCall,
    TResult? Function(String callId)? declineCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? toggleSpeaker,
    TResult? Function(CallEntity incomingCallData)? incomingCall,
    TResult? Function(CallStatus status)? callStatusChanged,
    TResult? Function(MediaStream stream)? remoteStreamReceived,
    TResult? Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult? Function(VideoQuality quality)? setVideoQuality,
    TResult? Function(AudioSettings settings)? updateAudioSettings,
    TResult? Function(List<String> participantIds)? addParticipants,
  }) {
    return toggleMute?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult Function(String callId)? answerCall,
    TResult Function(String callId)? declineCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? toggleSpeaker,
    TResult Function(CallEntity incomingCallData)? incomingCall,
    TResult Function(CallStatus status)? callStatusChanged,
    TResult Function(MediaStream stream)? remoteStreamReceived,
    TResult Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult Function(VideoQuality quality)? setVideoQuality,
    TResult Function(AudioSettings settings)? updateAudioSettings,
    TResult Function(List<String> participantIds)? addParticipants,
    required TResult orElse(),
  }) {
    if (toggleMute != null) {
      return toggleMute();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_AnswerCall value) answerCall,
    required TResult Function(_DeclineCall value) declineCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_CallStatusChanged value) callStatusChanged,
    required TResult Function(_RemoteStreamReceived value) remoteStreamReceived,
    required TResult Function(_UpdateStats value) updateStats,
    required TResult Function(_SetVideoQuality value) setVideoQuality,
    required TResult Function(_UpdateAudioSettings value) updateAudioSettings,
    required TResult Function(_AddParticipants value) addParticipants,
  }) {
    return toggleMute(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_AnswerCall value)? answerCall,
    TResult? Function(_DeclineCall value)? declineCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_CallStatusChanged value)? callStatusChanged,
    TResult? Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult? Function(_UpdateStats value)? updateStats,
    TResult? Function(_SetVideoQuality value)? setVideoQuality,
    TResult? Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult? Function(_AddParticipants value)? addParticipants,
  }) {
    return toggleMute?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_AnswerCall value)? answerCall,
    TResult Function(_DeclineCall value)? declineCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_CallStatusChanged value)? callStatusChanged,
    TResult Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult Function(_UpdateStats value)? updateStats,
    TResult Function(_SetVideoQuality value)? setVideoQuality,
    TResult Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult Function(_AddParticipants value)? addParticipants,
    required TResult orElse(),
  }) {
    if (toggleMute != null) {
      return toggleMute(this);
    }
    return orElse();
  }
}

abstract class _ToggleMute implements CallEvent {
  const factory _ToggleMute() = _$ToggleMuteImpl;
}

/// @nodoc
abstract class _$$ToggleVideoImplCopyWith<$Res> {
  factory _$$ToggleVideoImplCopyWith(
          _$ToggleVideoImpl value, $Res Function(_$ToggleVideoImpl) then) =
      __$$ToggleVideoImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ToggleVideoImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$ToggleVideoImpl>
    implements _$$ToggleVideoImplCopyWith<$Res> {
  __$$ToggleVideoImplCopyWithImpl(
      _$ToggleVideoImpl _value, $Res Function(_$ToggleVideoImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ToggleVideoImpl with DiagnosticableTreeMixin implements _ToggleVideo {
  const _$ToggleVideoImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.toggleVideo()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'CallEvent.toggleVideo'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ToggleVideoImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId, String recipientId,
            String recipientName, CallType callType)
        initiateCall,
    required TResult Function(String callId) answerCall,
    required TResult Function(String callId) declineCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() toggleSpeaker,
    required TResult Function(CallEntity incomingCallData) incomingCall,
    required TResult Function(CallStatus status) callStatusChanged,
    required TResult Function(MediaStream stream) remoteStreamReceived,
    required TResult Function(
            int latencyMs, double packetLossPercent, int jitterMs, int duration)
        updateStats,
    required TResult Function(VideoQuality quality) setVideoQuality,
    required TResult Function(AudioSettings settings) updateAudioSettings,
    required TResult Function(List<String> participantIds) addParticipants,
  }) {
    return toggleVideo();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult? Function(String callId)? answerCall,
    TResult? Function(String callId)? declineCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? toggleSpeaker,
    TResult? Function(CallEntity incomingCallData)? incomingCall,
    TResult? Function(CallStatus status)? callStatusChanged,
    TResult? Function(MediaStream stream)? remoteStreamReceived,
    TResult? Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult? Function(VideoQuality quality)? setVideoQuality,
    TResult? Function(AudioSettings settings)? updateAudioSettings,
    TResult? Function(List<String> participantIds)? addParticipants,
  }) {
    return toggleVideo?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult Function(String callId)? answerCall,
    TResult Function(String callId)? declineCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? toggleSpeaker,
    TResult Function(CallEntity incomingCallData)? incomingCall,
    TResult Function(CallStatus status)? callStatusChanged,
    TResult Function(MediaStream stream)? remoteStreamReceived,
    TResult Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult Function(VideoQuality quality)? setVideoQuality,
    TResult Function(AudioSettings settings)? updateAudioSettings,
    TResult Function(List<String> participantIds)? addParticipants,
    required TResult orElse(),
  }) {
    if (toggleVideo != null) {
      return toggleVideo();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_AnswerCall value) answerCall,
    required TResult Function(_DeclineCall value) declineCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_CallStatusChanged value) callStatusChanged,
    required TResult Function(_RemoteStreamReceived value) remoteStreamReceived,
    required TResult Function(_UpdateStats value) updateStats,
    required TResult Function(_SetVideoQuality value) setVideoQuality,
    required TResult Function(_UpdateAudioSettings value) updateAudioSettings,
    required TResult Function(_AddParticipants value) addParticipants,
  }) {
    return toggleVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_AnswerCall value)? answerCall,
    TResult? Function(_DeclineCall value)? declineCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_CallStatusChanged value)? callStatusChanged,
    TResult? Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult? Function(_UpdateStats value)? updateStats,
    TResult? Function(_SetVideoQuality value)? setVideoQuality,
    TResult? Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult? Function(_AddParticipants value)? addParticipants,
  }) {
    return toggleVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_AnswerCall value)? answerCall,
    TResult Function(_DeclineCall value)? declineCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_CallStatusChanged value)? callStatusChanged,
    TResult Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult Function(_UpdateStats value)? updateStats,
    TResult Function(_SetVideoQuality value)? setVideoQuality,
    TResult Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult Function(_AddParticipants value)? addParticipants,
    required TResult orElse(),
  }) {
    if (toggleVideo != null) {
      return toggleVideo(this);
    }
    return orElse();
  }
}

abstract class _ToggleVideo implements CallEvent {
  const factory _ToggleVideo() = _$ToggleVideoImpl;
}

/// @nodoc
abstract class _$$SwitchCameraImplCopyWith<$Res> {
  factory _$$SwitchCameraImplCopyWith(
          _$SwitchCameraImpl value, $Res Function(_$SwitchCameraImpl) then) =
      __$$SwitchCameraImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SwitchCameraImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$SwitchCameraImpl>
    implements _$$SwitchCameraImplCopyWith<$Res> {
  __$$SwitchCameraImplCopyWithImpl(
      _$SwitchCameraImpl _value, $Res Function(_$SwitchCameraImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SwitchCameraImpl with DiagnosticableTreeMixin implements _SwitchCamera {
  const _$SwitchCameraImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.switchCamera()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'CallEvent.switchCamera'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SwitchCameraImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId, String recipientId,
            String recipientName, CallType callType)
        initiateCall,
    required TResult Function(String callId) answerCall,
    required TResult Function(String callId) declineCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() toggleSpeaker,
    required TResult Function(CallEntity incomingCallData) incomingCall,
    required TResult Function(CallStatus status) callStatusChanged,
    required TResult Function(MediaStream stream) remoteStreamReceived,
    required TResult Function(
            int latencyMs, double packetLossPercent, int jitterMs, int duration)
        updateStats,
    required TResult Function(VideoQuality quality) setVideoQuality,
    required TResult Function(AudioSettings settings) updateAudioSettings,
    required TResult Function(List<String> participantIds) addParticipants,
  }) {
    return switchCamera();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult? Function(String callId)? answerCall,
    TResult? Function(String callId)? declineCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? toggleSpeaker,
    TResult? Function(CallEntity incomingCallData)? incomingCall,
    TResult? Function(CallStatus status)? callStatusChanged,
    TResult? Function(MediaStream stream)? remoteStreamReceived,
    TResult? Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult? Function(VideoQuality quality)? setVideoQuality,
    TResult? Function(AudioSettings settings)? updateAudioSettings,
    TResult? Function(List<String> participantIds)? addParticipants,
  }) {
    return switchCamera?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult Function(String callId)? answerCall,
    TResult Function(String callId)? declineCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? toggleSpeaker,
    TResult Function(CallEntity incomingCallData)? incomingCall,
    TResult Function(CallStatus status)? callStatusChanged,
    TResult Function(MediaStream stream)? remoteStreamReceived,
    TResult Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult Function(VideoQuality quality)? setVideoQuality,
    TResult Function(AudioSettings settings)? updateAudioSettings,
    TResult Function(List<String> participantIds)? addParticipants,
    required TResult orElse(),
  }) {
    if (switchCamera != null) {
      return switchCamera();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_AnswerCall value) answerCall,
    required TResult Function(_DeclineCall value) declineCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_CallStatusChanged value) callStatusChanged,
    required TResult Function(_RemoteStreamReceived value) remoteStreamReceived,
    required TResult Function(_UpdateStats value) updateStats,
    required TResult Function(_SetVideoQuality value) setVideoQuality,
    required TResult Function(_UpdateAudioSettings value) updateAudioSettings,
    required TResult Function(_AddParticipants value) addParticipants,
  }) {
    return switchCamera(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_AnswerCall value)? answerCall,
    TResult? Function(_DeclineCall value)? declineCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_CallStatusChanged value)? callStatusChanged,
    TResult? Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult? Function(_UpdateStats value)? updateStats,
    TResult? Function(_SetVideoQuality value)? setVideoQuality,
    TResult? Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult? Function(_AddParticipants value)? addParticipants,
  }) {
    return switchCamera?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_AnswerCall value)? answerCall,
    TResult Function(_DeclineCall value)? declineCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_CallStatusChanged value)? callStatusChanged,
    TResult Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult Function(_UpdateStats value)? updateStats,
    TResult Function(_SetVideoQuality value)? setVideoQuality,
    TResult Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult Function(_AddParticipants value)? addParticipants,
    required TResult orElse(),
  }) {
    if (switchCamera != null) {
      return switchCamera(this);
    }
    return orElse();
  }
}

abstract class _SwitchCamera implements CallEvent {
  const factory _SwitchCamera() = _$SwitchCameraImpl;
}

/// @nodoc
abstract class _$$ToggleSpeakerImplCopyWith<$Res> {
  factory _$$ToggleSpeakerImplCopyWith(
          _$ToggleSpeakerImpl value, $Res Function(_$ToggleSpeakerImpl) then) =
      __$$ToggleSpeakerImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ToggleSpeakerImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$ToggleSpeakerImpl>
    implements _$$ToggleSpeakerImplCopyWith<$Res> {
  __$$ToggleSpeakerImplCopyWithImpl(
      _$ToggleSpeakerImpl _value, $Res Function(_$ToggleSpeakerImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ToggleSpeakerImpl
    with DiagnosticableTreeMixin
    implements _ToggleSpeaker {
  const _$ToggleSpeakerImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.toggleSpeaker()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'CallEvent.toggleSpeaker'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ToggleSpeakerImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId, String recipientId,
            String recipientName, CallType callType)
        initiateCall,
    required TResult Function(String callId) answerCall,
    required TResult Function(String callId) declineCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() toggleSpeaker,
    required TResult Function(CallEntity incomingCallData) incomingCall,
    required TResult Function(CallStatus status) callStatusChanged,
    required TResult Function(MediaStream stream) remoteStreamReceived,
    required TResult Function(
            int latencyMs, double packetLossPercent, int jitterMs, int duration)
        updateStats,
    required TResult Function(VideoQuality quality) setVideoQuality,
    required TResult Function(AudioSettings settings) updateAudioSettings,
    required TResult Function(List<String> participantIds) addParticipants,
  }) {
    return toggleSpeaker();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult? Function(String callId)? answerCall,
    TResult? Function(String callId)? declineCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? toggleSpeaker,
    TResult? Function(CallEntity incomingCallData)? incomingCall,
    TResult? Function(CallStatus status)? callStatusChanged,
    TResult? Function(MediaStream stream)? remoteStreamReceived,
    TResult? Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult? Function(VideoQuality quality)? setVideoQuality,
    TResult? Function(AudioSettings settings)? updateAudioSettings,
    TResult? Function(List<String> participantIds)? addParticipants,
  }) {
    return toggleSpeaker?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult Function(String callId)? answerCall,
    TResult Function(String callId)? declineCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? toggleSpeaker,
    TResult Function(CallEntity incomingCallData)? incomingCall,
    TResult Function(CallStatus status)? callStatusChanged,
    TResult Function(MediaStream stream)? remoteStreamReceived,
    TResult Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult Function(VideoQuality quality)? setVideoQuality,
    TResult Function(AudioSettings settings)? updateAudioSettings,
    TResult Function(List<String> participantIds)? addParticipants,
    required TResult orElse(),
  }) {
    if (toggleSpeaker != null) {
      return toggleSpeaker();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_AnswerCall value) answerCall,
    required TResult Function(_DeclineCall value) declineCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_CallStatusChanged value) callStatusChanged,
    required TResult Function(_RemoteStreamReceived value) remoteStreamReceived,
    required TResult Function(_UpdateStats value) updateStats,
    required TResult Function(_SetVideoQuality value) setVideoQuality,
    required TResult Function(_UpdateAudioSettings value) updateAudioSettings,
    required TResult Function(_AddParticipants value) addParticipants,
  }) {
    return toggleSpeaker(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_AnswerCall value)? answerCall,
    TResult? Function(_DeclineCall value)? declineCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_CallStatusChanged value)? callStatusChanged,
    TResult? Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult? Function(_UpdateStats value)? updateStats,
    TResult? Function(_SetVideoQuality value)? setVideoQuality,
    TResult? Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult? Function(_AddParticipants value)? addParticipants,
  }) {
    return toggleSpeaker?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_AnswerCall value)? answerCall,
    TResult Function(_DeclineCall value)? declineCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_CallStatusChanged value)? callStatusChanged,
    TResult Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult Function(_UpdateStats value)? updateStats,
    TResult Function(_SetVideoQuality value)? setVideoQuality,
    TResult Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult Function(_AddParticipants value)? addParticipants,
    required TResult orElse(),
  }) {
    if (toggleSpeaker != null) {
      return toggleSpeaker(this);
    }
    return orElse();
  }
}

abstract class _ToggleSpeaker implements CallEvent {
  const factory _ToggleSpeaker() = _$ToggleSpeakerImpl;
}

/// @nodoc
abstract class _$$IncomingCallImplCopyWith<$Res> {
  factory _$$IncomingCallImplCopyWith(
          _$IncomingCallImpl value, $Res Function(_$IncomingCallImpl) then) =
      __$$IncomingCallImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CallEntity incomingCallData});

  $CallEntityCopyWith<$Res> get incomingCallData;
}

/// @nodoc
class __$$IncomingCallImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$IncomingCallImpl>
    implements _$$IncomingCallImplCopyWith<$Res> {
  __$$IncomingCallImplCopyWithImpl(
      _$IncomingCallImpl _value, $Res Function(_$IncomingCallImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? incomingCallData = null,
  }) {
    return _then(_$IncomingCallImpl(
      null == incomingCallData
          ? _value.incomingCallData
          : incomingCallData // ignore: cast_nullable_to_non_nullable
              as CallEntity,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $CallEntityCopyWith<$Res> get incomingCallData {
    return $CallEntityCopyWith<$Res>(_value.incomingCallData, (value) {
      return _then(_value.copyWith(incomingCallData: value));
    });
  }
}

/// @nodoc

class _$IncomingCallImpl with DiagnosticableTreeMixin implements _IncomingCall {
  const _$IncomingCallImpl(this.incomingCallData);

  @override
  final CallEntity incomingCallData;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.incomingCall(incomingCallData: $incomingCallData)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallEvent.incomingCall'))
      ..add(DiagnosticsProperty('incomingCallData', incomingCallData));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncomingCallImpl &&
            (identical(other.incomingCallData, incomingCallData) ||
                other.incomingCallData == incomingCallData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, incomingCallData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IncomingCallImplCopyWith<_$IncomingCallImpl> get copyWith =>
      __$$IncomingCallImplCopyWithImpl<_$IncomingCallImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId, String recipientId,
            String recipientName, CallType callType)
        initiateCall,
    required TResult Function(String callId) answerCall,
    required TResult Function(String callId) declineCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() toggleSpeaker,
    required TResult Function(CallEntity incomingCallData) incomingCall,
    required TResult Function(CallStatus status) callStatusChanged,
    required TResult Function(MediaStream stream) remoteStreamReceived,
    required TResult Function(
            int latencyMs, double packetLossPercent, int jitterMs, int duration)
        updateStats,
    required TResult Function(VideoQuality quality) setVideoQuality,
    required TResult Function(AudioSettings settings) updateAudioSettings,
    required TResult Function(List<String> participantIds) addParticipants,
  }) {
    return incomingCall(incomingCallData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult? Function(String callId)? answerCall,
    TResult? Function(String callId)? declineCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? toggleSpeaker,
    TResult? Function(CallEntity incomingCallData)? incomingCall,
    TResult? Function(CallStatus status)? callStatusChanged,
    TResult? Function(MediaStream stream)? remoteStreamReceived,
    TResult? Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult? Function(VideoQuality quality)? setVideoQuality,
    TResult? Function(AudioSettings settings)? updateAudioSettings,
    TResult? Function(List<String> participantIds)? addParticipants,
  }) {
    return incomingCall?.call(incomingCallData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult Function(String callId)? answerCall,
    TResult Function(String callId)? declineCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? toggleSpeaker,
    TResult Function(CallEntity incomingCallData)? incomingCall,
    TResult Function(CallStatus status)? callStatusChanged,
    TResult Function(MediaStream stream)? remoteStreamReceived,
    TResult Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult Function(VideoQuality quality)? setVideoQuality,
    TResult Function(AudioSettings settings)? updateAudioSettings,
    TResult Function(List<String> participantIds)? addParticipants,
    required TResult orElse(),
  }) {
    if (incomingCall != null) {
      return incomingCall(incomingCallData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_AnswerCall value) answerCall,
    required TResult Function(_DeclineCall value) declineCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_CallStatusChanged value) callStatusChanged,
    required TResult Function(_RemoteStreamReceived value) remoteStreamReceived,
    required TResult Function(_UpdateStats value) updateStats,
    required TResult Function(_SetVideoQuality value) setVideoQuality,
    required TResult Function(_UpdateAudioSettings value) updateAudioSettings,
    required TResult Function(_AddParticipants value) addParticipants,
  }) {
    return incomingCall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_AnswerCall value)? answerCall,
    TResult? Function(_DeclineCall value)? declineCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_CallStatusChanged value)? callStatusChanged,
    TResult? Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult? Function(_UpdateStats value)? updateStats,
    TResult? Function(_SetVideoQuality value)? setVideoQuality,
    TResult? Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult? Function(_AddParticipants value)? addParticipants,
  }) {
    return incomingCall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_AnswerCall value)? answerCall,
    TResult Function(_DeclineCall value)? declineCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_CallStatusChanged value)? callStatusChanged,
    TResult Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult Function(_UpdateStats value)? updateStats,
    TResult Function(_SetVideoQuality value)? setVideoQuality,
    TResult Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult Function(_AddParticipants value)? addParticipants,
    required TResult orElse(),
  }) {
    if (incomingCall != null) {
      return incomingCall(this);
    }
    return orElse();
  }
}

abstract class _IncomingCall implements CallEvent {
  const factory _IncomingCall(final CallEntity incomingCallData) =
      _$IncomingCallImpl;

  CallEntity get incomingCallData;
  @JsonKey(ignore: true)
  _$$IncomingCallImplCopyWith<_$IncomingCallImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CallStatusChangedImplCopyWith<$Res> {
  factory _$$CallStatusChangedImplCopyWith(_$CallStatusChangedImpl value,
          $Res Function(_$CallStatusChangedImpl) then) =
      __$$CallStatusChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CallStatus status});
}

/// @nodoc
class __$$CallStatusChangedImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$CallStatusChangedImpl>
    implements _$$CallStatusChangedImplCopyWith<$Res> {
  __$$CallStatusChangedImplCopyWithImpl(_$CallStatusChangedImpl _value,
      $Res Function(_$CallStatusChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$CallStatusChangedImpl(
      null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CallStatus,
    ));
  }
}

/// @nodoc

class _$CallStatusChangedImpl
    with DiagnosticableTreeMixin
    implements _CallStatusChanged {
  const _$CallStatusChangedImpl(this.status);

  @override
  final CallStatus status;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.callStatusChanged(status: $status)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallEvent.callStatusChanged'))
      ..add(DiagnosticsProperty('status', status));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallStatusChangedImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CallStatusChangedImplCopyWith<_$CallStatusChangedImpl> get copyWith =>
      __$$CallStatusChangedImplCopyWithImpl<_$CallStatusChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId, String recipientId,
            String recipientName, CallType callType)
        initiateCall,
    required TResult Function(String callId) answerCall,
    required TResult Function(String callId) declineCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() toggleSpeaker,
    required TResult Function(CallEntity incomingCallData) incomingCall,
    required TResult Function(CallStatus status) callStatusChanged,
    required TResult Function(MediaStream stream) remoteStreamReceived,
    required TResult Function(
            int latencyMs, double packetLossPercent, int jitterMs, int duration)
        updateStats,
    required TResult Function(VideoQuality quality) setVideoQuality,
    required TResult Function(AudioSettings settings) updateAudioSettings,
    required TResult Function(List<String> participantIds) addParticipants,
  }) {
    return callStatusChanged(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult? Function(String callId)? answerCall,
    TResult? Function(String callId)? declineCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? toggleSpeaker,
    TResult? Function(CallEntity incomingCallData)? incomingCall,
    TResult? Function(CallStatus status)? callStatusChanged,
    TResult? Function(MediaStream stream)? remoteStreamReceived,
    TResult? Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult? Function(VideoQuality quality)? setVideoQuality,
    TResult? Function(AudioSettings settings)? updateAudioSettings,
    TResult? Function(List<String> participantIds)? addParticipants,
  }) {
    return callStatusChanged?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult Function(String callId)? answerCall,
    TResult Function(String callId)? declineCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? toggleSpeaker,
    TResult Function(CallEntity incomingCallData)? incomingCall,
    TResult Function(CallStatus status)? callStatusChanged,
    TResult Function(MediaStream stream)? remoteStreamReceived,
    TResult Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult Function(VideoQuality quality)? setVideoQuality,
    TResult Function(AudioSettings settings)? updateAudioSettings,
    TResult Function(List<String> participantIds)? addParticipants,
    required TResult orElse(),
  }) {
    if (callStatusChanged != null) {
      return callStatusChanged(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_AnswerCall value) answerCall,
    required TResult Function(_DeclineCall value) declineCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_CallStatusChanged value) callStatusChanged,
    required TResult Function(_RemoteStreamReceived value) remoteStreamReceived,
    required TResult Function(_UpdateStats value) updateStats,
    required TResult Function(_SetVideoQuality value) setVideoQuality,
    required TResult Function(_UpdateAudioSettings value) updateAudioSettings,
    required TResult Function(_AddParticipants value) addParticipants,
  }) {
    return callStatusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_AnswerCall value)? answerCall,
    TResult? Function(_DeclineCall value)? declineCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_CallStatusChanged value)? callStatusChanged,
    TResult? Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult? Function(_UpdateStats value)? updateStats,
    TResult? Function(_SetVideoQuality value)? setVideoQuality,
    TResult? Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult? Function(_AddParticipants value)? addParticipants,
  }) {
    return callStatusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_AnswerCall value)? answerCall,
    TResult Function(_DeclineCall value)? declineCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_CallStatusChanged value)? callStatusChanged,
    TResult Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult Function(_UpdateStats value)? updateStats,
    TResult Function(_SetVideoQuality value)? setVideoQuality,
    TResult Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult Function(_AddParticipants value)? addParticipants,
    required TResult orElse(),
  }) {
    if (callStatusChanged != null) {
      return callStatusChanged(this);
    }
    return orElse();
  }
}

abstract class _CallStatusChanged implements CallEvent {
  const factory _CallStatusChanged(final CallStatus status) =
      _$CallStatusChangedImpl;

  CallStatus get status;
  @JsonKey(ignore: true)
  _$$CallStatusChangedImplCopyWith<_$CallStatusChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoteStreamReceivedImplCopyWith<$Res> {
  factory _$$RemoteStreamReceivedImplCopyWith(_$RemoteStreamReceivedImpl value,
          $Res Function(_$RemoteStreamReceivedImpl) then) =
      __$$RemoteStreamReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MediaStream stream});
}

/// @nodoc
class __$$RemoteStreamReceivedImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$RemoteStreamReceivedImpl>
    implements _$$RemoteStreamReceivedImplCopyWith<$Res> {
  __$$RemoteStreamReceivedImplCopyWithImpl(_$RemoteStreamReceivedImpl _value,
      $Res Function(_$RemoteStreamReceivedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stream = null,
  }) {
    return _then(_$RemoteStreamReceivedImpl(
      null == stream
          ? _value.stream
          : stream // ignore: cast_nullable_to_non_nullable
              as MediaStream,
    ));
  }
}

/// @nodoc

class _$RemoteStreamReceivedImpl
    with DiagnosticableTreeMixin
    implements _RemoteStreamReceived {
  const _$RemoteStreamReceivedImpl(this.stream);

  @override
  final MediaStream stream;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.remoteStreamReceived(stream: $stream)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallEvent.remoteStreamReceived'))
      ..add(DiagnosticsProperty('stream', stream));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoteStreamReceivedImpl &&
            (identical(other.stream, stream) || other.stream == stream));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stream);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoteStreamReceivedImplCopyWith<_$RemoteStreamReceivedImpl>
      get copyWith =>
          __$$RemoteStreamReceivedImplCopyWithImpl<_$RemoteStreamReceivedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId, String recipientId,
            String recipientName, CallType callType)
        initiateCall,
    required TResult Function(String callId) answerCall,
    required TResult Function(String callId) declineCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() toggleSpeaker,
    required TResult Function(CallEntity incomingCallData) incomingCall,
    required TResult Function(CallStatus status) callStatusChanged,
    required TResult Function(MediaStream stream) remoteStreamReceived,
    required TResult Function(
            int latencyMs, double packetLossPercent, int jitterMs, int duration)
        updateStats,
    required TResult Function(VideoQuality quality) setVideoQuality,
    required TResult Function(AudioSettings settings) updateAudioSettings,
    required TResult Function(List<String> participantIds) addParticipants,
  }) {
    return remoteStreamReceived(stream);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult? Function(String callId)? answerCall,
    TResult? Function(String callId)? declineCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? toggleSpeaker,
    TResult? Function(CallEntity incomingCallData)? incomingCall,
    TResult? Function(CallStatus status)? callStatusChanged,
    TResult? Function(MediaStream stream)? remoteStreamReceived,
    TResult? Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult? Function(VideoQuality quality)? setVideoQuality,
    TResult? Function(AudioSettings settings)? updateAudioSettings,
    TResult? Function(List<String> participantIds)? addParticipants,
  }) {
    return remoteStreamReceived?.call(stream);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult Function(String callId)? answerCall,
    TResult Function(String callId)? declineCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? toggleSpeaker,
    TResult Function(CallEntity incomingCallData)? incomingCall,
    TResult Function(CallStatus status)? callStatusChanged,
    TResult Function(MediaStream stream)? remoteStreamReceived,
    TResult Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult Function(VideoQuality quality)? setVideoQuality,
    TResult Function(AudioSettings settings)? updateAudioSettings,
    TResult Function(List<String> participantIds)? addParticipants,
    required TResult orElse(),
  }) {
    if (remoteStreamReceived != null) {
      return remoteStreamReceived(stream);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_AnswerCall value) answerCall,
    required TResult Function(_DeclineCall value) declineCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_CallStatusChanged value) callStatusChanged,
    required TResult Function(_RemoteStreamReceived value) remoteStreamReceived,
    required TResult Function(_UpdateStats value) updateStats,
    required TResult Function(_SetVideoQuality value) setVideoQuality,
    required TResult Function(_UpdateAudioSettings value) updateAudioSettings,
    required TResult Function(_AddParticipants value) addParticipants,
  }) {
    return remoteStreamReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_AnswerCall value)? answerCall,
    TResult? Function(_DeclineCall value)? declineCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_CallStatusChanged value)? callStatusChanged,
    TResult? Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult? Function(_UpdateStats value)? updateStats,
    TResult? Function(_SetVideoQuality value)? setVideoQuality,
    TResult? Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult? Function(_AddParticipants value)? addParticipants,
  }) {
    return remoteStreamReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_AnswerCall value)? answerCall,
    TResult Function(_DeclineCall value)? declineCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_CallStatusChanged value)? callStatusChanged,
    TResult Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult Function(_UpdateStats value)? updateStats,
    TResult Function(_SetVideoQuality value)? setVideoQuality,
    TResult Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult Function(_AddParticipants value)? addParticipants,
    required TResult orElse(),
  }) {
    if (remoteStreamReceived != null) {
      return remoteStreamReceived(this);
    }
    return orElse();
  }
}

abstract class _RemoteStreamReceived implements CallEvent {
  const factory _RemoteStreamReceived(final MediaStream stream) =
      _$RemoteStreamReceivedImpl;

  MediaStream get stream;
  @JsonKey(ignore: true)
  _$$RemoteStreamReceivedImplCopyWith<_$RemoteStreamReceivedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateStatsImplCopyWith<$Res> {
  factory _$$UpdateStatsImplCopyWith(
          _$UpdateStatsImpl value, $Res Function(_$UpdateStatsImpl) then) =
      __$$UpdateStatsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {int latencyMs, double packetLossPercent, int jitterMs, int duration});
}

/// @nodoc
class __$$UpdateStatsImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$UpdateStatsImpl>
    implements _$$UpdateStatsImplCopyWith<$Res> {
  __$$UpdateStatsImplCopyWithImpl(
      _$UpdateStatsImpl _value, $Res Function(_$UpdateStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latencyMs = null,
    Object? packetLossPercent = null,
    Object? jitterMs = null,
    Object? duration = null,
  }) {
    return _then(_$UpdateStatsImpl(
      latencyMs: null == latencyMs
          ? _value.latencyMs
          : latencyMs // ignore: cast_nullable_to_non_nullable
              as int,
      packetLossPercent: null == packetLossPercent
          ? _value.packetLossPercent
          : packetLossPercent // ignore: cast_nullable_to_non_nullable
              as double,
      jitterMs: null == jitterMs
          ? _value.jitterMs
          : jitterMs // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$UpdateStatsImpl with DiagnosticableTreeMixin implements _UpdateStats {
  const _$UpdateStatsImpl(
      {required this.latencyMs,
      required this.packetLossPercent,
      required this.jitterMs,
      required this.duration});

  @override
  final int latencyMs;
  @override
  final double packetLossPercent;
  @override
  final int jitterMs;
  @override
  final int duration;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.updateStats(latencyMs: $latencyMs, packetLossPercent: $packetLossPercent, jitterMs: $jitterMs, duration: $duration)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallEvent.updateStats'))
      ..add(DiagnosticsProperty('latencyMs', latencyMs))
      ..add(DiagnosticsProperty('packetLossPercent', packetLossPercent))
      ..add(DiagnosticsProperty('jitterMs', jitterMs))
      ..add(DiagnosticsProperty('duration', duration));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateStatsImpl &&
            (identical(other.latencyMs, latencyMs) ||
                other.latencyMs == latencyMs) &&
            (identical(other.packetLossPercent, packetLossPercent) ||
                other.packetLossPercent == packetLossPercent) &&
            (identical(other.jitterMs, jitterMs) ||
                other.jitterMs == jitterMs) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, latencyMs, packetLossPercent, jitterMs, duration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateStatsImplCopyWith<_$UpdateStatsImpl> get copyWith =>
      __$$UpdateStatsImplCopyWithImpl<_$UpdateStatsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId, String recipientId,
            String recipientName, CallType callType)
        initiateCall,
    required TResult Function(String callId) answerCall,
    required TResult Function(String callId) declineCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() toggleSpeaker,
    required TResult Function(CallEntity incomingCallData) incomingCall,
    required TResult Function(CallStatus status) callStatusChanged,
    required TResult Function(MediaStream stream) remoteStreamReceived,
    required TResult Function(
            int latencyMs, double packetLossPercent, int jitterMs, int duration)
        updateStats,
    required TResult Function(VideoQuality quality) setVideoQuality,
    required TResult Function(AudioSettings settings) updateAudioSettings,
    required TResult Function(List<String> participantIds) addParticipants,
  }) {
    return updateStats(latencyMs, packetLossPercent, jitterMs, duration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult? Function(String callId)? answerCall,
    TResult? Function(String callId)? declineCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? toggleSpeaker,
    TResult? Function(CallEntity incomingCallData)? incomingCall,
    TResult? Function(CallStatus status)? callStatusChanged,
    TResult? Function(MediaStream stream)? remoteStreamReceived,
    TResult? Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult? Function(VideoQuality quality)? setVideoQuality,
    TResult? Function(AudioSettings settings)? updateAudioSettings,
    TResult? Function(List<String> participantIds)? addParticipants,
  }) {
    return updateStats?.call(latencyMs, packetLossPercent, jitterMs, duration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult Function(String callId)? answerCall,
    TResult Function(String callId)? declineCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? toggleSpeaker,
    TResult Function(CallEntity incomingCallData)? incomingCall,
    TResult Function(CallStatus status)? callStatusChanged,
    TResult Function(MediaStream stream)? remoteStreamReceived,
    TResult Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult Function(VideoQuality quality)? setVideoQuality,
    TResult Function(AudioSettings settings)? updateAudioSettings,
    TResult Function(List<String> participantIds)? addParticipants,
    required TResult orElse(),
  }) {
    if (updateStats != null) {
      return updateStats(latencyMs, packetLossPercent, jitterMs, duration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_AnswerCall value) answerCall,
    required TResult Function(_DeclineCall value) declineCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_CallStatusChanged value) callStatusChanged,
    required TResult Function(_RemoteStreamReceived value) remoteStreamReceived,
    required TResult Function(_UpdateStats value) updateStats,
    required TResult Function(_SetVideoQuality value) setVideoQuality,
    required TResult Function(_UpdateAudioSettings value) updateAudioSettings,
    required TResult Function(_AddParticipants value) addParticipants,
  }) {
    return updateStats(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_AnswerCall value)? answerCall,
    TResult? Function(_DeclineCall value)? declineCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_CallStatusChanged value)? callStatusChanged,
    TResult? Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult? Function(_UpdateStats value)? updateStats,
    TResult? Function(_SetVideoQuality value)? setVideoQuality,
    TResult? Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult? Function(_AddParticipants value)? addParticipants,
  }) {
    return updateStats?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_AnswerCall value)? answerCall,
    TResult Function(_DeclineCall value)? declineCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_CallStatusChanged value)? callStatusChanged,
    TResult Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult Function(_UpdateStats value)? updateStats,
    TResult Function(_SetVideoQuality value)? setVideoQuality,
    TResult Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult Function(_AddParticipants value)? addParticipants,
    required TResult orElse(),
  }) {
    if (updateStats != null) {
      return updateStats(this);
    }
    return orElse();
  }
}

abstract class _UpdateStats implements CallEvent {
  const factory _UpdateStats(
      {required final int latencyMs,
      required final double packetLossPercent,
      required final int jitterMs,
      required final int duration}) = _$UpdateStatsImpl;

  int get latencyMs;
  double get packetLossPercent;
  int get jitterMs;
  int get duration;
  @JsonKey(ignore: true)
  _$$UpdateStatsImplCopyWith<_$UpdateStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetVideoQualityImplCopyWith<$Res> {
  factory _$$SetVideoQualityImplCopyWith(_$SetVideoQualityImpl value,
          $Res Function(_$SetVideoQualityImpl) then) =
      __$$SetVideoQualityImplCopyWithImpl<$Res>;
  @useResult
  $Res call({VideoQuality quality});
}

/// @nodoc
class __$$SetVideoQualityImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$SetVideoQualityImpl>
    implements _$$SetVideoQualityImplCopyWith<$Res> {
  __$$SetVideoQualityImplCopyWithImpl(
      _$SetVideoQualityImpl _value, $Res Function(_$SetVideoQualityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quality = null,
  }) {
    return _then(_$SetVideoQualityImpl(
      null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as VideoQuality,
    ));
  }
}

/// @nodoc

class _$SetVideoQualityImpl
    with DiagnosticableTreeMixin
    implements _SetVideoQuality {
  const _$SetVideoQualityImpl(this.quality);

  @override
  final VideoQuality quality;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.setVideoQuality(quality: $quality)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallEvent.setVideoQuality'))
      ..add(DiagnosticsProperty('quality', quality));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetVideoQualityImpl &&
            (identical(other.quality, quality) || other.quality == quality));
  }

  @override
  int get hashCode => Object.hash(runtimeType, quality);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetVideoQualityImplCopyWith<_$SetVideoQualityImpl> get copyWith =>
      __$$SetVideoQualityImplCopyWithImpl<_$SetVideoQualityImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId, String recipientId,
            String recipientName, CallType callType)
        initiateCall,
    required TResult Function(String callId) answerCall,
    required TResult Function(String callId) declineCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() toggleSpeaker,
    required TResult Function(CallEntity incomingCallData) incomingCall,
    required TResult Function(CallStatus status) callStatusChanged,
    required TResult Function(MediaStream stream) remoteStreamReceived,
    required TResult Function(
            int latencyMs, double packetLossPercent, int jitterMs, int duration)
        updateStats,
    required TResult Function(VideoQuality quality) setVideoQuality,
    required TResult Function(AudioSettings settings) updateAudioSettings,
    required TResult Function(List<String> participantIds) addParticipants,
  }) {
    return setVideoQuality(quality);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult? Function(String callId)? answerCall,
    TResult? Function(String callId)? declineCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? toggleSpeaker,
    TResult? Function(CallEntity incomingCallData)? incomingCall,
    TResult? Function(CallStatus status)? callStatusChanged,
    TResult? Function(MediaStream stream)? remoteStreamReceived,
    TResult? Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult? Function(VideoQuality quality)? setVideoQuality,
    TResult? Function(AudioSettings settings)? updateAudioSettings,
    TResult? Function(List<String> participantIds)? addParticipants,
  }) {
    return setVideoQuality?.call(quality);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult Function(String callId)? answerCall,
    TResult Function(String callId)? declineCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? toggleSpeaker,
    TResult Function(CallEntity incomingCallData)? incomingCall,
    TResult Function(CallStatus status)? callStatusChanged,
    TResult Function(MediaStream stream)? remoteStreamReceived,
    TResult Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult Function(VideoQuality quality)? setVideoQuality,
    TResult Function(AudioSettings settings)? updateAudioSettings,
    TResult Function(List<String> participantIds)? addParticipants,
    required TResult orElse(),
  }) {
    if (setVideoQuality != null) {
      return setVideoQuality(quality);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_AnswerCall value) answerCall,
    required TResult Function(_DeclineCall value) declineCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_CallStatusChanged value) callStatusChanged,
    required TResult Function(_RemoteStreamReceived value) remoteStreamReceived,
    required TResult Function(_UpdateStats value) updateStats,
    required TResult Function(_SetVideoQuality value) setVideoQuality,
    required TResult Function(_UpdateAudioSettings value) updateAudioSettings,
    required TResult Function(_AddParticipants value) addParticipants,
  }) {
    return setVideoQuality(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_AnswerCall value)? answerCall,
    TResult? Function(_DeclineCall value)? declineCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_CallStatusChanged value)? callStatusChanged,
    TResult? Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult? Function(_UpdateStats value)? updateStats,
    TResult? Function(_SetVideoQuality value)? setVideoQuality,
    TResult? Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult? Function(_AddParticipants value)? addParticipants,
  }) {
    return setVideoQuality?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_AnswerCall value)? answerCall,
    TResult Function(_DeclineCall value)? declineCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_CallStatusChanged value)? callStatusChanged,
    TResult Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult Function(_UpdateStats value)? updateStats,
    TResult Function(_SetVideoQuality value)? setVideoQuality,
    TResult Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult Function(_AddParticipants value)? addParticipants,
    required TResult orElse(),
  }) {
    if (setVideoQuality != null) {
      return setVideoQuality(this);
    }
    return orElse();
  }
}

abstract class _SetVideoQuality implements CallEvent {
  const factory _SetVideoQuality(final VideoQuality quality) =
      _$SetVideoQualityImpl;

  VideoQuality get quality;
  @JsonKey(ignore: true)
  _$$SetVideoQualityImplCopyWith<_$SetVideoQualityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateAudioSettingsImplCopyWith<$Res> {
  factory _$$UpdateAudioSettingsImplCopyWith(_$UpdateAudioSettingsImpl value,
          $Res Function(_$UpdateAudioSettingsImpl) then) =
      __$$UpdateAudioSettingsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AudioSettings settings});
}

/// @nodoc
class __$$UpdateAudioSettingsImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$UpdateAudioSettingsImpl>
    implements _$$UpdateAudioSettingsImplCopyWith<$Res> {
  __$$UpdateAudioSettingsImplCopyWithImpl(_$UpdateAudioSettingsImpl _value,
      $Res Function(_$UpdateAudioSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settings = null,
  }) {
    return _then(_$UpdateAudioSettingsImpl(
      null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as AudioSettings,
    ));
  }
}

/// @nodoc

class _$UpdateAudioSettingsImpl
    with DiagnosticableTreeMixin
    implements _UpdateAudioSettings {
  const _$UpdateAudioSettingsImpl(this.settings);

  @override
  final AudioSettings settings;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.updateAudioSettings(settings: $settings)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallEvent.updateAudioSettings'))
      ..add(DiagnosticsProperty('settings', settings));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateAudioSettingsImpl &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @override
  int get hashCode => Object.hash(runtimeType, settings);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateAudioSettingsImplCopyWith<_$UpdateAudioSettingsImpl> get copyWith =>
      __$$UpdateAudioSettingsImplCopyWithImpl<_$UpdateAudioSettingsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId, String recipientId,
            String recipientName, CallType callType)
        initiateCall,
    required TResult Function(String callId) answerCall,
    required TResult Function(String callId) declineCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() toggleSpeaker,
    required TResult Function(CallEntity incomingCallData) incomingCall,
    required TResult Function(CallStatus status) callStatusChanged,
    required TResult Function(MediaStream stream) remoteStreamReceived,
    required TResult Function(
            int latencyMs, double packetLossPercent, int jitterMs, int duration)
        updateStats,
    required TResult Function(VideoQuality quality) setVideoQuality,
    required TResult Function(AudioSettings settings) updateAudioSettings,
    required TResult Function(List<String> participantIds) addParticipants,
  }) {
    return updateAudioSettings(settings);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult? Function(String callId)? answerCall,
    TResult? Function(String callId)? declineCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? toggleSpeaker,
    TResult? Function(CallEntity incomingCallData)? incomingCall,
    TResult? Function(CallStatus status)? callStatusChanged,
    TResult? Function(MediaStream stream)? remoteStreamReceived,
    TResult? Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult? Function(VideoQuality quality)? setVideoQuality,
    TResult? Function(AudioSettings settings)? updateAudioSettings,
    TResult? Function(List<String> participantIds)? addParticipants,
  }) {
    return updateAudioSettings?.call(settings);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult Function(String callId)? answerCall,
    TResult Function(String callId)? declineCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? toggleSpeaker,
    TResult Function(CallEntity incomingCallData)? incomingCall,
    TResult Function(CallStatus status)? callStatusChanged,
    TResult Function(MediaStream stream)? remoteStreamReceived,
    TResult Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult Function(VideoQuality quality)? setVideoQuality,
    TResult Function(AudioSettings settings)? updateAudioSettings,
    TResult Function(List<String> participantIds)? addParticipants,
    required TResult orElse(),
  }) {
    if (updateAudioSettings != null) {
      return updateAudioSettings(settings);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_AnswerCall value) answerCall,
    required TResult Function(_DeclineCall value) declineCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_CallStatusChanged value) callStatusChanged,
    required TResult Function(_RemoteStreamReceived value) remoteStreamReceived,
    required TResult Function(_UpdateStats value) updateStats,
    required TResult Function(_SetVideoQuality value) setVideoQuality,
    required TResult Function(_UpdateAudioSettings value) updateAudioSettings,
    required TResult Function(_AddParticipants value) addParticipants,
  }) {
    return updateAudioSettings(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_AnswerCall value)? answerCall,
    TResult? Function(_DeclineCall value)? declineCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_CallStatusChanged value)? callStatusChanged,
    TResult? Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult? Function(_UpdateStats value)? updateStats,
    TResult? Function(_SetVideoQuality value)? setVideoQuality,
    TResult? Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult? Function(_AddParticipants value)? addParticipants,
  }) {
    return updateAudioSettings?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_AnswerCall value)? answerCall,
    TResult Function(_DeclineCall value)? declineCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_CallStatusChanged value)? callStatusChanged,
    TResult Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult Function(_UpdateStats value)? updateStats,
    TResult Function(_SetVideoQuality value)? setVideoQuality,
    TResult Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult Function(_AddParticipants value)? addParticipants,
    required TResult orElse(),
  }) {
    if (updateAudioSettings != null) {
      return updateAudioSettings(this);
    }
    return orElse();
  }
}

abstract class _UpdateAudioSettings implements CallEvent {
  const factory _UpdateAudioSettings(final AudioSettings settings) =
      _$UpdateAudioSettingsImpl;

  AudioSettings get settings;
  @JsonKey(ignore: true)
  _$$UpdateAudioSettingsImplCopyWith<_$UpdateAudioSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddParticipantsImplCopyWith<$Res> {
  factory _$$AddParticipantsImplCopyWith(_$AddParticipantsImpl value,
          $Res Function(_$AddParticipantsImpl) then) =
      __$$AddParticipantsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> participantIds});
}

/// @nodoc
class __$$AddParticipantsImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$AddParticipantsImpl>
    implements _$$AddParticipantsImplCopyWith<$Res> {
  __$$AddParticipantsImplCopyWithImpl(
      _$AddParticipantsImpl _value, $Res Function(_$AddParticipantsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? participantIds = null,
  }) {
    return _then(_$AddParticipantsImpl(
      null == participantIds
          ? _value._participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$AddParticipantsImpl
    with DiagnosticableTreeMixin
    implements _AddParticipants {
  const _$AddParticipantsImpl(final List<String> participantIds)
      : _participantIds = participantIds;

  final List<String> _participantIds;
  @override
  List<String> get participantIds {
    if (_participantIds is EqualUnmodifiableListView) return _participantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantIds);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallEvent.addParticipants(participantIds: $participantIds)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallEvent.addParticipants'))
      ..add(DiagnosticsProperty('participantIds', participantIds));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddParticipantsImpl &&
            const DeepCollectionEquality()
                .equals(other._participantIds, _participantIds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_participantIds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddParticipantsImplCopyWith<_$AddParticipantsImpl> get copyWith =>
      __$$AddParticipantsImplCopyWithImpl<_$AddParticipantsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId, String recipientId,
            String recipientName, CallType callType)
        initiateCall,
    required TResult Function(String callId) answerCall,
    required TResult Function(String callId) declineCall,
    required TResult Function() endCall,
    required TResult Function() toggleMute,
    required TResult Function() toggleVideo,
    required TResult Function() switchCamera,
    required TResult Function() toggleSpeaker,
    required TResult Function(CallEntity incomingCallData) incomingCall,
    required TResult Function(CallStatus status) callStatusChanged,
    required TResult Function(MediaStream stream) remoteStreamReceived,
    required TResult Function(
            int latencyMs, double packetLossPercent, int jitterMs, int duration)
        updateStats,
    required TResult Function(VideoQuality quality) setVideoQuality,
    required TResult Function(AudioSettings settings) updateAudioSettings,
    required TResult Function(List<String> participantIds) addParticipants,
  }) {
    return addParticipants(participantIds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult? Function(String callId)? answerCall,
    TResult? Function(String callId)? declineCall,
    TResult? Function()? endCall,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleVideo,
    TResult? Function()? switchCamera,
    TResult? Function()? toggleSpeaker,
    TResult? Function(CallEntity incomingCallData)? incomingCall,
    TResult? Function(CallStatus status)? callStatusChanged,
    TResult? Function(MediaStream stream)? remoteStreamReceived,
    TResult? Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult? Function(VideoQuality quality)? setVideoQuality,
    TResult? Function(AudioSettings settings)? updateAudioSettings,
    TResult? Function(List<String> participantIds)? addParticipants,
  }) {
    return addParticipants?.call(participantIds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId, String recipientId, String recipientName,
            CallType callType)?
        initiateCall,
    TResult Function(String callId)? answerCall,
    TResult Function(String callId)? declineCall,
    TResult Function()? endCall,
    TResult Function()? toggleMute,
    TResult Function()? toggleVideo,
    TResult Function()? switchCamera,
    TResult Function()? toggleSpeaker,
    TResult Function(CallEntity incomingCallData)? incomingCall,
    TResult Function(CallStatus status)? callStatusChanged,
    TResult Function(MediaStream stream)? remoteStreamReceived,
    TResult Function(int latencyMs, double packetLossPercent, int jitterMs,
            int duration)?
        updateStats,
    TResult Function(VideoQuality quality)? setVideoQuality,
    TResult Function(AudioSettings settings)? updateAudioSettings,
    TResult Function(List<String> participantIds)? addParticipants,
    required TResult orElse(),
  }) {
    if (addParticipants != null) {
      return addParticipants(participantIds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitiateCall value) initiateCall,
    required TResult Function(_AnswerCall value) answerCall,
    required TResult Function(_DeclineCall value) declineCall,
    required TResult Function(_EndCall value) endCall,
    required TResult Function(_ToggleMute value) toggleMute,
    required TResult Function(_ToggleVideo value) toggleVideo,
    required TResult Function(_SwitchCamera value) switchCamera,
    required TResult Function(_ToggleSpeaker value) toggleSpeaker,
    required TResult Function(_IncomingCall value) incomingCall,
    required TResult Function(_CallStatusChanged value) callStatusChanged,
    required TResult Function(_RemoteStreamReceived value) remoteStreamReceived,
    required TResult Function(_UpdateStats value) updateStats,
    required TResult Function(_SetVideoQuality value) setVideoQuality,
    required TResult Function(_UpdateAudioSettings value) updateAudioSettings,
    required TResult Function(_AddParticipants value) addParticipants,
  }) {
    return addParticipants(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitiateCall value)? initiateCall,
    TResult? Function(_AnswerCall value)? answerCall,
    TResult? Function(_DeclineCall value)? declineCall,
    TResult? Function(_EndCall value)? endCall,
    TResult? Function(_ToggleMute value)? toggleMute,
    TResult? Function(_ToggleVideo value)? toggleVideo,
    TResult? Function(_SwitchCamera value)? switchCamera,
    TResult? Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult? Function(_IncomingCall value)? incomingCall,
    TResult? Function(_CallStatusChanged value)? callStatusChanged,
    TResult? Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult? Function(_UpdateStats value)? updateStats,
    TResult? Function(_SetVideoQuality value)? setVideoQuality,
    TResult? Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult? Function(_AddParticipants value)? addParticipants,
  }) {
    return addParticipants?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitiateCall value)? initiateCall,
    TResult Function(_AnswerCall value)? answerCall,
    TResult Function(_DeclineCall value)? declineCall,
    TResult Function(_EndCall value)? endCall,
    TResult Function(_ToggleMute value)? toggleMute,
    TResult Function(_ToggleVideo value)? toggleVideo,
    TResult Function(_SwitchCamera value)? switchCamera,
    TResult Function(_ToggleSpeaker value)? toggleSpeaker,
    TResult Function(_IncomingCall value)? incomingCall,
    TResult Function(_CallStatusChanged value)? callStatusChanged,
    TResult Function(_RemoteStreamReceived value)? remoteStreamReceived,
    TResult Function(_UpdateStats value)? updateStats,
    TResult Function(_SetVideoQuality value)? setVideoQuality,
    TResult Function(_UpdateAudioSettings value)? updateAudioSettings,
    TResult Function(_AddParticipants value)? addParticipants,
    required TResult orElse(),
  }) {
    if (addParticipants != null) {
      return addParticipants(this);
    }
    return orElse();
  }
}

abstract class _AddParticipants implements CallEvent {
  const factory _AddParticipants(final List<String> participantIds) =
      _$AddParticipantsImpl;

  List<String> get participantIds;
  @JsonKey(ignore: true)
  _$$AddParticipantsImplCopyWith<_$AddParticipantsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CallState {
  CallEntity? get currentCall => throw _privateConstructorUsedError;
  bool get isInitiating => throw _privateConstructorUsedError;
  bool get isRinging => throw _privateConstructorUsedError;
  bool get isConnected => throw _privateConstructorUsedError;
  bool get isIncoming => throw _privateConstructorUsedError;
  bool get isMuted => throw _privateConstructorUsedError;
  bool get isVideoEnabled => throw _privateConstructorUsedError;
  bool get isSpeakerOn => throw _privateConstructorUsedError;
  MediaStream? get localStream => throw _privateConstructorUsedError;
  MediaStream? get remoteStream => throw _privateConstructorUsedError;
  int get callDuration => throw _privateConstructorUsedError;
  String? get errorMessage =>
      throw _privateConstructorUsedError; // Call quality stats
  int? get latencyMs => throw _privateConstructorUsedError;
  double? get packetLossPercent => throw _privateConstructorUsedError;
  int? get jitterMs => throw _privateConstructorUsedError;
  int get callQualityScore => throw _privateConstructorUsedError; // 0-100
  VideoQuality get videoQuality => throw _privateConstructorUsedError;
  AudioSettings get audioSettings => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CallStateCopyWith<CallState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallStateCopyWith<$Res> {
  factory $CallStateCopyWith(CallState value, $Res Function(CallState) then) =
      _$CallStateCopyWithImpl<$Res, CallState>;
  @useResult
  $Res call(
      {CallEntity? currentCall,
      bool isInitiating,
      bool isRinging,
      bool isConnected,
      bool isIncoming,
      bool isMuted,
      bool isVideoEnabled,
      bool isSpeakerOn,
      MediaStream? localStream,
      MediaStream? remoteStream,
      int callDuration,
      String? errorMessage,
      int? latencyMs,
      double? packetLossPercent,
      int? jitterMs,
      int callQualityScore,
      VideoQuality videoQuality,
      AudioSettings audioSettings});

  $CallEntityCopyWith<$Res>? get currentCall;
}

/// @nodoc
class _$CallStateCopyWithImpl<$Res, $Val extends CallState>
    implements $CallStateCopyWith<$Res> {
  _$CallStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentCall = freezed,
    Object? isInitiating = null,
    Object? isRinging = null,
    Object? isConnected = null,
    Object? isIncoming = null,
    Object? isMuted = null,
    Object? isVideoEnabled = null,
    Object? isSpeakerOn = null,
    Object? localStream = freezed,
    Object? remoteStream = freezed,
    Object? callDuration = null,
    Object? errorMessage = freezed,
    Object? latencyMs = freezed,
    Object? packetLossPercent = freezed,
    Object? jitterMs = freezed,
    Object? callQualityScore = null,
    Object? videoQuality = null,
    Object? audioSettings = null,
  }) {
    return _then(_value.copyWith(
      currentCall: freezed == currentCall
          ? _value.currentCall
          : currentCall // ignore: cast_nullable_to_non_nullable
              as CallEntity?,
      isInitiating: null == isInitiating
          ? _value.isInitiating
          : isInitiating // ignore: cast_nullable_to_non_nullable
              as bool,
      isRinging: null == isRinging
          ? _value.isRinging
          : isRinging // ignore: cast_nullable_to_non_nullable
              as bool,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isIncoming: null == isIncoming
          ? _value.isIncoming
          : isIncoming // ignore: cast_nullable_to_non_nullable
              as bool,
      isMuted: null == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      isVideoEnabled: null == isVideoEnabled
          ? _value.isVideoEnabled
          : isVideoEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isSpeakerOn: null == isSpeakerOn
          ? _value.isSpeakerOn
          : isSpeakerOn // ignore: cast_nullable_to_non_nullable
              as bool,
      localStream: freezed == localStream
          ? _value.localStream
          : localStream // ignore: cast_nullable_to_non_nullable
              as MediaStream?,
      remoteStream: freezed == remoteStream
          ? _value.remoteStream
          : remoteStream // ignore: cast_nullable_to_non_nullable
              as MediaStream?,
      callDuration: null == callDuration
          ? _value.callDuration
          : callDuration // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      latencyMs: freezed == latencyMs
          ? _value.latencyMs
          : latencyMs // ignore: cast_nullable_to_non_nullable
              as int?,
      packetLossPercent: freezed == packetLossPercent
          ? _value.packetLossPercent
          : packetLossPercent // ignore: cast_nullable_to_non_nullable
              as double?,
      jitterMs: freezed == jitterMs
          ? _value.jitterMs
          : jitterMs // ignore: cast_nullable_to_non_nullable
              as int?,
      callQualityScore: null == callQualityScore
          ? _value.callQualityScore
          : callQualityScore // ignore: cast_nullable_to_non_nullable
              as int,
      videoQuality: null == videoQuality
          ? _value.videoQuality
          : videoQuality // ignore: cast_nullable_to_non_nullable
              as VideoQuality,
      audioSettings: null == audioSettings
          ? _value.audioSettings
          : audioSettings // ignore: cast_nullable_to_non_nullable
              as AudioSettings,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CallEntityCopyWith<$Res>? get currentCall {
    if (_value.currentCall == null) {
      return null;
    }

    return $CallEntityCopyWith<$Res>(_value.currentCall!, (value) {
      return _then(_value.copyWith(currentCall: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CallStateImplCopyWith<$Res>
    implements $CallStateCopyWith<$Res> {
  factory _$$CallStateImplCopyWith(
          _$CallStateImpl value, $Res Function(_$CallStateImpl) then) =
      __$$CallStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CallEntity? currentCall,
      bool isInitiating,
      bool isRinging,
      bool isConnected,
      bool isIncoming,
      bool isMuted,
      bool isVideoEnabled,
      bool isSpeakerOn,
      MediaStream? localStream,
      MediaStream? remoteStream,
      int callDuration,
      String? errorMessage,
      int? latencyMs,
      double? packetLossPercent,
      int? jitterMs,
      int callQualityScore,
      VideoQuality videoQuality,
      AudioSettings audioSettings});

  @override
  $CallEntityCopyWith<$Res>? get currentCall;
}

/// @nodoc
class __$$CallStateImplCopyWithImpl<$Res>
    extends _$CallStateCopyWithImpl<$Res, _$CallStateImpl>
    implements _$$CallStateImplCopyWith<$Res> {
  __$$CallStateImplCopyWithImpl(
      _$CallStateImpl _value, $Res Function(_$CallStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentCall = freezed,
    Object? isInitiating = null,
    Object? isRinging = null,
    Object? isConnected = null,
    Object? isIncoming = null,
    Object? isMuted = null,
    Object? isVideoEnabled = null,
    Object? isSpeakerOn = null,
    Object? localStream = freezed,
    Object? remoteStream = freezed,
    Object? callDuration = null,
    Object? errorMessage = freezed,
    Object? latencyMs = freezed,
    Object? packetLossPercent = freezed,
    Object? jitterMs = freezed,
    Object? callQualityScore = null,
    Object? videoQuality = null,
    Object? audioSettings = null,
  }) {
    return _then(_$CallStateImpl(
      currentCall: freezed == currentCall
          ? _value.currentCall
          : currentCall // ignore: cast_nullable_to_non_nullable
              as CallEntity?,
      isInitiating: null == isInitiating
          ? _value.isInitiating
          : isInitiating // ignore: cast_nullable_to_non_nullable
              as bool,
      isRinging: null == isRinging
          ? _value.isRinging
          : isRinging // ignore: cast_nullable_to_non_nullable
              as bool,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isIncoming: null == isIncoming
          ? _value.isIncoming
          : isIncoming // ignore: cast_nullable_to_non_nullable
              as bool,
      isMuted: null == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      isVideoEnabled: null == isVideoEnabled
          ? _value.isVideoEnabled
          : isVideoEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isSpeakerOn: null == isSpeakerOn
          ? _value.isSpeakerOn
          : isSpeakerOn // ignore: cast_nullable_to_non_nullable
              as bool,
      localStream: freezed == localStream
          ? _value.localStream
          : localStream // ignore: cast_nullable_to_non_nullable
              as MediaStream?,
      remoteStream: freezed == remoteStream
          ? _value.remoteStream
          : remoteStream // ignore: cast_nullable_to_non_nullable
              as MediaStream?,
      callDuration: null == callDuration
          ? _value.callDuration
          : callDuration // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      latencyMs: freezed == latencyMs
          ? _value.latencyMs
          : latencyMs // ignore: cast_nullable_to_non_nullable
              as int?,
      packetLossPercent: freezed == packetLossPercent
          ? _value.packetLossPercent
          : packetLossPercent // ignore: cast_nullable_to_non_nullable
              as double?,
      jitterMs: freezed == jitterMs
          ? _value.jitterMs
          : jitterMs // ignore: cast_nullable_to_non_nullable
              as int?,
      callQualityScore: null == callQualityScore
          ? _value.callQualityScore
          : callQualityScore // ignore: cast_nullable_to_non_nullable
              as int,
      videoQuality: null == videoQuality
          ? _value.videoQuality
          : videoQuality // ignore: cast_nullable_to_non_nullable
              as VideoQuality,
      audioSettings: null == audioSettings
          ? _value.audioSettings
          : audioSettings // ignore: cast_nullable_to_non_nullable
              as AudioSettings,
    ));
  }
}

/// @nodoc

class _$CallStateImpl with DiagnosticableTreeMixin implements _CallState {
  const _$CallStateImpl(
      {this.currentCall = null,
      this.isInitiating = false,
      this.isRinging = false,
      this.isConnected = false,
      this.isIncoming = false,
      this.isMuted = false,
      this.isVideoEnabled = true,
      this.isSpeakerOn = false,
      this.localStream = null,
      this.remoteStream = null,
      this.callDuration = 0,
      this.errorMessage = null,
      this.latencyMs = null,
      this.packetLossPercent = null,
      this.jitterMs = null,
      this.callQualityScore = 0,
      this.videoQuality = VideoQuality.auto,
      this.audioSettings = const AudioSettings()});

  @override
  @JsonKey()
  final CallEntity? currentCall;
  @override
  @JsonKey()
  final bool isInitiating;
  @override
  @JsonKey()
  final bool isRinging;
  @override
  @JsonKey()
  final bool isConnected;
  @override
  @JsonKey()
  final bool isIncoming;
  @override
  @JsonKey()
  final bool isMuted;
  @override
  @JsonKey()
  final bool isVideoEnabled;
  @override
  @JsonKey()
  final bool isSpeakerOn;
  @override
  @JsonKey()
  final MediaStream? localStream;
  @override
  @JsonKey()
  final MediaStream? remoteStream;
  @override
  @JsonKey()
  final int callDuration;
  @override
  @JsonKey()
  final String? errorMessage;
// Call quality stats
  @override
  @JsonKey()
  final int? latencyMs;
  @override
  @JsonKey()
  final double? packetLossPercent;
  @override
  @JsonKey()
  final int? jitterMs;
  @override
  @JsonKey()
  final int callQualityScore;
// 0-100
  @override
  @JsonKey()
  final VideoQuality videoQuality;
  @override
  @JsonKey()
  final AudioSettings audioSettings;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallState(currentCall: $currentCall, isInitiating: $isInitiating, isRinging: $isRinging, isConnected: $isConnected, isIncoming: $isIncoming, isMuted: $isMuted, isVideoEnabled: $isVideoEnabled, isSpeakerOn: $isSpeakerOn, localStream: $localStream, remoteStream: $remoteStream, callDuration: $callDuration, errorMessage: $errorMessage, latencyMs: $latencyMs, packetLossPercent: $packetLossPercent, jitterMs: $jitterMs, callQualityScore: $callQualityScore, videoQuality: $videoQuality, audioSettings: $audioSettings)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallState'))
      ..add(DiagnosticsProperty('currentCall', currentCall))
      ..add(DiagnosticsProperty('isInitiating', isInitiating))
      ..add(DiagnosticsProperty('isRinging', isRinging))
      ..add(DiagnosticsProperty('isConnected', isConnected))
      ..add(DiagnosticsProperty('isIncoming', isIncoming))
      ..add(DiagnosticsProperty('isMuted', isMuted))
      ..add(DiagnosticsProperty('isVideoEnabled', isVideoEnabled))
      ..add(DiagnosticsProperty('isSpeakerOn', isSpeakerOn))
      ..add(DiagnosticsProperty('localStream', localStream))
      ..add(DiagnosticsProperty('remoteStream', remoteStream))
      ..add(DiagnosticsProperty('callDuration', callDuration))
      ..add(DiagnosticsProperty('errorMessage', errorMessage))
      ..add(DiagnosticsProperty('latencyMs', latencyMs))
      ..add(DiagnosticsProperty('packetLossPercent', packetLossPercent))
      ..add(DiagnosticsProperty('jitterMs', jitterMs))
      ..add(DiagnosticsProperty('callQualityScore', callQualityScore))
      ..add(DiagnosticsProperty('videoQuality', videoQuality))
      ..add(DiagnosticsProperty('audioSettings', audioSettings));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallStateImpl &&
            (identical(other.currentCall, currentCall) ||
                other.currentCall == currentCall) &&
            (identical(other.isInitiating, isInitiating) ||
                other.isInitiating == isInitiating) &&
            (identical(other.isRinging, isRinging) ||
                other.isRinging == isRinging) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.isIncoming, isIncoming) ||
                other.isIncoming == isIncoming) &&
            (identical(other.isMuted, isMuted) || other.isMuted == isMuted) &&
            (identical(other.isVideoEnabled, isVideoEnabled) ||
                other.isVideoEnabled == isVideoEnabled) &&
            (identical(other.isSpeakerOn, isSpeakerOn) ||
                other.isSpeakerOn == isSpeakerOn) &&
            (identical(other.localStream, localStream) ||
                other.localStream == localStream) &&
            (identical(other.remoteStream, remoteStream) ||
                other.remoteStream == remoteStream) &&
            (identical(other.callDuration, callDuration) ||
                other.callDuration == callDuration) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.latencyMs, latencyMs) ||
                other.latencyMs == latencyMs) &&
            (identical(other.packetLossPercent, packetLossPercent) ||
                other.packetLossPercent == packetLossPercent) &&
            (identical(other.jitterMs, jitterMs) ||
                other.jitterMs == jitterMs) &&
            (identical(other.callQualityScore, callQualityScore) ||
                other.callQualityScore == callQualityScore) &&
            (identical(other.videoQuality, videoQuality) ||
                other.videoQuality == videoQuality) &&
            (identical(other.audioSettings, audioSettings) ||
                other.audioSettings == audioSettings));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentCall,
      isInitiating,
      isRinging,
      isConnected,
      isIncoming,
      isMuted,
      isVideoEnabled,
      isSpeakerOn,
      localStream,
      remoteStream,
      callDuration,
      errorMessage,
      latencyMs,
      packetLossPercent,
      jitterMs,
      callQualityScore,
      videoQuality,
      audioSettings);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CallStateImplCopyWith<_$CallStateImpl> get copyWith =>
      __$$CallStateImplCopyWithImpl<_$CallStateImpl>(this, _$identity);
}

abstract class _CallState implements CallState {
  const factory _CallState(
      {final CallEntity? currentCall,
      final bool isInitiating,
      final bool isRinging,
      final bool isConnected,
      final bool isIncoming,
      final bool isMuted,
      final bool isVideoEnabled,
      final bool isSpeakerOn,
      final MediaStream? localStream,
      final MediaStream? remoteStream,
      final int callDuration,
      final String? errorMessage,
      final int? latencyMs,
      final double? packetLossPercent,
      final int? jitterMs,
      final int callQualityScore,
      final VideoQuality videoQuality,
      final AudioSettings audioSettings}) = _$CallStateImpl;

  @override
  CallEntity? get currentCall;
  @override
  bool get isInitiating;
  @override
  bool get isRinging;
  @override
  bool get isConnected;
  @override
  bool get isIncoming;
  @override
  bool get isMuted;
  @override
  bool get isVideoEnabled;
  @override
  bool get isSpeakerOn;
  @override
  MediaStream? get localStream;
  @override
  MediaStream? get remoteStream;
  @override
  int get callDuration;
  @override
  String? get errorMessage;
  @override // Call quality stats
  int? get latencyMs;
  @override
  double? get packetLossPercent;
  @override
  int? get jitterMs;
  @override
  int get callQualityScore;
  @override // 0-100
  VideoQuality get videoQuality;
  @override
  AudioSettings get audioSettings;
  @override
  @JsonKey(ignore: true)
  _$$CallStateImplCopyWith<_$CallStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
