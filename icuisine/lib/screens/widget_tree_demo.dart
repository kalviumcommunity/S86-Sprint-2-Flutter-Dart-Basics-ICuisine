import 'package:flutter/material.dart';

/// Widget Tree Demo Screen
/// Demonstrates Flutter's widget tree hierarchy and reactive UI model
class WidgetTreeDemo extends StatefulWidget {
  const WidgetTreeDemo({super.key});

  @override
  State<WidgetTreeDemo> createState() => _WidgetTreeDemoState();
}

class _WidgetTreeDemoState extends State<WidgetTreeDemo> {
  // State variables
  int _counter = 0;
  Color _backgroundColor = Colors.blue;
  bool _isTextVisible = true;
  String _statusMessage = 'Ready to interact!';
  double _containerSize = 100.0;

  // State update methods
  void _incrementCounter() {
    setState(() {
      _counter++;
      _statusMessage = 'Counter incremented to $_counter';
    });
  }

  void _changeBackgroundColor() {
    setState(() {
      _backgroundColor = _backgroundColor == Colors.blue
          ? Colors.purple
          : _backgroundColor == Colors.purple
              ? Colors.green
              : Colors.blue;
      _statusMessage = 'Background color changed!';
    });
  }

  void _toggleTextVisibility() {
    setState(() {
      _isTextVisible = !_isTextVisible;
      _statusMessage = _isTextVisible ? 'Text is now visible' : 'Text is now hidden';
    });
  }

  void _resizeContainer() {
    setState(() {
      _containerSize = _containerSize == 100.0 ? 150.0 : 100.0;
      _statusMessage = 'Container resized to ${_containerSize}px';
    });
  }

  void _resetAll() {
    setState(() {
      _counter = 0;
      _backgroundColor = Colors.blue;
      _isTextVisible = true;
      _containerSize = 100.0;
      _statusMessage = 'All states reset!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar - Top level widget
      appBar: AppBar(
        title: const Text('Widget Tree & Reactive UI Demo'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      // Body - Main content area
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _backgroundColor.withOpacity(0.3),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Card
              _buildHeaderCard(),
              const SizedBox(height: 16),

              // Counter Section
              _buildCounterSection(),
              const SizedBox(height: 16),

              // Interactive Container Section
              _buildInteractiveContainer(),
              const SizedBox(height: 16),

              // Toggle Visibility Section
              _buildToggleSection(),
              const SizedBox(height: 16),

              // Color Change Section
              _buildColorSection(),
              const SizedBox(height: 16),

              // Status Message
              _buildStatusMessage(),
              const SizedBox(height: 16),

              // Reset Button
              _buildResetButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// Header Card explaining the demo
  Widget _buildHeaderCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_tree,
                  color: Theme.of(context).colorScheme.primary,
                  size: 32,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Widget Tree Demo',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'This screen demonstrates how Flutter\'s widget tree works and how the reactive UI model updates only the necessary widgets when state changes.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  /// Counter Section - Demonstrates setState() with counter
  Widget _buildCounterSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Counter Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Tap the button to increment. Flutter rebuilds only this widget.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$_counter',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _incrementCounter,
              icon: const Icon(Icons.add),
              label: const Text('Increment Counter'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Interactive Container - Demonstrates size animation
  Widget _buildInteractiveContainer() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Dynamic Container',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Tap to resize the container. Watch how Flutter smoothly updates the widget.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _containerSize,
                height: _containerSize,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.red],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '${_containerSize.toInt()}px',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _resizeContainer,
              icon: const Icon(Icons.aspect_ratio),
              label: const Text('Resize Container'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Toggle Section - Demonstrates conditional rendering
  Widget _buildToggleSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Toggle Visibility',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Toggle the visibility of text. Flutter adds/removes widgets from the tree.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: _isTextVisible
                    ? const Text(
                        '👋 Hello, Widget Tree!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      )
                    : const Icon(
                        Icons.visibility_off,
                        size: 40,
                        color: Colors.grey,
                      ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _toggleTextVisibility,
              icon: Icon(_isTextVisible ? Icons.visibility_off : Icons.visibility),
              label: Text(_isTextVisible ? 'Hide Text' : 'Show Text'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Color Section - Demonstrates background color changes
  Widget _buildColorSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Background Color',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Change the gradient color. Flutter rebuilds the Container widget.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildColorIndicator(Colors.blue),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 16),
                const SizedBox(width: 8),
                _buildColorIndicator(Colors.purple),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 16),
                const SizedBox(width: 8),
                _buildColorIndicator(Colors.green),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _changeBackgroundColor,
              icon: const Icon(Icons.color_lens),
              label: const Text('Change Color'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Color indicator widget
  Widget _buildColorIndicator(Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: _backgroundColor == color ? Colors.black : Colors.transparent,
          width: 3,
        ),
      ),
    );
  }

  /// Status Message - Shows current action
  Widget _buildStatusMessage() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber, width: 2),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.amber),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _statusMessage,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Reset Button
  Widget _buildResetButton() {
    return OutlinedButton.icon(
      onPressed: _resetAll,
      icon: const Icon(Icons.refresh),
      label: const Text('Reset All States'),
      style: OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary,
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
