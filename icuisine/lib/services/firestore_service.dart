import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore service for managing database operations
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection names
  static const String usersCollection = 'users';
  static const String ordersCollection = 'orders';
  static const String menuItemsCollection = 'menu_items';

  // ========== USER OPERATIONS ==========

  /// Add user data to Firestore
  Future<void> addUserData(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(usersCollection).doc(uid).set({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding user data: $e');
      throw 'Failed to save user data. Please try again.';
    }
  }

  /// Get user data by UID
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final doc = await _firestore.collection(usersCollection).doc(uid).get();
      return doc.data();
    } catch (e) {
      print('Error getting user data: $e');
      throw 'Failed to retrieve user data. Please try again.';
    }
  }

  /// Update user data
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(usersCollection).doc(uid).update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error updating user data: $e');
      throw 'Failed to update user data. Please try again.';
    }
  }

  /// Delete user data
  Future<void> deleteUserData(String uid) async {
    try {
      await _firestore.collection(usersCollection).doc(uid).delete();
    } catch (e) {
      print('Error deleting user data: $e');
      throw 'Failed to delete user data. Please try again.';
    }
  }

  /// Stream user data in real-time
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUserData(String uid) {
    return _firestore.collection(usersCollection).doc(uid).snapshots();
  }

  // ========== ORDER OPERATIONS ==========

  /// Add a new order (always associates with current user)
  Future<String> addOrder(String userId, Map<String, dynamic> orderData) async {
    try {
      final docRef = await _firestore.collection(ordersCollection).add({
        ...orderData,
        'userId': userId,  // ✅ Always link to current user
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'status': 'pending', // Default status
      });
      return docRef.id;
    } catch (e) {
      print('Error adding order: $e');
      throw 'Failed to create order. Please try again.';
    }
  }

  /// Get order by ID (verify user owns it)
  /// ⚠️ SECURITY: Verifies user ownership before returning
  Future<Map<String, dynamic>?> getOrder(String orderId, String userId) async {
    try {
      final doc = await _firestore.collection(ordersCollection).doc(orderId).get();
      final data = doc.data();
      
      // ✅ Verify user owns this order
      if (data != null && data['userId'] != userId) {
        throw 'Unauthorized: You can only view your own orders';
      }
      
      return data;
    } catch (e) {
      print('Error getting order: $e');
      throw 'Failed to retrieve order. Please try again.';
    }
  }

  /// Update order status or data (only if user owns it)
  /// ⚠️ SECURITY: Verifies user ownership before updating
  Future<void> updateOrder(String orderId, String userId, Map<String, dynamic> data) async {
    try {
      // ✅ Verify the order belongs to the current user
      final order = await _firestore.collection(ordersCollection).doc(orderId).get();
      if (order.data()?['userId'] != userId) {
        throw 'Unauthorized: You can only update your own orders';
      }

      await _firestore.collection(ordersCollection).doc(orderId).update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error updating order: $e');
      throw 'Failed to update order. Please try again.';
    }
  }

  /// Delete order (only if user owns it)
  /// ⚠️ SECURITY: Verifies user ownership before deleting
  Future<void> deleteOrder(String orderId, String userId) async {
    try {
      // ✅ Verify the order belongs to the current user
      final order = await _firestore.collection(ordersCollection).doc(orderId).get();
      if (order.data()?['userId'] != userId) {
        throw 'Unauthorized: You can only delete your own orders';
      }

      await _firestore.collection(ordersCollection).doc(orderId).delete();
    } catch (e) {
      print('Error deleting order: $e');
      throw 'Failed to delete order. Please try again.';
    }
  }

  /// Stream orders for a specific user in real-time
  Stream<QuerySnapshot<Map<String, dynamic>>> streamUserOrders(String userId) {
    return _firestore
        .collection(ordersCollection)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Stream all orders (for vendor dashboard)
  /// ⚠️ SECURITY: Filtered by vendorId - users only see their own orders
  Stream<QuerySnapshot<Map<String, dynamic>>> streamVendorOrders(String vendorId) {
    return _firestore
        .collection(ordersCollection)
        .where('vendorId', isEqualTo: vendorId)  // ✅ Only vendor's orders
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Get orders by status
  /// ⚠️ SECURITY: Filtered by userId - users only see their own orders  
  Stream<QuerySnapshot<Map<String, dynamic>>> streamUserOrdersByStatus(
    String userId,
    String status,
  ) {
    return _firestore
        .collection(ordersCollection)
        .where('userId', isEqualTo: userId)  // ✅ Only user's orders
        .where('status', isEqualTo: status)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // ========== MENU ITEM OPERATIONS ==========

  /// Add a menu item
  Future<String> addMenuItem(Map<String, dynamic> itemData) async {
    try {
      final docRef = await _firestore.collection(menuItemsCollection).add({
        ...itemData,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return docRef.id;
    } catch (e) {
      print('Error adding menu item: $e');
      throw 'Failed to add menu item. Please try again.';
    }
  }

  /// Get menu item by ID
  Future<Map<String, dynamic>?> getMenuItem(String itemId) async {
    try {
      final doc = await _firestore.collection(menuItemsCollection).doc(itemId).get();
      return doc.data();
    } catch (e) {
      print('Error getting menu item: $e');
      throw 'Failed to retrieve menu item. Please try again.';
    }
  }

  /// Update menu item
  Future<void> updateMenuItem(String itemId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(menuItemsCollection).doc(itemId).update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error updating menu item: $e');
      throw 'Failed to update menu item. Please try again.';
    }
  }

  /// Delete menu item
  Future<void> deleteMenuItem(String itemId) async {
    try {
      await _firestore.collection(menuItemsCollection).doc(itemId).delete();
    } catch (e) {
      print('Error deleting menu item: $e');
      throw 'Failed to delete menu item. Please try again.';
    }
  }

  /// Stream all menu items in real-time
  Stream<QuerySnapshot<Map<String, dynamic>>> streamMenuItems() {
    return _firestore
        .collection(menuItemsCollection)
        .orderBy('name')
        .snapshots();
  }

  /// Stream menu items by vendor
  Stream<QuerySnapshot<Map<String, dynamic>>> streamVendorMenuItems(String vendorId) {
    return _firestore
        .collection(menuItemsCollection)
        .where('vendorId', isEqualTo: vendorId)
        .orderBy('name')
        .snapshots();
  }

  // ========== GENERIC OPERATIONS ==========

  /// Add document to any collection
  Future<String> addDocument(String collection, Map<String, dynamic> data) async {
    try {
      final docRef = await _firestore.collection(collection).add({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return docRef.id;
    } catch (e) {
      print('Error adding document: $e');
      throw 'Failed to add document. Please try again.';
    }
  }

  /// Get document from any collection
  Future<Map<String, dynamic>?> getDocument(String collection, String docId) async {
    try {
      final doc = await _firestore.collection(collection).doc(docId).get();
      return doc.data();
    } catch (e) {
      print('Error getting document: $e');
      throw 'Failed to retrieve document. Please try again.';
    }
  }

  /// Update document in any collection
  Future<void> updateDocument(String collection, String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(docId).update(data);
    } catch (e) {
      print('Error updating document: $e');
      throw 'Failed to update document. Please try again.';
    }
  }

  /// Delete document from any collection
  Future<void> deleteDocument(String collection, String docId) async {
    try {
      await _firestore.collection(collection).doc(docId).delete();
    } catch (e) {
      print('Error deleting document: $e');
      throw 'Failed to delete document. Please try again.';
    }
  }

  /// Stream collection in real-time
  Stream<QuerySnapshot<Map<String, dynamic>>> streamCollection(String collection) {
    return _firestore.collection(collection).snapshots();
  }
}
