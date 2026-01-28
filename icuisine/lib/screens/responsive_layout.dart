import 'package:flutter/material.dart';

/// Responsive Layout Screen - Demonstrates Rows, Columns, and Containers
/// This screen adapts to different screen sizes and orientations
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Layout Demo'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Header Section - Full Width
              _buildHeaderSection(screenWidth),
              const SizedBox(height: 16),

              // Screen Info - Responsive Display
              _buildScreenInfo(screenWidth, screenHeight, isPortrait),
              const SizedBox(height: 16),

              // Main Content Area - Responsive Layout
              isPortrait
                  ? _buildPortraitLayout(screenWidth)
                  : _buildLandscapeLayout(screenWidth),
              const SizedBox(height: 16),

              // Feature Cards - Grid Layout
              _buildFeatureCards(screenWidth, isPortrait),
              const SizedBox(height: 16),

              // Bottom Section
              _buildFooterSection(screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  /// Header Container - Demonstrates basic Container styling
  Widget _buildHeaderSection(double screenWidth) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.deepOrange, Colors.orangeAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome to ICuisine',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Responsive Design with Rows & Columns',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  /// Screen Info - Shows current screen dimensions
  Widget _buildScreenInfo(double width, double height, bool isPortrait) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const Icon(Icons.phone_android, color: Colors.blue, size: 24),
              const SizedBox(height: 4),
              Text(
                '${width.toStringAsFixed(0)}w',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Icon(Icons.height, color: Colors.blue, size: 24),
              const SizedBox(height: 4),
              Text(
                '${height.toStringAsFixed(0)}h',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Icon(
                isPortrait ? Icons.phone_in_portrait : Icons.phone_in_landscape,
                color: Colors.blue,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                isPortrait ? 'Portrait' : 'Landscape',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Portrait Layout - Stacked Columns for smaller screens
  Widget _buildPortraitLayout(double screenWidth) {
    return Column(
      children: [
        // Main content section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.1),
            border: Border.all(color: Colors.purple, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Main Content',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Primary Content Area',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Sidebar section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.teal.withOpacity(0.1),
            border: Border.all(color: Colors.teal, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sidebar Content',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Secondary Content',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Landscape Layout - Side-by-side Rows for larger screens
  Widget _buildLandscapeLayout(double screenWidth) {
    return Row(
      children: [
        // Left panel
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              border: Border.all(color: Colors.purple, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Main Content',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Primary Content Area',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Right panel (sidebar)
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.1),
              border: Border.all(color: Colors.teal, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sidebar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Secondary Content',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Feature Cards - Responsive Grid Layout
  Widget _buildFeatureCards(double screenWidth, bool isPortrait) {
    // Determine number of columns based on screen width
    int crossAxisCount = screenWidth > 900 ? 4 : (screenWidth > 600 ? 3 : 2);

    final features = [
      {'icon': Icons.restaurant, 'label': 'Menu', 'color': Colors.red},
      {'icon': Icons.shopping_cart, 'label': 'Orders', 'color': Colors.blue},
      {'icon': Icons.person, 'label': 'Profile', 'color': Colors.green},
      {'icon': Icons.settings, 'label': 'Settings', 'color': Colors.orange},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Feature Cards',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(
            features.length,
            (index) {
              final feature = features[index];
              return Container(
                width: (screenWidth - 32 - 12 * (crossAxisCount - 1)) /
                    crossAxisCount,
                height: 100,
                decoration: BoxDecoration(
                  color: (feature['color'] as Color).withOpacity(0.1),
                  border: Border.all(
                    color: feature['color'] as Color,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      feature['icon'] as IconData,
                      size: 32,
                      color: feature['color'] as Color,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      feature['label'].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: feature['color'] as Color,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Footer Section
  Widget _buildFooterSection(double screenWidth) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Text(
            'Responsive Layout Tips:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildTipRow(Icons.check, 'Use MediaQuery for screen dimensions'),
          _buildTipRow(Icons.check, 'Use Expanded for flexible sizing'),
          _buildTipRow(Icons.check, 'Use Row/Column for layout direction'),
          _buildTipRow(Icons.check, 'Test on different orientations'),
        ],
      ),
    );
  }

  /// Helper to build tip rows
  Widget _buildTipRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
