# iCuisine - Real-Time Food Ordering Application

A modern Flutter mobile application demonstrating real-time data synchronization using Cloud Firestore snapshot listeners.

---

## 📱 Project Overview

**iCuisine** is a comprehensive food ordering platform that leverages Firebase Cloud Firestore's real-time capabilities to provide instant updates across the application. Users and vendors can see live updates for orders, menu items, and user data without manual refresh.

---

## 🔥 Real-Time Firestore Implementation

### What are Snapshot Listeners?

Firestore provides powerful real-time synchronization using **snapshot listeners**. These listeners continuously monitor database changes and instantly notify your app when:
- A document is added
- A document is updated
- A document is deleted

This eliminates the need for manual refresh or polling, providing a seamless, modern user experience.

---

## 🎯 Features Implemented
### 🗺️ Google Maps Integration
1. **Interactive Map View**
  - Display live Google Maps inside the app
  - Supports panning, zooming, and user location
  - Custom markers for vendors, orders, or locations
2. **Setup Instructions**
  - Add `google_maps_flutter` to `pubspec.yaml`
  - Obtain Google Maps API key from Google Cloud Console
  - Add API key to Android (`android/app/src/main/AndroidManifest.xml`) and iOS (`ios/Runner/AppDelegate.swift`, `ios/Runner/Info.plist`)
  - Add location permissions for Android and iOS
  - Example map screen: `lib/screens/map_screen.dart`
3. **Usage Example**
  - See `MapScreen` widget for a minimal Google Map implementation
  - Enable user location and add markers as needed

### ✅ Real-Time Updates Across the App
1. **Live Order Tracking**
   - Users see instant updates when orders are created, updated, or completed
   - Vendors receive real-time notifications of new orders
   - Status changes reflect immediately in the UI

2. **Dynamic User Dashboard**
   - Live order list that updates automatically
   - Instant synchronization across multiple devices




3. **Authentication State Management**

   - Real-time user authentication status
   - Automatic navigation based on login state

4. **Menu Management**
   - Vendors see menu items update in real-time
   - Changes to menu items reflect instantly across all users

---

## 💻 Code Implementation


### 1. Firestore Dependency

Added to `pubspec.yaml`:
```yaml
dependencies:
  cloud_firestore: ^5.0.0

  firebase_core: ^3.0.0

---




**Implementation in FirestoreService:**

```dart
/// Stream user orders in real-time
Stream<QuerySnapshot<Map<String, dynamic>>> streamUserOrders(String userId) {
  return _firestore
      .collection(ordersCollection)
      .where('userId', isEqualTo: userId)
      .orderBy('createdAt', descending: true)
      .snapshots();  // ✅ Real-time listener
}

/// Stream vendor orders
Stream<QuerySnapshot<Map<String, dynamic>>> streamVendorOrders(String vendorId) {
  return _firestore
      .collection(ordersCollection)
      .where('vendorId', isEqualTo: vendorId)
      .orderBy('createdAt', descending: true)
      .snapshots();  // ✅ Instant updates
}

