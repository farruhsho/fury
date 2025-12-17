import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../../../../app/theme/app_colors.dart';

/// Camera modes
enum CameraMode { photo, video, videoNote }

/// Camera screen with photo/video/video note modes
class CameraScreen extends StatefulWidget {
  final CameraMode initialMode;
  final ValueChanged<String>? onCapture;
  final VoidCallback? onClose;

  const CameraScreen({
    super.key,
    this.initialMode = CameraMode.photo,
    this.onCapture,
    this.onClose,
  });

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  int _selectedCameraIndex = 0;
  bool _isInitialized = false;
  bool _isRecording = false;
  bool _isFlashOn = false;
  CameraMode _currentMode = CameraMode.photo;
  Duration _recordingDuration = Duration.zero;
  Timer? _recordingTimer;
  final List<String> _recentPhotos = [];

  @override
  void initState() {
    super.initState();
    _currentMode = widget.initialMode;
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        await _setupCamera(_selectedCameraIndex);
      }
    } catch (e) {
      debugPrint('Camera init error: $e');
    }
  }

  Future<void> _setupCamera(int index) async {
    if (_cameras.isEmpty) return;
    
    _controller?.dispose();
    _controller = CameraController(
      _cameras[index],
      ResolutionPreset.high,
      enableAudio: true,
    );

    try {
      await _controller!.initialize();
      setState(() {
        _isInitialized = true;
        _selectedCameraIndex = index;
      });
    } catch (e) {
      debugPrint('Camera setup error: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _recordingTimer?.cancel();
    super.dispose();
  }

  void _switchCamera() {
    if (_cameras.length < 2) return;
    final newIndex = (_selectedCameraIndex + 1) % _cameras.length;
    _setupCamera(newIndex);
  }

  void _toggleFlash() {
    if (_controller == null) return;
    setState(() => _isFlashOn = !_isFlashOn);
    _controller!.setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
  }

  Future<void> _takePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    
    try {
      final file = await _controller!.takePicture();
      widget.onCapture?.call(file.path);
    } catch (e) {
      debugPrint('Take photo error: $e');
    }
  }

  Future<void> _startVideoRecording() async {
    if (_controller == null || _isRecording) return;
    
    try {
      await _controller!.startVideoRecording();
      setState(() => _isRecording = true);
      _startRecordingTimer();
    } catch (e) {
      debugPrint('Start recording error: $e');
    }
  }

  Future<void> _stopVideoRecording() async {
    if (_controller == null || !_isRecording) return;
    
    try {
      final file = await _controller!.stopVideoRecording();
      setState(() => _isRecording = false);
      _stopRecordingTimer();
      widget.onCapture?.call(file.path);
    } catch (e) {
      debugPrint('Stop recording error: $e');
    }
  }

  void _startRecordingTimer() {
    _recordingDuration = Duration.zero;
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _recordingDuration += const Duration(seconds: 1);
      });
    });
  }

  void _stopRecordingTimer() {
    _recordingTimer?.cancel();
    _recordingDuration = Duration.zero;
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera preview
          if (_isInitialized && _controller != null)
            _currentMode == CameraMode.videoNote
                ? _buildVideoNotePreview()
                : _buildFullPreview()
          else
            const Center(child: CircularProgressIndicator()),

          // Top controls
          _buildTopControls(),

          // Recent photos (for photo mode)
          if (_currentMode != CameraMode.videoNote)
            _buildRecentPhotos(),

          // Bottom controls
          _buildBottomControls(),

          // Recording timer (for video modes)
          if (_isRecording)
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _formatDuration(_recordingDuration),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFullPreview() {
    return Positioned.fill(
      child: CameraPreview(_controller!),
    );
  }

  Widget _buildVideoNotePreview() {
    final size = MediaQuery.of(context).size.width * 0.7;
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: _isRecording ? AppColors.primary : Colors.white24,
            width: 4,
          ),
        ),
        child: ClipOval(
          child: CameraPreview(_controller!),
        ),
      ),
    );
  }

  Widget _buildTopControls() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Close button
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 28),
            onPressed: () {
              widget.onClose?.call();
              Navigator.of(context).pop();
            },
          ),
          // Flash toggle
          IconButton(
            icon: Icon(
              _isFlashOn ? Icons.flash_on : Icons.flash_off,
              color: _isFlashOn ? Colors.yellow : Colors.white,
              size: 28,
            ),
            onPressed: _toggleFlash,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentPhotos() {
    return Positioned(
      bottom: 160,
      left: 0,
      right: 0,
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5, // Placeholder
        itemBuilder: (context, index) {
          return Container(
            width: 60,
            height: 60,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.image, color: Colors.grey),
          );
        },
      ),
    );
  }

  Widget _buildBottomControls() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Capture button row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Gallery button
                if (_currentMode != CameraMode.videoNote)
                  IconButton(
                    icon: const Icon(Icons.photo_library, color: Colors.white, size: 28),
                    onPressed: () {
                      // Open gallery
                    },
                  )
                else
                  // Switch camera for video note
                  IconButton(
                    icon: const Icon(Icons.cameraswitch, color: Colors.white, size: 28),
                    onPressed: _switchCamera,
                  ),

                // Capture button
                GestureDetector(
                  onTap: () {
                    if (_currentMode == CameraMode.photo) {
                      _takePhoto();
                    }
                  },
                  onLongPress: () {
                    if (_currentMode != CameraMode.photo) {
                      _startVideoRecording();
                    }
                  },
                  onLongPressEnd: (_) {
                    if (_isRecording) {
                      _stopVideoRecording();
                    }
                  },
                  child: _buildCaptureButton(),
                ),

                // Switch camera
                if (_currentMode != CameraMode.videoNote)
                  IconButton(
                    icon: const Icon(Icons.cameraswitch, color: Colors.white, size: 28),
                    onPressed: _switchCamera,
                  )
                else
                  // Lock button for video note
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.lock_outline, color: Colors.white, size: 20),
                        SizedBox(height: 2),
                        Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 14),
                      ],
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 20),

            // Mode selector
            _buildModeSelector(),

            // Cancel hint for video note
            if (_currentMode == CameraMode.videoNote)
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chevron_left, color: Colors.grey, size: 20),
                    SizedBox(width: 4),
                    Text(
                      'Проведите, чтобы отменить',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaptureButton() {
    final isVideo = _currentMode != CameraMode.photo;
    final isVideoNote = _currentMode == CameraMode.videoNote;

    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: _isRecording ? Colors.red : Colors.white,
          width: 4,
        ),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _isRecording ? 24 : 56,
          height: _isRecording ? 24 : 56,
          decoration: BoxDecoration(
            color: isVideo ? Colors.red : Colors.white,
            shape: _isRecording ? BoxShape.rectangle : BoxShape.circle,
            borderRadius: _isRecording ? BorderRadius.circular(4) : null,
          ),
          child: isVideoNote && !_isRecording
              ? const Icon(Icons.videocam, color: Colors.white, size: 24)
              : null,
        ),
      ),
    );
  }

  Widget _buildModeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildModeButton('Видео', CameraMode.video),
        const SizedBox(width: 24),
        _buildModeButton('Фото', CameraMode.photo),
        const SizedBox(width: 24),
        _buildModeButton('Видеозаметка', CameraMode.videoNote),
      ],
    );
  }

  Widget _buildModeButton(String label, CameraMode mode) {
    final isSelected = _currentMode == mode;
    return GestureDetector(
      onTap: () => setState(() => _currentMode = mode),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
      ),
    );
  }
}
