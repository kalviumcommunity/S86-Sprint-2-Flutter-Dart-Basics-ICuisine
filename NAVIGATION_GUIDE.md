# 🗺️ Multi-Screen Navigation Guide

This document comprehensively explains how the iCuisine app implements multi-screen navigation using Flutter's Navigator class and named routes.

## Quick Start

1. **Run the app**: `flutter run -d chrome`
2. **Tap Navigation Demo button** (🗺️) in home screen AppBar
3. **Try each interactive example**
4. **Observe debug console logs**

---

## Core Concepts

### 1. Stack-Based Navigation

Flutter manages screens as a **LIFO (Last-In-First-Out) stack**:

```
Current Screen (TOP) ← pop() removes this
Previous Screen
Home Screen (BOTTOM) ← push() adds to top
```

### 2. Named Routes

Routes are defined centrally in `main.dart`:

```dart
routes: {
  '/': (context) => HomeScreen(),
  '/settings': (context) => SettingsScreen(),
  '/details': (context) => DetailsScreen(),
}
```

### 3. Navigation Methods

| Method | Purpose | Use Case |
|--------|---------|----------|
| `pushNamed()` | Go to new screen | Standard navigation ⭐ |
| `pop()` | Back to previous | Back button |
| `popUntil()` | Back to specific screen | Skip intermediate screens |
| `pushReplacementNamed()` | Replace current | Login → Home |
| `pushNamedAndRemoveUntil()` | Clear entire stack | Start new flow |

---

## Implementation Details

### Main.dart Route Configuration

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => AuthService().currentUser != null
        ? const HomeScreen()
        : const LoginScreen(),
    '/navigation-demo': (context) => const NavigationDemoScreen(),
    '/settings': (context) => const SettingsScreen(),
    '/details': (context) => const DetailsScreen(),
    '/navigation-stack': (context) => const NavigationStackScreen(),
  },
)
```

### Navigation Examples

**Navigate to Settings:**
```dart
Navigator.pushNamed(context, '/settings');
```

**Navigate with Arguments:**
```dart
Navigator.pushNamed(
  context,
  '/details',
  arguments: {
    'title': 'Product Details',
    'productId': 123,
  },
);
```

**Receive Arguments:**
```dart
final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
final title = args?['title'] ?? 'Default';
```

**Go Back:**
```dart
Navigator.pop(context);
```

---

## Screens Implemented

### 1. NavigationDemoScreen
- **Location**: `lib/screens/navigation_demo.dart`
- **Purpose**: Interactive tutorial for navigation concepts
- **Features**: 
  - Navigation concepts explanation
  - Method comparison table
  - Interactive examples with buttons
  - Code snippets
  - Pro tips

### 2. SettingsScreen
- **Location**: `lib/screens/settings_screen.dart`
- **Purpose**: Example screen accessible via named route
- **Features**:
  - Settings list with multiple options
  - Tappable items (interaction demo)
  - Back navigation

### 3. DetailsScreen
- **Location**: `lib/screens/details_screen.dart`
- **Purpose**: Demonstrates argument passing
- **Features**:
  - Displays received arguments
  - Shows how to safely handle null values
  - Code example of receiving arguments
  - Navigation options (Back, Home)

### 4. NavigationStackScreen
- **Location**: `lib/screens/navigation_stack_screen.dart`
- **Purpose**: Visualizes the navigation stack
- **Features**:
  - Visual stack representation
  - Stack explanation with diagrams
  - Navigation code examples
  - Benefits of named routes

---

## Benefits of This Approach

1. **Centralized**: All routes in one place
2. **Maintainable**: Easy to rename or reorganize
3. **Scalable**: Simple to add new screens
4. **Refactorable**: IDE can find all usages
5. **Type-Safe**: Can use code generation
6. **Deep-Linkable**: Support URLs to any screen
7. **Testable**: Easy to test navigation

---

## Common Patterns

### Pattern 1: Login to Home
```dart
// After successful login
Navigator.pushNamedAndRemoveUntil(
  context,
  '/',
  (route) => false,
);
```

### Pattern 2: Multi-step Workflow
```dart
// Step 1 → Step 2
Navigator.pushNamed(context, '/checkout/step2', arguments: cartData);

// Final step
Navigator.pushNamedAndRemoveUntil(
  context,
  '/confirmation',
  (route) => route.settings.name == '/',
);
```

### Pattern 3: Conditional Navigation
```dart
if (user.isVendor) {
  Navigator.pushNamed(context, '/vendor/dashboard');
} else {
  Navigator.pushNamed(context, '/customer/orders');
}
```

---

## Testing Navigation

### Test Route Exists
```dart
testWidgets('can navigate to settings', (tester) async {
  await tester.pumpWidget(const MyApp());
  await tester.tap(find.byIcon(Icons.settings));
  await tester.pumpAndSettle();
  expect(find.byType(SettingsScreen), findsOneWidget);
});
```

### Test Arguments Passed
```dart
testWidgets('receives arguments correctly', (tester) async {
  Navigator.pushNamed(
    context,
    '/details',
    arguments: {'id': 123},
  );
  // Verify in DetailsScreen
});
```

---

## Debugging Navigation

### Debug Logs Throughout App

```dart
// Every navigation call includes debugPrint
Navigator.pushNamed(context, '/settings');
debugPrint('📍 Navigating to /settings');

Navigator.pop(context);
debugPrint('🔙 Back to previous screen');
```

### Enable Flutter DevTools

```bash
# In flutter run terminal, press: p
# Or manually:
flutter pub global run devtools
```

---

## Common Mistakes to Avoid

❌ **Don't navigate in build():**
```dart
@override
Widget build(BuildContext context) {
  Navigator.pushNamed(context, '/settings');  // ❌ WRONG
}
```

✅ **Navigate in callback:**
```dart
ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/settings');  // ✅ CORRECT
  },
)
```

---

## File Structure

```
lib/
├── main.dart (routes defined here)
└── screens/
    ├── navigation_demo.dart
    ├── settings_screen.dart
    ├── details_screen.dart
    └── navigation_stack_screen.dart
```

---

## Next Steps

- [ ] Add more screens as needed
- [ ] Implement GoRouter for advanced routing
- [ ] Add route animations
- [ ] Deep linking support
- [ ] Route-level permissions
- [ ] Navigation state restoration
