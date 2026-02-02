import 'package:flutter/material.dart';

/// Navigation Demo Screen
/// Demonstrates various navigation patterns in Flutter:
/// - Named routes
/// - Navigator.push()
/// - Navigator.pop()
/// - Passing arguments between screens

class NavigationDemoScreen extends StatelessWidget {
  const NavigationDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Demo'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.navigation, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            'Multi-Screen Navigation',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Learn how to navigate between different screens using Navigator and named routes. '
                        'This is essential for building multi-page Flutter applications.',
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
              const SizedBox(height: 24),

              // Navigation Concepts
              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '📚 Navigation Concepts',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildConceptItem(
                        '🔺 Stack-Based Navigation',
                        'Flutter maintains a stack of screens. Each new screen is pushed onto the stack, '
                            'and pressing back pops the current screen.',
                      ),
                      const SizedBox(height: 12),
                      _buildConceptItem(
                        '🔗 Named Routes',
                        'Define route names (like "/home", "/settings") in MaterialApp routes. '
                            'Use Navigator.pushNamed() to navigate.',
                      ),
                      const SizedBox(height: 12),
                      _buildConceptItem(
                        '📤 Passing Arguments',
                        'Send data between screens using arguments parameter. '
                            'Retrieve with ModalRoute.of(context)?.settings.arguments.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Navigation Methods
              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '⚙️ Navigation Methods',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildMethodItem(
                        'Navigator.push()',
                        'Push a new screen onto the stack. User can navigate back.',
                        'Best for: Modal flows, detailed views',
                      ),
                      const SizedBox(height: 10),
                      _buildMethodItem(
                        'Navigator.pop()',
                        'Pop the current screen from the stack, return to previous screen.',
                        'Best for: Back navigation, dismissing screens',
                      ),
                      const SizedBox(height: 10),
                      _buildMethodItem(
                        'Navigator.pushNamed()',
                        'Push a named route (defined in MaterialApp).',
                        'Best for: Large apps, predefined navigation',
                      ),
                      const SizedBox(height: 10),
                      _buildMethodItem(
                        'Navigator.pushReplacementNamed()',
                        'Replace current screen without keeping it in stack.',
                        'Best for: Login → Home transitions',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Interactive Navigation Examples
              const Text(
                '🎮 Try Navigation Examples',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // Example 1: Named Routes
              ElevatedButton(
                onPressed: () {
                  debugPrint('📍 Navigating to Settings via named route');
                  Navigator.pushNamed(context, '/settings');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('📍 Go to Settings (Named Route)'),
              ),
              const SizedBox(height: 12),

              // Example 2: Navigation with Arguments
              ElevatedButton(
                onPressed: () {
                  debugPrint('📤 Navigating with arguments');
                  Navigator.pushNamed(
                    context,
                    '/details',
                    arguments: {
                      'title': 'Navigation Details',
                      'message': 'This data was passed via arguments!',
                      'timestamp': DateTime.now().toString(),
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('📤 Pass Data Between Screens'),
              ),
              const SizedBox(height: 12),

              // Example 3: Multiple Navigation
              ElevatedButton(
                onPressed: () {
                  debugPrint('🔗 Demonstrating navigation stack');
                  Navigator.pushNamed(context, '/navigation-stack');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('🔗 See Navigation Stack Demo'),
              ),
              const SizedBox(height: 24),

              // Code Example
              Card(
                color: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '💻 Code Example',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '''// Basic named route navigation
Navigator.pushNamed(context, '/settings');

// Navigation with arguments
Navigator.pushNamed(
  context,
  '/details',
  arguments: {'id': 123, 'name': 'Item'},
);

// Receiving arguments
final args = ModalRoute.of(context)
    ?.settings.arguments as Map?;
final id = args?['id'];

// Go back
Navigator.pop(context);''',
                          style: const TextStyle(
                            color: Colors.greenAccent,
                            fontFamily: 'monospace',
                            fontSize: 12,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Tips
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
                      '✓ Use named routes for maintainability\n'
                      '✓ Keep route names simple and hierarchical (/home, /settings/account)\n'
                      '✓ Use pushReplacementNamed for login→home to prevent back navigation\n'
                      '✓ Pass minimal data between screens\n'
                      '✓ Use ModalRoute to access navigation arguments safely\n'
                      '✓ Consider using GoRouter for complex navigation patterns',
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

  Widget _buildConceptItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildMethodItem(String method, String description, String useCase) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.blue[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            method,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            useCase,
            style: TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
