// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MessageEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String chatId, String text, String? replyTo)
        sendMessage,
    required TResult Function(String chatId, File file, String type,
            File? thumbnail, String? replyTo)
        sendAttachment,
    required TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)
        sendVoiceMessage,
    required TResult Function(String chatId) markAsRead,
    required TResult Function(String messageId, String newText) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(
            String messageId, String originalText, List<String> targetChatIds)
        forwardMessage,
    required TResult Function(String messageId, String emoji) reactToMessage,
    required TResult Function(String chatId, String query) searchMessages,
    required TResult Function(String messageId) pinMessage,
    required TResult Function(String messageId) unpinMessage,
    required TResult Function(String messageId) retryMessage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult? Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult? Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult? Function(String chatId)? markAsRead,
    TResult? Function(String messageId, String newText)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult? Function(String messageId, String emoji)? reactToMessage,
    TResult? Function(String chatId, String query)? searchMessages,
    TResult? Function(String messageId)? pinMessage,
    TResult? Function(String messageId)? unpinMessage,
    TResult? Function(String messageId)? retryMessage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult Function(String chatId)? markAsRead,
    TResult Function(String messageId, String newText)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult Function(String messageId, String emoji)? reactToMessage,
    TResult Function(String chatId, String query)? searchMessages,
    TResult Function(String messageId)? pinMessage,
    TResult Function(String messageId)? unpinMessage,
    TResult Function(String messageId)? retryMessage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_SendMessage value) sendMessage,
    required TResult Function(_SendAttachment value) sendAttachment,
    required TResult Function(_SendVoiceMessage value) sendVoiceMessage,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_EditMessage value) editMessage,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ReactToMessage value) reactToMessage,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_PinMessage value) pinMessage,
    required TResult Function(_UnpinMessage value) unpinMessage,
    required TResult Function(_RetryMessage value) retryMessage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_SendMessage value)? sendMessage,
    TResult? Function(_SendAttachment value)? sendAttachment,
    TResult? Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_EditMessage value)? editMessage,
    TResult? Function(_DeleteMessage value)? deleteMessage,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ReactToMessage value)? reactToMessage,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_PinMessage value)? pinMessage,
    TResult? Function(_UnpinMessage value)? unpinMessage,
    TResult? Function(_RetryMessage value)? retryMessage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_SendMessage value)? sendMessage,
    TResult Function(_SendAttachment value)? sendAttachment,
    TResult Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_EditMessage value)? editMessage,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ReactToMessage value)? reactToMessage,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_PinMessage value)? pinMessage,
    TResult Function(_UnpinMessage value)? unpinMessage,
    TResult Function(_RetryMessage value)? retryMessage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageEventCopyWith<$Res> {
  factory $MessageEventCopyWith(
          MessageEvent value, $Res Function(MessageEvent) then) =
      _$MessageEventCopyWithImpl<$Res, MessageEvent>;
}

/// @nodoc
class _$MessageEventCopyWithImpl<$Res, $Val extends MessageEvent>
    implements $MessageEventCopyWith<$Res> {
  _$MessageEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadMessagesImplCopyWith<$Res> {
  factory _$$LoadMessagesImplCopyWith(
          _$LoadMessagesImpl value, $Res Function(_$LoadMessagesImpl) then) =
      __$$LoadMessagesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String chatId});
}

/// @nodoc
class __$$LoadMessagesImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$LoadMessagesImpl>
    implements _$$LoadMessagesImplCopyWith<$Res> {
  __$$LoadMessagesImplCopyWithImpl(
      _$LoadMessagesImpl _value, $Res Function(_$LoadMessagesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
  }) {
    return _then(_$LoadMessagesImpl(
      null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadMessagesImpl with DiagnosticableTreeMixin implements _LoadMessages {
  const _$LoadMessagesImpl(this.chatId);

  @override
  final String chatId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageEvent.loadMessages(chatId: $chatId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MessageEvent.loadMessages'))
      ..add(DiagnosticsProperty('chatId', chatId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadMessagesImpl &&
            (identical(other.chatId, chatId) || other.chatId == chatId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, chatId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadMessagesImplCopyWith<_$LoadMessagesImpl> get copyWith =>
      __$$LoadMessagesImplCopyWithImpl<_$LoadMessagesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String chatId, String text, String? replyTo)
        sendMessage,
    required TResult Function(String chatId, File file, String type,
            File? thumbnail, String? replyTo)
        sendAttachment,
    required TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)
        sendVoiceMessage,
    required TResult Function(String chatId) markAsRead,
    required TResult Function(String messageId, String newText) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(
            String messageId, String originalText, List<String> targetChatIds)
        forwardMessage,
    required TResult Function(String messageId, String emoji) reactToMessage,
    required TResult Function(String chatId, String query) searchMessages,
    required TResult Function(String messageId) pinMessage,
    required TResult Function(String messageId) unpinMessage,
    required TResult Function(String messageId) retryMessage,
  }) {
    return loadMessages(chatId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult? Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult? Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult? Function(String chatId)? markAsRead,
    TResult? Function(String messageId, String newText)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult? Function(String messageId, String emoji)? reactToMessage,
    TResult? Function(String chatId, String query)? searchMessages,
    TResult? Function(String messageId)? pinMessage,
    TResult? Function(String messageId)? unpinMessage,
    TResult? Function(String messageId)? retryMessage,
  }) {
    return loadMessages?.call(chatId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult Function(String chatId)? markAsRead,
    TResult Function(String messageId, String newText)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult Function(String messageId, String emoji)? reactToMessage,
    TResult Function(String chatId, String query)? searchMessages,
    TResult Function(String messageId)? pinMessage,
    TResult Function(String messageId)? unpinMessage,
    TResult Function(String messageId)? retryMessage,
    required TResult orElse(),
  }) {
    if (loadMessages != null) {
      return loadMessages(chatId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_SendMessage value) sendMessage,
    required TResult Function(_SendAttachment value) sendAttachment,
    required TResult Function(_SendVoiceMessage value) sendVoiceMessage,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_EditMessage value) editMessage,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ReactToMessage value) reactToMessage,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_PinMessage value) pinMessage,
    required TResult Function(_UnpinMessage value) unpinMessage,
    required TResult Function(_RetryMessage value) retryMessage,
  }) {
    return loadMessages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_SendMessage value)? sendMessage,
    TResult? Function(_SendAttachment value)? sendAttachment,
    TResult? Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_EditMessage value)? editMessage,
    TResult? Function(_DeleteMessage value)? deleteMessage,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ReactToMessage value)? reactToMessage,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_PinMessage value)? pinMessage,
    TResult? Function(_UnpinMessage value)? unpinMessage,
    TResult? Function(_RetryMessage value)? retryMessage,
  }) {
    return loadMessages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_SendMessage value)? sendMessage,
    TResult Function(_SendAttachment value)? sendAttachment,
    TResult Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_EditMessage value)? editMessage,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ReactToMessage value)? reactToMessage,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_PinMessage value)? pinMessage,
    TResult Function(_UnpinMessage value)? unpinMessage,
    TResult Function(_RetryMessage value)? retryMessage,
    required TResult orElse(),
  }) {
    if (loadMessages != null) {
      return loadMessages(this);
    }
    return orElse();
  }
}

abstract class _LoadMessages implements MessageEvent {
  const factory _LoadMessages(final String chatId) = _$LoadMessagesImpl;

  String get chatId;
  @JsonKey(ignore: true)
  _$$LoadMessagesImplCopyWith<_$LoadMessagesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendMessageImplCopyWith<$Res> {
  factory _$$SendMessageImplCopyWith(
          _$SendMessageImpl value, $Res Function(_$SendMessageImpl) then) =
      __$$SendMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String chatId, String text, String? replyTo});
}

