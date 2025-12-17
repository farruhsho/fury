import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

/// Smart reply suggestions based on message context
class SmartReplySuggestions extends StatelessWidget {
  final List<String> suggestions;
  final Function(String) onSuggestionTap;

  const SmartReplySuggestions({
    super.key,
    required this.suggestions,
    required this.onSuggestionTap,
  });

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 4),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: OutlinedButton(
              onPressed: () => onSuggestionTap(suggestion),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                side: BorderSide(color: AppColors.primary.withValues(alpha: 0.3)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                suggestion,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Service for generating smart reply suggestions
class SmartReplyService {
  /// Generate suggestions based on the last received message
  /// 
  /// In production, this would use ML Kit or a trained model
  static List<String> generateSuggestions(String lastMessage) {
    final lowerMessage = lastMessage.toLowerCase().trim();
    
    // Simple rule-based suggestions
    // In production, use Google ML Kit Smart Reply or custom ML model
    
    // Greetings
    if (_matchesAny(lowerMessage, ['hi', 'hello', 'hey', 'good morning', 'good evening'])) {
      return ['Hello! 👋', 'Hi there!', 'Hey! How are you?'];
    }
    
    // Questions about wellbeing
    if (_matchesAny(lowerMessage, ['how are you', 'how r u', 'whats up', "what's up"])) {
      return ["I'm good, thanks!", "Doing great! You?", "All good here 👍"];
    }
    
    // Thank you
    if (_matchesAny(lowerMessage, ['thanks', 'thank you', 'thx'])) {
      return ['You\'re welcome!', 'No problem!', 'Anytime! 😊'];
    }
    
    // Questions
    if (lowerMessage.endsWith('?')) {
      if (_matchesAny(lowerMessage, ['want', 'like', 'interested'])) {
        return ['Yes, sure!', 'Maybe later', 'Not right now'];
      }
      if (_matchesAny(lowerMessage, ['when', 'what time'])) {
        return ['Now', 'In 10 minutes', 'Later today'];
      }
      if (_matchesAny(lowerMessage, ['where', 'location'])) {
        return ['Here', 'At home', 'I\'ll share location'];
      }
      return ['Yes', 'No', 'Maybe'];
    }
    
    // Positive statements
    if (_matchesAny(lowerMessage, ['great', 'awesome', 'wonderful', 'cool', 'nice'])) {
      return ['Glad to hear! 😊', '👍', 'That\'s great!'];
    }
    
    // Sad statements
    if (_matchesAny(lowerMessage, ['sad', 'upset', 'bad', 'tired', 'stressed'])) {
      return ['I\'m sorry to hear that', 'Take care! ❤️', 'Let me know if I can help'];
    }
    
    // Meeting/plans
    if (_matchesAny(lowerMessage, ['meet', 'call', 'talk'])) {
      return ['Sounds good!', 'When works for you?', 'Let me check my schedule'];
    }
    
    // Default suggestions
    return ['OK', '👍', 'I see'];
  }
  
  static bool _matchesAny(String message, List<String> patterns) {
    return patterns.any((pattern) => message.contains(pattern));
  }
}

/// Widget that listens to messages and shows smart replies
class SmartReplyWidget extends StatefulWidget {
  final Stream<String> lastMessageStream;
  final Function(String) onSuggestionSelected;

  const SmartReplyWidget({
    super.key,
    required this.lastMessageStream,
    required this.onSuggestionSelected,
  });

  @override
  State<SmartReplyWidget> createState() => _SmartReplyWidgetState();
}

class _SmartReplyWidgetState extends State<SmartReplyWidget> {
  List<String> _suggestions = [];

  @override
  void initState() {
    super.initState();
    widget.lastMessageStream.listen((message) {
      setState(() {
        _suggestions = SmartReplyService.generateSuggestions(message);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SmartReplySuggestions(
      suggestions: _suggestions,
      onSuggestionTap: widget.onSuggestionSelected,
    );
  }
}
