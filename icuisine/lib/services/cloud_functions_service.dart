import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

/// Service for calling Firebase Cloud Functions from Flutter
/// 
/// This service provides methods to invoke callable Cloud Functions
/// and handle responses/errors consistently across the app.
class CloudFunctionsService {
  // Singleton pattern
  static final CloudFunctionsService _instance = CloudFunctionsService._internal();
  factory CloudFunctionsService() => _instance;
  CloudFunctionsService._internal();

  // Firebase Functions instance
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  /// Call the sayHello Cloud Function
  /// 
  /// This is a simple callable function that greets the user
  /// 
  /// Parameters:
  /// - [name]: The name to greet (optional, defaults to "User")
  /// 
  /// Returns:
  /// - A map containing the greeting message and other data
  /// 
  /// Example:
  /// ```dart
  /// final result = await CloudFunctionsService().callSayHello(name: 'John');
  /// print(result['message']); // "Hello, John! Welcome to ICuisine."
  /// ```
  Future<Map<String, dynamic>> callSayHello({String? name}) async {
    try {
      debugPrint('📞 Calling Cloud Function: sayHello');
      debugPrint('   Input: name = ${name ?? "User"}');

      // Get the callable function reference
      final callable = _functions.httpsCallable('sayHello');

      // Call the function with data
      final result = await callable.call(<String, dynamic>{
        'name': name ?? 'User',
      });

      debugPrint('✅ Cloud Function Success!');
      debugPrint('   Response: ${result.data}');

      // Return the data from the function
      return Map<String, dynamic>.from(result.data);
    } on FirebaseFunctionsException catch (e) {
      debugPrint('❌ Cloud Function Error:');
      debugPrint('   Code: ${e.code}');
      debugPrint('   Message: ${e.message}');
      debugPrint('   Details: ${e.details}');
      
      // Rethrow with better error message
      throw Exception('Failed to call sayHello: ${e.message}');
    } catch (e) {
      debugPrint('❌ Unexpected Error: $e');
      throw Exception('Unexpected error calling sayHello: $e');
    }
  }

  /// Call the processOrder Cloud Function
  /// 
  /// This function validates and processes orders with custom business logic
  /// 
  /// Parameters:
  /// - [orderId]: The ID of the order to process
  /// - [items]: List of order items
  /// - [totalAmount]: Total order amount
  /// 
  /// Returns:
  /// - A map containing success status and order details
  Future<Map<String, dynamic>> callProcessOrder({
    required String orderId,
    required List<Map<String, dynamic>> items,
    required double totalAmount,
  }) async {
    try {
      debugPrint('📞 Calling Cloud Function: processOrder');
      debugPrint('   Order ID: $orderId');

      final callable = _functions.httpsCallable('processOrder');

      final result = await callable.call(<String, dynamic>{
        'orderId': orderId,
        'items': items,
        'totalAmount': totalAmount,
      });

      debugPrint('✅ Order processed successfully');
      return Map<String, dynamic>.from(result.data);
    } on FirebaseFunctionsException catch (e) {
      debugPrint('❌ Process Order Error: ${e.message}');
      
      // Handle specific error codes
      if (e.code == 'unauthenticated') {
        throw Exception('You must be logged in to process orders');
      } else if (e.code == 'invalid-argument') {
        throw Exception('Invalid order data provided');
      }
      
      throw Exception('Failed to process order: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error processing order: $e');
    }
  }

  /// Test function to verify Cloud Functions are working
  /// 
  /// This is useful for debugging and confirming the setup
  Future<bool> testConnection() async {
    try {
      final result = await callSayHello(name: 'Test User');
      return result.containsKey('message');
    } catch (e) {
      debugPrint('Cloud Functions test failed: $e');
      return false;
    }
  }

  /// Get a list of available Cloud Functions (for documentation)
  List<String> get availableFunctions => [
    'sayHello - Greet a user by name',
    'processOrder - Validate and process an order',
    'newUserCreated - Auto-triggered when new user signs up (event-based)',
    'onOrderStatusChanged - Auto-triggered when order status updates (event-based)',
    'onOrderDeleted - Auto-triggered when order is deleted (event-based)',
  ];
}
