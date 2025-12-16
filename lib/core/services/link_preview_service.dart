import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:flutter/foundation.dart';

/// Service for extracting link previews using OpenGraph metadata
class LinkPreviewService {
  final http.Client _client;
  final Map<String, LinkPreviewData> _cache = {};

  LinkPreviewService({http.Client? client}) 
      : _client = client ?? http.Client();

  /// Extract link preview data from a URL
  Future<LinkPreviewData?> getPreview(String url) async {
    // Check cache first
    if (_cache.containsKey(url)) {
      return _cache[url];
    }

    try {
      // Validate URL
      final uri = Uri.tryParse(url);
      if (uri == null || !uri.hasScheme) return null;

      // Fetch the page
      final response = await _client
          .get(uri, headers: {
            'User-Agent': 'Mozilla/5.0 (compatible; FuryChat/1.0)',
          })
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) return null;

      // Parse HTML
      final document = html_parser.parse(response.body);
      
      // Extract OpenGraph tags
      String? title;
      String? description;
      String? image;
      String? siteName;
      String? favicon;

      // Get meta tags
      final metaTags = document.getElementsByTagName('meta');
      for (final meta in metaTags) {
        final property = meta.attributes['property'] ?? meta.attributes['name'];
        final content = meta.attributes['content'];

        if (content == null || content.isEmpty) continue;

        switch (property) {
          case 'og:title':
            title = content;
            break;
          case 'og:description':
            description = content;
            break;
          case 'og:image':
            image = _resolveUrl(uri, content);
            break;
          case 'og:site_name':
            siteName = content;
            break;
          case 'description':
            description ??= content;
            break;
        }
      }

      // Fallback to title tag
      if (title == null || title.isEmpty) {
        final titleTag = document.getElementsByTagName('title').firstOrNull;
        title = titleTag?.text;
      }

      // Get favicon
      final links = document.getElementsByTagName('link');
      for (final link in links) {
        final rel = link.attributes['rel'];
        if (rel == 'icon' || rel == 'shortcut icon') {
          final href = link.attributes['href'];
          if (href != null) {
            favicon = _resolveUrl(uri, href);
            break;
          }
        }
      }

      // Fallback favicon
      favicon ??= '${uri.scheme}://${uri.host}/favicon.ico';

      if (title == null && description == null && image == null) {
        return null;
      }

      final preview = LinkPreviewData(
        url: url,
        title: title,
        description: description,
        imageUrl: image,
        siteName: siteName ?? uri.host,
        faviconUrl: favicon,
      );

      // Cache result
      _cache[url] = preview;

      return preview;
    } catch (e) {
      debugPrint('❌ [LINK_PREVIEW] Error fetching preview: $e');
      return null;
    }
  }

  /// Extract URLs from text
  List<String> extractUrls(String text) {
    final urlRegex = RegExp(
      r'https?://[^\s<>"{}|\\^`\[\]]+',
      caseSensitive: false,
    );
    
    return urlRegex.allMatches(text).map((m) => m.group(0)!).toList();
  }

  /// Check if text contains a URL
  bool containsUrl(String text) {
    return extractUrls(text).isNotEmpty;
  }

  String _resolveUrl(Uri baseUri, String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }
    if (url.startsWith('//')) {
      return '${baseUri.scheme}:$url';
    }
    if (url.startsWith('/')) {
      return '${baseUri.scheme}://${baseUri.host}$url';
    }
    return '${baseUri.scheme}://${baseUri.host}/$url';
  }

  void dispose() {
    _client.close();
  }
}

class LinkPreviewData {
  final String url;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? siteName;
  final String? faviconUrl;

  const LinkPreviewData({
    required this.url,
    this.title,
    this.description,
    this.imageUrl,
    this.siteName,
    this.faviconUrl,
  });

  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;
  bool get hasTitle => title != null && title!.isNotEmpty;
  bool get hasDescription => description != null && description!.isNotEmpty;

  Map<String, dynamic> toJson() => {
    'url': url,
    'title': title,
    'description': description,
    'imageUrl': imageUrl,
    'siteName': siteName,
    'faviconUrl': faviconUrl,
  };

  factory LinkPreviewData.fromJson(Map<String, dynamic> json) {
    return LinkPreviewData(
      url: json['url'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      siteName: json['siteName'] as String?,
      faviconUrl: json['faviconUrl'] as String?,
    );
  }
}