/// @nodoc
class __$$SendMessageImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$SendMessageImpl>
    implements _$$SendMessageImplCopyWith<$Res> {
  __$$SendMessageImplCopyWithImpl(
      _$SendMessageImpl _value, $Res Function(_$SendMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
    Object? text = null,
    Object? replyTo = freezed,
  }) {
    return _then(_$SendMessageImpl(
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      replyTo: freezed == replyTo
          ? _value.replyTo
          : replyTo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SendMessageImpl with DiagnosticableTreeMixin implements _SendMessage {
  const _$SendMessageImpl(
      {required this.chatId, required this.text, this.replyTo});

  @override
  final String chatId;
  @override
  final String text;
  @override
  final String? replyTo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageEvent.sendMessage(chatId: $chatId, text: $text, replyTo: $replyTo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MessageEvent.sendMessage'))
      ..add(DiagnosticsProperty('chatId', chatId))
      ..add(DiagnosticsProperty('text', text))
      ..add(DiagnosticsProperty('replyTo', replyTo));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendMessageImpl &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.replyTo, replyTo) || other.replyTo == replyTo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, chatId, text, replyTo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendMessageImplCopyWith<_$SendMessageImpl> get copyWith =>
      __$$SendMessageImplCopyWithImpl<_$SendMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String chatId, String text, String? replyTo)
        sendMessage,
    required TResult Function(String chatId, File file, String type,
            File? thumbnail, String? replyTo)
        sendAttachment,
    required TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)
        sendVoiceMessage,
    required TResult Function(String chatId) markAsRead,
    required TResult Function(String messageId, String newText) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(
            String messageId, String originalText, List<String> targetChatIds)
        forwardMessage,
    required TResult Function(String messageId, String emoji) reactToMessage,
    required TResult Function(String chatId, String query) searchMessages,
    required TResult Function(String messageId) pinMessage,
    required TResult Function(String messageId) unpinMessage,
    required TResult Function(String messageId) retryMessage,
  }) {
    return sendMessage(chatId, text, replyTo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult? Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult? Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult? Function(String chatId)? markAsRead,
    TResult? Function(String messageId, String newText)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult? Function(String messageId, String emoji)? reactToMessage,
    TResult? Function(String chatId, String query)? searchMessages,
    TResult? Function(String messageId)? pinMessage,
    TResult? Function(String messageId)? unpinMessage,
    TResult? Function(String messageId)? retryMessage,
  }) {
    return sendMessage?.call(chatId, text, replyTo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult Function(String chatId)? markAsRead,
    TResult Function(String messageId, String newText)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult Function(String messageId, String emoji)? reactToMessage,
    TResult Function(String chatId, String query)? searchMessages,
    TResult Function(String messageId)? pinMessage,
    TResult Function(String messageId)? unpinMessage,
    TResult Function(String messageId)? retryMessage,
    required TResult orElse(),
  }) {
    if (sendMessage != null) {
      return sendMessage(chatId, text, replyTo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_SendMessage value) sendMessage,
    required TResult Function(_SendAttachment value) sendAttachment,
    required TResult Function(_SendVoiceMessage value) sendVoiceMessage,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_EditMessage value) editMessage,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ReactToMessage value) reactToMessage,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_PinMessage value) pinMessage,
    required TResult Function(_UnpinMessage value) unpinMessage,
    required TResult Function(_RetryMessage value) retryMessage,
  }) {
    return sendMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_SendMessage value)? sendMessage,
    TResult? Function(_SendAttachment value)? sendAttachment,
    TResult? Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_EditMessage value)? editMessage,
    TResult? Function(_DeleteMessage value)? deleteMessage,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ReactToMessage value)? reactToMessage,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_PinMessage value)? pinMessage,
    TResult? Function(_UnpinMessage value)? unpinMessage,
    TResult? Function(_RetryMessage value)? retryMessage,
  }) {
    return sendMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_SendMessage value)? sendMessage,
    TResult Function(_SendAttachment value)? sendAttachment,
    TResult Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_EditMessage value)? editMessage,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ReactToMessage value)? reactToMessage,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_PinMessage value)? pinMessage,
    TResult Function(_UnpinMessage value)? unpinMessage,
    TResult Function(_RetryMessage value)? retryMessage,
    required TResult orElse(),
  }) {
    if (sendMessage != null) {
      return sendMessage(this);
    }
    return orElse();
  }
}

abstract class _SendMessage implements MessageEvent {
  const factory _SendMessage(
      {required final String chatId,
      required final String text,
      final String? replyTo}) = _$SendMessageImpl;

  String get chatId;
  String get text;
  String? get replyTo;
  @JsonKey(ignore: true)
  _$$SendMessageImplCopyWith<_$SendMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendAttachmentImplCopyWith<$Res> {
  factory _$$SendAttachmentImplCopyWith(_$SendAttachmentImpl value,
          $Res Function(_$SendAttachmentImpl) then) =
      __$$SendAttachmentImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String chatId,
      File file,
      String type,
      File? thumbnail,
      String? replyTo});
}

/// @nodoc
class __$$SendAttachmentImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$SendAttachmentImpl>
    implements _$$SendAttachmentImplCopyWith<$Res> {
  __$$SendAttachmentImplCopyWithImpl(
      _$SendAttachmentImpl _value, $Res Function(_$SendAttachmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
    Object? file = null,
    Object? type = null,
    Object? thumbnail = freezed,
    Object? replyTo = freezed,
  }) {
    return _then(_$SendAttachmentImpl(
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as File?,
      replyTo: freezed == replyTo
          ? _value.replyTo
          : replyTo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SendAttachmentImpl
    with DiagnosticableTreeMixin
    implements _SendAttachment {
  const _$SendAttachmentImpl(
      {required this.chatId,
      required this.file,
      required this.type,
      this.thumbnail,
      this.replyTo});

  @override
  final String chatId;
  @override
  final File file;
  @override
  final String type;
  @override
  final File? thumbnail;
  @override
  final String? replyTo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageEvent.sendAttachment(chatId: $chatId, file: $file, type: $type, thumbnail: $thumbnail, replyTo: $replyTo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MessageEvent.sendAttachment'))
      ..add(DiagnosticsProperty('chatId', chatId))
      ..add(DiagnosticsProperty('file', file))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('thumbnail', thumbnail))
      ..add(DiagnosticsProperty('replyTo', replyTo));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendAttachmentImpl &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.file, file) || other.file == file) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.replyTo, replyTo) || other.replyTo == replyTo));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, chatId, file, type, thumbnail, replyTo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendAttachmentImplCopyWith<_$SendAttachmentImpl> get copyWith =>
      __$$SendAttachmentImplCopyWithImpl<_$SendAttachmentImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String chatId, String text, String? replyTo)
        sendMessage,
    required TResult Function(String chatId, File file, String type,
            File? thumbnail, String? replyTo)
        sendAttachment,
    required TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)
        sendVoiceMessage,
    required TResult Function(String chatId) markAsRead,
    required TResult Function(String messageId, String newText) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(
            String messageId, String originalText, List<String> targetChatIds)
        forwardMessage,
    required TResult Function(String messageId, String emoji) reactToMessage,
    required TResult Function(String chatId, String query) searchMessages,
    required TResult Function(String messageId) pinMessage,
    required TResult Function(String messageId) unpinMessage,
    required TResult Function(String messageId) retryMessage,
  }) {
    return sendAttachment(chatId, file, type, thumbnail, replyTo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult? Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult? Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult? Function(String chatId)? markAsRead,
    TResult? Function(String messageId, String newText)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult? Function(String messageId, String emoji)? reactToMessage,
    TResult? Function(String chatId, String query)? searchMessages,
    TResult? Function(String messageId)? pinMessage,
    TResult? Function(String messageId)? unpinMessage,
    TResult? Function(String messageId)? retryMessage,
  }) {
    return sendAttachment?.call(chatId, file, type, thumbnail, replyTo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult Function(String chatId)? markAsRead,
    TResult Function(String messageId, String newText)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult Function(String messageId, String emoji)? reactToMessage,
    TResult Function(String chatId, String query)? searchMessages,
    TResult Function(String messageId)? pinMessage,
    TResult Function(String messageId)? unpinMessage,
    TResult Function(String messageId)? retryMessage,
    required TResult orElse(),
  }) {
    if (sendAttachment != null) {
      return sendAttachment(chatId, file, type, thumbnail, replyTo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_SendMessage value) sendMessage,
    required TResult Function(_SendAttachment value) sendAttachment,
    required TResult Function(_SendVoiceMessage value) sendVoiceMessage,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_EditMessage value) editMessage,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ReactToMessage value) reactToMessage,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_PinMessage value) pinMessage,
    required TResult Function(_UnpinMessage value) unpinMessage,
    required TResult Function(_RetryMessage value) retryMessage,
  }) {
    return sendAttachment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_SendMessage value)? sendMessage,
    TResult? Function(_SendAttachment value)? sendAttachment,
    TResult? Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_EditMessage value)? editMessage,
    TResult? Function(_DeleteMessage value)? deleteMessage,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ReactToMessage value)? reactToMessage,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_PinMessage value)? pinMessage,
    TResult? Function(_UnpinMessage value)? unpinMessage,
    TResult? Function(_RetryMessage value)? retryMessage,
  }) {
    return sendAttachment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_SendMessage value)? sendMessage,
    TResult Function(_SendAttachment value)? sendAttachment,
    TResult Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_EditMessage value)? editMessage,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ReactToMessage value)? reactToMessage,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_PinMessage value)? pinMessage,
    TResult Function(_UnpinMessage value)? unpinMessage,
    TResult Function(_RetryMessage value)? retryMessage,
    required TResult orElse(),
  }) {
    if (sendAttachment != null) {
      return sendAttachment(this);
    }
    return orElse();
  }
}

