import 'dart:math';
import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  // AnimatedContainer properties
  double _width = 150.0;
  double _height = 150.0;
  Color _color = const Color(0xFF4F46E5);
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(20.0);
  Alignment _alignment = Alignment.center;
  double _elevation = 8.0;
  bool _isToggled = false;
  int _presetIndex = 0;

  final List<Color> _palette = const [
    Color(0xFF4F46E5), // Indigo
    Color(0xFFEC4899), // Pink
    Color(0xFF059669), // Emerald
    Color(0xFFD97706), // Amber
    Color(0xFF8B5CF6), // Purple
    Color(0xFF0284C7), // Sky Blue
    Color(0xFFDC2626), // Crimson
  ];

  // Method 1: Standard Toggle between two contrasting states
  void _toggleContainer() {
    setState(() {
      _isToggled = !_isToggled;
      if (_isToggled) {
        _width = 260.0;
        _height = 200.0;
        _color = const Color(0xFFEA580C);
        _borderRadius = BorderRadius.circular(48.0);
        _alignment = Alignment.topCenter;
        _elevation = 20.0;
      } else {
        _width = 150.0;
        _height = 150.0;
        _color = const Color(0xFF4F46E5);
        _borderRadius = BorderRadius.circular(20.0);
        _alignment = Alignment.center;
        _elevation = 8.0;
      }
    });
  }

  // Method 2: Apply specific visual preset
  void _applyPreset(int index) {
    setState(() {
      _presetIndex = index;
      switch (index) {
        case 0: // Standard Box
          _width = 150.0;
          _height = 150.0;
          _color = const Color(0xFF4F46E5);
          _borderRadius = BorderRadius.circular(20.0);
          _alignment = Alignment.center;
          _elevation = 8.0;
          _isToggled = false;
          break;
        case 1: // Circle
          _width = 180.0;
          _height = 180.0;
          _color = const Color(0xFFEC4899);
          _borderRadius = BorderRadius.circular(90.0);
          _alignment = Alignment.center;
          _elevation = 16.0;
          _isToggled = true;
          break;
        case 2: // Wide Banner
          _width = 300.0;
          _height = 120.0;
          _color = const Color(0xFF059669);
          _borderRadius = BorderRadius.circular(16.0);
          _alignment = Alignment.center;
          _elevation = 12.0;
          _isToggled = true;
          break;
        case 3: // Pill Card
          _width = 240.0;
          _height = 80.0;
          _color = const Color(0xFFD97706);
          _borderRadius = BorderRadius.circular(40.0);
          _alignment = Alignment.center;
          _elevation = 14.0;
          _isToggled = true;
          break;
      }
    });
  }

  // Method 3: Randomize visual properties
  void _randomizeProperties() {
    final random = Random();
    setState(() {
      _width = 120.0 + random.nextInt(180);
      _height = 100.0 + random.nextInt(160);
      _color = _palette[random.nextInt(_palette.length)];
      _borderRadius = BorderRadius.circular(random.nextInt(60).toDouble());
      _elevation = 4.0 + random.nextInt(20);
      final alignments = [
        Alignment.center,
        Alignment.topCenter,
        Alignment.bottomCenter,
        Alignment.centerLeft,
        Alignment.centerRight,
      ];
      _alignment = alignments[random.nextInt(alignments.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedContainer'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Randomize Properties',
            icon: const Icon(Icons.casino_outlined),
            onPressed: _randomizeProperties,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Concept banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.auto_awesome_rounded,
                      color: Color(0xFFD97706),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'AnimatedContainer Demo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF92400E),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Watch the container smoothly interpolate its size (width/height), background color, border radius, position alignment, and box shadow over a 500ms duration.',
                            style: TextStyle(
                              fontSize: 12.5,
                              color: Color(0xFFB45309),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Animated Container Playground stage
              Container(
                height: 320,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A0F172A),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: AnimatedAlign(
                  alignment: _alignment,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  child: AnimatedContainer(
                    // Core concept: AnimatedContainer
                    key: const Key('animated_container_target'),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    width: _width,
                    height: _height,
                    decoration: BoxDecoration(
                      color: _color,
                      borderRadius: _borderRadius,
                      boxShadow: [
                        BoxShadow(
                          color: _color.withValues(alpha: 0.4),
                          blurRadius: _elevation * 1.5,
                          offset: Offset(0, _elevation * 0.6),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isToggled
                              ? Icons.flare_rounded
                              : Icons.widgets_rounded,
                          color: Colors.white,
                          size: min(_width, _height) * 0.28,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${_width.toInt()} × ${_height.toInt()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Live Inspection Card
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildMetric('Width', '${_width.toInt()}px'),
                    _buildDivider(),
                    _buildMetric('Height', '${_height.toInt()}px'),
                    _buildDivider(),
                    _buildMetric(
                      'Color',
                      '#${_color.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Preset Selector Chips
              const Text(
                'Shape Presets',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('Default Box'),
                    selected: _presetIndex == 0,
                    onSelected: (_) => _applyPreset(0),
                  ),
                  ChoiceChip(
                    label: const Text('Circle Mode'),
                    selected: _presetIndex == 1,
                    onSelected: (_) => _applyPreset(1),
                  ),
                  ChoiceChip(
                    label: const Text('Wide Banner'),
                    selected: _presetIndex == 2,
                    onSelected: (_) => _applyPreset(2),
                  ),
                  ChoiceChip(
                    label: const Text('Pill Card'),
                    selected: _presetIndex == 3,
                    onSelected: (_) => _applyPreset(3),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Main Toggle Trigger Button
              FilledButton.icon(
                key: const Key('toggle_animation_button'),
                onPressed: _toggleContainer,
                icon: const Icon(Icons.play_arrow_rounded, size: 22),
                label: Text(
                  _isToggled ? 'Reverse Animation' : 'Trigger Smooth Animation',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Randomize Button
              OutlinedButton.icon(
                onPressed: _randomizeProperties,
                icon: const Icon(Icons.shuffle_rounded, size: 18),
                label: const Text('Randomize All Attributes'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetric(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 24,
      width: 1,
      color: const Color(0xFFCBD5E1),
    );
  }
}
