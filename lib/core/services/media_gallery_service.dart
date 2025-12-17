import 'package:cloud_firestore/cloud_firestore.dart';

/// Service for managing media gallery in chats
class MediaGalleryService {
  final FirebaseFirestore _firestore;

  static const int pageSize = 20;

  MediaGalleryService({
    FirebaseFirestore? firestore,
  })  : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Get all media from a chat (images, videos, files)
  Future<MediaGalleryResult> getMediaFromChat({
    required String chatId,
    MediaType? type,
    DocumentSnapshot? lastDocument,
  }) async {
    Query query = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where('type', whereIn: type != null
            ? [type.name]
            : ['image', 'video', 'audio', 'document'])
        .orderBy('createdAt', descending: true)
        .limit(pageSize);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final snapshot = await query.get();
    
    final items = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return MediaItem.fromFirestore(doc.id, data);
    }).toList();

    return MediaGalleryResult(
      items: items,
      hasMore: items.length == pageSize,
      lastDocument: snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
    );
  }

  /// Get media count by type
  Future<Map<MediaType, int>> getMediaCounts(String chatId) async {
    final counts = <MediaType, int>{};

    for (final type in MediaType.values) {
      final snapshot = await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .where('type', isEqualTo: type.name)
          .count()
          .get();
      
      counts[type] = snapshot.count ?? 0;
    }

    return counts;
  }

  /// Get shared links from chat
  Future<List<LinkItem>> getSharedLinks(String chatId) async {
    final snapshot = await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where('type', isEqualTo: 'text')
        .orderBy('createdAt', descending: true)
        .limit(100)
        .get();

    final links = <LinkItem>[];
    final urlRegex = RegExp(r'https?://[^\s]+');

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final text = data['text'] as String?;
      if (text == null) continue;

      final matches = urlRegex.allMatches(text);
      for (final match in matches) {
        links.add(LinkItem(
          messageId: doc.id,
          url: match.group(0)!,
          text: text,
          createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
          senderId: data['senderId'] as String,
        ));
      }
    }

    return links;
  }

  /// Search media by sender
  Future<List<MediaItem>> getMediaBySender({
    required String chatId,
    required String senderId,
    MediaType? type,
  }) async {
    Query query = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where('senderId', isEqualTo: senderId);

    if (type != null) {
      query = query.where('type', isEqualTo: type.name);
    } else {
      query = query.where('type', whereIn: ['image', 'video', 'audio', 'document']);
    }

    final snapshot = await query
        .orderBy('createdAt', descending: true)
        .limit(50)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return MediaItem.fromFirestore(doc.id, data);
    }).toList();
  }

  /// Get media in date range
  Future<List<MediaItem>> getMediaInDateRange({
    required String chatId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final snapshot = await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where('type', whereIn: ['image', 'video', 'audio', 'document'])
        .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .where('createdAt', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return MediaItem.fromFirestore(doc.id, data);
    }).toList();
  }
}

enum MediaType {
  image,
  video,
  audio,
  document,
}

class MediaItem {
  final String id;
  final MediaType type;
  final String url;
  final String? thumbnailUrl;
  final String? fileName;
  final int? fileSize;
  final int? durationMs;
  final DateTime createdAt;
  final String senderId;

  MediaItem({
    required this.id,
    required this.type,
    required this.url,
    this.thumbnailUrl,
    this.fileName,
    this.fileSize,
    this.durationMs,
    required this.createdAt,
    required this.senderId,
  });

  factory MediaItem.fromFirestore(String id, Map<String, dynamic> data) {
    final attachments = List<Map<String, dynamic>>.from(data['attachments'] ?? []);
    final firstAttachment = attachments.isNotEmpty ? attachments.first : <String, dynamic>{};

    return MediaItem(
      id: id,
      type: MediaType.values.firstWhere(
        (t) => t.name == data['type'],
        orElse: () => MediaType.document,
      ),
      url: firstAttachment['url'] as String? ?? data['mediaUrl'] as String? ?? '',
      thumbnailUrl: firstAttachment['thumbnailUrl'] as String?,
      fileName: firstAttachment['fileName'] as String?,
      fileSize: firstAttachment['fileSize'] as int?,
      durationMs: firstAttachment['durationMs'] as int?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      senderId: data['senderId'] as String,
    );
  }

  String get fileSizeFormatted {
    if (fileSize == null) return '';
    if (fileSize! < 1024) return '$fileSize B';
    if (fileSize! < 1024 * 1024) return '${(fileSize! / 1024).toStringAsFixed(1)} KB';
    return '${(fileSize! / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

class LinkItem {
  final String messageId;
  final String url;
  final String text;
  final DateTime createdAt;
  final String senderId;

  LinkItem({
    required this.messageId,
    required this.url,
    required this.text,
    required this.createdAt,
    required this.senderId,
  });

  String get domain {
    try {
      return Uri.parse(url).host;
    } catch (_) {
      return url;
    }
  }
}

class MediaGalleryResult {
  final List<MediaItem> items;
  final bool hasMore;
  final DocumentSnapshot? lastDocument;

  MediaGalleryResult({
    required this.items,
    required this.hasMore,
    this.lastDocument,
  });
}