abstract class _SendAttachment implements MessageEvent {
  const factory _SendAttachment(
      {required final String chatId,
      required final File file,
      required final String type,
      final File? thumbnail,
      final String? replyTo}) = _$SendAttachmentImpl;

  String get chatId;
  File get file;
  String get type;
  File? get thumbnail;
  String? get replyTo;
  @JsonKey(ignore: true)
  _$$SendAttachmentImplCopyWith<_$SendAttachmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendVoiceMessageImplCopyWith<$Res> {
  factory _$$SendVoiceMessageImplCopyWith(_$SendVoiceMessageImpl value,
          $Res Function(_$SendVoiceMessageImpl) then) =
      __$$SendVoiceMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String chatId, File audioFile, int duration, List<double> waveform});
}

/// @nodoc
class __$$SendVoiceMessageImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$SendVoiceMessageImpl>
    implements _$$SendVoiceMessageImplCopyWith<$Res> {
  __$$SendVoiceMessageImplCopyWithImpl(_$SendVoiceMessageImpl _value,
      $Res Function(_$SendVoiceMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
    Object? audioFile = null,
    Object? duration = null,
    Object? waveform = null,
  }) {
    return _then(_$SendVoiceMessageImpl(
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      audioFile: null == audioFile
          ? _value.audioFile
          : audioFile // ignore: cast_nullable_to_non_nullable
              as File,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      waveform: null == waveform
          ? _value._waveform
          : waveform // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc

class _$SendVoiceMessageImpl
    with DiagnosticableTreeMixin
    implements _SendVoiceMessage {
  const _$SendVoiceMessageImpl(
      {required this.chatId,
      required this.audioFile,
      required this.duration,
      required final List<double> waveform})
      : _waveform = waveform;

  @override
  final String chatId;
  @override
  final File audioFile;
  @override
  final int duration;
  final List<double> _waveform;
  @override
  List<double> get waveform {
    if (_waveform is EqualUnmodifiableListView) return _waveform;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_waveform);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageEvent.sendVoiceMessage(chatId: $chatId, audioFile: $audioFile, duration: $duration, waveform: $waveform)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MessageEvent.sendVoiceMessage'))
      ..add(DiagnosticsProperty('chatId', chatId))
      ..add(DiagnosticsProperty('audioFile', audioFile))
      ..add(DiagnosticsProperty('duration', duration))
      ..add(DiagnosticsProperty('waveform', waveform));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendVoiceMessageImpl &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.audioFile, audioFile) ||
                other.audioFile == audioFile) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality().equals(other._waveform, _waveform));
  }

  @override
  int get hashCode => Object.hash(runtimeType, chatId, audioFile, duration,
      const DeepCollectionEquality().hash(_waveform));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendVoiceMessageImplCopyWith<_$SendVoiceMessageImpl> get copyWith =>
      __$$SendVoiceMessageImplCopyWithImpl<_$SendVoiceMessageImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String chatId, String text, String? replyTo)
        sendMessage,
    required TResult Function(String chatId, File file, String type,
            File? thumbnail, String? replyTo)
        sendAttachment,
    required TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)
        sendVoiceMessage,
    required TResult Function(String chatId) markAsRead,
    required TResult Function(String messageId, String newText) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(
            String messageId, String originalText, List<String> targetChatIds)
        forwardMessage,
    required TResult Function(String messageId, String emoji) reactToMessage,
    required TResult Function(String chatId, String query) searchMessages,
    required TResult Function(String messageId) pinMessage,
    required TResult Function(String messageId) unpinMessage,
    required TResult Function(String messageId) retryMessage,
  }) {
    return sendVoiceMessage(chatId, audioFile, duration, waveform);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult? Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult? Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult? Function(String chatId)? markAsRead,
    TResult? Function(String messageId, String newText)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult? Function(String messageId, String emoji)? reactToMessage,
    TResult? Function(String chatId, String query)? searchMessages,
    TResult? Function(String messageId)? pinMessage,
    TResult? Function(String messageId)? unpinMessage,
    TResult? Function(String messageId)? retryMessage,
  }) {
    return sendVoiceMessage?.call(chatId, audioFile, duration, waveform);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult Function(String chatId)? markAsRead,
    TResult Function(String messageId, String newText)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult Function(String messageId, String emoji)? reactToMessage,
    TResult Function(String chatId, String query)? searchMessages,
    TResult Function(String messageId)? pinMessage,
    TResult Function(String messageId)? unpinMessage,
    TResult Function(String messageId)? retryMessage,
    required TResult orElse(),
  }) {
    if (sendVoiceMessage != null) {
      return sendVoiceMessage(chatId, audioFile, duration, waveform);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_SendMessage value) sendMessage,
    required TResult Function(_SendAttachment value) sendAttachment,
    required TResult Function(_SendVoiceMessage value) sendVoiceMessage,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_EditMessage value) editMessage,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ReactToMessage value) reactToMessage,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_PinMessage value) pinMessage,
    required TResult Function(_UnpinMessage value) unpinMessage,
    required TResult Function(_RetryMessage value) retryMessage,
  }) {
    return sendVoiceMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_SendMessage value)? sendMessage,
    TResult? Function(_SendAttachment value)? sendAttachment,
    TResult? Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_EditMessage value)? editMessage,
    TResult? Function(_DeleteMessage value)? deleteMessage,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ReactToMessage value)? reactToMessage,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_PinMessage value)? pinMessage,
    TResult? Function(_UnpinMessage value)? unpinMessage,
    TResult? Function(_RetryMessage value)? retryMessage,
  }) {
    return sendVoiceMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_SendMessage value)? sendMessage,
    TResult Function(_SendAttachment value)? sendAttachment,
    TResult Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_EditMessage value)? editMessage,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ReactToMessage value)? reactToMessage,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_PinMessage value)? pinMessage,
    TResult Function(_UnpinMessage value)? unpinMessage,
    TResult Function(_RetryMessage value)? retryMessage,
    required TResult orElse(),
  }) {
    if (sendVoiceMessage != null) {
      return sendVoiceMessage(this);
    }
    return orElse();
  }
}

abstract class _SendVoiceMessage implements MessageEvent {
  const factory _SendVoiceMessage(
      {required final String chatId,
      required final File audioFile,
      required final int duration,
      required final List<double> waveform}) = _$SendVoiceMessageImpl;

  String get chatId;
  File get audioFile;
  int get duration;
  List<double> get waveform;
  @JsonKey(ignore: true)
  _$$SendVoiceMessageImplCopyWith<_$SendVoiceMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MarkAsReadImplCopyWith<$Res> {
  factory _$$MarkAsReadImplCopyWith(
          _$MarkAsReadImpl value, $Res Function(_$MarkAsReadImpl) then) =
      __$$MarkAsReadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String chatId});
}