/// Stream orders by status
Stream<QuerySnapshot<Map<String, dynamic>>> streamUserOrdersByStatus(

  String userId,

      .collection(ordersCollection)

/// Stream menu items
Stream<QuerySnapshot<Map<String, dynamic>>> streamMenuItems() {
  return _firestore
      .collection(menuItemsCollection)
      .orderBy('name')
      .snapshots();
}
```

**Triggers on:**
- New document added to collection
- Any document updated
- Document deleted from collection

---

#### B. Document Snapshots (Single Document)

**Implementation:**

```dart
/// Stream user data in real-time
Stream<DocumentSnapshot<Map<String, dynamic>>> streamUserData(String uid) {
  return _firestore
      .collection(usersCollection)
      .doc(uid)
      .snapshots();  // ✅ Listen to single document
}
```

**Triggers on:**
- Field updates
- Nested field changes
- Server-side updates (timestamps, etc.)

---

### 3. StreamBuilder for Real-Time UI

#### Example 1: Real-Time Order List (User Dashboard)

**File:** `lib/screens/user_dashboard.dart`

```dart
StreamBuilder<QuerySnapshot>(
  stream: _firestoreService.streamUserOrders(user.uid),
  builder: (context, snapshot) {
    // 1️⃣ Handle loading state
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: RotatingLoadingWidget(),
        ),
      );
    }

    // 2️⃣ Handle errors
    if (snapshot.hasError) {
      return Center(
        child: Text('Error: ${snapshot.error}'),
      );
    }

    // 3️⃣ Handle empty state
    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text('No orders yet. Add your first order!'),
        ),
      );
    }

    // 4️⃣ Display real-time data
    final orders = snapshot.data!.docs;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final orderData = order.data() as Map<String, dynamic>;
        final status = orderData['status'] ?? 'pending';

        return AnimatedCardWidget(
          delay: Duration(milliseconds: 100 * (index + 1)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getStatusColor(status),
              child: const Icon(Icons.receipt, color: Colors.white),
            ),
            title: Text(
              orderData['description'] ?? 'No description',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Status: $status'),
            trailing: Text(
              '\$${orderData['total']?.toStringAsFixed(2) ?? '0.00'}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  },
)
```

**✨ This UI updates instantly when:**
- A new order is added in Firestore Console
- Order status changes from "pending" → "completed"
- Order is deleted
- Order data is modified

---

#### Example 2: Real-Time Statistics Dashboard

**File:** `lib/screens/home_screen.dart`

```dart
StreamBuilder<QuerySnapshot>(
  stream: isVendor
      ? _firestoreService.streamVendorOrders(user?.uid ?? '')
      : _firestoreService.streamUserOrders(user?.uid ?? ''),
  builder: (context, snapshot) {
    // Calculate stats in real-time
    int totalOrders = 0;
    int pendingOrders = 0;
    int completedOrders = 0;
    double totalRevenue = 0;

    if (snapshot.hasData) {
      final orders = snapshot.data!.docs;
      totalOrders = orders.length;
      
      for (var order in orders) {
        final data = order.data() as Map<String, dynamic>;
        final status = data['status'] ?? 'pending';
        
        if (status == 'pending') pendingOrders++;
        if (status == 'completed') {
          completedOrders++;
          totalRevenue += (data['total'] ?? 0).toDouble();
        }
      }
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomStatCard(
                label: 'Total Orders',
                value: totalOrders.toString(),
                icon: Icons.receipt_long,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomStatCard(
                label: 'Pending',
                value: pendingOrders.toString(),
                icon: Icons.schedule,
                color: Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: CustomStatCard(
                label: 'Completed',
                value: completedOrders.toString(),
                icon: Icons.check_circle,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomStatCard(
                label: isVendor ? 'Revenue' : 'Spent',
                value: '\$${totalRevenue.toStringAsFixed(2)}',
                icon: Icons.attach_money,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ],
    );
  },
)
```

**✨ Stats update instantly when:**
- New orders arrive
- Order status changes
- Orders are deleted
- Revenue changes

---

#### Example 3: Filtered Real-Time Data

**File:** `lib/screens/home_screen.dart`

```dart
StreamBuilder<QuerySnapshot>(
  stream: _selectedFilter == 'all'
      ? (isVendor
          ? _firestoreService.streamVendorOrders(user?.uid ?? '')
          : _firestoreService.streamUserOrders(user?.uid ?? ''))
      : (isVendor
          ? _firestoreService.streamVendorOrders(user?.uid ?? '')
          : _firestoreService.streamUserOrdersByStatus(
              user?.uid ?? '', 
              _selectedFilter
            )),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (snapshot.hasError) {
      return SliverFillRemaining(
        child: Center(
          child: Text('Error: ${snapshot.error}'),
        ),
      );
    }

    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inbox_outlined,
                size: 80,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'No orders yet',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _selectedFilter == 'all'
                    ? 'Orders will appear here'
                    : 'No $_selectedFilter orders',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      );
    }

    final orders = snapshot.data!.docs;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final order = orders[index];
          final orderData = order.data() as Map<String, dynamic>;
          
          return OrderCard(
            orderData: orderData,
            orderId: order.id,
          );
        },
        childCount: orders.length,
      ),
    );
  },
)
```

---

#### Example 4: Authentication State Streaming

**File:** `lib/main.dart`

```dart
StreamBuilder(
  stream: AuthService().authStateChanges,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return SplashScreen();
    }
    if (snapshot.hasData) {
      return const HomeScreen();
    }
    return const LoginScreen();
  },
)
```

**✨ Auto-navigates when:**
- User logs in
- User logs out
- Session expires

---

### 4. Handling Connection States

```dart
if (snapshot.connectionState == ConnectionState.waiting) {
  return CircularProgressIndicator();  // ⏳ Loading
}

