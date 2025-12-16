import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';

/// Media Gallery page with tabs for Media, Documents, Links
class MediaGalleryPage extends StatefulWidget {
  final String chatId;
  final String? chatName;

  const MediaGalleryPage({
    super.key, 
    required this.chatId,
    this.chatName,
  });

  @override
  State<MediaGalleryPage> createState() => _MediaGalleryPageState();
}

class _MediaGalleryPageState extends State<MediaGalleryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<MediaItem> _mediaItems = [];
  List<MediaItem> _documents = [];
  List<MediaItem> _links = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadMedia();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadMedia() async {
    try {
      // Load all messages with attachments
      final messagesSnapshot = await FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatId)
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .limit(100)
          .get();

      final media = <MediaItem>[];
      final docs = <MediaItem>[];
      final links = <MediaItem>[];

      for (final doc in messagesSnapshot.docs) {
        final data = doc.data();
        final createdAt = (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now();
        final text = data['text'] as String? ?? '';
        final attachments = data['attachments'] as List<dynamic>?;

        // Check for links in text
        final urlRegex = RegExp(r'https?://[^\s]+');
        final matches = urlRegex.allMatches(text);
        for (final match in matches) {
          links.add(MediaItem(
            id: '${doc.id}_link_${match.start}',
            type: MediaType.link,
            url: match.group(0)!,
            createdAt: createdAt,
          ));
        }

        // Check attachments
        if (attachments != null) {
          for (final attachment in attachments) {
            final url = attachment['url'] as String? ?? '';
            final type = attachment['type'] as String? ?? '';
            final name = attachment['name'] as String? ?? 'File';

            if (type.contains('image') || type.contains('video')) {
              media.add(MediaItem(
                id: '${doc.id}_${attachment.hashCode}',
                type: type.contains('video') ? MediaType.video : MediaType.image,
                url: url,
                thumbnailUrl: attachment['thumbnailUrl'] as String?,
                duration: attachment['duration'] as String?,
                createdAt: createdAt,
              ));
            } else {
              docs.add(MediaItem(
                id: '${doc.id}_${attachment.hashCode}',
                type: MediaType.document,
                url: url,
                name: name,
                size: attachment['size'] as int?,
                createdAt: createdAt,
              ));
            }
          }
        }
      }

      setState(() {
        _mediaItems = media;
        _documents = docs;
        _links = links;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          widget.chatName ?? 'Медиа',
          style: AppTypography.h3.copyWith(color: AppColors.textPrimaryLight),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondaryLight,
          tabs: const [
            Tab(text: 'Медиа'),
            Tab(text: 'Докум.'),
            Tab(text: 'Ссылки'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildMediaGrid(),
                _buildDocumentsList(),
                _buildLinksList(),
              ],
            ),
    );
  }

  Widget _buildMediaGrid() {
    if (_mediaItems.isEmpty) {
      return _buildEmptyState('Нет медиа файлов');
    }

    // Group by date
    final grouped = _groupByDate(_mediaItems);

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.sm),
      itemCount: grouped.length,
      itemBuilder: (context, index) {
        final group = grouped.entries.elementAt(index);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.sm,
                horizontal: AppSpacing.xs,
              ),
              child: Text(
                group.key,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondaryLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              itemCount: group.value.length,
              itemBuilder: (context, i) => _buildMediaTile(group.value[i]),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMediaTile(MediaItem item) {
    return GestureDetector(
      onTap: () {
        // Open media viewer
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Thumbnail
          Container(
            color: AppColors.surfaceLight,
            child: item.thumbnailUrl != null || item.url.isNotEmpty
                ? Image.network(
                    item.thumbnailUrl ?? item.url,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Center(
                      child: Icon(Icons.broken_image, color: AppColors.textSecondaryLight),
                    ),
                  )
                : const Center(
                    child: Icon(Icons.image, color: AppColors.textSecondaryLight),
                  ),
          ),
          // Video indicator
          if (item.type == MediaType.video)
            Positioned(
              left: 4,
              bottom: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.videocam, size: 12, color: Colors.white),
                    if (item.duration != null) ...[
                      const SizedBox(width: 2),
                      Text(
                        item.duration!,
                        style: const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDocumentsList() {
    if (_documents.isEmpty) {
      return _buildEmptyState('Нет документов');
    }

    return ListView.builder(
      itemCount: _documents.length,
      itemBuilder: (context, index) {
        final doc = _documents[index];
        return ListTile(
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: const Icon(Icons.insert_drive_file, color: AppColors.primary),
          ),
          title: Text(
            doc.name ?? 'Document',
            style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimaryLight),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            _formatFileSize(doc.size) + ' · ' + _formatDate(doc.createdAt),
            style: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
          ),
          onTap: () {
            // Open document
          },
        );
      },
    );
  }

  Widget _buildLinksList() {
    if (_links.isEmpty) {
      return _buildEmptyState('Нет ссылок');
    }

    return ListView.builder(
      itemCount: _links.length,
      itemBuilder: (context, index) {
        final link = _links[index];
        return ListTile(
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: const Icon(Icons.link, color: AppColors.accent),
          ),
          title: Text(
            link.url,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.primary,
              decoration: TextDecoration.underline,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            _formatDate(link.createdAt),
            style: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
          ),
          onTap: () {
            // Open link
          },
        );
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open,
            size: 64,
            color: AppColors.textSecondaryLight,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, List<MediaItem>> _groupByDate(List<MediaItem> items) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastWeek = today.subtract(const Duration(days: 7));
    final lastMonth = today.subtract(const Duration(days: 30));

    final grouped = <String, List<MediaItem>>{};

    for (final item in items) {
      final date = DateTime(item.createdAt.year, item.createdAt.month, item.createdAt.day);
      String key;

      if (date == today) {
        key = 'СЕГОДНЯ';
      } else if (date.isAfter(lastWeek)) {
        key = 'НА ПРОШЛОЙ НЕДЕЛЕ';
      } else if (date.isAfter(lastMonth)) {
        key = 'В ПРОШЛОМ МЕСЯЦЕ';
      } else {
        key = 'РАНЕЕ';
      }

      grouped.putIfAbsent(key, () => []).add(item);
    }

    return grouped;
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  String _formatFileSize(int? bytes) {
    if (bytes == null) return '';
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

enum MediaType { image, video, document, link }

class MediaItem {
  final String id;
  final MediaType type;
  final String url;
  final String? thumbnailUrl;
  final String? name;
  final String? duration;
  final int? size;
  final DateTime createdAt;

  MediaItem({
    required this.id,
    required this.type,
    required this.url,
    this.thumbnailUrl,
    this.name,
    this.duration,
    this.size,
    required this.createdAt,
  });
}
