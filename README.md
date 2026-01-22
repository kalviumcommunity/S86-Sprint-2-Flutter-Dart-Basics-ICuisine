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

### Variables & Functions
- **camelCase**: `userName`, `fetchOrders()`, `isLoading`
- Boolean variables prefixed with `is`, `has`, `can`: `isLoggedIn`, `hasOrders`

### Constants
- **UPPER_SNAKE_CASE**: `API_BASE_URL`, `MAX_ORDER_ITEMS`, `DEFAULT_TIMEOUT`

---

## Getting Started

(Add installation and setup instructions here)