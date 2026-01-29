import 'package:flutter/material.dart';

/// State Management Demo Screen
/// Demonstrates how to manage local UI state using setState() in Flutter
/// Shows real-time updates with increment/decrement counter and dynamic UI changes
class StateManagementDemo extends StatefulWidget {
  const StateManagementDemo({super.key});

  @override
  State<StateManagementDemo> createState() => _StateManagementDemoState();
}

class _StateManagementDemoState extends State<StateManagementDemo> {
  // State variables
  int _counter = 0;
  bool _isEven = true;
  String _message = 'Start counting!';
  Color _backgroundColor = Colors.white;
  IconData _icon = Icons.sentiment_neutral;

  /// Increment counter and update UI state
  void _incrementCounter() {
    setState(() {
      _counter++;
      _updateUIState();
    });
  }

  /// Decrement counter and update UI state
  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
        _updateUIState();
      }
    });
  }

  /// Reset counter to zero
  void _resetCounter() {
    setState(() {
      _counter = 0;
      _updateUIState();
    });
  }

  /// Update UI based on counter value
  void _updateUIState() {
    // Check if even or odd
    _isEven = _counter % 2 == 0;

    // Update background color based on counter value
    if (_counter == 0) {
      _backgroundColor = Colors.grey[100]!;
      _icon = Icons.sentiment_neutral;
      _message = 'Start counting!';
    } else if (_counter < 5) {
      _backgroundColor = Colors.blue[50]!;
      _icon = Icons.sentiment_satisfied;
      _message = 'Keep going!';
    } else if (_counter < 10) {
      _backgroundColor = Colors.green[50]!;
      _icon = Icons.sentiment_very_satisfied;
      _message = 'Great progress!';
    } else if (_counter < 15) {
      _backgroundColor = Colors.orange[50]!;
      _icon = Icons.mood;
      _message = 'You\'re on fire! 🔥';
    } else {
      _backgroundColor = Colors.purple[50]!;
      _icon = Icons.celebration;
      _message = 'Amazing! You\'re a champion! 🏆';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Management Demo'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset',
            onPressed: _resetCounter,
          ),
        ],
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: _backgroundColor,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title Section
                  const Text(
                    'Button Press Counter',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Using setState() for reactive UI',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Counter Display Card
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 300,
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          Icon(
                            _icon,
                            size: 80,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Count:',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child: Text(
                              '$_counter',
                              key: ValueKey<int>(_counter),
                              style: TextStyle(
                                fontSize: 72,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: _isEven
                                  ? Colors.green[100]
                                  : Colors.orange[100],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _isEven ? 'EVEN' : 'ODD',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _isEven
                                    ? Colors.green[800]
                                    : Colors.orange[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Message Display
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      _message,
                      key: ValueKey<String>(_message),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Control Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Decrement Button
                      ElevatedButton.icon(
                        onPressed: _counter > 0 ? _decrementCounter : null,
                        icon: const Icon(Icons.remove),
                        label: const Text('Decrement'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          disabledBackgroundColor: Colors.grey[300],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Increment Button
                      ElevatedButton.icon(
                        onPressed: _incrementCounter,
                        icon: const Icon(Icons.add),
                        label: const Text('Increment'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Reset Button
                  OutlinedButton.icon(
                    onPressed: _counter > 0 ? _resetCounter : null,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset Counter'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Info Section
                  Card(
                    color: Colors.blue[50],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.blue[700],
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'setState() in Action',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[700],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(
                            '🔄',
                            'Counter updates trigger setState()',
                          ),
                          _buildInfoRow(
                            '🎨',
                            'Background color changes dynamically',
                          ),
                          _buildInfoRow(
                            '😊',
                            'Icon and message adapt to count',
                          ),
                          _buildInfoRow(
                            '🟢🟠',
                            'Even/Odd badge updates instantly',
                          ),
                          _buildInfoRow(
                            '⚡',
                            'Only affected widgets rebuild',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Statistics Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Statistics',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem(
                              'Total Clicks',
                              _counter.toString(),
                              Icons.touch_app,
                            ),
                            _buildStatItem(
                              'Number Type',
                              _isEven ? 'Even' : 'Odd',
                              Icons.tag,
                            ),
                            _buildStatItem(
                              'Level',
                              _getLevel(),
                              Icons.trending_up,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  String _getLevel() {
    if (_counter < 5) return 'Beginner';
    if (_counter < 10) return 'Intermediate';
    if (_counter < 15) return 'Advanced';
    return 'Expert';
  }
}