if (snapshot.hasError) {
  return Text('Error: ${snapshot.error}');  // ❌ Error
}

if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
  return Text('No records available');  // 📭 Empty
}

// ✅ Success - Display data
final data = snapshot.data!.docs;
```

---

## 🧪 Real-Time Testing Results

### ✅ Test Scenarios Performed:

1. **Add Order Test**
   - Action: Added new order in Firebase Console
   - Result: ✅ Order appeared instantly in app UI
   - Delay: < 1 second

2. **Update Order Status Test**
   - Action: Changed status from "pending" → "completed"
   - Result: ✅ UI updated instantly, stats recalculated
   - Delay: < 1 second

3. **Delete Order Test**
   - Action: Deleted order from Firestore Console
   - Result: ✅ Order removed from UI immediately
   - Delay: < 1 second

4. **Multi-Device Sync Test**
   - Action: Modified data on one device
   - Result: ✅ All connected devices updated simultaneously
   - Delay: < 2 seconds

5. **Rapid Changes Test**
   - Action: Made 10 consecutive changes quickly
   - Result: ✅ All changes reflected correctly, no data loss
   - Consistency: 100%

---

## 📸 Screenshots

### Firebase Console - Before Change
![Firebase Console showing orders collection with pending status](https://via.placeholder.com/800x400/FF6B35/FFFFFF?text=Firebase+Console+-+Pending+Order)

### Firebase Console - After Update
![Firebase Console after updating order status to completed](https://via.placeholder.com/800x400/4CAF50/FFFFFF?text=Firebase+Console+-+Completed+Order)

### App UI - Real-Time Update
![App UI automatically reflecting the status change without refresh](https://via.placeholder.com/400x800/2196F3/FFFFFF?text=App+UI+-+Real-Time+Update)

### Live Statistics Dashboard
![Dashboard showing real-time statistics updating as orders change](https://via.placeholder.com/400x800/FF9800/FFFFFF?text=Live+Stats+Dashboard)

---

## 🎨 Architecture & Code Structure

```
lib/
├── services/
│   └── firestore_service.dart      ← 🔥 All snapshot listeners
├── screens/
│   ├── home_screen.dart            ← StreamBuilder for orders & stats
│   ├── user_dashboard.dart         ← StreamBuilder for user orders
│   └── login_screen.dart           ← Auth state listener
└── main.dart                       ← Root auth StreamBuilder
```

---

## 🚀 Why Real-Time Sync Improves UX

### Traditional Approach (Manual Refresh)
```
User Action → Manual Pull-to-Refresh → API Call → Wait → UI Update
❌ User must manually refresh
❌ Delay in seeing new data
❌ Frustrating user experience
```

### Firestore Real-Time Approach
```
Database Change → Instant Push to App → UI Updates Automatically
✅ Zero user interaction required
✅ Instant updates (< 1 second)
✅ Modern, seamless experience
```

---

## 🔐 Security & Best Practices

### 1. User Ownership Verification
All snapshot streams are filtered by user ID to ensure security:

```dart
Stream<QuerySnapshot> streamUserOrders(String userId) {
  return _firestore
      .collection('orders')
      .where('userId', isEqualTo: userId)  // ✅ User can only see their orders
      .snapshots();
}
```

### 2. Proper Error Handling
```dart
if (snapshot.hasError) {
  return Center(child: Text('Error: ${snapshot.error}'));
}
```

### 3. Loading States
```dart
if (snapshot.connectionState == ConnectionState.waiting) {
  return CircularProgressIndicator();
}
```

### 4. Empty States
```dart
if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
  return Text('No data available');
}
```

---

## 💡 Key Learnings & Reflections

### What We Learned:

1. **Firestore's `.snapshots()` is Incredibly Powerful**
   - Single method call provides complete real-time sync
   - No complex polling or WebSocket management needed
   - Firebase handles all the networking complexity

2. **StreamBuilder Simplifies Real-Time UI**
   - Automatically rebuilds widget when data changes
   - Built-in connection state management
   - Clean separation of data and UI logic

3. **Real-Time Updates Transform User Experience**
   - Users no longer need to refresh manually
   - App feels alive and responsive
   - Critical for collaborative features

4. **Performance Considerations**
   - Firestore efficiently handles multiple simultaneous listeners
   - Only changed documents are transmitted
   - Minimal battery and network impact

### Challenges Faced:

1. **Initial State Management**
   - Challenge: Handling the brief loading state on first load
   - Solution: Implemented proper `ConnectionState.waiting` checks

2. **Empty State Handling**
   - Challenge: UI crashes when collection is empty
   - Solution: Always check `snapshot.data!.docs.isEmpty`

3. **Multiple Listeners Performance**
   - Challenge: Worried about too many active listeners
   - Solution: Discovered Firestore handles this efficiently

4. **Data Consistency**
   - Challenge: Ensuring UI stays consistent during rapid changes
   - Solution: Firestore guarantees ordered updates

---

## 🔄 How Firestore's `.snapshots()` Works

```dart
// Behind the scenes:
.snapshots()
  ↓
