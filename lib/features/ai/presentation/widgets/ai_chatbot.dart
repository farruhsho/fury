import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

/// AI Chatbot integration for the messenger
/// 
/// Features:
/// - Quick actions (translate, summarize, suggest)
/// - Custom AI assistant
/// - Context-aware responses
class AIChatBot {
  static const String botId = 'fury_ai_assistant';
  static const String botName = 'Fury AI';
  static const String botAvatar = '🤖';
  
  /// Available AI actions
  static const List<AIAction> actions = [
    AIAction(
      id: 'translate',
      name: 'Translate',
      icon: Icons.translate,
      description: 'Translate message to another language',
    ),
    AIAction(
      id: 'summarize',
      name: 'Summarize',
      icon: Icons.summarize,
      description: 'Summarize long messages or conversation',
    ),
    AIAction(
      id: 'reply_suggestion',
      name: 'Suggest Reply',
      icon: Icons.auto_awesome,
      description: 'Get AI-powered reply suggestions',
    ),
    AIAction(
      id: 'grammar_check',
      name: 'Check Grammar',
      icon: Icons.spellcheck,
      description: 'Check and fix grammar mistakes',
    ),
    AIAction(
      id: 'tone_change',
      name: 'Change Tone',
      icon: Icons.mood,
      description: 'Make message more formal/casual/friendly',
    ),
  ];
}

/// Model for an AI action
class AIAction {
  final String id;
  final String name;
  final IconData icon;
  final String description;

  const AIAction({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });
}

/// AI Actions menu widget
class AIActionsMenu extends StatelessWidget {
  final String messageText;
  final Function(String actionId, String result) onActionComplete;

  const AIActionsMenu({
    super.key,
    required this.messageText,
    required this.onActionComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('🤖', style: TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Fury AI',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'What would you like to do?',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...AIChatBot.actions.map((action) => _buildActionTile(context, action)),
        ],
      ),
    );
  }

  Widget _buildActionTile(BuildContext context, AIAction action) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(action.icon, color: AppColors.primary),
      ),
      title: Text(action.name),
      subtitle: Text(
        action.description,
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _performAction(context, action),
    );
  }

  void _performAction(BuildContext context, AIAction action) async {
    Navigator.pop(context);
    
    // Show loading
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 12),
            Text('${action.name}...'),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    // Simulate AI processing
    await Future.delayed(const Duration(seconds: 1));

    // Generate result based on action
    final result = _generateResult(action.id, messageText);
    onActionComplete(action.id, result);
  }

  String _generateResult(String actionId, String text) {
    // Placeholder results - in production, use actual AI APIs
    switch (actionId) {
      case 'translate':
        return '[Translated] $text\n(API integration needed for real translation)';
      case 'summarize':
        return 'Summary: ${text.length > 50 ? '${text.substring(0, 47)}...' : text}';
      case 'reply_suggestion':
        return 'Suggested replies:\n• Sounds good!\n• I\'ll think about it\n• Let me get back to you';
      case 'grammar_check':
        return 'Grammar check: Your message looks good! ✓';
      case 'tone_change':
        return '[Formal version] $text';
      default:
        return text;
    }
  }
}

/// Message translation widget
class MessageTranslator extends StatefulWidget {
  final String originalText;
  final String sourceLanguage;
  final Function(String translatedText, String language) onTranslated;

  const MessageTranslator({
    super.key,
    required this.originalText,
    this.sourceLanguage = 'auto',
    required this.onTranslated,
  });

  @override
  State<MessageTranslator> createState() => _MessageTranslatorState();
}

class _MessageTranslatorState extends State<MessageTranslator> {
  String _selectedLanguage = 'en';
  bool _isTranslating = false;
  String? _translatedText;

  static const Map<String, String> _languages = {
    'en': 'English',
    'es': 'Spanish',
    'fr': 'French',
    'de': 'German',
    'it': 'Italian',
    'pt': 'Portuguese',
    'ru': 'Russian',
    'zh': 'Chinese',
    'ja': 'Japanese',
    'ko': 'Korean',
    'ar': 'Arabic',
    'hi': 'Hindi',
    'uz': 'Uzbek',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.translate, color: AppColors.primary),
              SizedBox(width: 8),
              Text(
                'Translate Message',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Original text
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.originalText,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 16),
          
          // Language selector
          Row(
            children: [
              const Text('Translate to: '),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedLanguage,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  items: _languages.entries.map((entry) {
                    return DropdownMenuItem(
                      value: entry.key,
                      child: Text(entry.value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedLanguage = value);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Translated text (if available)
          if (_translatedText != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
              ),
              child: Text(
                _translatedText!,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 16),
          ],
          
          // Translate button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isTranslating ? null : _translate,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _isTranslating
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Translate', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _translate() async {
    setState(() => _isTranslating = true);

    // Simulate translation - in production, use Google Translate API or ML Kit
    await Future.delayed(const Duration(seconds: 1));

    // Placeholder translation
    final translated = '[${_languages[_selectedLanguage]}] ${widget.originalText}';
    
    setState(() {
      _translatedText = translated;
      _isTranslating = false;
    });

    widget.onTranslated(translated, _selectedLanguage);
  }
}
