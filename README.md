# ICuisine

## Project Overview
ICuisine is a mobile application designed to help popular street-food vendors manage orders efficiently during rush hours. The app aims to reduce long queues and prevent order mismanagement by providing a smooth ordering system that doesn't slow down service.

## Problem Statement
Popular street-food vendors face long queues and order mismanagement during rush hours. How might we help them accept and manage orders smoothly without slowing down service?

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

## Getting Started

(Add installation and setup instructions here)