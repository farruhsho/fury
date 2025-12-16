import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

/// Service for translating messages using free translation APIs
class MessageTranslationService {
  final http.Client _client;
  final Map<String, String> _cache = {};

  // Supported languages (subset of most common)
  static const Map<String, String> supportedLanguages = {
    'en': 'English',
    'ru': 'Русский',
    'es': 'Español',
    'fr': 'Français',
    'de': 'Deutsch',
    'it': 'Italiano',
    'pt': 'Português',
    'zh': '中文',
    'ja': '日本語',
    'ko': '한국어',
    'ar': 'العربية',
    'hi': 'हिन्दी',
    'tr': 'Türkçe',
    'pl': 'Polski',
    'nl': 'Nederlands',
    'uk': 'Українська',
    'uz': 'O\'zbek',
  };

  MessageTranslationService({http.Client? client})
      : _client = client ?? http.Client();

  /// Translate text to target language
  /// Uses LibreTranslate API (free, self-hosted option available)
  Future<TranslationResult> translate({
    required String text,
    required String targetLanguage,
    String? sourceLanguage,
  }) async {
    // Check cache first
    final cacheKey = '${text.hashCode}_$targetLanguage';
    if (_cache.containsKey(cacheKey)) {
      return TranslationResult(
        originalText: text,
        translatedText: _cache[cacheKey]!,
        sourceLanguage: sourceLanguage ?? 'auto',
        targetLanguage: targetLanguage,
        fromCache: true,
      );
    }

    try {
      // Using MyMemory Translation API (free, no API key needed for small volume)
      final response = await _client.get(
        Uri.parse(
          'https://api.mymemory.translated.net/get'
          '?q=${Uri.encodeComponent(text)}'
          '&langpair=${sourceLanguage ?? 'auto'}|$targetLanguage',
        ),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final translatedText = data['responseData']['translatedText'] as String;
        
        // Cache result
        _cache[cacheKey] = translatedText;
        
        return TranslationResult(
          originalText: text,
          translatedText: translatedText,
          sourceLanguage: data['responseData']['detectedLanguage'] as String? ?? sourceLanguage ?? 'auto',
          targetLanguage: targetLanguage,
          fromCache: false,
        );
      } else {
        throw TranslationException('Translation API error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('❌ [TRANSLATION] Error: $e');
      throw TranslationException('Translation failed: $e');
    }
  }

  /// Detect language of text
  Future<String> detectLanguage(String text) async {
    try {
      // Simple language detection based on character sets
      final hasRussian = RegExp(r'[а-яА-ЯёЁ]').hasMatch(text);
      final hasChinese = RegExp(r'[\u4e00-\u9fa5]').hasMatch(text);
      final hasArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(text);
      final hasJapanese = RegExp(r'[\u3040-\u309F\u30A0-\u30FF]').hasMatch(text);
      final hasKorean = RegExp(r'[\uAC00-\uD7AF]').hasMatch(text);
      
      if (hasRussian) return 'ru';
      if (hasChinese) return 'zh';
      if (hasArabic) return 'ar';
      if (hasJapanese) return 'ja';
      if (hasKorean) return 'ko';
      
      // Default to English for Latin scripts
      return 'en';
    } catch (e) {
      return 'en';
    }
  }

  /// Get language name from code
  String getLanguageName(String code) {
    return supportedLanguages[code] ?? code.toUpperCase();
  }

  void clearCache() {
    _cache.clear();
  }

  void dispose() {
    _client.close();
  }
}

class TranslationResult {
  final String originalText;
  final String translatedText;
  final String sourceLanguage;
  final String targetLanguage;
  final bool fromCache;

  TranslationResult({
    required this.originalText,
    required this.translatedText,
    required this.sourceLanguage,
    required this.targetLanguage,
    this.fromCache = false,
  });

  bool get isTranslated => originalText != translatedText;
}

class TranslationException implements Exception {
  final String message;
  TranslationException(this.message);
  
  @override
  String toString() => message;
}

/// Widget for showing translation option on messages
class TranslateMessageButton extends StatefulWidget {
  final String text;
  final String? detectedLanguage;
  final Function(String translatedText)? onTranslated;

  const TranslateMessageButton({
    super.key,
    required this.text,
    this.detectedLanguage,
    this.onTranslated,
  });

  @override
  State<TranslateMessageButton> createState() => _TranslateMessageButtonState();
}

class _TranslateMessageButtonState extends State<TranslateMessageButton> {
  final MessageTranslationService _translationService = MessageTranslationService();
  bool _isTranslating = false;
  String? _translatedText;
  String? _error;

  @override
  void dispose() {
    _translationService.dispose();
    super.dispose();
  }

  Future<void> _translate() async {
    setState(() {
      _isTranslating = true;
      _error = null;
    });

    try {
      // Get device locale
      final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
      
      final result = await _translationService.translate(
        text: widget.text,
        targetLanguage: deviceLocale,
      );

      if (mounted) {
        setState(() {
          _translatedText = result.translatedText;
          _isTranslating = false;
        });
        widget.onTranslated?.call(result.translatedText);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isTranslating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_translatedText != null) {
      return Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.translate, size: 14, color: Colors.blue[700]),
                const SizedBox(width: 4),
                Text(
                  'Translation',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(_translatedText!),
          ],
        ),
      );
    }

    if (_error != null) {
      return TextButton.icon(
        onPressed: _translate,
        icon: const Icon(Icons.error_outline, size: 14),
        label: const Text('Retry translation'),
        style: TextButton.styleFrom(
          foregroundColor: Colors.red,
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 24),
        ),
      );
    }

    return TextButton.icon(
      onPressed: _isTranslating ? null : _translate,
      icon: _isTranslating
          ? const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.translate, size: 14),
      label: Text(_isTranslating ? 'Translating...' : 'Translate'),
      style: TextButton.styleFrom(
        foregroundColor: Colors.grey,
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 24),
      ),
    );
  }
}
