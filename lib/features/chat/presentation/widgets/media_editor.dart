import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../../app/theme/app_colors.dart';

/// Full-screen media editor for photos - Web compatible
/// Supports: drawing, text, stickers, quality selection
class MediaEditor extends StatefulWidget {
  final Uint8List imageBytes; // Use bytes instead of File for web compatibility
  final String? imagePath; // Optional path for non-web
  final Function(Uint8List editedBytes, {bool isOneTime, String quality}) onSave;
  final VoidCallback onCancel;

  const MediaEditor({
    super.key,
    required this.imageBytes,
    this.imagePath,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<MediaEditor> createState() => _MediaEditorState();
}

class _MediaEditorState extends State<MediaEditor> {
  final GlobalKey _repaintKey = GlobalKey();
  
  // Drawing
  List<DrawingPath> _paths = [];
  DrawingPath? _currentPath;
  Color _drawColor = Colors.red;
  double _strokeWidth = 4.0;
  
  // Text overlays
  List<TextOverlay> _textOverlays = [];
  
  // Stickers
  List<StickerOverlay> _stickers = [];
  
  // Mode
  EditorMode _mode = EditorMode.none;
  
  // Quality
  String _quality = 'high';
  
  // One-time view
  bool _isOneTime = false;
  
  // Available colors
  final List<Color> _colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.white,
    Colors.black,
  ];
  
  // Available stickers
  final List<String> _availableStickers = [
    '❤️', '😀', '😂', '🔥', '👍', '🎉', '⭐', '💯',
    '😍', '🥳', '😎', '🤔', '💪', '🙏', '✨', '🌟',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Image with overlays
            Center(
              child: RepaintBoundary(
                key: _repaintKey,
                child: Stack(
                  children: [
                    // Base image - Web compatible
                    Image.memory(
                      widget.imageBytes,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stack) {
                        return Container(
                          color: Colors.grey.shade800,
                          child: const Center(
                            child: Icon(Icons.broken_image, size: 64, color: Colors.white54),
                          ),
                        );
                      },
                    ),
                    
                    // Drawing canvas
                    Positioned.fill(
                      child: GestureDetector(
                        onPanStart: _mode == EditorMode.draw ? _onPanStart : null,
                        onPanUpdate: _mode == EditorMode.draw ? _onPanUpdate : null,
                        onPanEnd: _mode == EditorMode.draw ? _onPanEnd : null,
                        child: CustomPaint(
                          painter: _DrawingPainter(paths: _paths, currentPath: _currentPath),
                          size: Size.infinite,
                        ),
                      ),
                    ),
                    
                    // Text overlays
                    ..._textOverlays.asMap().entries.map((entry) => 
                      _buildDraggableText(entry.key, entry.value)),
                    
                    // Stickers
                    ..._stickers.asMap().entries.map((entry) =>
                      _buildDraggableSticker(entry.key, entry.value)),
                  ],
                ),
              ),
            ),
            
            // Top toolbar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildTopToolbar(),
            ),
            
