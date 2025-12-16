import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/services/media_compression_service.dart';
import '../../../../core/services/typing_status_service.dart';
import '../bloc/message_bloc/message_bloc.dart';
import 'emoji_picker_widget.dart';
import 'attachment_picker.dart';
import 'recording_widget.dart';
import 'sticker_gif_picker.dart';
import 'media_editor.dart';
import 'video_circle_recorder.dart';

class MessageInput extends StatefulWidget {
  final String chatId;
  final String? replyToMessageId;
  final String? replyToMessageText;
  final VoidCallback? onCancelReply;

  const MessageInput({
    super.key,
    required this.chatId,
    this.replyToMessageId,
    this.replyToMessageText,
    this.onCancelReply,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  final _mediaCompression = MediaCompressionService();
  late final TypingStatusService _typingService;
  
  bool _hasText = false;
  bool _showEmojiPicker = false;
  bool _showStickerPicker = false;
  bool _isRecordingVoice = false;
  bool _isRecordingVideo = false;
  bool _isRecordingLocked = false;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _typingService = TypingStatusService();
    
    _textController.addListener(() {
      setState(() {
        _hasText = _textController.text.trim().isNotEmpty;
      });
      
      // Trigger typing indicator
      if (_textController.text.isNotEmpty) {
        _typingService.onTyping(widget.chatId);
      }
    });
    
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _showEmojiPicker = false;
          _showStickerPicker = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _typingService.stopTyping(widget.chatId);
    _typingService.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    context.read<MessageBloc>().add(
      MessageEvent.sendMessage(
        chatId: widget.chatId,
        text: text,
        replyTo: widget.replyToMessageId,
      ),
    );

    _textController.clear();
    widget.onCancelReply?.call();
  }

  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
      _showStickerPicker = false;
    });
    
    if (_showEmojiPicker) {
      _focusNode.unfocus();
    } else {
      _focusNode.requestFocus();
    }
  }

  void _toggleStickerPicker() {
    setState(() {
      _showStickerPicker = !_showStickerPicker;
      _showEmojiPicker = false;
    });
    
    if (_showStickerPicker) {
      _focusNode.unfocus();
    }
  }

  void _startVoiceRecording() {
    try { HapticFeedback.mediumImpact(); } catch (_) {}
    if (!mounted) return;
    setState(() {
      _isRecordingVoice = true;
      _isRecordingLocked = false;
    });
  }

  void _startVideoRecording() {
    try { HapticFeedback.mediumImpact(); } catch (_) {}
    if (!mounted) return;
    setState(() {
      _isRecordingVideo = true;
      _isRecordingLocked = false;
    });
  }

  void _cancelRecording() {
    try { HapticFeedback.heavyImpact(); } catch (_) {}
    // Schedule state update for after the current frame to avoid
    // calling setState while the widget tree is locked
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _isRecordingVoice = false;
        _isRecordingVideo = false;
        _isRecordingLocked = false;
      });
    });
  }

  void _onRecordingLockChanged(bool locked) {
    if (!mounted) return;
    setState(() {
      _isRecordingLocked = locked;
    });
  }

  Future<void> _sendVoiceMessage(File file, int durationMs, List<double>? waveform) async {
    setState(() {
      _isRecordingVoice = false;
      _isRecordingLocked = false;
    });
    
    context.read<MessageBloc>().add(
      MessageEvent.sendVoiceMessage(
        chatId: widget.chatId,
        audioFile: file,
        duration: durationMs,
        waveform: waveform ?? [],
      ),
    );
  }

  Future<void> _sendVideoMessage(File file, int durationMs, List<double>? waveform) async {
    setState(() {
      _isRecordingVideo = false;
      _isRecordingLocked = false;
    });
    
    // Send as video circle message
    context.read<MessageBloc>().add(
      MessageEvent.sendAttachment(
        chatId: widget.chatId,
        file: file,
        type: 'video_circle',
      ),
    );
  }

  Future<void> _shareLocation() async {
    try {
      // Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permission denied')),
            );
          }
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permission permanently denied')),
          );
        }
        return;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Send location message with coordinates in a format that can be parsed
      // Format: location:lat,lng that the message bubble will recognize
      final lat = position.latitude;
      final lng = position.longitude;
      
      context.read<MessageBloc>().add(
        MessageEvent.sendMessage(
          chatId: widget.chatId,
          text: 'location:$lat,$lng',
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location shared!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sharing location: $e')),
        );
      }
    }
  }

  Future<void> _handleImageUpload(XFile image) async {
    Navigator.pop(context);
    if (!mounted) return;
    setState(() => _isUploading = true);

    try {
      // On web, File operations are limited - send directly without editor
      if (kIsWeb) {
        // For web, use XFile path directly
        final file = File(image.path);
        final prepared = await _mediaCompression.prepareForUpload(
          file: file,
          type: MediaType.image,
        );
        
        context.read<MessageBloc>().add(
          MessageEvent.sendAttachment(
            chatId: widget.chatId,
            file: prepared.file,
            type: 'image',
            thumbnail: prepared.thumbnail,
          ),
        );
      } else {
        // On mobile, open editor
        final file = File(image.path);
        final prepared = await _mediaCompression.prepareForUpload(
          file: file,
          type: MediaType.image,
        );
        
        context.read<MessageBloc>().add(
          MessageEvent.sendAttachment(
            chatId: widget.chatId,
            file: prepared.file,
            type: 'image',
            thumbnail: prepared.thumbnail,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  Future<void> _handleVideoUpload(XFile video) async {
    Navigator.pop(context);
    setState(() => _isUploading = true);
    
    try {
      final file = File(video.path);
      final prepared = await _mediaCompression.prepareForUpload(
        file: file,
        type: MediaType.video,
      );
      
      context.read<MessageBloc>().add(
        MessageEvent.sendAttachment(
          chatId: widget.chatId,
          file: prepared.file,
          type: 'video',
          thumbnail: prepared.thumbnail,
        ),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }

  Future<void> _handleDocumentUpload(XFile document) async {
    Navigator.pop(context);
    setState(() => _isUploading = true);
    
    try {
      final file = File(document.path);
      
      context.read<MessageBloc>().add(
        MessageEvent.sendAttachment(
          chatId: widget.chatId,
          file: file,
          type: 'document',
        ),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }

  void _showAttachmentPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => AttachmentPicker(
        onImagePicked: _handleImageUpload,
        onVideoPicked: _handleVideoUpload,
        onDocumentPicked: _handleDocumentUpload,
        onLocationTap: () {
          Navigator.pop(context);
          _shareLocation();
        },
        onContactTap: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contact sharing coming soon')),
          );
        },
      ),
    );
  }

  void _showCameraOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => MediaPickerSheet(
        onImagePicked: (image, {isOneTime = false}) {
          if (isOneTime) {
            _handleImageUploadOneTime(image);
          } else {
            _handleImageUpload(image);
          }
        },
        onVideoPicked: (video, {isOneTime = false}) {
          if (isOneTime) {
            _handleVideoUploadOneTime(video);
          } else {
            _handleVideoUpload(video);
          }
        },
        onLocationTap: () {
          Navigator.pop(context);
          _shareLocation();
        },
        onCameraTap: () async {
          Navigator.pop(context);
          final picker = ImagePicker();
          final photo = await picker.pickImage(source: ImageSource.camera);
          if (photo != null && mounted) {
            _handleImageUploadDirect(photo);
          }
        },
      ),
    );
  }

  Future<void> _handleImageUploadDirect(XFile image) async {
    // Skip editor - send directly for simplicity
    if (!mounted) return;
    setState(() => _isUploading = true);
    
    try {
      final file = File(image.path);
      final prepared = await _mediaCompression.prepareForUpload(
        file: file,
        type: MediaType.image,
      );
      
      context.read<MessageBloc>().add(
        MessageEvent.sendAttachment(
          chatId: widget.chatId,
          file: prepared.file,
          type: 'image',
          thumbnail: prepared.thumbnail,
        ),
      );
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }
  
  Future<void> _sendImageWithOptions(File file, {required bool isOneTime, required String quality}) async {
    if (!mounted) return;
    setState(() => _isUploading = true);
    
    try {
      final prepared = await _mediaCompression.prepareForUpload(
        file: file,
        type: MediaType.image,
      );
      
      context.read<MessageBloc>().add(
        MessageEvent.sendAttachment(
          chatId: widget.chatId,
          file: prepared.file,
          type: isOneTime ? 'image_once' : 'image',
          thumbnail: prepared.thumbnail,
        ),
      );
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  Future<void> _handleImageUploadOneTime(XFile image) async {
    // Send as one-time view directly
    if (!mounted) return;
    setState(() => _isUploading = true);
    
    try {
      final file = File(image.path);
      final prepared = await _mediaCompression.prepareForUpload(
        file: file,
        type: MediaType.image,
      );
      
      context.read<MessageBloc>().add(
        MessageEvent.sendAttachment(
          chatId: widget.chatId,
          file: prepared.file,
          type: 'image_once', // One-time view
          thumbnail: prepared.thumbnail,
        ),
      );
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  Future<void> _handleVideoUploadOneTime(XFile video) async {
    setState(() => _isUploading = true);
    
    try {
      final file = File(video.path);
      final prepared = await _mediaCompression.prepareForUpload(
        file: file,
        type: MediaType.video,
      );
      
      context.read<MessageBloc>().add(
        MessageEvent.sendAttachment(
          chatId: widget.chatId,
          file: prepared.file,
          type: 'video_once', // One-time view
          thumbnail: prepared.thumbnail,
        ),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }

  void _sendSticker(String sticker, bool isGif) {
    setState(() => _showStickerPicker = false);
    
    context.read<MessageBloc>().add(
      MessageEvent.sendMessage(
        chatId: widget.chatId,
        text: sticker,
        // type: isGif ? 'gif' : 'sticker',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Voice recording mode - only on non-web platforms
    if (_isRecordingVoice && !kIsWeb) {
      return RecordingWidget(
        type: RecordingType.voice,
        onComplete: _sendVoiceMessage,
        onCancel: _cancelRecording,
        isLocked: _isRecordingLocked,
        onLockChanged: _onRecordingLockChanged,
      );
    }
    
    // Video circle recording mode with live camera preview - only on non-web
    if (_isRecordingVideo && !kIsWeb) {
      return VideoCircleRecorder(
        onComplete: (videoFile, durationMs) {
          if (!mounted) return;
          setState(() {
            _isRecordingVideo = false;
            _isRecordingLocked = false;
          });
          
          context.read<MessageBloc>().add(
            MessageEvent.sendAttachment(
              chatId: widget.chatId,
              file: videoFile,
              type: 'video_circle',
            ),
          );
        },
        onCancel: _cancelRecording,
        isLocked: _isRecordingLocked,
        onLockChanged: _onRecordingLockChanged,
      );
    }

    return BlocListener<MessageBloc, MessageState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to send message: $message'),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Retry',
                  textColor: Colors.white,
                  onPressed: () {
                    // User can retry by pressing send again
                  },
                ),
              ),
            );
          },
          orElse: () {},
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        // Reply preview
        if (widget.replyToMessageText != null)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              border: Border(
                left: BorderSide(color: AppColors.primary, width: 4),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reply',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        widget.replyToMessageText!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: widget.onCancelReply,
                ),
              ],
            ),
          ),
        
        // Upload progress
        if (_isUploading)
          const LinearProgressIndicator(),
        
        // Input Bar
        SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ).copyWith(bottom: AppSpacing.md),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Attachment Button
              IconButton(
                icon: const Icon(Icons.add),
                color: AppColors.primary,
                onPressed: _showAttachmentPicker,
              ),
              
              // Sticker Button
              IconButton(
                icon: Icon(
                  _showStickerPicker ? Icons.keyboard : Icons.sticky_note_2_outlined,
                ),
                color: _showStickerPicker ? AppColors.primary : AppColors.textSecondaryLight,
                onPressed: _toggleStickerPicker,
              ),
              
              // Text Input
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.surfaceDark
                        : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          focusNode: _focusNode,
                          decoration: const InputDecoration(
                            hintText: 'Type a message',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                          ),
                          maxLines: 5,
                          minLines: 1,
                          textCapitalization: TextCapitalization.sentences,
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _showEmojiPicker
                              ? Icons.keyboard
                              : Icons.emoji_emotions_outlined,
                        ),
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        color: _showEmojiPicker
                            ? AppColors.primary
                            : AppColors.textSecondaryLight,
                        onPressed: _toggleEmojiPicker,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(width: AppSpacing.xs),
              
              // Camera Button (tap for picker, hold for video circle) - NOT on web
              if (!_hasText && !kIsWeb)
                CameraRecordButton(
                  size: 40,
                  color: Colors.grey.shade600,
                  onTap: _showCameraOptions,
                  onRecordingStart: _startVideoRecording,
                  onRecordingCancel: _cancelRecording,
                ),
              
              // On web, show simple gallery picker
              if (!_hasText && kIsWeb)
                IconButton(
                  icon: const Icon(Icons.photo_library),
                  color: Colors.grey.shade600,
                  onPressed: _showAttachmentPicker,
                  tooltip: 'Add image',
                ),
              
              const SizedBox(width: AppSpacing.xs),
              
              // Send/Voice Button - on web, just send. On mobile, long press for voice
              GestureDetector(
                onLongPress: (_hasText || kIsWeb) ? null : _startVoiceRecording,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: _hasText 
                        ? LinearGradient(
                            colors: [AppColors.primary, AppColors.primary.withBlue(255)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: _hasText ? null : AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: _hasText ? 0.5 : 0.3),
                        blurRadius: _hasText ? 12 : 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      switchInCurve: Curves.easeOutBack,
                      switchOutCurve: Curves.easeIn,
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: RotationTransition(
                            turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Icon(
                        // On web, always show send. On mobile, show mic when no text
                        (_hasText || kIsWeb) ? Icons.send : Icons.mic,
                        key: ValueKey(_hasText || kIsWeb),
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    onPressed: (_hasText || kIsWeb)
                        ? _sendMessage
                        : _startVoiceRecording,
                  ),
                ),
              ),
            ],
          ),
          ),
        ),
        
        // Emoji Picker
        if (_showEmojiPicker)
          EmojiPickerWidget(
            onEmojiSelected: (emoji) {
              _textController.text += emoji;
              _textController.selection = TextSelection.fromPosition(
                TextPosition(offset: _textController.text.length),
              );
            },
            onBackspacePressed: () {
              final text = _textController.text;
              if (text.isNotEmpty) {
                _textController.text = text.substring(0, text.length - 1);
              }
            },
          ),
        
        // Sticker/GIF Picker
        if (_showStickerPicker)
          StickerGifPicker(
            onSelected: _sendSticker,
          ),
      ],
      ),
    );
  }
}