/// @nodoc
class __$$MarkAsReadImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$MarkAsReadImpl>
    implements _$$MarkAsReadImplCopyWith<$Res> {
  __$$MarkAsReadImplCopyWithImpl(
      _$MarkAsReadImpl _value, $Res Function(_$MarkAsReadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
  }) {
    return _then(_$MarkAsReadImpl(
      null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MarkAsReadImpl with DiagnosticableTreeMixin implements _MarkAsRead {
  const _$MarkAsReadImpl(this.chatId);

  @override
  final String chatId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageEvent.markAsRead(chatId: $chatId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MessageEvent.markAsRead'))
      ..add(DiagnosticsProperty('chatId', chatId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkAsReadImpl &&
            (identical(other.chatId, chatId) || other.chatId == chatId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, chatId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkAsReadImplCopyWith<_$MarkAsReadImpl> get copyWith =>
      __$$MarkAsReadImplCopyWithImpl<_$MarkAsReadImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String chatId, String text, String? replyTo)
        sendMessage,
    required TResult Function(String chatId, File file, String type,
            File? thumbnail, String? replyTo)
        sendAttachment,
    required TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)
        sendVoiceMessage,
    required TResult Function(String chatId) markAsRead,
    required TResult Function(String messageId, String newText) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(
            String messageId, String originalText, List<String> targetChatIds)
        forwardMessage,
    required TResult Function(String messageId, String emoji) reactToMessage,
    required TResult Function(String chatId, String query) searchMessages,
    required TResult Function(String messageId) pinMessage,
    required TResult Function(String messageId) unpinMessage,
    required TResult Function(String messageId) retryMessage,
  }) {
    return markAsRead(chatId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult? Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult? Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult? Function(String chatId)? markAsRead,
    TResult? Function(String messageId, String newText)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult? Function(String messageId, String emoji)? reactToMessage,
    TResult? Function(String chatId, String query)? searchMessages,
    TResult? Function(String messageId)? pinMessage,
    TResult? Function(String messageId)? unpinMessage,
    TResult? Function(String messageId)? retryMessage,
  }) {
    return markAsRead?.call(chatId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult Function(String chatId)? markAsRead,
    TResult Function(String messageId, String newText)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult Function(String messageId, String emoji)? reactToMessage,
    TResult Function(String chatId, String query)? searchMessages,
    TResult Function(String messageId)? pinMessage,
    TResult Function(String messageId)? unpinMessage,
    TResult Function(String messageId)? retryMessage,
    required TResult orElse(),
  }) {
    if (markAsRead != null) {
      return markAsRead(chatId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_SendMessage value) sendMessage,
    required TResult Function(_SendAttachment value) sendAttachment,
    required TResult Function(_SendVoiceMessage value) sendVoiceMessage,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_EditMessage value) editMessage,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ReactToMessage value) reactToMessage,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_PinMessage value) pinMessage,
    required TResult Function(_UnpinMessage value) unpinMessage,
    required TResult Function(_RetryMessage value) retryMessage,
  }) {
    return markAsRead(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_SendMessage value)? sendMessage,
    TResult? Function(_SendAttachment value)? sendAttachment,
    TResult? Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_EditMessage value)? editMessage,
    TResult? Function(_DeleteMessage value)? deleteMessage,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ReactToMessage value)? reactToMessage,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_PinMessage value)? pinMessage,
    TResult? Function(_UnpinMessage value)? unpinMessage,
    TResult? Function(_RetryMessage value)? retryMessage,
  }) {
    return markAsRead?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_SendMessage value)? sendMessage,
    TResult Function(_SendAttachment value)? sendAttachment,
    TResult Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_EditMessage value)? editMessage,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ReactToMessage value)? reactToMessage,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_PinMessage value)? pinMessage,
    TResult Function(_UnpinMessage value)? unpinMessage,
    TResult Function(_RetryMessage value)? retryMessage,
    required TResult orElse(),
  }) {
    if (markAsRead != null) {
      return markAsRead(this);
    }
    return orElse();
  }
}

abstract class _MarkAsRead implements MessageEvent {
  const factory _MarkAsRead(final String chatId) = _$MarkAsReadImpl;

  String get chatId;
  @JsonKey(ignore: true)
  _$$MarkAsReadImplCopyWith<_$MarkAsReadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditMessageImplCopyWith<$Res> {
  factory _$$EditMessageImplCopyWith(
          _$EditMessageImpl value, $Res Function(_$EditMessageImpl) then) =
      __$$EditMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageId, String newText});
}

/// @nodoc
class __$$EditMessageImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$EditMessageImpl>
    implements _$$EditMessageImplCopyWith<$Res> {
  __$$EditMessageImplCopyWithImpl(
      _$EditMessageImpl _value, $Res Function(_$EditMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? newText = null,
  }) {
    return _then(_$EditMessageImpl(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      newText: null == newText
          ? _value.newText
          : newText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EditMessageImpl with DiagnosticableTreeMixin implements _EditMessage {
  const _$EditMessageImpl({required this.messageId, required this.newText});

  @override
  final String messageId;
  @override
  final String newText;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageEvent.editMessage(messageId: $messageId, newText: $newText)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MessageEvent.editMessage'))
      ..add(DiagnosticsProperty('messageId', messageId))
      ..add(DiagnosticsProperty('newText', newText));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditMessageImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.newText, newText) || other.newText == newText));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId, newText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditMessageImplCopyWith<_$EditMessageImpl> get copyWith =>
      __$$EditMessageImplCopyWithImpl<_$EditMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String chatId, String text, String? replyTo)
        sendMessage,
    required TResult Function(String chatId, File file, String type,
            File? thumbnail, String? replyTo)
        sendAttachment,
    required TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)
        sendVoiceMessage,
    required TResult Function(String chatId) markAsRead,
    required TResult Function(String messageId, String newText) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(
            String messageId, String originalText, List<String> targetChatIds)
        forwardMessage,
    required TResult Function(String messageId, String emoji) reactToMessage,
    required TResult Function(String chatId, String query) searchMessages,
    required TResult Function(String messageId) pinMessage,
    required TResult Function(String messageId) unpinMessage,
    required TResult Function(String messageId) retryMessage,
  }) {
    return editMessage(messageId, newText);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult? Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult? Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult? Function(String chatId)? markAsRead,
    TResult? Function(String messageId, String newText)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult? Function(String messageId, String emoji)? reactToMessage,
    TResult? Function(String chatId, String query)? searchMessages,
    TResult? Function(String messageId)? pinMessage,
    TResult? Function(String messageId)? unpinMessage,
    TResult? Function(String messageId)? retryMessage,
  }) {
    return editMessage?.call(messageId, newText);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult Function(String chatId)? markAsRead,
    TResult Function(String messageId, String newText)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult Function(String messageId, String emoji)? reactToMessage,
    TResult Function(String chatId, String query)? searchMessages,
    TResult Function(String messageId)? pinMessage,
    TResult Function(String messageId)? unpinMessage,
    TResult Function(String messageId)? retryMessage,
    required TResult orElse(),
  }) {
    if (editMessage != null) {
      return editMessage(messageId, newText);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_SendMessage value) sendMessage,
    required TResult Function(_SendAttachment value) sendAttachment,
    required TResult Function(_SendVoiceMessage value) sendVoiceMessage,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_EditMessage value) editMessage,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ReactToMessage value) reactToMessage,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_PinMessage value) pinMessage,
    required TResult Function(_UnpinMessage value) unpinMessage,
    required TResult Function(_RetryMessage value) retryMessage,
  }) {
    return editMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_SendMessage value)? sendMessage,
    TResult? Function(_SendAttachment value)? sendAttachment,
    TResult? Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_EditMessage value)? editMessage,
    TResult? Function(_DeleteMessage value)? deleteMessage,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ReactToMessage value)? reactToMessage,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_PinMessage value)? pinMessage,
    TResult? Function(_UnpinMessage value)? unpinMessage,
    TResult? Function(_RetryMessage value)? retryMessage,
  }) {
    return editMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_SendMessage value)? sendMessage,
    TResult Function(_SendAttachment value)? sendAttachment,
    TResult Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_EditMessage value)? editMessage,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ReactToMessage value)? reactToMessage,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_PinMessage value)? pinMessage,
    TResult Function(_UnpinMessage value)? unpinMessage,
    TResult Function(_RetryMessage value)? retryMessage,
    required TResult orElse(),
  }) {
    if (editMessage != null) {
      return editMessage(this);
    }
    return orElse();
  }
}

abstract class _EditMessage implements MessageEvent {
  const factory _EditMessage(
      {required final String messageId,
      required final String newText}) = _$EditMessageImpl;

  String get messageId;
  String get newText;
  @JsonKey(ignore: true)
  _$$EditMessageImplCopyWith<_$EditMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteMessageImplCopyWith<$Res> {
  factory _$$DeleteMessageImplCopyWith(
          _$DeleteMessageImpl value, $Res Function(_$DeleteMessageImpl) then) =
      __$$DeleteMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageId, bool forEveryone});
}

