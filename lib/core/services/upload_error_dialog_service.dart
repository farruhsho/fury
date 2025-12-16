import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';

/// Service for showing upload error dialogs with retry option
class UploadErrorDialogService {
  /// Show upload failed dialog with retry option
  static Future<bool?> showUploadError({
    required BuildContext context,
    required String fileName,
    required String errorMessage,
    VoidCallback? onRetry,
  }) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.cloud_off,
          color: AppColors.error,
          size: 48,
        ),
        title: const Text('Upload Failed'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Failed to upload:',
              style: AppTypography.bodySmall.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.insert_drive_file, size: 20, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      fileName,
                      style: AppTypography.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              errorMessage,
              style: AppTypography.bodySmall.copyWith(color: Colors.red[700]),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context, true);
              onRetry?.call();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  /// Show network error dialog
  static Future<void> showNetworkError(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.wifi_off,
          color: Colors.orange,
          size: 48,
        ),
        title: const Text('No Internet Connection'),
        content: const Text(
          'Please check your internet connection and try again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Show storage error dialog
  static Future<void> showStorageError(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.storage,
          color: Colors.orange,
          size: 48,
        ),
        title: const Text('Storage Full'),
        content: const Text(
          'Your device storage is full. Please free up some space and try again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Show file too large error
  static Future<void> showFileTooLargeError(
    BuildContext context, {
    required int maxSizeMb,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.file_present,
          color: Colors.orange,
          size: 48,
        ),
        title: const Text('File Too Large'),
        content: Text(
          'Maximum file size is $maxSizeMb MB. Please choose a smaller file.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Show uploading snackbar with progress
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showUploadingSnackbar(
    BuildContext context, {
    required String fileName,
    double progress = 0.0,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(minutes: 5),
        content: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                value: progress > 0 ? progress : null,
                strokeWidth: 2,
                valueColor: const AlwaysStoppedAnimation(Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Uploading...'),
                  Text(
                    fileName,
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (progress > 0)
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
