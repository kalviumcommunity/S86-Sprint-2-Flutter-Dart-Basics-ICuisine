import 'package:flutter/material.dart';
import '../services/cloud_functions_service.dart';
import '../services/firestore_service.dart';

/// Screen to demonstrate Cloud Functions integration
/// 
/// This screen showcases:
/// 1. Callable Cloud Functions (triggered from Flutter)
/// 2. Event-based Cloud Functions (triggered by Firestore changes)
class CloudFunctionsScreen extends StatefulWidget {
  const CloudFunctionsScreen({super.key});

  @override
  State<CloudFunctionsScreen> createState() => _CloudFunctionsScreenState();
}

class _CloudFunctionsScreenState extends State<CloudFunctionsScreen> {
  final CloudFunctionsService _functionsService = CloudFunctionsService();
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _nameController = TextEditingController(text: 'Alex');
  
  String _functionResult = '';
  bool _isLoading = false;
  bool _isConnectionTested = false;

  @override
  void initState() {
    super.initState();
    _testConnection();
  }

  /// Test if Cloud Functions are accessible
  Future<void> _testConnection() async {
    setState(() => _isLoading = true);
    try {
      final isConnected = await _functionsService.testConnection();
      setState(() {
        _isConnectionTested = true;
        _functionResult = isConnected 
          ? '✅ Cloud Functions connected successfully!' 
          : '❌ Cloud Functions connection failed';
      });
    } catch (e) {
      setState(() {
        _isConnectionTested = true;
        _functionResult = '❌ Error testing connection: $e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// Call the sayHello callable function
  Future<void> _callSayHello() async {
    setState(() {
      _isLoading = true;
      _functionResult = 'Calling Cloud Function...';
    });

    try {
      final result = await _functionsService.callSayHello(
        name: _nameController.text.trim(),
      );

      setState(() {
        _functionResult = '''
✅ SUCCESS!

Message: ${result['message']}
User ID: ${result['userId'] ?? 'Not authenticated'}
Timestamp: ${result['timestamp'] ?? 'N/A'}

📋 Full Response:
${result.toString()}
        ''';
      });

      // Show success snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Function called successfully!'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _functionResult = '❌ ERROR:\n\n$e';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// Trigger event-based function by creating a new user document
  /// This will automatically trigger the newUserCreated Cloud Function
  Future<void> _triggerEventBasedFunction() async {
    setState(() {
      _isLoading = true;
      _functionResult = 'Creating new user to trigger event-based function...';
    });

    try {
      // Create a test user document
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final testUserId = 'test_user_$timestamp';
      
      await _firestoreService.createDocument(
        collection: 'users',
        documentId: testUserId,
        data: {
          'name': _nameController.text.trim(),
          'email': 'test_$timestamp@example.com',
          'isTestUser': true,
        },
      );

      setState(() {
        _functionResult = '''
✅ EVENT-BASED FUNCTION TRIGGERED!

Created test user: $testUserId

The Cloud Function 'newUserCreated' has been automatically triggered!

Check Firebase Console → Functions → Logs to see:
- User creation log
- Auto-generated profile fields
- Welcome bonus (100 loyalty points)

The function will automatically:
✓ Add createdAt timestamp
✓ Set profileComplete to false
✓ Initialize orderCount to 0
✓ Grant 100 welcome loyalty points
✓ Set account status to active
        ''';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Event-based function triggered! Check Firebase logs.'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _functionResult = '❌ ERROR:\n\n$e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Functions Demo'),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Card
            Card(
              color: Colors.orange.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.cloud, color: Colors.orange, size: 32),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Firebase Cloud Functions',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Serverless backend execution',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (_isConnectionTested)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _functionResult.contains('✅') 
                            ? '✅ Connected' 
                            : '❌ Connection Failed',
                          style: TextStyle(
                            color: _functionResult.contains('✅') 
                              ? Colors.green 
                              : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Input Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Input',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Your Name',
                        hintText: 'Enter your name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Callable Function Button
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.phone_callback, color: Colors.blue),
                        const SizedBox(width: 8),
                        const Text(
                          'Callable Function',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Directly invoke a Cloud Function from Flutter',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _callSayHello,
                      icon: const Icon(Icons.send),
                      label: const Text('Call sayHello()'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Event-Based Function Button
            Card(
              color: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.event, color: Colors.green),
                        const SizedBox(width: 8),
                        const Text(
                          'Event-Based Function',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Trigger auto-executed function by creating Firestore data',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _triggerEventBasedFunction,
                      icon: const Icon(Icons.auto_awesome),
                      label: const Text('Trigger newUserCreated'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Result Display
            if (_functionResult.isNotEmpty) ...[
              const Text(
                'Result',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                color: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_isLoading)
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                      else
                        SelectableText(
                          _functionResult,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 13,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Available Functions Info
            Card(
              color: Colors.purple.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.info, color: Colors.purple),
                        SizedBox(width: 8),
                        Text(
                          'Available Functions',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ..._functionsService.availableFunctions.map(
                      (func) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          '• $func',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Instructions
            Card(
              color: Colors.amber.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb, color: Colors.amber.shade700),
                        const SizedBox(width: 8),
                        const Text(
                          'How to View Logs',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '1. Go to Firebase Console\n'
                      '2. Navigate to Functions → Logs\n'
                      '3. Trigger a function from this screen\n'
                      '4. Watch logs update in real-time\n'
                      '5. Look for console.log() outputs',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