/// @nodoc
class __$$DeleteMessageImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$DeleteMessageImpl>
    implements _$$DeleteMessageImplCopyWith<$Res> {
  __$$DeleteMessageImplCopyWithImpl(
      _$DeleteMessageImpl _value, $Res Function(_$DeleteMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? forEveryone = null,
  }) {
    return _then(_$DeleteMessageImpl(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      forEveryone: null == forEveryone
          ? _value.forEveryone
          : forEveryone // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$DeleteMessageImpl
    with DiagnosticableTreeMixin
    implements _DeleteMessage {
  const _$DeleteMessageImpl(
      {required this.messageId, this.forEveryone = false});

  @override
  final String messageId;
  @override
  @JsonKey()
  final bool forEveryone;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageEvent.deleteMessage(messageId: $messageId, forEveryone: $forEveryone)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MessageEvent.deleteMessage'))
      ..add(DiagnosticsProperty('messageId', messageId))
      ..add(DiagnosticsProperty('forEveryone', forEveryone));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteMessageImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.forEveryone, forEveryone) ||
                other.forEveryone == forEveryone));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId, forEveryone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteMessageImplCopyWith<_$DeleteMessageImpl> get copyWith =>
      __$$DeleteMessageImplCopyWithImpl<_$DeleteMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String chatId, String text, String? replyTo)
        sendMessage,
    required TResult Function(String chatId, File file, String type,
            File? thumbnail, String? replyTo)
        sendAttachment,
    required TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)
        sendVoiceMessage,
    required TResult Function(String chatId) markAsRead,
    required TResult Function(String messageId, String newText) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(
            String messageId, String originalText, List<String> targetChatIds)
        forwardMessage,
    required TResult Function(String messageId, String emoji) reactToMessage,
    required TResult Function(String chatId, String query) searchMessages,
    required TResult Function(String messageId) pinMessage,
    required TResult Function(String messageId) unpinMessage,
    required TResult Function(String messageId) retryMessage,
  }) {
    return deleteMessage(messageId, forEveryone);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult? Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult? Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult? Function(String chatId)? markAsRead,
    TResult? Function(String messageId, String newText)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult? Function(String messageId, String emoji)? reactToMessage,
    TResult? Function(String chatId, String query)? searchMessages,
    TResult? Function(String messageId)? pinMessage,
    TResult? Function(String messageId)? unpinMessage,
    TResult? Function(String messageId)? retryMessage,
  }) {
    return deleteMessage?.call(messageId, forEveryone);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult Function(String chatId)? markAsRead,
    TResult Function(String messageId, String newText)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult Function(String messageId, String emoji)? reactToMessage,
    TResult Function(String chatId, String query)? searchMessages,
    TResult Function(String messageId)? pinMessage,
    TResult Function(String messageId)? unpinMessage,
    TResult Function(String messageId)? retryMessage,
    required TResult orElse(),
  }) {
    if (deleteMessage != null) {
      return deleteMessage(messageId, forEveryone);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_SendMessage value) sendMessage,
    required TResult Function(_SendAttachment value) sendAttachment,
    required TResult Function(_SendVoiceMessage value) sendVoiceMessage,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_EditMessage value) editMessage,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ReactToMessage value) reactToMessage,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_PinMessage value) pinMessage,
    required TResult Function(_UnpinMessage value) unpinMessage,
    required TResult Function(_RetryMessage value) retryMessage,
  }) {
    return deleteMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_SendMessage value)? sendMessage,
    TResult? Function(_SendAttachment value)? sendAttachment,
    TResult? Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_EditMessage value)? editMessage,
    TResult? Function(_DeleteMessage value)? deleteMessage,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ReactToMessage value)? reactToMessage,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_PinMessage value)? pinMessage,
    TResult? Function(_UnpinMessage value)? unpinMessage,
    TResult? Function(_RetryMessage value)? retryMessage,
  }) {
    return deleteMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_SendMessage value)? sendMessage,
    TResult Function(_SendAttachment value)? sendAttachment,
    TResult Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_EditMessage value)? editMessage,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ReactToMessage value)? reactToMessage,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_PinMessage value)? pinMessage,
    TResult Function(_UnpinMessage value)? unpinMessage,
    TResult Function(_RetryMessage value)? retryMessage,
    required TResult orElse(),
  }) {
    if (deleteMessage != null) {
      return deleteMessage(this);
    }
    return orElse();
  }
}

abstract class _DeleteMessage implements MessageEvent {
  const factory _DeleteMessage(
      {required final String messageId,
      final bool forEveryone}) = _$DeleteMessageImpl;

  String get messageId;
  bool get forEveryone;
  @JsonKey(ignore: true)
  _$$DeleteMessageImplCopyWith<_$DeleteMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ForwardMessageImplCopyWith<$Res> {
  factory _$$ForwardMessageImplCopyWith(_$ForwardMessageImpl value,
          $Res Function(_$ForwardMessageImpl) then) =
      __$$ForwardMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String messageId, String originalText, List<String> targetChatIds});
}

/// @nodoc
class __$$ForwardMessageImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$ForwardMessageImpl>
    implements _$$ForwardMessageImplCopyWith<$Res> {
  __$$ForwardMessageImplCopyWithImpl(
      _$ForwardMessageImpl _value, $Res Function(_$ForwardMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? originalText = null,
    Object? targetChatIds = null,
  }) {
    return _then(_$ForwardMessageImpl(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      originalText: null == originalText
          ? _value.originalText
          : originalText // ignore: cast_nullable_to_non_nullable
              as String,
      targetChatIds: null == targetChatIds
          ? _value._targetChatIds
          : targetChatIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$ForwardMessageImpl
    with DiagnosticableTreeMixin
    implements _ForwardMessage {
  const _$ForwardMessageImpl(
      {required this.messageId,
      required this.originalText,
      required final List<String> targetChatIds})
      : _targetChatIds = targetChatIds;

  @override
  final String messageId;
  @override
  final String originalText;
  final List<String> _targetChatIds;
  @override
  List<String> get targetChatIds {
    if (_targetChatIds is EqualUnmodifiableListView) return _targetChatIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_targetChatIds);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageEvent.forwardMessage(messageId: $messageId, originalText: $originalText, targetChatIds: $targetChatIds)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MessageEvent.forwardMessage'))
      ..add(DiagnosticsProperty('messageId', messageId))
      ..add(DiagnosticsProperty('originalText', originalText))
      ..add(DiagnosticsProperty('targetChatIds', targetChatIds));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForwardMessageImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.originalText, originalText) ||
                other.originalText == originalText) &&
            const DeepCollectionEquality()
                .equals(other._targetChatIds, _targetChatIds));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId, originalText,
      const DeepCollectionEquality().hash(_targetChatIds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ForwardMessageImplCopyWith<_$ForwardMessageImpl> get copyWith =>
      __$$ForwardMessageImplCopyWithImpl<_$ForwardMessageImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String chatId, String text, String? replyTo)
        sendMessage,
    required TResult Function(String chatId, File file, String type,
            File? thumbnail, String? replyTo)
        sendAttachment,
    required TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)
        sendVoiceMessage,
    required TResult Function(String chatId) markAsRead,
    required TResult Function(String messageId, String newText) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(
            String messageId, String originalText, List<String> targetChatIds)
        forwardMessage,
    required TResult Function(String messageId, String emoji) reactToMessage,
    required TResult Function(String chatId, String query) searchMessages,
    required TResult Function(String messageId) pinMessage,
    required TResult Function(String messageId) unpinMessage,
    required TResult Function(String messageId) retryMessage,
  }) {
    return forwardMessage(messageId, originalText, targetChatIds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult? Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult? Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult? Function(String chatId)? markAsRead,
    TResult? Function(String messageId, String newText)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult? Function(String messageId, String emoji)? reactToMessage,
    TResult? Function(String chatId, String query)? searchMessages,
    TResult? Function(String messageId)? pinMessage,
    TResult? Function(String messageId)? unpinMessage,
    TResult? Function(String messageId)? retryMessage,
  }) {
    return forwardMessage?.call(messageId, originalText, targetChatIds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult Function(String chatId)? markAsRead,
    TResult Function(String messageId, String newText)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult Function(String messageId, String emoji)? reactToMessage,
    TResult Function(String chatId, String query)? searchMessages,
    TResult Function(String messageId)? pinMessage,
    TResult Function(String messageId)? unpinMessage,
    TResult Function(String messageId)? retryMessage,
    required TResult orElse(),
  }) {
    if (forwardMessage != null) {
      return forwardMessage(messageId, originalText, targetChatIds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_SendMessage value) sendMessage,
    required TResult Function(_SendAttachment value) sendAttachment,
    required TResult Function(_SendVoiceMessage value) sendVoiceMessage,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_EditMessage value) editMessage,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ReactToMessage value) reactToMessage,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_PinMessage value) pinMessage,
    required TResult Function(_UnpinMessage value) unpinMessage,
    required TResult Function(_RetryMessage value) retryMessage,
  }) {
    return forwardMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_SendMessage value)? sendMessage,
    TResult? Function(_SendAttachment value)? sendAttachment,
    TResult? Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_EditMessage value)? editMessage,
    TResult? Function(_DeleteMessage value)? deleteMessage,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ReactToMessage value)? reactToMessage,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_PinMessage value)? pinMessage,
    TResult? Function(_UnpinMessage value)? unpinMessage,
    TResult? Function(_RetryMessage value)? retryMessage,
  }) {
    return forwardMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_SendMessage value)? sendMessage,
    TResult Function(_SendAttachment value)? sendAttachment,
    TResult Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_EditMessage value)? editMessage,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ReactToMessage value)? reactToMessage,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_PinMessage value)? pinMessage,
    TResult Function(_UnpinMessage value)? unpinMessage,
    TResult Function(_RetryMessage value)? retryMessage,
    required TResult orElse(),
  }) {
    if (forwardMessage != null) {
      return forwardMessage(this);
    }
    return orElse();
  }
}

abstract class _ForwardMessage implements MessageEvent {
  const factory _ForwardMessage(
      {required final String messageId,
      required final String originalText,
      required final List<String> targetChatIds}) = _$ForwardMessageImpl;

