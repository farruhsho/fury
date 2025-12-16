import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';

/// Custom snackbar for displaying messages
class CustomSnackbar {
  /// Show success snackbar
  static void showSuccess(BuildContext context, String message) {
    _show(
      context,
      message,
      AppColors.success,
      Icons.check_circle,
    );
  }
  
  /// Show error snackbar
  static void showError(BuildContext context, String message) {
    _show(
      context,
      message,
      AppColors.error,
      Icons.error,
    );
  }
  
  /// Show info snackbar
  static void showInfo(BuildContext context, String message) {
    _show(
      context,
      message,
      AppColors.info,
      Icons.info,
    );
  }
  
  /// Show warning snackbar
  static void showWarning(BuildContext context, String message) {
    _show(
      context,
      message,
      AppColors.warning,
      Icons.warning,
    );
  }
  
  /// Show custom snackbar
  static void _show(
    BuildContext context,
    String message,
    Color color,
    IconData icon,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        margin: const EdgeInsets.all(AppSpacing.md),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