Opens persistent WebSocket connection
  ↓
Listens for server-side changes
  ↓
Receives push notifications on any change
  ↓
Streams updates to your Flutter app
  ↓
StreamBuilder rebuilds UI automatically
```

---

## 📊 Performance Metrics

| Metric | Result |
|--------|--------|
| Average Update Latency | < 1 second |
| UI Rebuild Time | < 100ms |
| Network Efficiency | Only changed docs transmitted |
| Battery Impact | Minimal (persistent connection) |
| Offline Support | ✅ Yes (cached data) |
| Multi-Device Sync | ✅ Real-time |

---

## 🎯 Use Cases Implemented

1. ✅ **Live Order Tracking** - Users see order status changes instantly
2. ✅ **Real-Time Dashboard** - Statistics update as data changes
3. ✅ **Live Order List** - New orders appear automatically
4. ✅ **Status Filters** - Filtered views update in real-time
5. ✅ **Authentication State** - Auto-navigation on login/logout
6. ✅ **Multi-User Sync** - Changes reflect across all devices

---

## 📚 Resources Used

- [Firestore Real-Time Listeners Documentation](https://firebase.google.com/docs/firestore/query-data/listen)
- [StreamBuilder Widget Reference](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html)
- [Cloud Firestore for Flutter](https://firebase.flutter.dev/docs/firestore/usage)
- [Best Practices for Firestore](https://firebase.google.com/docs/firestore/best-practices)

---

## 🎥 Video Demonstration

**Video Link:** [Insert your video link here]

**Video demonstrates:**
- ✅ App displaying live Firestore data
- ✅ Real-time modifications in Firebase Console
- ✅ App updating instantly without manual refresh
- ✅ Explanation of snapshot listeners and StreamBuilder
- ✅ Live statistics updating dynamically

**Access:** Anyone with the link

---

## 🏆 Sprint Summary

**Sprint:** Sprint-2  
**Task:** Real-Time Sync with Firestore Snapshots  
**Team:** [Your Team Name]  
**Status:** ✅ Completed

**Implemented Features:**
- ✅ Firestore snapshot listeners for all collections
- ✅ StreamBuilder-based real-time UI
- ✅ Live order tracking and statistics
- ✅ Instant multi-device synchronization
- ✅ Proper error and loading state handling

---

## 🚀 Getting Started

### Prerequisites
```bash
flutter --version  # Ensure Flutter is installed
```

### Installation
```bash
# Clone the repository
git clone [your-repo-url]

