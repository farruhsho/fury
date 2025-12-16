import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

/// Loading widget with circular progress indicator
class LoadingWidget extends StatelessWidget {
  final String? message;
  final Color? color;
  
  const LoadingWidget({
    super.key,
    this.message,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: color ?? AppColors.primary,
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

/// Small loading indicator for inline use
class SmallLoadingIndicator extends StatelessWidget {
  final Color? color;
  final double size;
  
  const SmallLoadingIndicator({
    super.key,
    this.color,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: color ?? AppColors.primary,
      ),
    );
  }
}
