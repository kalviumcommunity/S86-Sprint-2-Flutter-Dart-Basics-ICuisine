import 'package:flutter/material.dart';

/// Hot Reload & DevTools Demonstration Screen
/// 
/// This screen demonstrates:
/// 1. Hot Reload - Instant UI updates without full app restart
/// 2. Debug Console - Real-time logging and debugging information
/// 3. Flutter DevTools - Widget inspection and performance analysis
/// 
/// Instructions:
/// - Run: flutter run
/// - Edit widget properties and save (Ctrl+S)
/// - Press 'r' in terminal to trigger hot reload
/// - Open DevTools: flutter pub global run devtools
/// - Check Debug Console for print statements

class HotReloadDemoScreen extends StatefulWidget {
  const HotReloadDemoScreen({super.key});

  @override
  State<HotReloadDemoScreen> createState() => _HotReloadDemoState();
}

class _HotReloadDemoState extends State<HotReloadDemoScreen> {
  // State variables for hot reload demonstration
  int _clickCount = 0;
  String _displayText = 'Welcome to Hot Reload Demo!';
  Color _buttonColor = const Color(0xFFFF6B35); // Primary color
  double _containerSize = 100;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    debugPrint('🚀 HotReloadDemoScreen initialized');
    _logState('Initial state created');
  }

  /// Log current state to debug console
  void _logState(String message) {
    debugPrint('📱 [HotReloadDemo] $message');
    debugPrint('   - Click Count: $_clickCount');
    debugPrint('   - Display Text: $_displayText');
    debugPrint('   - Button Color: $_buttonColor');
  }

  /// Increment counter and trigger hot reload
  void _incrementCounter() {
    setState(() {
      _clickCount++;
      _displayText = 'Button clicked $_clickCount time(s)!';
      _containerSize = 100 + (_clickCount * 10);
      
      // Change button color based on click count
      if (_clickCount % 3 == 0) {
        _buttonColor = const Color(0xFF4ECDC4); // Teal
      } else if (_clickCount % 2 == 0) {
        _buttonColor = const Color(0xFFF44336); // Red
      } else {
        _buttonColor = const Color(0xFFFF6B35); // Orange
      }
    });
    
    _logState('Counter incremented to $_clickCount');
  }

  /// Reset state
  void _resetState() {
    setState(() {
      _clickCount = 0;
      _displayText = 'Welcome to Hot Reload Demo!';
      _buttonColor = const Color(0xFFFF6B35);
      _containerSize = 100;
      _isExpanded = false;
    });
    
    debugPrint('🔄 State reset to initial values');
  }

  /// Toggle expanded state
  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    
    debugPrint('📦 Expanded state toggled: $_isExpanded');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hot Reload & DevTools Demo'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Section 1: Hot Reload Explanation
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.flash_on, color: Colors.amber),
                          SizedBox(width: 8),
                          Text(
                            'What is Hot Reload?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Hot Reload allows you to see code changes instantly without losing app state. '
                        'This dramatically speeds up development!\n\n'
                        'Try editing the text below and saving (Ctrl+S), then press "r" in your terminal.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Section 2: Interactive Demo Area
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _buttonColor.withOpacity(0.1),
                      _buttonColor.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _buttonColor.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    // TRY EDITING THIS TEXT - Hot Reload will update it instantly!
                    Text(
                      _displayText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Animated container that grows with clicks
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _containerSize,
                      height: _containerSize,
                      decoration: BoxDecoration(
                        color: _buttonColor,
                        borderRadius: BorderRadius.circular(_containerSize / 2),
                        boxShadow: [
                          BoxShadow(
                            color: _buttonColor.withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '$_clickCount',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Section 3: Buttons for Interaction
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _incrementCounter,
                    icon: const Icon(Icons.add),
                    label: const Text('Increment'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _buttonColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _resetState,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Section 4: Debug Console Info Card
              Card(
                color: Colors.blue[50],
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.bug_report, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            'Debug Console in Action',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Open the Debug Console (View > Debug Console) to see real-time logs when you:\n'
                        '• Click buttons\n'
                        '• Toggle expanded state\n'
                        '• Use Hot Reload\n\n'
                        'Press the toggle button below to see debug output:',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _toggleExpanded,
                          icon: Icon(
                            _isExpanded
                                ? Icons.expand_less
                                : Icons.expand_more,
                          ),
                          label: Text(
                            _isExpanded ? 'Hide Details' : 'Show Details',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                        ),
                      ),
                      if (_isExpanded) ...[
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '📱 [HotReloadDemo] Current State:\n'
                            '├─ Click Count: $_clickCount\n'
                            '├─ Display Text: $_displayText\n'
                            '├─ Container Size: ${_containerSize.toStringAsFixed(0)}\n'
                            '├─ Button Color: $_buttonColor\n'
                            '└─ Expanded: $_isExpanded\n\n'
                            '💡 Tip: Use debugPrint() in your code\n'
                            '   for formatted console output!',
                            style: const TextStyle(
                              color: Colors.greenAccent,
                              fontFamily: 'monospace',
                              fontSize: 11,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Section 5: DevTools Guide
              Card(
                color: Colors.purple[50],
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.settings, color: Colors.purple),
                          SizedBox(width: 8),
                          Text(
                            'Flutter DevTools Guide',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'DevTools offers powerful debugging capabilities:\n\n'
                        '🔍 Widget Inspector:\n'
                        'Select any widget to inspect its properties and hierarchy.\n\n'
                        '⚡ Performance:\n'
                        'Watch frame render times as you interact with the app.\n\n'
                        '🧠 Memory:\n'
                        'Monitor memory usage to detect leaks.\n\n'
                        '🌐 Network:\n'
                        'Track API calls and Firebase operations.\n\n'
                        'Launch DevTools:\n'
                        '• VS Code: Run DevTools in terminal\n'
                        '• Terminal: flutter pub global run devtools',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                          height: 1.7,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Tips section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.amber[200]!,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.lightbulb, color: Colors.amber),
                        SizedBox(width: 8),
                        Text(
                          'Pro Tips',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '✓ Change color/text in code and save for instant Hot Reload\n'
                      '✓ Use debugPrint() instead of print() for better formatting\n'
                      '✓ Open Widget Inspector to inspect this screen\'s widget tree\n'
                      '✓ Use Performance tab to monitor frame rendering\n'
                      '✓ Hot Reload preserves app state - perfect for UI iteration!',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[800],
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    debugPrint('🛑 HotReloadDemoScreen disposed');
    super.dispose();
  }
}