            // Bottom toolbar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomToolbar(),
            ),
            
            // Color picker
            if (_mode == EditorMode.draw)
              Positioned(
                right: 16,
                top: 100,
                child: _buildColorPicker(),
              ),
            
            // Sticker picker
            if (_mode == EditorMode.sticker)
              _buildStickerPicker(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopToolbar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black54, Colors.transparent],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: widget.onCancel,
          ),
          Row(
            children: [
              // Undo
              if (_paths.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.undo, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      if (_paths.isNotEmpty) _paths.removeLast();
                    });
                  },
                ),
              // Quality selector
              _buildQualitySelector(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQualitySelector() {
    return PopupMenuButton<String>(
      initialValue: _quality,
      onSelected: (value) => setState(() => _quality = value),
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'original', child: Text('Оригинал')),
        const PopupMenuItem(value: 'high', child: Text('Высокое (1080p)')),
        const PopupMenuItem(value: 'medium', child: Text('Среднее (720p)')),
        const PopupMenuItem(value: 'low', child: Text('Низкое (480p)')),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.high_quality, color: Colors.white, size: 16),
            const SizedBox(width: 4),
            Text(
              _quality == 'original' ? 'Ориг' :
              _quality == 'high' ? 'HD' :
              _quality == 'medium' ? '720p' : '480p',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomToolbar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black87, Colors.transparent],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tools
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildToolButton(
                icon: Icons.edit,
                label: 'Рисовать',
                isSelected: _mode == EditorMode.draw,
                onTap: () => setState(() => 
                  _mode = _mode == EditorMode.draw ? EditorMode.none : EditorMode.draw),
              ),
              _buildToolButton(
                icon: Icons.text_fields,
                label: 'Текст',
                isSelected: _mode == EditorMode.text,
                onTap: _addText,
              ),
              _buildToolButton(
                icon: Icons.emoji_emotions,
                label: 'Стикер',
                isSelected: _mode == EditorMode.sticker,
                onTap: () => setState(() =>
                  _mode = _mode == EditorMode.sticker ? EditorMode.none : EditorMode.sticker),
              ),
              _buildToolButton(
                icon: _isOneTime ? Icons.visibility_off : Icons.visibility,
                label: _isOneTime ? '1x просмотр' : 'Обычное',
                isSelected: _isOneTime,
                onTap: () => setState(() => _isOneTime = !_isOneTime),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Send button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('Отправить'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: _saveAndSend,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.white24,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorPicker() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Stroke width
          RotatedBox(
            quarterTurns: 3,
            child: SizedBox(
              width: 100,
              child: Slider(
                value: _strokeWidth,
                min: 2,
                max: 20,
                onChanged: (value) => setState(() => _strokeWidth = value),
                activeColor: _drawColor,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Colors
          ..._colors.map((color) => GestureDetector(
            onTap: () => setState(() => _drawColor = color),
            child: Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: _drawColor == color ? Colors.white : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildStickerPicker() {
    return Positioned(
      bottom: 150,
      left: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: _availableStickers.map((sticker) => GestureDetector(
            onTap: () => _addSticker(sticker),
            child: Text(sticker, style: const TextStyle(fontSize: 32)),
          )).toList(),
        ),
      ),
    );
  }

  Widget _buildDraggableText(int index, TextOverlay overlay) {
    return Positioned(
      left: overlay.position.dx,
      top: overlay.position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _textOverlays[index] = overlay.copyWith(
              position: overlay.position + details.delta,
            );
          });
        },
        onDoubleTap: () => _editText(index, overlay),
        onLongPress: () => _removeText(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: overlay.backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            overlay.text,
            style: TextStyle(
              color: overlay.textColor,
              fontSize: overlay.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDraggableSticker(int index, StickerOverlay sticker) {
    return Positioned(
      left: sticker.position.dx,
      top: sticker.position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _stickers[index] = sticker.copyWith(
              position: sticker.position + details.delta,
            );
          });
        },
        onLongPress: () => setState(() => _stickers.removeAt(index)),
        child: Text(sticker.emoji, style: TextStyle(fontSize: sticker.size)),
      ),
    );
  }

  // Drawing handlers
  void _onPanStart(DragStartDetails details) {
    setState(() {
      _currentPath = DrawingPath(
        color: _drawColor,
        strokeWidth: _strokeWidth,
        points: [details.localPosition],
      );
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_currentPath != null) {
      setState(() {
        _currentPath = _currentPath!.copyWith(
          points: [..._currentPath!.points, details.localPosition],
        );
      });
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_currentPath != null) {
      setState(() {
        _paths.add(_currentPath!);
        _currentPath = null;
      });
    }
  }

  // Text handlers
  void _addText() {
    showDialog(
      context: context,
      builder: (context) => _TextInputDialog(
        onSubmit: (text) {
          setState(() {
            _textOverlays.add(TextOverlay(
              text: text,
              position: const Offset(100, 200),
            ));
            _mode = EditorMode.none;
          });
        },
      ),
    );
  }

  void _editText(int index, TextOverlay overlay) {
    showDialog(
      context: context,
      builder: (context) => _TextInputDialog(
        initialText: overlay.text,
        onSubmit: (text) {
          setState(() {
            _textOverlays[index] = overlay.copyWith(text: text);
          });
        },
      ),
    );
  }

  void _removeText(int index) {
    setState(() => _textOverlays.removeAt(index));
  }

  // Sticker handler
  void _addSticker(String emoji) {
    setState(() {
      _stickers.add(StickerOverlay(
        emoji: emoji,
        position: const Offset(150, 250),
      ));
      _mode = EditorMode.none;
    });
  }

  // Save handler - Web compatible
  Future<void> _saveAndSend() async {
    try {
      // If no edits were made, send original
      if (_paths.isEmpty && _textOverlays.isEmpty && _stickers.isEmpty) {
        widget.onSave(widget.imageBytes, isOneTime: _isOneTime, quality: _quality);
        return;
      }

      // Capture the edited image
      final boundary = _repaintKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        widget.onSave(widget.imageBytes, isOneTime: _isOneTime, quality: _quality);
        return;
      }

      final image = await boundary.toImage(pixelRatio: 2.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      
      if (byteData == null) {
        widget.onSave(widget.imageBytes, isOneTime: _isOneTime, quality: _quality);
        return;
      }

      widget.onSave(
        byteData.buffer.asUint8List(),
        isOneTime: _isOneTime,
        quality: _quality,
      );
    } catch (e) {
      debugPrint('Error saving edited image: $e');
      widget.onSave(widget.imageBytes, isOneTime: _isOneTime, quality: _quality);
    }
  }
}

enum EditorMode { none, draw, text, sticker }

class DrawingPath {
  final Color color;
  final double strokeWidth;
  final List<Offset> points;

  DrawingPath({
    required this.color,
    required this.strokeWidth,
    required this.points,
  });

  DrawingPath copyWith({List<Offset>? points}) {
    return DrawingPath(
      color: color,
      strokeWidth: strokeWidth,
      points: points ?? this.points,
    );
  }
}

class TextOverlay {
  final String text;
  final Offset position;
  final Color textColor;
  final Color backgroundColor;
  final double fontSize;

  TextOverlay({
    required this.text,
    required this.position,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.black54,
    this.fontSize = 24,
  });

  TextOverlay copyWith({String? text, Offset? position}) {
    return TextOverlay(
      text: text ?? this.text,
      position: position ?? this.position,
      textColor: textColor,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
    );
  }
}

class StickerOverlay {
  final String emoji;
  final Offset position;
  final double size;

  StickerOverlay({
    required this.emoji,
    required this.position,
    this.size = 48,
  });

  StickerOverlay copyWith({Offset? position}) {
    return StickerOverlay(
      emoji: emoji,
      position: position ?? this.position,
      size: size,
    );
  }
}

class _DrawingPainter extends CustomPainter {
  final List<DrawingPath> paths;
  final DrawingPath? currentPath;

  _DrawingPainter({required this.paths, this.currentPath});

  @override
  void paint(Canvas canvas, Size size) {
    for (final path in [...paths, if (currentPath != null) currentPath!]) {
      if (path.points.length < 2) continue;

      final paint = Paint()
        ..color = path.color
        ..strokeWidth = path.strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      final uiPath = ui.Path();
      uiPath.moveTo(path.points.first.dx, path.points.first.dy);
      
      for (int i = 1; i < path.points.length; i++) {
        uiPath.lineTo(path.points[i].dx, path.points[i].dy);
      }

      canvas.drawPath(uiPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _DrawingPainter oldDelegate) => true;
}

class _TextInputDialog extends StatefulWidget {
  final String? initialText;
  final Function(String) onSubmit;

  const _TextInputDialog({this.initialText, required this.onSubmit});

  @override
  State<_TextInputDialog> createState() => _TextInputDialogState();
}

class _TextInputDialogState extends State<_TextInputDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить текст'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Введите текст...',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              widget.onSubmit(_controller.text);
            }
            Navigator.pop(context);
          },
          child: const Text('Добавить'),
        ),
      ],
    );
  }
}
