import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:uuid/uuid.dart';

/// Service for generating video thumbnails
class VideoThumbnailService {

  /// Generate a thumbnail from video file
  /// Returns the path to the generated thumbnail
  static Future<String?> generateThumbnail(String videoPath) async {
    // Video thumbnails are not supported on web platform
    if (kIsWeb) {
      print('⚠️ [THUMBNAIL] Not supported on web platform');
      return null;
    }

    try {
      // Create video player controller to get first frame
      final file = File(videoPath);
      if (!await file.exists()) {
        print('❌ [THUMBNAIL] Video file not found: $videoPath');
        return null;
      }

      // Get temp directory for thumbnail
      final tempDir = await getTemporaryDirectory();
      final thumbnailPath = '${tempDir.path}/thumb_${const Uuid().v4()}.jpg';

      // Note: For a production app, use video_thumbnail package
      // This is a placeholder that creates a black frame
      // flutter pub add video_thumbnail
      
      // For now, return null - actual implementation would use:
      // final thumbnail = await VideoThumbnail.thumbnailFile(
      //   video: videoPath,
      //   thumbnailPath: thumbnailPath,
      //   imageFormat: ImageFormat.JPEG,
      //   maxHeight: 200,
      //   quality: 75,
      // );
      
      print('📸 [THUMBNAIL] Would generate thumbnail at: $thumbnailPath');
      return null; // Return null until video_thumbnail is added
      
    } catch (e) {
      print('❌ [THUMBNAIL] Error generating: $e');
      return null;
    }
  }

  /// Generate thumbnail from video bytes
  static Future<String?> generateThumbnailFromBytes(
    Uint8List videoBytes,
    String extension,
  ) async {
    // Video thumbnails are not supported on web platform
    if (kIsWeb) {
      print('⚠️ [THUMBNAIL] Not supported on web platform');
      return null;
    }

    try {
      final tempDir = await getTemporaryDirectory();
      final videoPath = '${tempDir.path}/temp_video_${const Uuid().v4()}.$extension';
      
      // Write video to temp file
      final file = File(videoPath);
      await file.writeAsBytes(videoBytes);
      
      // Generate thumbnail
      final thumbnailPath = await generateThumbnail(videoPath);
      
      // Clean up temp video
      await file.delete();
      
      return thumbnailPath;
    } catch (e) {
      print('❌ [THUMBNAIL] Error from bytes: $e');
      return null;
    }
  }

  /// Get video duration in seconds
  static Future<int> getVideoDuration(String videoPath) async {
    // Video duration from file is not supported on web platform
    if (kIsWeb) {
      print('⚠️ [THUMBNAIL] getVideoDuration not supported on web platform');
      return 0;
    }

    try {
      final controller = VideoPlayerController.file(File(videoPath));
      await controller.initialize();
      final duration = controller.value.duration.inSeconds;
      await controller.dispose();
      return duration;
    } catch (e) {
      print('❌ [THUMBNAIL] Error getting duration: $e');
      return 0;
    }
  }
}
