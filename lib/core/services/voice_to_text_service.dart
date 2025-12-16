import 'dart:async';
import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

/// Voice-to-text service for transcribing audio messages
/// 
/// This service provides speech recognition capabilities:
/// - Real-time speech-to-text
/// - Recorded audio transcription
/// - Language detection
/// 
/// Note: Requires platform-specific implementation:
/// - iOS: Speech framework
/// - Android: SpeechRecognizer
/// - Use speech_to_text package for cross-platform
class VoiceToTextService {
  bool _isListening = false;
  String _lastTranscription = '';
  StreamController<String>? _transcriptionController;
  
  /// Whether the service is currently listening
  bool get isListening => _isListening;
  
  /// Last transcribed text
  String get lastTranscription => _lastTranscription;
  
  /// Stream of transcribed text (real-time updates)
  Stream<String> get transcriptionStream => 
      _transcriptionController?.stream ?? const Stream.empty();

  /// Initialize the speech recognition service
  Future<bool> initialize() async {
    // TODO: Initialize speech_to_text package
    // final speech = SpeechToText();
    // return await speech.initialize();
    return true;
  }

  /// Start listening for speech
  Future<void> startListening({
    String? locale,
    void Function(String)? onResult,
    void Function()? onComplete,
    void Function(String)? onError,
  }) async {
    if (_isListening) return;
    
    _isListening = true;
    _transcriptionController = StreamController<String>.broadcast();
    
    // TODO: Implement actual speech recognition
    // Example with speech_to_text package:
    // await speech.listen(
    //   onResult: (result) {
    //     _lastTranscription = result.recognizedWords;
    //     _transcriptionController?.add(_lastTranscription);
    //     onResult?.call(_lastTranscription);
    //   },
    //   localeId: locale,
    // );
    
    // Placeholder simulation
    await Future.delayed(const Duration(milliseconds: 500));
    _lastTranscription = 'Speech recognition placeholder';
    _transcriptionController?.add(_lastTranscription);
    onResult?.call(_lastTranscription);
  }

  /// Stop listening for speech
  Future<void> stopListening() async {
    if (!_isListening) return;
    
    _isListening = false;
    await _transcriptionController?.close();
    _transcriptionController = null;
    
    // TODO: speech.stop();
  }

  /// Transcribe audio file to text
  Future<String> transcribeAudioFile(String filePath) async {
    // TODO: Implement audio file transcription
    // This could use:
    // - Google Cloud Speech-to-Text API
    // - AWS Transcribe
    // - Azure Speech Services
    // - On-device ML models
    
    return 'Audio transcription placeholder';
  }

  /// Get available locales for speech recognition
  Future<List<String>> getAvailableLocales() async {
    // TODO: Return actual available locales
    // final locales = await speech.locales();
    // return locales.map((l) => l.localeId).toList();
    
    return ['en-US', 'en-GB', 'es-ES', 'fr-FR', 'de-DE', 'ru-RU'];
  }

  /// Dispose resources
  void dispose() {
    _transcriptionController?.close();
    _isListening = false;
  }
}

/// Widget for voice-to-text transcription UI
class VoiceToTextWidget extends StatefulWidget {
  final void Function(String text)? onTranscription;
  final String? locale;
  
  const VoiceToTextWidget({
    super.key,
    this.onTranscription,
    this.locale,
  });

  @override
  State<VoiceToTextWidget> createState() => _VoiceToTextWidgetState();
}

class _VoiceToTextWidgetState extends State<VoiceToTextWidget>
    with SingleTickerProviderStateMixin {
  final VoiceToTextService _service = VoiceToTextService();
  late AnimationController _animController;
  String _transcribedText = '';
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _service.initialize();
  }

  @override
  void dispose() {
    _animController.dispose();
    _service.dispose();
    super.dispose();
  }

  Future<void> _toggleListening() async {
    if (_isListening) {
      await _service.stopListening();
      _animController.stop();
      widget.onTranscription?.call(_transcribedText);
    } else {
      await _service.startListening(
        locale: widget.locale,
        onResult: (text) {
          setState(() => _transcribedText = text);
        },
      );
      _animController.repeat(reverse: true);
    }
    setState(() => _isListening = !_isListening);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Mic button with animation
          GestureDetector(
            onTap: _toggleListening,
            child: AnimatedBuilder(
              animation: _animController,
              builder: (context, child) {
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: _isListening
                          ? [Colors.red.shade400, Colors.red.shade600]
                          : [AppColors.primary, AppColors.primaryDark],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (_isListening ? Colors.red : AppColors.primary)
                            .withValues(alpha: 0.3 + _animController.value * 0.2),
                        blurRadius: 20 + _animController.value * 10,
                        spreadRadius: _animController.value * 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    _isListening ? Icons.stop : Icons.mic,
                    color: Colors.white,
                    size: 36,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          
          // Status text
          Text(
            _isListening ? 'Listening...' : 'Tap to speak',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: _isListening ? Colors.red : AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          
          // Transcribed text
          if (_transcribedText.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _transcribedText,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}

/// Voice-to-text button for message input
class VoiceToTextButton extends StatefulWidget {
  final void Function(String text) onTranscription;
  
  const VoiceToTextButton({
    super.key,
    required this.onTranscription,
  });

  @override
  State<VoiceToTextButton> createState() => _VoiceToTextButtonState();
}

class _VoiceToTextButtonState extends State<VoiceToTextButton> {
  final VoiceToTextService _service = VoiceToTextService();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _service.initialize();
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }

  Future<void> _handlePress() async {
    if (_isListening) {
      await _service.stopListening();
      widget.onTranscription(_service.lastTranscription);
    } else {
      await _service.startListening(
        onResult: (text) {
          // Real-time updates if needed
        },
      );
    }
    setState(() => _isListening = !_isListening);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handlePress,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isListening 
              ? Colors.red 
              : AppColors.primary.withValues(alpha: 0.1),
        ),
        child: Icon(
          _isListening ? Icons.stop : Icons.keyboard_voice,
          color: _isListening ? Colors.white : AppColors.primary,
          size: 20,
        ),
      ),
    );
  }
}