  String get messageId;
  String get originalText;
  List<String> get targetChatIds;
  @JsonKey(ignore: true)
  _$$ForwardMessageImplCopyWith<_$ForwardMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReactToMessageImplCopyWith<$Res> {
  factory _$$ReactToMessageImplCopyWith(_$ReactToMessageImpl value,
          $Res Function(_$ReactToMessageImpl) then) =
      __$$ReactToMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageId, String emoji});
}

/// @nodoc
class __$$ReactToMessageImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$ReactToMessageImpl>
    implements _$$ReactToMessageImplCopyWith<$Res> {
  __$$ReactToMessageImplCopyWithImpl(
      _$ReactToMessageImpl _value, $Res Function(_$ReactToMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? emoji = null,
  }) {
    return _then(_$ReactToMessageImpl(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      emoji: null == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ReactToMessageImpl
    with DiagnosticableTreeMixin
    implements _ReactToMessage {
  const _$ReactToMessageImpl({required this.messageId, required this.emoji});

  @override
  final String messageId;
  @override
  final String emoji;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageEvent.reactToMessage(messageId: $messageId, emoji: $emoji)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MessageEvent.reactToMessage'))
      ..add(DiagnosticsProperty('messageId', messageId))
      ..add(DiagnosticsProperty('emoji', emoji));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReactToMessageImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.emoji, emoji) || other.emoji == emoji));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId, emoji);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReactToMessageImplCopyWith<_$ReactToMessageImpl> get copyWith =>
      __$$ReactToMessageImplCopyWithImpl<_$ReactToMessageImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String chatId, String text, String? replyTo)
        sendMessage,
    required TResult Function(String chatId, File file, String type,
            File? thumbnail, String? replyTo)
        sendAttachment,
    required TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)
        sendVoiceMessage,
    required TResult Function(String chatId) markAsRead,
    required TResult Function(String messageId, String newText) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(
            String messageId, String originalText, List<String> targetChatIds)
        forwardMessage,
    required TResult Function(String messageId, String emoji) reactToMessage,
    required TResult Function(String chatId, String query) searchMessages,
    required TResult Function(String messageId) pinMessage,
    required TResult Function(String messageId) unpinMessage,
    required TResult Function(String messageId) retryMessage,
  }) {
    return reactToMessage(messageId, emoji);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult? Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult? Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult? Function(String chatId)? markAsRead,
    TResult? Function(String messageId, String newText)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult? Function(String messageId, String emoji)? reactToMessage,
    TResult? Function(String chatId, String query)? searchMessages,
    TResult? Function(String messageId)? pinMessage,
    TResult? Function(String messageId)? unpinMessage,
    TResult? Function(String messageId)? retryMessage,
  }) {
    return reactToMessage?.call(messageId, emoji);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult Function(String chatId)? markAsRead,
    TResult Function(String messageId, String newText)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult Function(String messageId, String emoji)? reactToMessage,
    TResult Function(String chatId, String query)? searchMessages,
    TResult Function(String messageId)? pinMessage,
    TResult Function(String messageId)? unpinMessage,
    TResult Function(String messageId)? retryMessage,
    required TResult orElse(),
  }) {
    if (reactToMessage != null) {
      return reactToMessage(messageId, emoji);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_SendMessage value) sendMessage,
    required TResult Function(_SendAttachment value) sendAttachment,
    required TResult Function(_SendVoiceMessage value) sendVoiceMessage,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_EditMessage value) editMessage,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ReactToMessage value) reactToMessage,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_PinMessage value) pinMessage,
    required TResult Function(_UnpinMessage value) unpinMessage,
    required TResult Function(_RetryMessage value) retryMessage,
  }) {
    return reactToMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_SendMessage value)? sendMessage,
    TResult? Function(_SendAttachment value)? sendAttachment,
    TResult? Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_EditMessage value)? editMessage,
    TResult? Function(_DeleteMessage value)? deleteMessage,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ReactToMessage value)? reactToMessage,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_PinMessage value)? pinMessage,
    TResult? Function(_UnpinMessage value)? unpinMessage,
    TResult? Function(_RetryMessage value)? retryMessage,
  }) {
    return reactToMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_SendMessage value)? sendMessage,
    TResult Function(_SendAttachment value)? sendAttachment,
    TResult Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_EditMessage value)? editMessage,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ReactToMessage value)? reactToMessage,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_PinMessage value)? pinMessage,
    TResult Function(_UnpinMessage value)? unpinMessage,
    TResult Function(_RetryMessage value)? retryMessage,
    required TResult orElse(),
  }) {
    if (reactToMessage != null) {
      return reactToMessage(this);
    }
    return orElse();
  }
}

abstract class _ReactToMessage implements MessageEvent {
  const factory _ReactToMessage(
      {required final String messageId,
      required final String emoji}) = _$ReactToMessageImpl;

  String get messageId;
  String get emoji;
  @JsonKey(ignore: true)
  _$$ReactToMessageImplCopyWith<_$ReactToMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchMessagesImplCopyWith<$Res> {
  factory _$$SearchMessagesImplCopyWith(_$SearchMessagesImpl value,
          $Res Function(_$SearchMessagesImpl) then) =
      __$$SearchMessagesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String chatId, String query});
}

/// @nodoc
class __$$SearchMessagesImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$SearchMessagesImpl>
    implements _$$SearchMessagesImplCopyWith<$Res> {
  __$$SearchMessagesImplCopyWithImpl(
      _$SearchMessagesImpl _value, $Res Function(_$SearchMessagesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
    Object? query = null,
  }) {
    return _then(_$SearchMessagesImpl(
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchMessagesImpl
    with DiagnosticableTreeMixin
    implements _SearchMessages {
  const _$SearchMessagesImpl({required this.chatId, required this.query});

  @override
  final String chatId;
  @override
  final String query;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageEvent.searchMessages(chatId: $chatId, query: $query)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MessageEvent.searchMessages'))
      ..add(DiagnosticsProperty('chatId', chatId))
      ..add(DiagnosticsProperty('query', query));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchMessagesImpl &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, chatId, query);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchMessagesImplCopyWith<_$SearchMessagesImpl> get copyWith =>
      __$$SearchMessagesImplCopyWithImpl<_$SearchMessagesImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String chatId, String text, String? replyTo)
        sendMessage,
    required TResult Function(String chatId, File file, String type,
            File? thumbnail, String? replyTo)
        sendAttachment,
    required TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)
        sendVoiceMessage,
    required TResult Function(String chatId) markAsRead,
    required TResult Function(String messageId, String newText) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(
            String messageId, String originalText, List<String> targetChatIds)
        forwardMessage,
    required TResult Function(String messageId, String emoji) reactToMessage,
    required TResult Function(String chatId, String query) searchMessages,
    required TResult Function(String messageId) pinMessage,
    required TResult Function(String messageId) unpinMessage,
    required TResult Function(String messageId) retryMessage,
  }) {
    return searchMessages(chatId, query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult? Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult? Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult? Function(String chatId)? markAsRead,
    TResult? Function(String messageId, String newText)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult? Function(String messageId, String emoji)? reactToMessage,
    TResult? Function(String chatId, String query)? searchMessages,
    TResult? Function(String messageId)? pinMessage,
    TResult? Function(String messageId)? unpinMessage,
    TResult? Function(String messageId)? retryMessage,
  }) {
    return searchMessages?.call(chatId, query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult Function(String chatId)? markAsRead,
    TResult Function(String messageId, String newText)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult Function(String messageId, String emoji)? reactToMessage,
    TResult Function(String chatId, String query)? searchMessages,
    TResult Function(String messageId)? pinMessage,
    TResult Function(String messageId)? unpinMessage,
    TResult Function(String messageId)? retryMessage,
    required TResult orElse(),
  }) {
    if (searchMessages != null) {
      return searchMessages(chatId, query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_SendMessage value) sendMessage,
    required TResult Function(_SendAttachment value) sendAttachment,
    required TResult Function(_SendVoiceMessage value) sendVoiceMessage,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_EditMessage value) editMessage,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ReactToMessage value) reactToMessage,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_PinMessage value) pinMessage,
    required TResult Function(_UnpinMessage value) unpinMessage,
    required TResult Function(_RetryMessage value) retryMessage,
  }) {
    return searchMessages(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_SendMessage value)? sendMessage,
    TResult? Function(_SendAttachment value)? sendAttachment,
    TResult? Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_EditMessage value)? editMessage,
    TResult? Function(_DeleteMessage value)? deleteMessage,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ReactToMessage value)? reactToMessage,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_PinMessage value)? pinMessage,
    TResult? Function(_UnpinMessage value)? unpinMessage,
    TResult? Function(_RetryMessage value)? retryMessage,
  }) {
    return searchMessages?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_SendMessage value)? sendMessage,
    TResult Function(_SendAttachment value)? sendAttachment,
    TResult Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_EditMessage value)? editMessage,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ReactToMessage value)? reactToMessage,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_PinMessage value)? pinMessage,
    TResult Function(_UnpinMessage value)? unpinMessage,
    TResult Function(_RetryMessage value)? retryMessage,
    required TResult orElse(),
  }) {
    if (searchMessages != null) {
      return searchMessages(this);
    }
    return orElse();
  }
}

