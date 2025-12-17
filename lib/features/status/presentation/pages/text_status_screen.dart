import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Text status creation screen with colored backgrounds
class TextStatusScreen extends StatefulWidget {
  const TextStatusScreen({super.key});

  @override
  State<TextStatusScreen> createState() => _TextStatusScreenState();
}

class _TextStatusScreenState extends State<TextStatusScreen> {
  final _textController = TextEditingController();
  int _selectedColorIndex = 0;
  int _selectedFontIndex = 0;
  final int _excludedCount = 12; // Placeholder

  // Background colors
  static const List<Color> _backgroundColors = [
    Color(0xFFFF8A80), // Pink/Coral
    Color(0xFF82B1FF), // Light Blue
    Color(0xFFB388FF), // Purple
    Color(0xFF80CBC4), // Teal
    Color(0xFFFFD180), // Orange
    Color(0xFFA5D6A7), // Green
    Color(0xFF90CAF9), // Blue
    Color(0xFFF48FB1), // Pink
    Color(0xFFCE93D8), // Light Purple
    Color(0xFFFFCC80), // Light Orange
  ];

  // Font families
  static const List<String> _fonts = [
    'Default',
    'Serif',
    'Sans-Serif',
    'Monospace',
    'Cursive',
  ];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _nextColor() {
    setState(() {
      _selectedColorIndex = (_selectedColorIndex + 1) % _backgroundColors.length;
    });
  }

  void _nextFont() {
    setState(() {
      _selectedFontIndex = (_selectedFontIndex + 1) % _fonts.length;
    });
  }

  Future<void> _publishStatus() async {
    if (_textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите текст статуса')),
      );
      return;
    }

    // TODO: Publish to Firebase
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Статус опубликован!')),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _backgroundColors[_selectedColorIndex];
    final fontFamily = _fonts[_selectedFontIndex];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top toolbar
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  // Close button
                  IconButton(
                    icon: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, color: Colors.white, size: 20),
                    ),
                    onPressed: () => context.pop(),
                  ),
                  const Spacer(),
                  // Color picker button
                  IconButton(
                    icon: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.palette, color: Colors.white, size: 20),
                    ),
                    onPressed: _nextColor,
                  ),
                  // Font button
                  IconButton(
                    icon: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.text_fields, color: Colors.white, size: 20),
                    ),
                    onPressed: _nextFont,
                  ),
                  // Emoji button
                  IconButton(
                    icon: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.emoji_emotions, color: Colors.white, size: 20),
                    ),
                    onPressed: () {
                      // Show emoji picker
                    },
                  ),
                  // Edit/Pen button
                  IconButton(
                    icon: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, color: Colors.white, size: 20),
                    ),
                    onPressed: () {
                      // Drawing mode
                    },
                  ),
                ],
              ),
            ),

            // Text input area
            Expanded(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                    child: TextField(
                      controller: _textController,
                      textAlign: TextAlign.center,
                      maxLines: null,
                      autofocus: true,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        fontFamily: _getFontFamily(fontFamily),
                        shadows: const [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 2,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Введите текст',
                        hintStyle: TextStyle(
                          color: Colors.white54,
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => setState(() {}),
                    ),
                  ),
                ),
              ),
            ),

            // Bottom section
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  // Privacy info
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.visibility_off, size: 16, color: Colors.white),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Статус (исключено: $_excludedCount)',
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  // Send button
                  FloatingActionButton(
                    backgroundColor: AppColors.primary,
                    onPressed: _publishStatus,
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _getFontFamily(String fontName) {
    switch (fontName) {
      case 'Serif': return 'serif';
      case 'Sans-Serif': return 'sans-serif';
      case 'Monospace': return 'monospace';
      case 'Cursive': return 'cursive';
      default: return null;
    }
  }
}

/// Color palette picker widget
class ColorPalettePicker extends StatelessWidget {
  final List<Color> colors;
  final int selectedIndex;
  final ValueChanged<int> onColorSelected;

  const ColorPalettePicker({
    super.key,
    required this.colors,
    required this.selectedIndex,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onColorSelected(index),
            child: Container(
              width: 36,
              height: 36,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: colors[index],
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: Colors.white, width: 3)
                    : null,
                boxShadow: isSelected
                    ? [
                        const BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
