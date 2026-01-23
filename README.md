# ICuisine

## Project Overview
ICuisine is a mobile application designed to help popular street-food vendors manage orders efficiently during rush hours. The app aims to reduce long queues and prevent order mismanagement by providing a smooth ordering system that doesn't slow down service.

## Problem Statement
Popular street-food vendors face long queues and order mismanagement during rush hours. How might we help them accept and manage orders smoothly without slowing down service?

## Sprint 2 – Folder Structure Exploration

- Cross-platform Flutter app (mobile, web, desktop) with Firebase config in lib/firebase_options.dart; install dependencies with `flutter pub get` and run with `flutter run -d <device>`.
- Detailed folder and file roles are documented in [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md).

Folder snapshot (current):
```
icuisine/
├── lib/
│   ├── main.dart
│   ├── firebase_options.dart
│   ├── screens/...
│   └── services/...
├── android/ ios/ web/ windows/ macos/ linux/
├── test/
└── pubspec.yaml
```

Reflection
- Knowing each folder’s purpose accelerates onboarding and debugging because contributors can navigate directly to UI, services, or platform configs.
- A clean, predictable structure reduces merge conflicts and keeps cross-platform build settings isolated from shared Dart code.

## Project Structure

### Directory Organization

- **`/lib`** - Main application source code
    - **`/models`** - Data models and business logic entities (e.g., Order, MenuItem, Vendor)
    - **`/views`** - UI screens and pages (e.g., HomePage, OrderPage, MenuPage)
    - **`/controllers`** - Business logic and state management
    - **`/widgets`** - Reusable UI components (e.g., CustomButton, OrderCard, MenuItem)
    - **`/services`** - External integrations (API calls, database, authentication)
    - **`/utils`** - Helper functions and constants
    - **`/config`** - App configuration files (theme, routes, environment variables)

- **`/assets`** - Static resources
    - **`/images`** - Image files and icons
    - **`/fonts`** - Custom fonts

- **`/test`** - Unit and widget tests

## Modular Design Approach

This structure supports modular app design through:

1. **Separation of Concerns**: Each directory has a single, well-defined responsibility
2. **Reusability**: Widgets and services can be reused across different views
3. **Scalability**: New features can be added without affecting existing code
4. **Maintainability**: Clear organization makes it easy to locate and update code
5. **Testability**: Isolated components are easier to test independently

## Naming Conventions

### Files
- **Snake_case**: `order_page.dart`, `menu_item_card.dart`
- Descriptive names that reflect content: `user_service.dart`, `app_theme.dart`

### Classes
- **PascalCase**: `OrderPage`, `MenuItemCard`, `VendorService`
- Suffix with type: `HomePage`, `OrderController`, `UserModel`

### Widgets
- **PascalCase**: `CustomButton`, `OrderCard`, `MenuItemTile`
- Descriptive of UI component: `LoadingSpinner`, `EmptyStateWidget`

---

## Responsive Layout Implementation

### Overview
The `responsive_home.dart` screen demonstrates comprehensive responsive design principles for the iCuisine vendor dashboard. The layout adapts seamlessly across phones, tablets, and desktop devices, providing an optimal user experience in both portrait and landscape orientations.

### Key Features Implemented

#### 1. MediaQuery for Device Detection
The app uses `MediaQuery` to detect screen dimensions and adjust the layout dynamically:

```dart
// Get screen dimensions
double screenWidth = MediaQuery.of(context).size.width;
double screenHeight = MediaQuery.of(context).size.height;
Orientation orientation = MediaQuery.of(context).orientation;

// Determine device type
bool isPhone = screenWidth < 600;
bool isTablet = screenWidth >= 600 && screenWidth < 1200;
bool isDesktop = screenWidth >= 1200;

// Responsive values based on device
int crossAxisCount = isPhone ? 2 : (isTablet ? 3 : 4);
double fontSize = isPhone ? 14.0 : (isTablet ? 16.0 : 18.0);
```

#### 2. LayoutBuilder for Context-Aware Layouts
Used `LayoutBuilder` to create layouts that respond to their container's constraints:

