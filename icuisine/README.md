# iCuisine - Flutter Widget Demo

A comprehensive Flutter application demonstrating the fundamentals of Stateless and Stateful widgets, along with Firebase integration and responsive design.

## Sprint 2: Stateless vs Stateful Widgets

This project showcases the two fundamental building blocks of Flutter applications: **Stateless Widgets** and **Stateful Widgets**. Understanding when and how to use each type is crucial for building efficient, maintainable Flutter applications.

---

## 📚 Understanding Stateless and Stateful Widgets

### What is a Stateless Widget?

A **StatelessWidget** is immutable and does not maintain any state that changes over time. Once built, it remains constant until its parent widget rebuilds it with new data.

**Key Characteristics:**
- ✅ Immutable - Cannot change after being built
- ✅ No internal state management
- ✅ Lightweight and efficient
- ✅ Perfect for static UI components

**When to Use:**
- Static text labels, headers, and titles
- Icons and images that don't change
- Layout widgets (Container, Row, Column, etc.)
- UI components that display fixed data

**Example Implementation:**

```dart
class DemoHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const DemoHeaderWidget({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade300, Colors.teal.shade600],
        ),
      ),
      child: Column(
        children: [
          Icon(Icons.widgets, size: 60, color: Colors.white),
          Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(subtitle, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
```

---

### What is a Stateful Widget?

A **StatefulWidget** maintains mutable state that can change during the widget's lifetime. It can respond to user interactions, animations, network requests, and other dynamic events.

**Key Characteristics:**
- ✅ Mutable state that can change over time
- ✅ Uses `setState()` to trigger UI updates
- ✅ Separated into Widget and State classes
- ✅ Can react to user interactions and events

**When to Use:**
- Interactive forms and input fields
- Counters, timers, and animations
- Toggle switches and checkboxes
- Any UI that changes based on user actions or external data

**Example Implementation:**

```dart
class CounterWidget extends StatefulWidget {
  const CounterWidget({Key? key}) : super(key: key);

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      _count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Count: $_count', style: TextStyle(fontSize: 48)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _decrement,
              child: Text('Decrease'),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: _increment,
              child: Text('Increase'),
            ),
          ],
        ),
      ],
    );
  }
}
```

---

## 🎯 Demo App Features

Our interactive demo app (`lib/screens/stateless_stateful_demo.dart`) showcases three types of stateful widgets:

### 1. **Counter Widget** 🔢
- Demonstrates basic state management with `setState()`
- Includes increment, decrement, and reset functionality
- Shows how user interactions trigger UI updates

### 2. **Color Changer Widget** 🎨
- Cycles through rainbow colors on button press
- Uses `AnimatedContainer` for smooth color transitions
- Demonstrates how state changes can affect multiple UI properties

### 3. **Theme Toggle Widget** 🌓
- Switches between light and dark modes
- Shows how boolean state can control entire UI themes
- Uses a `Switch` widget for intuitive toggling

### Static Components (Stateless):
- **Header Widget**: Displays app title and description
- **Info Card Widget**: Shows educational content
- Both remain unchanged throughout the app's lifecycle

---

## 📸 Screenshots

### Initial State
![Initial UI](screenshots/initial_state.png)
*The app loads with default values: counter at 0, red color, and light mode*

### After Interaction
![After Interaction](screenshots/after_interaction.png)
*Counter incremented, color changed to purple, theme toggled to dark mode*

### Interactive Demo Navigation
![Navigation](screenshots/navigation.png)
*Access the demo from the home screen using the widgets icon in the app bar*

---

## 🚀 How to Run

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd icuisine
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

4. **Access the demo:**
   - Login to the app
   - Tap the **widgets icon** (📦) in the top right corner of the home screen
   - Explore the interactive demo!

---

## 🔍 Key Concepts Demonstrated

### State Management with `setState()`

The `setState()` method is the fundamental way to update the UI in a StatefulWidget:

```dart
void _updateValue() {
  setState(() {
    // Modify state variables here
    _count++;
    _isDarkMode = !_isDarkMode;
  });
}
```

**Important:** Only the widgets that depend on the changed state will rebuild, making Flutter's rendering highly efficient.

### Widget Lifecycle

Stateful widgets have a lifecycle that includes:
1. **createState()** - Creates the mutable state
2. **initState()** - Called once when the widget is inserted
3. **build()** - Called whenever setState() is triggered
4. **dispose()** - Called when the widget is removed

### Separation of Concerns

Our demo separates:
- **Static UI** (Stateless): Headers, labels, info cards
- **Dynamic UI** (Stateful): Counters, toggles, interactive elements

This separation makes code more maintainable and performant.

---

## 💡 Reflection

### How do Stateful widgets make Flutter apps dynamic?

Stateful widgets enable Flutter apps to respond to user interactions and changing data in real-time. By maintaining internal state and using `setState()`, we can create interactive experiences like:
- Real-time counters and timers
- Animated transitions and effects
- Form validation and input handling
- Dynamic theming and personalization

Without stateful widgets, apps would be completely static and unable to react to user input.

### Why is it important to separate static and reactive parts of the UI?

**Performance**: Stateless widgets are more lightweight and don't require state management overhead. Using them for static content improves app performance.

**Maintainability**: Clear separation makes code easier to understand and modify. Developers can immediately identify which parts of the UI are dynamic.

**Reusability**: Stateless widgets are highly reusable across different parts of the app since they have no internal dependencies.

**Best Practices**: Following Flutter's widget composition model leads to cleaner, more testable code that's easier to debug.

**Optimization**: Flutter's rendering engine can skip rebuilding stateless widgets, focusing only on parts that actually changed.

---

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point
├── firebase_options.dart              # Firebase configuration
├── screens/
│   ├── home_screen.dart              # Main dashboard
│   ├── login_screen.dart             # Authentication
│   ├── signup_screen.dart            # User registration
│   ├── welcome_screen.dart           # Landing page
│   ├── widget_tree_demo.dart         # Widget tree visualization
│   └── stateless_stateful_demo.dart  # ⭐ Widget types demo
└── services/
    ├── auth_service.dart             # Firebase authentication
    └── firestore_service.dart        # Database operations
```

---

## 🛠️ Technologies Used

- **Flutter** - UI framework
- **Dart** - Programming language
- **Firebase** - Backend services (Auth, Firestore)
- **Material Design 3** - UI components

---

## 👥 Team Information

**Team Name:** [Your Team Name]

**Sprint:** Sprint 2 - Flutter & Dart Basics

**Assignment:** Creating and Using Stateless and Stateful Widgets

---

## 📖 Additional Resources

- [Flutter Widget Catalog](https://docs.flutter.dev/development/ui/widgets)
- [StatelessWidget Documentation](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html)
- [StatefulWidget Documentation](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)
- [Flutter State Management](https://docs.flutter.dev/development/data-and-backend/state-mgmt)

---

## 📝 Commit Message

```
feat: implemented demo showing stateless and stateful widgets

- Created comprehensive widget demo screen with multiple examples
- Implemented Counter, Color Changer, and Theme Toggle widgets
- Added static header and info card using StatelessWidget
- Integrated navigation from home screen to demo
- Updated README with detailed explanations and code snippets
- Demonstrated proper state management with setState()
```

---

## 🎓 Learning Outcomes

By completing this sprint, we've learned:

✅ The fundamental difference between Stateless and Stateful widgets  
✅ When to use each widget type appropriately  
✅ How to manage state using `setState()`  
✅ Best practices for widget composition  
✅ How to create interactive, responsive Flutter UIs  
✅ The importance of separating concerns in widget architecture  

---

**Made with ❤️ using Flutter**

