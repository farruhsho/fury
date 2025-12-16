import 'package:permission_handler/permission_handler.dart';

/// Service for handling runtime permissions
class PermissionService {
  /// Request camera permission
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  /// Request microphone permission
  Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  /// Request storage permission
  Future<bool> requestStoragePermission() async {
    if (await Permission.storage.isGranted) {
      return true;
    }
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  /// Request photos permission (iOS/Android 13+)
  Future<bool> requestPhotosPermission() async {
    final status = await Permission.photos.request();
    return status.isGranted;
  }

  /// Request all media permissions needed for messaging
  Future<Map<String, bool>> requestMediaPermissions() async {
    final results = await [
      Permission.camera,
      Permission.microphone,
      Permission.storage,
      Permission.photos,
    ].request();

    return {
      'camera': results[Permission.camera]?.isGranted ?? false,
      'microphone': results[Permission.microphone]?.isGranted ?? false,
      'storage': results[Permission.storage]?.isGranted ?? false,
      'photos': results[Permission.photos]?.isGranted ?? false,
    };
  }

  /// Check if camera permission is granted
  Future<bool> isCameraGranted() async {
    return await Permission.camera.isGranted;
  }

  /// Check if microphone permission is granted
  Future<bool> isMicrophoneGranted() async {
    return await Permission.microphone.isGranted;
  }

  /// Check if storage permission is granted
  Future<bool> isStorageGranted() async {
    return await Permission.storage.isGranted;
  }

  /// Open app settings
  Future<bool> openSettings() async {
    return await openAppSettings();
  }

  /// Check permission status
  Future<PermissionStatus> checkPermissionStatus(Permission permission) async {
    return await permission.status;
  }

  /// Request permission with rationale
  Future<bool> requestPermissionWithRationale({
    required Permission permission,
    required String rationale,
  }) async {
    final status = await permission.status;

    if (status.isGranted) {
      return true;
    }

    if (status.isDenied) {
      final result = await permission.request();
      return result.isGranted;
    }

    if (status.isPermanentlyDenied) {
      // Show dialog to open settings
      return false;
    }

    return false;
  }
}