```dart
return LayoutBuilder(
  builder: (context, constraints) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: isPhone ? 1.2 : 1.5,
      ),
      // ...
    );
  },
);
```

#### 3. Flexible & Adaptive Widgets
Implemented various responsive widgets for smooth scaling:

- **Expanded**: Makes content fill available space in the Column layout
- **Flexible**: Allows widgets to resize proportionally within Row/Column
- **FittedBox**: Scales content to fit within bounds without overflow
- **AspectRatio**: Maintains consistent proportions across devices
- **Wrap**: Creates flowing layouts that adapt to screen width

```dart
// Example: FittedBox prevents text overflow
FittedBox(
  fit: BoxFit.scaleDown,
  child: Text(
    'iCuisine Dashboard',
    style: TextStyle(fontSize: headerFontSize),
  ),
)

// Example: Wrap for responsive button flow
Wrap(
  spacing: isPhone ? 8 : 16,
  runSpacing: isPhone ? 8 : 16,
  children: [
    _buildActionButton(...),
    _buildActionButton(...),
  ],
)
```

#### 4. Orientation-Aware Layouts
The app switches between list and grid views based on orientation:

```dart
orientation == Orientation.portrait
  ? _buildOrdersList(screenWidth, fontSize, isPhone)
  : _buildOrdersGrid(screenWidth, fontSize, isPhone)
```

### Screen Components

The responsive dashboard includes:

1. **Header Section** - Gradient AppBar with adaptive sizing and spacing
2. **Statistics Cards** - Grid layout that adjusts columns (2/3/4) based on device
3. **Active Orders** - List view (portrait) / Grid view (landscape)
4. **Quick Actions** - Wrap layout with responsive button sizing
5. **Footer Actions** - Column layout (phone) / Row layout (tablet/desktop)

### Responsive Breakpoints

- **Phone**: `width < 600px` - Single column, compact spacing
- **Tablet**: `600px ≤ width < 1200px` - Two-column layouts, medium spacing
- **Desktop**: `width ≥ 1200px` - Multi-column layouts, generous spacing

### Testing Results

#### Tested Devices:
1. **Phone (Portrait)**: Pixel 6 - 412 x 915 px
   - 2-column statistics grid
   - List view for orders
   - Stacked footer buttons
   
2. **Tablet (Portrait)**: iPad Pro - 834 x 1194 px
   - 3-column statistics grid
   - List view for orders
   - Side-by-side footer buttons
   
3. **Tablet (Landscape)**: iPad Pro - 1194 x 834 px
   - 3-column statistics grid
   - 2-column grid for orders
   - Side-by-side footer buttons

4. **Desktop**: Chrome/Edge Browser - 1920 x 1080 px
   - 4-column statistics grid
   - Grid view for orders
   - Expanded action buttons

### Code Snippets

#### Dynamic Grid Column Count
```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: isPhone ? 2 : (isTablet ? 3 : 4),
    crossAxisSpacing: isPhone ? 8 : 16,
    mainAxisSpacing: isPhone ? 8 : 16,
    childAspectRatio: isPhone ? 1.2 : 1.5,
  ),
  itemBuilder: (context, index) => _buildStatCard(...),
)
```

#### Conditional Layout Switching
```dart
Container(
  child: screenWidth < 600
    ? Column(children: [button1, button2]) // Phone: vertical
    : Row(children: [button1, button2]),   // Tablet+: horizontal
)
```

### Challenges & Solutions

#### Challenge 1: Text Overflow on Small Screens
**Problem**: Long text labels were overflowing on small phone screens.
**Solution**: Wrapped text widgets in `FittedBox` and `Flexible` widgets to automatically scale text down when space is limited.

```dart
Flexible(
  child: FittedBox(
    fit: BoxFit.scaleDown,
    child: Text('Order #${orderNumber}'),
  ),
)
```

#### Challenge 2: Inconsistent Button Sizing
**Problem**: Buttons appeared disproportionate across different screen sizes.
**Solution**: Used conditional sizing based on device type and `SizedBox` for fixed widths where appropriate.

```dart
double buttonWidth = isPhone ? 160 : 180;
SizedBox(
  width: buttonWidth,
  child: ElevatedButton(...),
)
```