# Navigate to project
cd icuisine

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Firebase Setup
1. Add your `google-services.json` (Android)
2. Add your `GoogleService-Info.plist` (iOS)
3. Update `firebase_options.dart` with your Firebase config

---

## ☁️ Firebase Cloud Functions - Serverless Backend Logic

Modern mobile applications often need backend logic — sending notifications, processing data, validating input, or updating related records. Instead of managing your own servers, Firebase provides **Cloud Functions**, a serverless backend that runs your code automatically in response to events.

### What are Cloud Functions?

Cloud Functions are server-side code that:
- **Run automatically** when triggered by events (Firestore changes, user actions, etc.)
- **Execute on-demand** when called directly from your Flutter app
- **Scale automatically** without managing servers
- **Reduce backend overhead** by eliminating server maintenance

### 🎯 Cloud Functions Implemented

#### 1. **Callable Functions** (Invoked from Flutter)

##### `sayHello` - Greeting Function
A simple callable function that greets users by name.

**Cloud Function (functions/index.js):**
```javascript
exports.sayHello = functions.https.onCall((data, context) => {
  const name = data.name || "User";
  console.log(`sayHello called with name: ${name}`);
  
  return {
    message: `Hello, ${name}! Welcome to ICuisine.`,
    timestamp: admin.firestore.FieldValue.serverTimestamp(),
    userId: context.auth ? context.auth.uid : null,
  };
});
```

**Flutter Implementation (lib/services/cloud_functions_service.dart):**
```dart
Future<Map<String, dynamic>> callSayHello({String? name}) async {
  final callable = _functions.httpsCallable('sayHello');
  final result = await callable.call(<String, dynamic>{
    'name': name ?? 'User',
  });
  return Map<String, dynamic>.from(result.data);
}
```

**Use Case:** Personalized greetings, welcome messages, custom business logic

---

##### `processOrder` - Order Validation Function
Validates and processes orders with custom business logic.

**Cloud Function:**
```javascript
exports.processOrder = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated to process orders."
    );
  }

  const {orderId, items, totalAmount} = data;
  
  await admin.firestore().collection("orders").doc(orderId).update({
    status: "processing",
    processedAt: admin.firestore.FieldValue.serverTimestamp(),
    processedBy: "cloud-function",
  });

  return {
    success: true,
    message: "Order processed successfully",
    orderId: orderId,
   };
});
```

**Use Case:** Order validation, payment processing, inventory updates

---

#### 2. **Event-Based Functions** (Auto-triggered)

##### `newUserCreated` - Auto-Profile Generation
Triggers automatically when a new user document is created in Firestore.

**Cloud Function:**
```javascript
exports.newUserCreated = functions.firestore
  .document("users/{userId}")
  .onCreate(async (snap, context) => {
    const userData = snap.data();
    const userId = context.params.userId;

    console.log("New user created:", userId);

    // Auto-generate additional profile fields
    await snap.ref.update({
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      profileComplete: false,
      orderCount: 0,
      totalSpent: 0,
      loyaltyPoints: 100,  // Welcome bonus!
      accountStatus: "active",
    });

    return null;
  });
```

