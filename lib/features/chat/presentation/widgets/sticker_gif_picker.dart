import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

/// Sticker and GIF picker widget
class StickerGifPicker extends StatefulWidget {
  final Function(String url, bool isGif) onSelected;
  final double height;

  const StickerGifPicker({
    super.key,
    required this.onSelected,
    this.height = 300,
  });

  @override
  State<StickerGifPicker> createState() => _StickerGifPickerState();
}

class _StickerGifPickerState extends State<StickerGifPicker>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
  // Sample sticker packs - in production, fetch from server/API
  final List<StickerPack> _stickerPacks = [
    const StickerPack(
      id: 'popular',
      name: 'Popular',
      stickers: [
        '😀', '😂', '🥰', '😎', '🤔', '👍', '👏', '🎉',
        '❤️', '🔥', '💯', '✨', '🌟', '💪', '🙌', '👋',
      ],
    ),
    const StickerPack(
      id: 'emotions',
      name: 'Emotions',
      stickers: [
        '😊', '😢', '😡', '😱', '🤗', '😴', '🤮', '🥳',
        '😇', '🤓', '😈', '🤡', '👻', '💀', '👽', '🤖',
      ],
    ),
    const StickerPack(
      id: 'animals',
      name: 'Animals',
      stickers: [
        '🐶', '🐱', '🐭', '🐹', '🐰', '🦊', '🐻', '🐼',
        '🐨', '🐯', '🦁', '🐮', '🐷', '🐸', '🐵', '🦄',
      ],
    ),
  ];

  // Sample GIF categories - in production, use Giphy/Tenor API
  final List<String> _gifCategories = [
    'Trending', 'Reactions', 'Love', 'Happy', 'Sad', 'Angry', 'Celebrate', 'Thanks',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search stickers and GIFs',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          
          // Tabs
          TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.primary,
            tabs: const [
              Tab(text: 'Stickers'),
              Tab(text: 'GIFs'),
            ],
          ),
          
          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildStickersTab(),
                _buildGifsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStickersTab() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: _stickerPacks.length,
      itemBuilder: (context, index) {
        final pack = _stickerPacks[index];
        final filteredStickers = _searchQuery.isEmpty
            ? pack.stickers
            : pack.stickers.where((s) => s.contains(_searchQuery)).toList();
        
        if (filteredStickers.isEmpty) return const SizedBox.shrink();
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                pack.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: filteredStickers.map((sticker) {
                return GestureDetector(
                  onTap: () => widget.onSelected(sticker, false),
                  child: Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(sticker, style: const TextStyle(fontSize: 28)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildGifsTab() {
    return Column(
      children: [
        // Category chips
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _gifCategories.length,
            itemBuilder: (context, index) {
              final category = _gifCategories[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ActionChip(
                  label: Text(category),
                  onPressed: () {
                    // TODO: Fetch GIFs for category from Giphy/Tenor API
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$category GIFs - API integration needed')),
                    );
                  },
                ),
              );
            },
          ),
        ),
        
        // GIF grid placeholder
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.gif_box_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'GIF search powered by\\nGiphy or Tenor API',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'API integration required',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Model for a sticker pack
class StickerPack {
  final String id;
  final String name;
  final List<String> stickers;
  final String? iconUrl;

  const StickerPack({
    required this.id,
    required this.name,
    required this.stickers,
    this.iconUrl,
  });
}
