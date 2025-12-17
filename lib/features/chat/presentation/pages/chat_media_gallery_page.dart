import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Page to display media, links and documents from a chat
class ChatMediaGalleryPage extends StatefulWidget {
  final String chatId;
  final String chatName;

  const ChatMediaGalleryPage({
    super.key,
    required this.chatId,
    required this.chatName,
  });

  @override
  State<ChatMediaGalleryPage> createState() => _ChatMediaGalleryPageState();
}

class _ChatMediaGalleryPageState extends State<ChatMediaGalleryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatName),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Медиа', icon: Icon(Icons.photo_library)),
            Tab(text: 'Ссылки', icon: Icon(Icons.link)),
            Tab(text: 'Документы', icon: Icon(Icons.insert_drive_file)),
          ],
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primary,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _MediaTab(chatId: widget.chatId),
          _LinksTab(chatId: widget.chatId),
          _DocsTab(chatId: widget.chatId),
        ],
      ),
    );
  }
}

/// Media tab - shows images and videos
class _MediaTab extends StatelessWidget {
  final String chatId;

  const _MediaTab({required this.chatId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .where('type', whereIn: ['image', 'video'])
          .orderBy('createdAt', descending: true)
          .limit(100)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildEmptyState(
            icon: Icons.photo_library_outlined,
            title: 'Нет медиа',
            subtitle: 'Фотографии и видео будут здесь',
          );
        }

        final media = snapshot.data!.docs;

        return GridView.builder(
          padding: const EdgeInsets.all(4),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: media.length,
          itemBuilder: (context, index) {
            final doc = media[index];
            final data = doc.data() as Map<String, dynamic>;
            final type = data['type'] as String? ?? 'image';
            final mediaUrl = data['mediaUrl'] as String? ?? '';

            return GestureDetector(
              onTap: () => _openMedia(context, mediaUrl, type),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: type == 'video' 
                        ? (data['thumbnailUrl'] as String? ?? mediaUrl)
                        : mediaUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.error),
                    ),
                  ),
                  if (type == 'video')
                    const Center(
                      child: Icon(
                        Icons.play_circle_filled,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _openMedia(BuildContext context, String url, String type) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: type == 'video'
              ? const Center(child: Text('Video player', style: TextStyle(color: Colors.white)))
              : InteractiveViewer(
                  child: CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.contain,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(title, style: AppTypography.h3),
          const SizedBox(height: 8),
          Text(subtitle, style: AppTypography.bodyMedium.copyWith(color: Colors.grey)),
        ],
      ),
    );
  }
}

/// Links tab - shows shared links
class _LinksTab extends StatelessWidget {
  final String chatId;

  const _LinksTab({required this.chatId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .where('hasLink', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(100)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildEmptyState();
        }

        final links = snapshot.data!.docs;

        return ListView.builder(
          itemCount: links.length,
          itemBuilder: (context, index) {
            final data = links[index].data() as Map<String, dynamic>;
            final text = data['text'] as String? ?? '';
            final url = _extractUrl(text);

            return ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.link),
              ),
              title: Text(
                url,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () => _openUrl(url),
            );
          },
        );
      },
    );
  }

  String _extractUrl(String text) {
    final urlRegex = RegExp(
      r'https?://[^\s]+',
      caseSensitive: false,
    );
    final match = urlRegex.firstMatch(text);
    return match?.group(0) ?? text;
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.link_off, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('Нет ссылок', style: AppTypography.h3),
          const SizedBox(height: 8),
          Text(
            'Здесь будут отображаться ссылки',
            style: AppTypography.bodyMedium.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

/// Documents tab - shows shared files
class _DocsTab extends StatelessWidget {
  final String chatId;

  const _DocsTab({required this.chatId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .where('type', isEqualTo: 'file')
          .orderBy('createdAt', descending: true)
          .limit(100)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildEmptyState();
        }

        final docs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final fileName = data['fileName'] as String? ?? 'Document';
            final fileSize = data['fileSize'] as int? ?? 0;
            final fileUrl = data['mediaUrl'] as String? ?? '';

            return ListTile(
              leading: _getFileIcon(fileName),
              title: Text(fileName, maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Text(_formatFileSize(fileSize)),
              trailing: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () => _downloadFile(fileUrl),
              ),
            );
          },
        );
      },
    );
  }

  Widget _getFileIcon(String fileName) {
    IconData icon;
    Color color;

    if (fileName.endsWith('.pdf')) {
      icon = Icons.picture_as_pdf;
      color = Colors.red;
    } else if (fileName.endsWith('.doc') || fileName.endsWith('.docx')) {
      icon = Icons.description;
      color = Colors.blue;
    } else if (fileName.endsWith('.xls') || fileName.endsWith('.xlsx')) {
      icon = Icons.table_chart;
      color = Colors.green;
    } else {
      icon = Icons.insert_drive_file;
      color = Colors.grey;
    }

    return CircleAvatar(
      backgroundColor: color.withOpacity(0.1),
      child: Icon(icon, color: color),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  Future<void> _downloadFile(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.folder_open, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('Нет документов', style: AppTypography.h3),
          const SizedBox(height: 8),
          Text(
            'Здесь будут отображаться файлы',
            style: AppTypography.bodyMedium.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