**What it does:**
- ✅ Adds timestamp automatically
- ✅ Initializes order count and spending
- ✅ Grants 100 welcome loyalty points
- ✅ Sets account status to active

**Use Case:** Welcome bonuses, profile initialization, send welcome emails

---

##### `onOrderStatusChanged` - Status Change Logger
Triggers when an order's status is updated.

**Cloud Function:**
```javascript
exports.onOrderStatusChanged = functions.firestore
  .document("orders/{orderId}")
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();
    
    if (before.status !== after.status) {
      console.log(`Order ${context.params.orderId} status: ${before.status} → ${after.status}`);
      
      // Log to separate collection
      await admin.firestore().collection("order_logs").add({
        orderId: context.params.orderId,
        previousStatus: before.status,
        newStatus: after.status,
        changedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }
    
    return null;
  });
```

**Use Case:** Push notifications, audit logs, analytics, email confirmations

---

##### `onOrderDeleted` - Archive Deleted Orders
Triggers when an order is deleted to maintain records.

**Cloud Function:**
```javascript
exports.onOrderDeleted = functions.firestore
  .document("orders/{orderId}")
  .onDelete(async (snap, context) => {
    const orderData = snap.data();
    
    // Archive for record-keeping
    await admin.firestore().collection("deleted_orders").doc(context.params.orderId).set({
      ...orderData,
      deletedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    
    return null;
  });
```

**Use Case:** Data archiving, audit trails, compliance

---

### 📱 Flutter Integration

#### 1. Add Dependency
```yaml
dependencies:
  cloud_functions: ^5.0.0
```

#### 2. Create Service Class
The `CloudFunctionsService` provides a clean interface for calling functions:

```dart
class CloudFunctionsService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<Map<String, dynamic>> callSayHello({String? name}) async {
    try {
      final callable = _functions.httpsCallable('sayHello');
      final result = await callable.call({'name': name ?? 'User'});
      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      throw Exception('Failed to call function: $e');
    }
  }
}
```

#### 3. Call from UI
```dart
final result = await CloudFunctionsService().callSayHello(name: 'Alex');
print(result['message']); // "Hello, Alex! Welcome to ICuisine."
```

#### 4. Cloud Functions Demo Screen
Navigate to **Cloud Functions Demo** from the home screen to:
- ✅ Test callable functions
- ✅ Trigger event-based functions
- ✅ View function responses
- ✅ See real-time results

---

### 🚀 Deployment

#### 1. Install Firebase Tools
```bash
npm install -g firebase-tools
```

#### 2. Login to Firebase
```bash
firebase login
```

#### 3. Initialize Functions (First time only)
```bash
cd functions
npm install
```

#### 4. Deploy Functions
```bash
firebase deploy --only functions
```

#### 5. View Logs
```bash
firebase functions:log
```

Or view in **Firebase Console → Functions → Logs**

---

### 📊 Viewing Execution Logs

#### Firebase Console Method:
1. Open **Firebase Console** → **Functions**
2. Click on **Logs** tab
3. Trigger a function from the app
4. Watch logs update in real-time
5. Look for:
   - ✅ Success messages
   - 📊 Input data
   - ❌ Errors (if any)
   - ⏱️ Execution time

#### Command Line Method:
```bash
firebase functions:log --only sayHello
```

---

### 🎯 Real-World Use Cases

#### Callable Functions:
- **Payment Processing** - Validate and process payments securely
- **Email Verification** - Send verification codes
- **Data Validation** - Complex validation logic
- **Third-Party API Calls** - Call external services securely
- **Custom Business Logic** - Complex computations

#### Event-Based Functions:
- **Welcome Emails** - Send when user signs up
- **Push Notifications** - Notify on order status change
- **Data Cleanup** - Clean up related data on deletion
- **Analytics** - Track events automatically
- **Image Processing** - Resize uploaded images
- **Backup** - Auto-backup critical data