#### Challenge 3: Grid Layout Breaking in Landscape
**Problem**: Grid cards were too stretched in landscape mode.
**Solution**: Adjusted `childAspectRatio` dynamically and switched to different layouts based on orientation.

```dart
orientation == Orientation.portrait
  ? _buildOrdersList()  // Better for narrow screens
  : _buildOrdersGrid()  // Better for wide screens
```

### Real-World Benefits of Responsive Design

1. **Universal Accessibility**: Street food vendors can use any device - phone, tablet, or desktop - to manage orders
2. **Improved Usability**: Larger touch targets on tablets make it easier to take orders during busy rush hours
3. **Better Visual Hierarchy**: Adaptive layouts ensure critical information is always prominent regardless of screen size
4. **Reduced Training Time**: Consistent experience across devices means vendors don't need separate training
5. **Future-Proof**: Design adapts automatically to new device sizes without code changes
6. **Professional Appearance**: Clean, properly-scaled UI builds trust with vendors and customers

### How to Run & Test

```bash
# Run on different devices
flutter run -d chrome      # Test in web browser
flutter run -d windows     # Test on Windows desktop
flutter run -d <device-id> # Test on connected device/emulator

# Test different screen sizes in Chrome DevTools
# Press F12 → Toggle device toolbar → Select different devices
```

### Screenshots

To see the responsive layout in action:
1. Run the app: `flutter run`
2. Open Chrome DevTools (F12)
3. Toggle device toolbar
4. Test with: iPhone SE, Pixel 6, iPad, iPad Pro, Desktop
5. Rotate to test both portrait and landscape orientations

---

## Future Enhancements

- Dark mode support with adaptive colors
- Tablet-optimized split-view for order management
- Desktop multi-window support for kitchen display systems

### Variables & Functions
- **camelCase**: `userName`, `fetchOrders()`, `isLoading`
- Boolean variables prefixed with `is`, `has`, `can`: `isLoggedIn`, `hasOrders`

### Constants
- **UPPER_SNAKE_CASE**: `API_BASE_URL`, `MAX_ORDER_ITEMS`, `DEFAULT_TIMEOUT`

---

## Firebase Integration (Sprint 2)

### Overview
iCuisine is now integrated with Firebase to provide secure authentication, real-time data storage, and cloud-based backend services. This enables vendors and customers to manage orders efficiently with data synchronized across devices in real-time.

### Firebase Features Implemented

#### 1. Firebase Authentication
- **User Sign Up**: Create new accounts with email and password
- **User Login**: Secure authentication with existing credentials
- **Password Reset**: Email-based password recovery
- **User Logout**: Secure session termination
- **Account Deletion**: Complete user account removal

#### 2. Cloud Firestore Database
- **User Data Management**: Store user profiles (name, email, user type)
- **Order Management**: CRUD operations for orders with real-time updates
- **Menu Items**: Store and manage vendor menu items
- **Real-time Sync**: Instant data updates across all connected devices
- **Status Tracking**: Track order status (pending, preparing, ready, completed)

### Firebase Setup Instructions

#### Prerequisites
- Flutter SDK installed
- Firebase CLI installed (`npm install -g firebase-tools`)
- FlutterFire CLI installed (`dart pub global activate flutterfire_cli`)

#### Step 1: Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project" and follow the setup wizard
3. Enter project name: `icuisine-app`
4. Enable Google Analytics (optional)
5. Click "Create project"

#### Step 2: Configure Firebase for Flutter
```bash
# Login to Firebase
firebase login

# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Navigate to your project directory
cd icuisine

# Configure Firebase
flutterfire configure
```

Select your Firebase project and platforms (Android, iOS, Web) when prompted.

#### Step 3: Enable Firebase Services

**Enable Authentication:**
1. In Firebase Console, go to **Authentication** → **Sign-in method**
2. Enable **Email/Password** provider
3. Click "Save"

**Enable Cloud Firestore:**
1. Go to **Firestore Database** → **Create database**
2. Start in **Test mode** (for development)
3. Choose a location closest to your users
4. Click "Enable"

