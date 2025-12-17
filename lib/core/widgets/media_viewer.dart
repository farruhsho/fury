import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../app/theme/app_colors.dart';

/// Full-screen media viewer with zoom, swipe, and video support
class MediaViewer extends StatefulWidget {
  final List<MediaItem> items;
  final int initialIndex;
  final String? heroTag;

  const MediaViewer({
    super.key,
    required this.items,
    this.initialIndex = 0,
    this.heroTag,
  });

  /// Show media viewer as full-screen overlay
  static Future<void> show(
    BuildContext context, {
    required List<MediaItem> items,
    int initialIndex = 0,
    String? heroTag,
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black87,
        pageBuilder: (context, animation, secondaryAnimation) {
          return MediaViewer(
            items: items,
            initialIndex: initialIndex,
            heroTag: heroTag,
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  State<MediaViewer> createState() => _MediaViewerState();
}

class _MediaViewerState extends State<MediaViewer> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late int _currentIndex;
  bool _showControls = true;
  VideoPlayerController? _videoController;
  late AnimationController _fadeController;
  
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: 1.0,
    );
    
    // Hide system UI for immersive experience
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    
    // Initialize video if first item is video
    if (widget.items[_currentIndex].isVideo) {
      _initVideoPlayer(widget.items[_currentIndex]);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    _videoController?.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _initVideoPlayer(MediaItem item) {
    _videoController?.dispose();
    
    if (item.url != null) {
      _videoController = VideoPlayerController.networkUrl(Uri.parse(item.url!))
        ..initialize().then((_) {
          setState(() {});
          _videoController!.play();
        });
    } else if (item.file != null) {
      _videoController = VideoPlayerController.file(item.file!)
        ..initialize().then((_) {
          setState(() {});
          _videoController!.play();
        });
    }
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) {
      _fadeController.forward();
    } else {
      _fadeController.reverse();
    }
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
    
    // Handle video player switching
    final item = widget.items[index];
    if (item.isVideo) {
      _initVideoPlayer(item);
    } else {
      _videoController?.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Media content with gesture detection
          GestureDetector(
            onTap: _toggleControls,
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity != null && details.primaryVelocity!.abs() > 500) {
                Navigator.of(context).pop();
              }
            },
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                
                if (item.isVideo) {
                  return _buildVideoPlayer(item);
                } else {
                  return _buildImageViewer(item, index == widget.initialIndex);
                }
              },
            ),
          ),
          
          // Top controls
          if (_showControls)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _fadeController,
                child: _buildTopControls(),
              ),
            ),
          
          // Bottom controls
          if (_showControls)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _fadeController,
                child: _buildBottomControls(),
              ),
            ),
          
          // Page indicator
          if (widget.items.length > 1)
            Positioned(
              top: MediaQuery.of(context).padding.top + 60,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  '${_currentIndex + 1} / ${widget.items.length}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageViewer(MediaItem item, bool isInitial) {
    Widget imageWidget;
    
    if (item.url != null) {
      imageWidget = CachedNetworkImage(
        imageUrl: item.url!,
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
        errorWidget: (context, url, error) => const Center(
          child: Icon(Icons.error, color: Colors.white),
        ),
      );
    } else if (item.file != null) {
      imageWidget = Image.file(
        item.file!,
        fit: BoxFit.contain,
      );
    } else {
      imageWidget = const Center(
        child: Icon(Icons.broken_image, color: Colors.white),
      );
    }

    // Wrap with InteractiveViewer for zoom
    Widget child = InteractiveViewer(
      minScale: 0.5,
      maxScale: 4.0,
      child: Center(child: imageWidget),
    );

    // Add hero animation for initial image
    if (isInitial && widget.heroTag != null) {
      child = Hero(
        tag: widget.heroTag!,
        child: child,
      );
    }

    return child;
  }

  Widget _buildVideoPlayer(MediaItem item) {
    if (_videoController == null || !_videoController!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: _videoController!.value.aspectRatio,
          child: VideoPlayer(_videoController!),
        ),
        
        // Play/Pause button
        GestureDetector(
          onTap: () {
            setState(() {
              if (_videoController!.value.isPlaying) {
                _videoController!.pause();
              } else {
                _videoController!.play();
              }
            });
          },
          child: AnimatedOpacity(
            opacity: !_videoController!.value.isPlaying ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopControls() {
    final item = widget.items[_currentIndex];
    
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black54,
            Colors.transparent,
          ],
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.senderName != null)
                  Text(
                    item.senderName!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (item.timestamp != null)
                  Text(
                    _formatTime(item.timestamp!),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              // TODO: Share media
            },
          ),
          IconButton(
            icon: const Icon(Icons.download, color: Colors.white),
            onPressed: () {
              // TODO: Download media
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    final item = widget.items[_currentIndex];
    
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 16,
        left: 16,
        right: 16,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black54,
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Video progress bar
          if (item.isVideo && _videoController != null && _videoController!.value.isInitialized)
            _buildVideoProgress(),
          
          // Caption
          if (item.caption != null && item.caption!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                item.caption!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVideoProgress() {
    return VideoProgressIndicator(
      _videoController!,
      allowScrubbing: true,
      colors: const VideoProgressColors(
        playedColor: AppColors.primary,
        bufferedColor: Colors.white24,
        backgroundColor: Colors.white12,
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    
    if (diff.inDays == 0) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }
}

/// Model for media items in the viewer
class MediaItem {
  final String? url;
  final File? file;
  final bool isVideo;
  final String? caption;
  final String? senderName;
  final DateTime? timestamp;
  final String? thumbnailUrl;

  const MediaItem({
    this.url,
    this.file,
    this.isVideo = false,
    this.caption,
    this.senderName,
    this.timestamp,
    this.thumbnailUrl,
  });
}