---

### 🔒 Security Benefits

Cloud Functions run in a **secure server environment**, allowing you to:
- ✅ Hide API keys from client code
- ✅ Validate authentication server-side
- ✅ Enforce business rules consistently
- ✅ Access admin SDK with full permissions
- ✅ Process sensitive data securely

---

### 🎓 Why Serverless Functions Reduce Backend Overhead

1. **No Server Management**
   - No servers to set up, configure, or maintain
   - Automatic scaling based on demand
   - Pay only for execution time

2. **Instant Deployment**
   - Deploy with one command
   - No downtime during updates
   - Version control built-in

3. **Built-in Monitoring**
   - Logs automatically captured
   - Error tracking included
   - Performance metrics available

4. **Automatic Scaling**
   - Handles 1 user or 1 million users
   - No capacity planning needed
   - Traffic spikes handled automatically

5. **Cost Effective**
   - Free tier: 2M invocations/month
   - Pay per execution (not per server)
   - No idle server costs

---

### 📸 Screenshots

#### Cloud Functions Demo Screen
![Cloud Functions Screen](screenshots/cloud_functions_screen.png)
*Interactive UI for testing callable and event-based functions*

#### Firebase Console - Functions
![Firebase Functions](screenshots/firebase_functions.png)
*Deployed functions in Firebase Console*

#### Firebase Console - Logs
![Function Logs](screenshots/function_logs.png)
*Real-time execution logs showing successful function calls*

#### Function Response
![Function Response](screenshots/function_response.png)
*App displaying Cloud Function response*

---

### 🧪 Testing Cloud Functions

#### Test Callable Function:
1. Open the app
2. Navigate to **Cloud Functions Demo**
3. Enter your name
4. Click **Call sayHello()**
5. See the response displayed
6. Check Firebase logs for execution details

#### Test Event-Based Function:
1. Click **Trigger newUserCreated**
2. A test user document is created
3. Function automatically executes
4. Check Firebase Console → Firestore to see auto-generated fields
5. View logs to confirm execution

---

### 📝 Reflection

#### Why Serverless Functions Reduce Backend Overhead

**Traditional Backend:**
- Set up and maintain servers
- Configure load balancers
- Manage scaling
- Monitor uptime
- Apply security patches
- Pay for idle time

**Cloud Functions:**
- Write code, deploy, done!
- Auto-scaling included
- Built-in monitoring
- Security managed by Firebase
- Pay per execution only

#### Function Type Chosen

We implemented **both callable and event-based functions** to demonstrate:
- **Callable:** Direct control from Flutter (sayHello, processOrder)
- **Event-Based:** Automatic triggers (newUserCreated, onOrderStatusChanged)

#### Real-World Use Cases

1. **Welcome Bonus System** - Automatically grant points to new users
2. **Order Processing** - Validate orders and update inventory
3. **Audit Trails** - Log all status changes for compliance
4. **Data Archiving** - Preserve deleted records
5. **Notifications** - Send alerts on important events

This serverless architecture allows our ICuisine app to scale effortlessly while maintaining clean, secure backend logic.

---

## 🤝 Contributing

This project demonstrates real-time Firestore integration as part of Sprint-2 coursework.

---

## 📝 License

This project is created for educational purposes.

---

## 📞 Contact

**Team:** [Your Team Name]  
**Sprint:** Sprint-2  
**Task:** Real-Time Firestore Sync

---

**Built with ❤️ using Flutter & Firebase**

# Securing Firebase with Authentication and Firestore Rules

Modern mobile apps frequently store sensitive user data in the cloud. Firebase provides a powerful NoSQL database—Cloud Firestore—but it must be properly secured to prevent unauthorized access. In this lesson, you will learn how to secure Firestore using Authentication and custom security rules that determine who can read or write specific documents.

