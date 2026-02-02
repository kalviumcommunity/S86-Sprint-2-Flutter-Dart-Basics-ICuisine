import 'package:flutter/material.dart';

/// Navigation Stack Demo Screen
/// Demonstrates the navigation stack and multiple screen navigation

class NavigationStackScreen extends StatefulWidget {
  const NavigationStackScreen({super.key});

  @override
  State<NavigationStackScreen> createState() => _NavigationStackScreenState();
}

class _NavigationStackScreenState extends State<NavigationStackScreen> {
  int screenCount = 0;

  @override
  void initState() {
    super.initState();
    debugPrint('🔗 NavigationStackScreen initialized - screenCount: $screenCount');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Stack Demo'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.layers, color: Colors.purple),
                          SizedBox(width: 8),
                          Text(
                            'Navigation Stack Visualization',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Flutter uses a Stack data structure to manage screens. When you push a new screen, '
                        'it goes on top of the stack. When you pop, the top screen is removed.',
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

              // Stack Visualization
              const Text(
                '📚 Current Navigation Stack:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    // Stack representation
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange, width: 2),
                      ),
                      child: const Center(
                        child: Text(
                          'NavigationStackScreen (TOP)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(
                        Icons.expand_less,
                        size: 32,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      child: const Center(
                        child: Text(
                          'NavigationDemoScreen',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(
                        Icons.expand_less,
                        size: 32,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green, width: 2),
                      ),
                      child: const Center(
                        child: Text(
                          'HomeScreen (BOTTOM)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Explanation
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.blue[200]!,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          'How Stack Navigation Works',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildExplanationItem(
                      '1. Home Screen',
                      'Initial screen pushed to stack when app starts',
                    ),
                    const SizedBox(height: 10),
                    _buildExplanationItem(
                      '2. Navigate to Navigation Demo',
                      'New screen pushed on top of stack',
                    ),
                    const SizedBox(height: 10),
                    _buildExplanationItem(
                      '3. Navigate to Stack Screen',
                      'Another screen pushed on top (current screen)',
                    ),
                    const SizedBox(height: 10),
                    _buildExplanationItem(
                      '4. Press Back',
                      'Current screen pops off, Navigation Demo is now on top',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Benefits of Stack Navigation
              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          SizedBox(width: 8),
                          Text(
                            'Benefits of Named Routes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildBenefit(
                        'Centralized Management',
                        'All routes defined in one place (main.dart)',
                      ),
                      const SizedBox(height: 10),
                      _buildBenefit(
                        'Easy to Refactor',
                        'Change route path without updating all navigation calls',
                      ),
                      const SizedBox(height: 10),
                      _buildBenefit(
                        'Scalability',
                        'Better for large apps with many screens',
                      ),
                      const SizedBox(height: 10),
                      _buildBenefit(
                        'Type Safety',
                        'Combine with code generation for compile-time safety',
                      ),
                      const SizedBox(height: 10),
                      _buildBenefit(
                        'Deep Linking',
                        'Support deep links directly to named routes',
                      ),
                    ],
                  ),
                ),
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
                        '💻 Stack Operations Code',
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
                        child: const Text(
                          '''// Push (add to stack)
Navigator.push(context, 
  MaterialPageRoute(
    builder: (_) => SettingsScreen()));

// Push Named (named route)
Navigator.pushNamed(context, '/settings');

// Pop (remove from stack)
Navigator.pop(context);

// Replace (pop + push)
Navigator.pushReplacementNamed(
  context, '/login');

// Pop Until (pop multiple screens)
Navigator.popUntil(
  context, 
  ModalRoute.withName('/'));''',
                          style: TextStyle(
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

              // Navigation Buttons
              ElevatedButton(
                onPressed: () {
                  debugPrint('🔙 Pop from stack');
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('← Back (Pop from Stack)'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  debugPrint('🏠 Pop until Home');
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('🏠 Pop Until Home'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExplanationItem(String title, String description) {
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
          ),
        ),
      ],
    );
  }

  Widget _buildBenefit(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.arrow_right, color: Colors.green, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