abstract class _SearchMessages implements MessageEvent {
  const factory _SearchMessages(
      {required final String chatId,
      required final String query}) = _$SearchMessagesImpl;

  String get chatId;
  String get query;
  @JsonKey(ignore: true)
  _$$SearchMessagesImplCopyWith<_$SearchMessagesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PinMessageImplCopyWith<$Res> {
  factory _$$PinMessageImplCopyWith(
          _$PinMessageImpl value, $Res Function(_$PinMessageImpl) then) =
      __$$PinMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageId});
}

/// @nodoc
class __$$PinMessageImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$PinMessageImpl>
    implements _$$PinMessageImplCopyWith<$Res> {
  __$$PinMessageImplCopyWithImpl(
      _$PinMessageImpl _value, $Res Function(_$PinMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
  }) {
    return _then(_$PinMessageImpl(
      null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PinMessageImpl with DiagnosticableTreeMixin implements _PinMessage {
  const _$PinMessageImpl(this.messageId);

  @override
  final String messageId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageEvent.pinMessage(messageId: $messageId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MessageEvent.pinMessage'))
      ..add(DiagnosticsProperty('messageId', messageId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PinMessageImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PinMessageImplCopyWith<_$PinMessageImpl> get copyWith =>
      __$$PinMessageImplCopyWithImpl<_$PinMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String chatId, String text, String? replyTo)
        sendMessage,
    required TResult Function(String chatId, File file, String type,
            File? thumbnail, String? replyTo)
        sendAttachment,
    required TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)
        sendVoiceMessage,
    required TResult Function(String chatId) markAsRead,
    required TResult Function(String messageId, String newText) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(
            String messageId, String originalText, List<String> targetChatIds)
        forwardMessage,
    required TResult Function(String messageId, String emoji) reactToMessage,
    required TResult Function(String chatId, String query) searchMessages,
    required TResult Function(String messageId) pinMessage,
    required TResult Function(String messageId) unpinMessage,
    required TResult Function(String messageId) retryMessage,
  }) {
    return pinMessage(messageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult? Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult? Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult? Function(String chatId)? markAsRead,
    TResult? Function(String messageId, String newText)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult? Function(String messageId, String emoji)? reactToMessage,
    TResult? Function(String chatId, String query)? searchMessages,
    TResult? Function(String messageId)? pinMessage,
    TResult? Function(String messageId)? unpinMessage,
    TResult? Function(String messageId)? retryMessage,
  }) {
    return pinMessage?.call(messageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult Function(String chatId)? markAsRead,
    TResult Function(String messageId, String newText)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult Function(String messageId, String emoji)? reactToMessage,
    TResult Function(String chatId, String query)? searchMessages,
    TResult Function(String messageId)? pinMessage,
    TResult Function(String messageId)? unpinMessage,
    TResult Function(String messageId)? retryMessage,
    required TResult orElse(),
  }) {
    if (pinMessage != null) {
      return pinMessage(messageId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_SendMessage value) sendMessage,
    required TResult Function(_SendAttachment value) sendAttachment,
    required TResult Function(_SendVoiceMessage value) sendVoiceMessage,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_EditMessage value) editMessage,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ReactToMessage value) reactToMessage,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_PinMessage value) pinMessage,
    required TResult Function(_UnpinMessage value) unpinMessage,
    required TResult Function(_RetryMessage value) retryMessage,
  }) {
    return pinMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_SendMessage value)? sendMessage,
    TResult? Function(_SendAttachment value)? sendAttachment,
    TResult? Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_EditMessage value)? editMessage,
    TResult? Function(_DeleteMessage value)? deleteMessage,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ReactToMessage value)? reactToMessage,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_PinMessage value)? pinMessage,
    TResult? Function(_UnpinMessage value)? unpinMessage,
    TResult? Function(_RetryMessage value)? retryMessage,
  }) {
    return pinMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_SendMessage value)? sendMessage,
    TResult Function(_SendAttachment value)? sendAttachment,
    TResult Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_EditMessage value)? editMessage,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ReactToMessage value)? reactToMessage,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_PinMessage value)? pinMessage,
    TResult Function(_UnpinMessage value)? unpinMessage,
    TResult Function(_RetryMessage value)? retryMessage,
    required TResult orElse(),
  }) {
    if (pinMessage != null) {
      return pinMessage(this);
    }
    return orElse();
  }
}

abstract class _PinMessage implements MessageEvent {
  const factory _PinMessage(final String messageId) = _$PinMessageImpl;

  String get messageId;
  @JsonKey(ignore: true)
  _$$PinMessageImplCopyWith<_$PinMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnpinMessageImplCopyWith<$Res> {
  factory _$$UnpinMessageImplCopyWith(
          _$UnpinMessageImpl value, $Res Function(_$UnpinMessageImpl) then) =
      __$$UnpinMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageId});
}

/// @nodoc
class __$$UnpinMessageImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$UnpinMessageImpl>
    implements _$$UnpinMessageImplCopyWith<$Res> {
  __$$UnpinMessageImplCopyWithImpl(
      _$UnpinMessageImpl _value, $Res Function(_$UnpinMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
  }) {
    return _then(_$UnpinMessageImpl(
      null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UnpinMessageImpl with DiagnosticableTreeMixin implements _UnpinMessage {
  const _$UnpinMessageImpl(this.messageId);

  @override
  final String messageId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageEvent.unpinMessage(messageId: $messageId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MessageEvent.unpinMessage'))
      ..add(DiagnosticsProperty('messageId', messageId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnpinMessageImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnpinMessageImplCopyWith<_$UnpinMessageImpl> get copyWith =>
      __$$UnpinMessageImplCopyWithImpl<_$UnpinMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String chatId, String text, String? replyTo)
        sendMessage,
    required TResult Function(String chatId, File file, String type,
            File? thumbnail, String? replyTo)
        sendAttachment,
    required TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)
        sendVoiceMessage,
    required TResult Function(String chatId) markAsRead,
    required TResult Function(String messageId, String newText) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(
            String messageId, String originalText, List<String> targetChatIds)
        forwardMessage,
    required TResult Function(String messageId, String emoji) reactToMessage,
    required TResult Function(String chatId, String query) searchMessages,
    required TResult Function(String messageId) pinMessage,
    required TResult Function(String messageId) unpinMessage,
    required TResult Function(String messageId) retryMessage,
  }) {
    return unpinMessage(messageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult? Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult? Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult? Function(String chatId)? markAsRead,
    TResult? Function(String messageId, String newText)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult? Function(String messageId, String emoji)? reactToMessage,
    TResult? Function(String chatId, String query)? searchMessages,
    TResult? Function(String messageId)? pinMessage,
    TResult? Function(String messageId)? unpinMessage,
    TResult? Function(String messageId)? retryMessage,
  }) {
    return unpinMessage?.call(messageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult Function(String chatId)? markAsRead,
    TResult Function(String messageId, String newText)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult Function(String messageId, String emoji)? reactToMessage,
    TResult Function(String chatId, String query)? searchMessages,
    TResult Function(String messageId)? pinMessage,
    TResult Function(String messageId)? unpinMessage,
    TResult Function(String messageId)? retryMessage,
    required TResult orElse(),
  }) {
    if (unpinMessage != null) {
      return unpinMessage(messageId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_SendMessage value) sendMessage,
    required TResult Function(_SendAttachment value) sendAttachment,
    required TResult Function(_SendVoiceMessage value) sendVoiceMessage,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_EditMessage value) editMessage,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ReactToMessage value) reactToMessage,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_PinMessage value) pinMessage,
    required TResult Function(_UnpinMessage value) unpinMessage,
    required TResult Function(_RetryMessage value) retryMessage,
  }) {
    return unpinMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_SendMessage value)? sendMessage,
    TResult? Function(_SendAttachment value)? sendAttachment,
    TResult? Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_EditMessage value)? editMessage,
    TResult? Function(_DeleteMessage value)? deleteMessage,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ReactToMessage value)? reactToMessage,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_PinMessage value)? pinMessage,
    TResult? Function(_UnpinMessage value)? unpinMessage,
    TResult? Function(_RetryMessage value)? retryMessage,
  }) {
    return unpinMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_SendMessage value)? sendMessage,
    TResult Function(_SendAttachment value)? sendAttachment,
    TResult Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_EditMessage value)? editMessage,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ReactToMessage value)? reactToMessage,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_PinMessage value)? pinMessage,
    TResult Function(_UnpinMessage value)? unpinMessage,
    TResult Function(_RetryMessage value)? retryMessage,
    required TResult orElse(),
  }) {
    if (unpinMessage != null) {
      return unpinMessage(this);
    }
    return orElse();
  }
}

