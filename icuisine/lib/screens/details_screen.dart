import 'package:flutter/material.dart';
import 'package:icuisine/widgets/custom_stat_card.dart';
import 'package:icuisine/widgets/primary_button.dart';

/// Details Screen with Arguments
/// Demonstrates how to receive and display data passed from navigation

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('📋 DetailsScreen initialized');

    // Receive arguments from previous screen
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final title = args?['title'] ?? 'Details';
    final message = args?['message'] ?? 'No message provided';
    final timestamp = args?['timestamp'] ?? 'No timestamp';

    debugPrint('📥 Received arguments: title=$title');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          Icon(Icons.info, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            'Data from Arguments',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'This screen demonstrates how to pass data between screens using navigation arguments. '
                        'Data was sent when Navigator.pushNamed() was called with arguments parameter.',
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

              // Received Arguments
              const Text(
                '📤 Received Arguments:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              CustomStatCard(
                icon: Icons.title,
                label: 'Title',
                value: title,
                color: Colors.blue,
              ),
              const SizedBox(height: 12),

              CustomStatCard(
                icon: Icons.message,
                label: 'Message',
                value: message,
                color: Colors.green,
              ),
              const SizedBox(height: 12),

              CustomStatCard(
                icon: Icons.schedule,
                label: 'Timestamp',
                value: timestamp,
                color: Colors.orange,
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
                        '💻 How to Pass Arguments',
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
                          '''// Sending arguments
Navigator.pushNamed(
  context,
  '/details',
  arguments: {
    'title': 'My Title',
    'message': 'Hello!',
    'data': 123,
  },
);

// Receiving arguments
final args = ModalRoute.of(context)
    ?.settings.arguments as Map<String, dynamic>?;
final title = args?['title'];
final message = args?['message'];''',
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

              // Tips
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
                        Icon(Icons.lightbulb, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          'Best Practices',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '✓ Always check if arguments exist (use null coalescing)\n'
                      '✓ Validate argument types before using\n'
                      '✓ Keep arguments serializable (no complex objects)\n'
                      '✓ Document expected argument structure\n'
                      '✓ Use TypedMap or similar pattern for type safety',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[800],
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Navigation Buttons
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: 'Back',
                      onPressed: () {
                        debugPrint('🔙 Pop current screen');
                        Navigator.pop(context);
                      },
                      color: Colors.blue,
                      icon: Icons.arrow_back,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      label: 'Home',
                      onPressed: () {
                        debugPrint('🏠 Go to Home');
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/',
                          (route) => false,
                        );
                      },
                      color: Colors.green,
                      icon: Icons.home,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

}