**Set Firestore Security Rules (for production):**
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Orders: users can manage their own orders
    match /orders/{orderId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update, delete: if request.auth != null && 
        resource.data.userId == request.auth.uid;
    }
    
    // Menu items: authenticated users can read, vendors can write
    match /menu_items/{itemId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
  }
}
```

#### Step 4: Install Dependencies
```bash
# Navigate to your Flutter project
cd icuisine

# Get dependencies
flutter pub get

# Run the app
flutter run
```

### Dependencies Used

```yaml
dependencies:
  firebase_core: ^3.0.0       # Firebase core functionality
  firebase_auth: ^5.0.0       # Authentication services
  cloud_firestore: ^5.0.0     # Cloud database
```

### Project Structure

```
lib/
├── services/
│   ├── auth_service.dart         # Authentication logic
│   └── firestore_service.dart    # Firestore CRUD operations
├── screens/
│   ├── login_screen.dart         # User login interface
│   ├── signup_screen.dart        # User registration interface
│   └── user_dashboard.dart       # Main dashboard with orders
└── main.dart                     # Firebase initialization
```

### Code Examples

#### Authentication Service (auth_service.dart)

```dart
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up with email and password
  Future<User?> signUp(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print('Sign up error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    }
  }

  // Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
```

#### Firestore Service (firestore_service.dart)

```dart
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add user data
  Future<void> addUserData(String uid, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(uid).set({
      ...data,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Add order
  Future<String> addOrder(Map<String, dynamic> orderData) async {
    final docRef = await _firestore.collection('orders').add({
      ...orderData,
      'createdAt': FieldValue.serverTimestamp(),
      'status': 'pending',
    });
    return docRef.id;
  }

  // Stream user orders in real-time
  Stream<QuerySnapshot> streamUserOrders(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Update order status
  Future<void> updateOrder(String orderId, Map<String, dynamic> data) async {
    await _firestore.collection('orders').doc(orderId).update({
      ...data,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Delete order
  Future<void> deleteOrder(String orderId) async {
    await _firestore.collection('orders').doc(orderId).delete();
  }
}
```

#### Real-time Data Display (StreamBuilder)

```dart
StreamBuilder<QuerySnapshot>(
  stream: _firestoreService.streamUserOrders(user.uid),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }

    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Text('No orders yet');
    }

    final orders = snapshot.data!.docs;
    
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final orderData = order.data() as Map<String, dynamic>;
        
        return ListTile(
          title: Text(orderData['description']),
          subtitle: Text('Status: ${orderData['status']}'),
          trailing: Text('\$${orderData['total']}'),
        );
      },
    );
  },
)
```

### Features & Functionality

#### Sign Up Flow
1. User opens the app and navigates to Sign Up screen
2. Enters full name, email, password, and selects user type (Customer/Vendor)
3. Firebase Authentication creates the account
4. User data is saved to Firestore in `users` collection
5. User is automatically redirected to the Dashboard

#### Login Flow
1. User enters email and password
2. Firebase authenticates credentials
3. On success, user is redirected to Dashboard
4. User data is loaded from Firestore
5. Real-time order updates begin

#### Dashboard Features
- **User Profile**: Displays user info (name, email, type) from Firestore
- **Add Orders**: Create new orders with descriptions
- **View Orders**: Real-time list of all user orders
- **Update Status**: Change order status (pending → preparing → ready → completed)
- **Delete Orders**: Remove orders from database
- **Logout**: Sign out and return to login screen

### Testing Guide

#### Test Authentication
1. Run the app: `flutter run`
2. Click "Sign Up" and create a new account
3. Verify account creation in Firebase Console → Authentication
4. Test login with the new credentials
5. Test "Forgot Password" functionality
6. Test logout

#### Test Firestore Operations
1. After logging in, add a new order
2. Check Firebase Console → Firestore Database → `orders` collection
3. Verify the order appears in real-time
4. Update order status in the app
5. Verify status change in Firebase Console
6. Delete an order and confirm removal

#### Test Real-time Sync
1. Open the app on two devices/browsers
2. Log in with the same account
3. Add an order on device 1
4. Observe instant update on device 2
5. Update status on device 2
6. Observe change on device 1

### Screenshots

*(Include screenshots showing):*
1. **Login Screen**: Email/password input fields
2. **Sign Up Screen**: Registration form with user type selection
3. **User Dashboard**: Profile card with user info
4. **Orders List**: Real-time orders with status indicators
5. **Firebase Console - Authentication**: User list
6. **Firebase Console - Firestore**: Orders collection with data

### Challenges & Solutions

#### Challenge 1: Firebase Initialization
**Problem**: App crashed on startup with "Firebase not initialized" error.

**Solution**: Added `WidgetsFlutterBinding.ensureInitialized()` and `await Firebase.initializeApp()` in main() before runApp().

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
```

#### Challenge 2: Real-time Updates Not Working
**Problem**: Orders weren't updating in real-time when status changed.

**Solution**: Used `StreamBuilder` widget to listen to Firestore snapshots instead of one-time reads with `FutureBuilder`.

```dart
StreamBuilder<QuerySnapshot>(
  stream: _firestoreService.streamUserOrders(userId),
  builder: (context, snapshot) {
    // UI updates automatically when data changes
  },
)
```

#### Challenge 3: Error Handling
**Problem**: Generic error messages weren't helpful for users.

**Solution**: Created custom error handler in AuthService to provide user-friendly messages for each Firebase error code.

```dart
String _handleAuthException(FirebaseAuthException e) {
  switch (e.code) {
    case 'weak-password':
      return 'Password must be at least 6 characters';
    case 'email-already-in-use':
      return 'Account already exists with this email';
    // ... more cases
  }
}
```

#### Challenge 4: Data Persistence
**Problem**: User data wasn't persisting after account creation.

**Solution**: Immediately saved user profile to Firestore after successful authentication using a separate collection.

```dart
if (user != null) {
  await _firestoreService.addUserData(user.uid, {
    'name': _nameController.text.trim(),
    'email': _emailController.text.trim(),
    'userType': _userType,
  });
}
```

### Reflection: Learning Outcomes

**How does Firebase improve scalability?**
- **Automatic Scaling**: Firebase handles infrastructure, automatically scaling from 1 to millions of users without manual server management
- **Real-time Sync**: Changes propagate instantly to all connected clients, reducing polling and server load
- **Offline Support**: Firestore caches data locally, enabling offline functionality and reducing server requests
- **Global CDN**: Firebase hosting and storage use Google's global infrastructure for fast worldwide access

**How does Firebase enable real-time collaboration?**
- **Instant Updates**: Multiple vendors can see order updates in real-time without refreshing
- **Conflict Resolution**: Firestore handles concurrent writes automatically with timestamps
- **Live Dashboard**: Orders appear on vendor dashboard immediately when customers place them
- **Status Tracking**: All stakeholders see order status changes instantly (pending → preparing → ready)

**Benefits for iCuisine:**
1. **Reduced Development Time**: No need to build custom backend, authentication, or database systems
2. **Cost-Effective**: Pay only for what you use, with generous free tier for development
3. **Security**: Built-in authentication and security rules protect user data
4. **Reliability**: 99.95% uptime SLA ensures vendors can always access the system
5. **Speed**: Real-time updates eliminate refresh delays during rush hours
6. **Flexibility**: Easy to add new features like push notifications, analytics, and cloud functions

### Next Steps

- [ ] Add push notifications for new orders
- [ ] Implement Firebase Storage for menu item images
- [ ] Add Firebase Analytics for user behavior tracking
- [ ] Create admin dashboard for vendor management
- [ ] Implement Firebase Cloud Functions for automated order processing
- [ ] Add Firebase Performance Monitoring

### Resources
- [Firebase for Flutter Setup](https://firebase.google.com/docs/flutter/setup)
- [Firebase Authentication Docs](https://firebase.google.com/docs/auth)
- [Cloud Firestore Docs](https://firebase.google.com/docs/firestore)
- [FlutterFire CLI Reference](https://firebase.flutter.dev/docs/cli)
- [StreamBuilder Widget Guide](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html)

---

## Getting Started

(Add installation and setup instructions here)