abstract class _UnpinMessage implements MessageEvent {
  const factory _UnpinMessage(final String messageId) = _$UnpinMessageImpl;

  String get messageId;
  @JsonKey(ignore: true)
  _$$UnpinMessageImplCopyWith<_$UnpinMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RetryMessageImplCopyWith<$Res> {
  factory _$$RetryMessageImplCopyWith(
          _$RetryMessageImpl value, $Res Function(_$RetryMessageImpl) then) =
      __$$RetryMessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageId});
}

/// @nodoc
class __$$RetryMessageImplCopyWithImpl<$Res>
    extends _$MessageEventCopyWithImpl<$Res, _$RetryMessageImpl>
    implements _$$RetryMessageImplCopyWith<$Res> {
  __$$RetryMessageImplCopyWithImpl(
      _$RetryMessageImpl _value, $Res Function(_$RetryMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
  }) {
    return _then(_$RetryMessageImpl(
      null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RetryMessageImpl with DiagnosticableTreeMixin implements _RetryMessage {
  const _$RetryMessageImpl(this.messageId);

  @override
  final String messageId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageEvent.retryMessage(messageId: $messageId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MessageEvent.retryMessage'))
      ..add(DiagnosticsProperty('messageId', messageId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RetryMessageImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RetryMessageImplCopyWith<_$RetryMessageImpl> get copyWith =>
      __$$RetryMessageImplCopyWithImpl<_$RetryMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String chatId) loadMessages,
    required TResult Function(String chatId, String text, String? replyTo)
        sendMessage,
    required TResult Function(String chatId, File file, String type,
            File? thumbnail, String? replyTo)
        sendAttachment,
    required TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)
        sendVoiceMessage,
    required TResult Function(String chatId) markAsRead,
    required TResult Function(String messageId, String newText) editMessage,
    required TResult Function(String messageId, bool forEveryone) deleteMessage,
    required TResult Function(
            String messageId, String originalText, List<String> targetChatIds)
        forwardMessage,
    required TResult Function(String messageId, String emoji) reactToMessage,
    required TResult Function(String chatId, String query) searchMessages,
    required TResult Function(String messageId) pinMessage,
    required TResult Function(String messageId) unpinMessage,
    required TResult Function(String messageId) retryMessage,
  }) {
    return retryMessage(messageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String chatId)? loadMessages,
    TResult? Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult? Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult? Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult? Function(String chatId)? markAsRead,
    TResult? Function(String messageId, String newText)? editMessage,
    TResult? Function(String messageId, bool forEveryone)? deleteMessage,
    TResult? Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult? Function(String messageId, String emoji)? reactToMessage,
    TResult? Function(String chatId, String query)? searchMessages,
    TResult? Function(String messageId)? pinMessage,
    TResult? Function(String messageId)? unpinMessage,
    TResult? Function(String messageId)? retryMessage,
  }) {
    return retryMessage?.call(messageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String chatId)? loadMessages,
    TResult Function(String chatId, String text, String? replyTo)? sendMessage,
    TResult Function(String chatId, File file, String type, File? thumbnail,
            String? replyTo)?
        sendAttachment,
    TResult Function(
            String chatId, File audioFile, int duration, List<double> waveform)?
        sendVoiceMessage,
    TResult Function(String chatId)? markAsRead,
    TResult Function(String messageId, String newText)? editMessage,
    TResult Function(String messageId, bool forEveryone)? deleteMessage,
    TResult Function(
            String messageId, String originalText, List<String> targetChatIds)?
        forwardMessage,
    TResult Function(String messageId, String emoji)? reactToMessage,
    TResult Function(String chatId, String query)? searchMessages,
    TResult Function(String messageId)? pinMessage,
    TResult Function(String messageId)? unpinMessage,
    TResult Function(String messageId)? retryMessage,
    required TResult orElse(),
  }) {
    if (retryMessage != null) {
      return retryMessage(messageId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMessages value) loadMessages,
    required TResult Function(_SendMessage value) sendMessage,
    required TResult Function(_SendAttachment value) sendAttachment,
    required TResult Function(_SendVoiceMessage value) sendVoiceMessage,
    required TResult Function(_MarkAsRead value) markAsRead,
    required TResult Function(_EditMessage value) editMessage,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_ForwardMessage value) forwardMessage,
    required TResult Function(_ReactToMessage value) reactToMessage,
    required TResult Function(_SearchMessages value) searchMessages,
    required TResult Function(_PinMessage value) pinMessage,
    required TResult Function(_UnpinMessage value) unpinMessage,
    required TResult Function(_RetryMessage value) retryMessage,
  }) {
    return retryMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMessages value)? loadMessages,
    TResult? Function(_SendMessage value)? sendMessage,
    TResult? Function(_SendAttachment value)? sendAttachment,
    TResult? Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult? Function(_MarkAsRead value)? markAsRead,
    TResult? Function(_EditMessage value)? editMessage,
    TResult? Function(_DeleteMessage value)? deleteMessage,
    TResult? Function(_ForwardMessage value)? forwardMessage,
    TResult? Function(_ReactToMessage value)? reactToMessage,
    TResult? Function(_SearchMessages value)? searchMessages,
    TResult? Function(_PinMessage value)? pinMessage,
    TResult? Function(_UnpinMessage value)? unpinMessage,
    TResult? Function(_RetryMessage value)? retryMessage,
  }) {
    return retryMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMessages value)? loadMessages,
    TResult Function(_SendMessage value)? sendMessage,
    TResult Function(_SendAttachment value)? sendAttachment,
    TResult Function(_SendVoiceMessage value)? sendVoiceMessage,
    TResult Function(_MarkAsRead value)? markAsRead,
    TResult Function(_EditMessage value)? editMessage,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_ForwardMessage value)? forwardMessage,
    TResult Function(_ReactToMessage value)? reactToMessage,
    TResult Function(_SearchMessages value)? searchMessages,
    TResult Function(_PinMessage value)? pinMessage,
    TResult Function(_UnpinMessage value)? unpinMessage,
    TResult Function(_RetryMessage value)? retryMessage,
    required TResult orElse(),
  }) {
    if (retryMessage != null) {
      return retryMessage(this);
    }
    return orElse();
  }
}

abstract class _RetryMessage implements MessageEvent {
  const factory _RetryMessage(final String messageId) = _$RetryMessageImpl;

  String get messageId;
  @JsonKey(ignore: true)
  _$$RetryMessageImplCopyWith<_$RetryMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MessageState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MessageEntity> messages) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MessageEntity> messages)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MessageEntity> messages)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageStateCopyWith<$Res> {
  factory $MessageStateCopyWith(
          MessageState value, $Res Function(MessageState) then) =
      _$MessageStateCopyWithImpl<$Res, MessageState>;
}

/// @nodoc
class _$MessageStateCopyWithImpl<$Res, $Val extends MessageState>
    implements $MessageStateCopyWith<$Res> {
  _$MessageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$MessageStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl with DiagnosticableTreeMixin implements _Initial {
  const _$InitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'MessageState.initial'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MessageEntity> messages) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MessageEntity> messages)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MessageEntity> messages)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements MessageState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$MessageStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl with DiagnosticableTreeMixin implements _Loading {
  const _$LoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'MessageState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MessageEntity> messages) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MessageEntity> messages)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MessageEntity> messages)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements MessageState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<MessageEntity> messages});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$MessageStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
  }) {
    return _then(_$LoadedImpl(
      null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageEntity>,
    ));
  }
}

/// @nodoc

class _$LoadedImpl with DiagnosticableTreeMixin implements _Loaded {
  const _$LoadedImpl(final List<MessageEntity> messages) : _messages = messages;

  final List<MessageEntity> _messages;
  @override
  List<MessageEntity> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageState.loaded(messages: $messages)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MessageState.loaded'))
      ..add(DiagnosticsProperty('messages', messages));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_messages));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MessageEntity> messages) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MessageEntity> messages)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MessageEntity> messages)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(messages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements MessageState {
  const factory _Loaded(final List<MessageEntity> messages) = _$LoadedImpl;

  List<MessageEntity> get messages;
  @JsonKey(ignore: true)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$MessageStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl with DiagnosticableTreeMixin implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MessageState.error'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<MessageEntity> messages) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<MessageEntity> messages)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<MessageEntity> messages)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements MessageState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
