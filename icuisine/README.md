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

## 📜 Scrollable Views: ListView and GridView

### Overview

This section demonstrates how to work with scrollable layouts in Flutter using **ListView** and **GridView** widgets. These are essential for displaying dynamic content like product catalogs, chat lists, photo galleries, and more.

---

### 🎯 Key Scrollable Widgets

#### ListView - For List-Based Content

**ListView** displays widgets in a scrollable vertical or horizontal list. It's perfect for:
- Contact lists
- Chat messages
- News feeds
- Menu items

**Basic ListView Example:**

```dart
ListView(
  children: [
    ListTile(
      leading: Icon(Icons.person),
      title: Text('User 1'),
      subtitle: Text('Online'),
    ),
    ListTile(
      leading: Icon(Icons.person),
      title: Text('User 2'),
      subtitle: Text('Offline'),
    ),
  ],
);
```

**Optimized ListView.builder:**

For performance with large lists, use `ListView.builder`:

```dart
ListView.builder(
  itemCount: 20,
  itemBuilder: (context, index) {
    return ListTile(
      leading: CircleAvatar(child: Text('${index + 1}')),
      title: Text('Item $index'),
      subtitle: Text('Description of item $index'),
    );
  },
);
```

**Why use .builder()?**
- Creates items on demand
- Only renders visible items
- Improves memory efficiency
- Better performance for large datasets

---

#### GridView - For Grid Layouts

**GridView** arranges widgets in a scrollable grid pattern. Perfect for:
- Image galleries
- Product showcases
- Dashboard tiles
- App launchers

**Basic GridView Example:**

```dart
GridView.count(
  crossAxisCount: 2,
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  children: [
    Container(color: Colors.teal, child: Center(child: Text('1'))),
    Container(color: Colors.orange, child: Center(child: Text('2'))),
    Container(color: Colors.blue, child: Center(child: Text('3'))),
    Container(color: Colors.purple, child: Center(child: Text('4'))),
  ],
);
```

**Optimized GridView.builder:**

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
  ),
  itemCount: 8,
  itemBuilder: (context, index) {
    return Container(
      color: Colors.primaries[index % Colors.primaries.length],
      child: Center(
        child: Text(
          'Tile $index',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  },
);
```

---

### 🎨 Demo Implementation

Our [scrollable_views.dart](lib/screens/scrollable_views.dart) screen features:

#### Tab 1: ListView Examples
- **Vertical ListView**: Scrollable list with cards and avatars
- **Horizontal ListView**: Swipeable menu items with icons

#### Tab 2: GridView Examples
- **2-Column Grid**: Responsive grid layout
- **3-Column Grid**: Dense grid display

#### Tab 3: Combined Layout
- Horizontal scrolling list of featured items
- Vertical grid of popular products
- Single scrollable container combining both

**Code Snippet from Combined Layout:**

```dart
SingleChildScrollView(
  child: Column(
    children: [
      // Horizontal ListView
      Container(
        height: 180,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            return Container(
              width: 140,
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.primaries[index % Colors.primaries.length],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: Text(menuItems[index])),
            );
          },
        ),
      ),
      
      // GridView
      GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.primaries[index % Colors.primaries.length],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Text('Item ${index + 1}')),
          );
        },
      ),
    ],
  ),
);
```

---

### 📸 Screenshots

#### ListView Tab
![ListView Demo](screenshots/listview_demo.png)
*Vertical and horizontal scrolling lists with interactive items*

#### GridView Tab
![GridView Demo](screenshots/gridview_demo.png)
*2-column and 3-column grid layouts with colorful tiles*

#### Combined Layout
![Combined Layout](screenshots/combined_layout.png)
*Horizontal list and grid view in a single scrollable screen*

---

### 🔍 Performance Best Practices

Our implementation follows these optimization techniques:

1. **Use Builder Constructors**
   ```dart
   ListView.builder()  // ✅ Lazy loading
   ListView()          // ❌ Loads all at once
   ```

2. **Set shrinkWrap for Nested Scrolling**
   ```dart
   GridView.builder(
     shrinkWrap: true,
     physics: NeverScrollableScrollPhysics(),
   )
   ```

3. **Optimize Item Count**
   - Only load what's needed
   - Implement pagination for large datasets

4. **Use Const Constructors**
   - Reduces widget rebuilds
   - Improves performance

---

### 💡 Reflection Questions

#### How does ListView differ from GridView in design use cases?

**ListView** is ideal for:
- Single-column content (contacts, messages, settings)
- Horizontally scrolling content (image carousels, category filters)
- Variable height items (news articles, social media posts)
- Sequential data presentation

**GridView** excels at:
- Multi-column layouts (photo galleries, product grids)
- Uniform-sized items (app icons, calendar days)
- Dense information display (dashboards, tile-based UIs)
- Symmetrical content arrangement

**Key Difference**: ListView focuses on sequential, linear presentation, while GridView emphasizes spatial organization across multiple columns.

---

#### Why is ListView.builder() more efficient for large lists?

1. **Lazy Loading**: Creates widgets only when they're about to appear on screen
2. **Memory Efficient**: Doesn't hold all widgets in memory at once
3. **On-Demand Rendering**: Builds items dynamically as user scrolls
4. **Widget Recycling**: Reuses widgets that scroll off-screen
5. **Smooth Performance**: Prevents UI lag even with thousands of items

**Example Impact:**
```dart
// ❌ Regular ListView - Loads 1000 items immediately
ListView(
  children: List.generate(1000, (i) => ListTile(...))
)