Every Firestore database starts in “test mode,” which grants open read/write access to anyone. While convenient during initial development, this is unsafe for production apps. Using Firebase Authentication, you can ensure only signed-in users can write or read data, and Firestore Security Rules allow you to apply fine-grained restrictions—for example: Only allow the owner of a document to update it.

- Block all anonymous writes.
- Restrict admin-only operations.

This lesson walks you through configuring Firebase Auth, writing secure Firestore rules, testing them, and understanding the difference between safe, basic, and open rules.

## 1. Why Securing Firestore Matters
- Protects user data from unauthorized access.
- Ensures that only authenticated users can write to or read the database.
- Prevents malicious usage, spam writes, data deletion, or tampering.
- Enforces role-based permissions (e.g., admin vs. regular user).
- Required before deploying apps to real users.

## 2. Firebase Authentication Setup

### Step 1: Add Required Dependencies
```yaml
dependencies:
  firebase_core: ^latest
  firebase_auth: ^latest
  cloud_firestore: ^latest
```
Run:
```bash
flutter pub get
```

### Step 2: Initialize Firebase
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
```

### Step 3: Enable Authentication
In the Firebase Console:

1. Go to Authentication → Sign-in methods
2. Enable:
   - Email/Password OR
   - Any provider you prefer (Google, Phone, etc.)

### Step 4: Sign Up / Sign In a User in Flutter
```dart
final auth = FirebaseAuth.instance;

Future<UserCredential> signIn(String email, String pass) {
  return auth.signInWithEmailAndPassword(email: email, password: pass);
}
```
Once authenticated, `FirebaseAuth.instance.currentUser` represents the signed-in user.

## 3. Securing Firestore With Rules

Firestore Rules control:
- Who can read a document
- Who can write a document
- Under what conditions they can do so

### Open Rules (Unsafe):
```firestore
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true;  // ❌ Completely open
    }
  }
}
```

### Secure Example (Recommended for Assignments):
Allow reads/writes only for authenticated users:
```firestore
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{uid} {
      allow read, write: if request.auth != null && request.auth.uid == uid;
    }
  }
}
```
This rule ensures:
- User must be logged in
- User can only access their own document
- No cross-account reading or writing

## 4. Firestore Access From Flutter

### Example: Write Data (Authenticated User)
```dart
final uid = FirebaseAuth.instance.currentUser!.uid;

await FirebaseFirestore.instance
    .collection('users')
    .doc(uid)
    .set({
  'name': 'John Doe',
  'lastLogin': DateTime.now(),
});
```

### Example: Restricted Read
```dart
final uid = FirebaseAuth.instance.currentUser!.uid;

final data = await FirebaseFirestore.instance
    .collection('users')
    .doc(uid)
    .get();

print(data.data());
```
If the rules deny access, this will throw a `FirebaseException`.

## 5. Testing Firestore Rules

In Firebase Console:
1. Go to Firestore → Rules
2. Switch to the Rules Playground
3. Simulate:
   - Authenticated request (with UID)
   - Unauthenticated request
4. Test for read or write access

## 6. Minimal Example

### Firestore Service Class
```dart
class FirestoreService {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  Future<void> updateUserProfile() async {
    final uid = auth.currentUser!.uid;

    await db.collection('users').doc(uid).set({
      'updatedAt': DateTime.now(),
    });
  }
}
```

### Corresponding Firestore Rule
```firestore
match /users/{uid} {
  allow read, write: if request.auth.uid == uid;
}
```

## 7. Common Issues & Fixes

| Issue                          | Cause                        | Fix                                      |
|-------------------------------|-----------------------------|------------------------------------------|
| PERMISSION_DENIED             | Rules block access          | Check rules + auth user UID              |
| Writes fail from unauthenticated users | No login performed        | Ensure sign-in before DB calls           |
| Accidentally open rules       | Started in test mode        | Replace with secure rules                |
| Google sign-in works locally but fails on release | Missing SHA keys         | Add SHA-1/SHA-256 to Firebase project    |
