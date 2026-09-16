import 'package:flutter/material.dart';

class ImageItem {
  final String title;
  final String category;
  final String assetPath;
  final String description;

  const ImageItem({
    required this.title,
    required this.category,
    required this.assetPath,
    required this.description,
  });
}

class ImageGridScreen extends StatefulWidget {
  const ImageGridScreen({super.key});

  @override
  State<ImageGridScreen> createState() => _ImageGridScreenState();
}

class _ImageGridScreenState extends State<ImageGridScreen> {
  int _crossAxisCount = 2;

  final List<ImageItem> _images = const [
    ImageItem(
      title: 'Alpine Peak',
      category: 'Mountain',
      assetPath: 'assets/images/nature_mountain.png',
      description: 'Majestic snowy summit under early morning golden hour light.',
    ),
    ImageItem(
      title: 'Ocean Horizon',
      category: 'Seascape',
      assetPath: 'assets/images/ocean_breeze.png',
      description: 'Calm rolling waves reflecting the warm evening glow.',
    ),
    ImageItem(
      title: 'Misty Pines',
      category: 'Forest',
      assetPath: 'assets/images/forest_path.png',
      description: 'Lush evergreen canopy shrouded in gentle morning fog.',
    ),
    ImageItem(
      title: 'Golden Twilight',
      category: 'Sunset',
      assetPath: 'assets/images/golden_sunset.png',
      description: 'Vibrant sunset silhouettes across layered mountain ranges.',
    ),
    ImageItem(
      title: 'Desert Dunes',
      category: 'Desert',
      assetPath: 'assets/images/desert_dune.png',
      description: 'Sculpted wind-swept sand dunes under crescent moonlight.',
    ),
    ImageItem(
      title: 'Aurora Borealis',
      category: 'Night Sky',
      assetPath: 'assets/images/aurora_lights.png',
      description: 'Shimmering emerald and violet aurora ribbons in polar night.',
    ),
  ];

  void _showImageDetails(ImageItem item) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                item.assetPath,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF059669).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          item.category,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF059669),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF475569),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.folder_open_rounded,
                          size: 16,
                          color: Color(0xFF64748B),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.assetPath,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: Color(0xFF334155),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('Close'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images, Assets & Fonts'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Switch Grid Columns',
            icon: Icon(
              _crossAxisCount == 2
                  ? Icons.view_column_rounded
                  : Icons.grid_view_rounded,
            ),
            onPressed: () {
              setState(() {
                _crossAxisCount = _crossAxisCount == 2 ? 3 : 2;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Typography banner demonstrating Poppins font
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFA7F3D0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.font_download_rounded,
                            color: Color(0xFF059669),
                            size: 22,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Custom Typography: Poppins',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF065F46),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Rendered using the local custom TTF font configured in pubspec.yaml and applied globally via ThemeData. Tap any image card below to view details.',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Color(0xFF047857),
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Grid section using GridView.count via SliverGrid.count
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              sliver: SliverGrid.count(
                crossAxisCount: _crossAxisCount,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: _crossAxisCount == 2 ? 0.82 : 0.70,
                children: _images.map((image) {
                  return _buildImageCard(image);
                }).toList(),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(ImageItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A0F172A),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showImageDetails(item),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Local asset image loaded via Image.asset()
                    Image.asset(
                      item.assetPath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFE2E8F0),
                          child: const Center(
                            child: Icon(
                              Icons.broken_image_rounded,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item.category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