// ✅ ListView.builder - Loads items as needed
ListView.builder(
  itemCount: 1000,
  itemBuilder: (context, index) => ListTile(...)
)
```

---

#### What can you do to prevent lag or overflow errors in scrollable views?

**1. Use Bounded Heights:**
```dart
// ✅ Wrap ListView in Container with height
Container(
  height: 300,
  child: ListView.builder(...)
)
```

**2. Set Physics Correctly:**
```dart
// For nested scrolling
GridView.builder(
  physics: NeverScrollableScrollPhysics(),
  shrinkWrap: true,
)
```

**3. Avoid Deep Widget Trees:**
```dart
// ❌ Bad - Nested scrollables without control
SingleChildScrollView(
  child: ListView(...)  // Causes issues
)

// ✅ Good - Use shrinkWrap and disable physics
SingleChildScrollView(
  child: ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
  )
)
```

**4. Implement Pagination:**
- Load data in chunks (20-50 items at a time)
- Use infinite scroll with loading indicators

**5. Optimize Item Widgets:**
- Use const constructors where possible
- Keep itemBuilder simple and lightweight
- Cache images and heavy computations

**6. Profile Performance:**
```bash
flutter run --profile
```

---

### 🚀 How to Access the Demo

1. Launch the app
2. From the home screen, tap the **scroll icon** (📜) in the app bar
3. Explore the three tabs:
   - **ListView**: See vertical and horizontal lists
   - **GridView**: Compare 2-column and 3-column grids
   - **Combined**: Experience both in one layout

---

### 📁 File Structure

```
lib/screens/
└── scrollable_views.dart      # ⭐ Complete scrollable demo
    ├── _buildListViewTab()           # ListView examples
    ├── _buildGridViewTab()           # GridView examples
    └── _buildCombinedTab()           # Combined layout
```

---

### 🎓 Learning Outcomes

By implementing scrollable views, we've learned:

✅ How to use ListView and GridView for dynamic content  
✅ The difference between regular and builder constructors  
✅ Performance optimization techniques for large lists  
✅ How to combine multiple scrollable widgets  
✅ Best practices for preventing overflow errors  
✅ Proper use of scroll physics and shrinkWrap  

---

## Responsive Design Demo

A demonstration of how to build adaptive layouts in Flutter using MediaQuery and LayoutBuilder.

## Responsive Design in Flutter
Responsive design ensures your app’s interface adjusts dynamically to different screen sizes and orientations. Instead of using fixed pixel values, you use relative sizing based on screen dimensions.

### Why it matters
- Improves usability on different devices
- Ensures accessibility and consistent design
- Helps your app adapt seamlessly to both mobile and tablet layouts

## MediaQuery Example
```dart
var screenWidth = MediaQuery.of(context).size.width;
Container(
  width: screenWidth * 0.8,
  height: 100,
  color: Colors.teal,
  child: Center(child: Text('Responsive Container')),
);
```

## LayoutBuilder Example
```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 600) {
      return Column(children: [Text('Mobile Layout')]);
    } else {
      return Row(children: [Text('Tablet Layout')]);
    }
  },
)
```

## Combined Example
See `lib/screens/responsive_demo.dart`:
```dart
class ResponsiveDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Responsive Design Demo')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (screenWidth < 600) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.8,
                  height: 100,
                  color: Colors.tealAccent,
                  child: Center(child: Text('Mobile View')),
                ),
              ],
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 250,
                  height: 150,
                  color: Colors.orangeAccent,
                  child: Center(child: Text('Tablet Left Panel')),
                ),
                Container(
                  width: 250,
                  height: 150,
                  color: Colors.tealAccent,
                  child: Center(child: Text('Tablet Right Panel')),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
```

## Screenshots
- Mobile layout: ![Mobile Screenshot](screenshots/mobile.png)
- Tablet layout: ![Tablet Screenshot](screenshots/tablet.png)

## Reflection
- **Why is responsiveness important in mobile development?**
  - It ensures a consistent, usable experience across all devices and screen sizes.
- **How does LayoutBuilder differ from MediaQuery?**
  - MediaQuery provides device metrics, while LayoutBuilder gives widget constraints for building conditional layouts.
- **How could your team use these tools to scale the app design efficiently?**
  - By combining both, you can create flexible, maintainable UIs that adapt to any device, reducing rework and improving user experience.

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

---

