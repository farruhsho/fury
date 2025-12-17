import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/link_preview_service.dart';

/// Widget for displaying link previews in messages
class LinkPreviewWidget extends StatefulWidget {
  final String url;
  final bool isMe;

  const LinkPreviewWidget({
    super.key,
    required this.url,
    this.isMe = false,
  });

  @override
  State<LinkPreviewWidget> createState() => _LinkPreviewWidgetState();
}

class _LinkPreviewWidgetState extends State<LinkPreviewWidget> {
  final LinkPreviewService _previewService = LinkPreviewService();
  LinkPreviewData? _preview;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadPreview();
  }

  Future<void> _loadPreview() async {
    try {
      final preview = await _previewService.getPreview(widget.url);
      if (mounted) {
        setState(() {
          _preview = preview;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _openUrl() async {
    final uri = Uri.tryParse(widget.url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_hasError || _preview == null) {
      return _buildMinimalLink();
    }

    return _buildPreview();
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: widget.isMe
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(
                widget.isMe ? Colors.white70 : AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Loading preview...',
            style: AppTypography.caption.copyWith(
              color: widget.isMe ? Colors.white70 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMinimalLink() {
    return GestureDetector(
      onTap: _openUrl,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: widget.isMe
              ? Colors.white.withValues(alpha: 0.1)
              : AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.link,
              size: 14,
              color: widget.isMe ? Colors.white70 : AppColors.primary,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                Uri.tryParse(widget.url)?.host ?? widget.url,
                style: AppTypography.caption.copyWith(
                  color: widget.isMe ? Colors.white : AppColors.primary,
                  decoration: TextDecoration.underline,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreview() {
    return GestureDetector(
      onTap: _openUrl,
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: widget.isMe
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.isMe
                ? Colors.white.withValues(alpha: 0.2)
                : Colors.grey.withValues(alpha: 0.2),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            if (_preview!.hasImage)
              Container(
                height: 120,
                width: double.infinity,
                color: Colors.grey[200],
                child: Image.network(
                  _preview!.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Site name with favicon
                  Row(
                    children: [
                      if (_preview!.faviconUrl != null)
                        Container(
                          width: 16,
                          height: 16,
                          margin: const EdgeInsets.only(right: 6),
                          child: Image.network(
                            _preview!.faviconUrl!,
                            errorBuilder: (_, __, ___) => Icon(
                              Icons.public,
                              size: 16,
                              color: widget.isMe ? Colors.white70 : Colors.grey,
                            ),
                          ),
                        ),
                      Expanded(
                        child: Text(
                          _preview!.siteName ?? '',
                          style: AppTypography.caption.copyWith(
                            color: widget.isMe ? Colors.white60 : Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  
                  if (_preview!.hasTitle) ...[
                    const SizedBox(height: 4),
                    Text(
                      _preview!.title!,
                      style: AppTypography.bodyMedium.copyWith(
                        color: widget.isMe ? Colors.white : AppColors.textPrimaryLight,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  
                  if (_preview!.hasDescription) ...[
                    const SizedBox(height: 4),
                    Text(
                      _preview!.description!,
                      style: AppTypography.bodySmall.copyWith(
                        color: widget.isMe ? Colors.white70 : AppColors.textSecondaryLight,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _previewService.dispose();
    super.dispose();
  }
}
