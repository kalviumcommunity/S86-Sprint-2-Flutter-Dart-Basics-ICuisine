# Sprint 2 - Firebase Authentication Implementation

## ✅ Task: User Authentication with Firebase Auth (Email & Password)

### 📋 Overview

Implemented secure user authentication system using Firebase Authentication with Email and Password method. Users can register new accounts, log in securely, and manage their sessions.

## 🔒 Persistent Login & Session Handling

### Why Persistent Login?
Modern users expect to stay logged in even after closing or restarting the app. Persistent login improves user experience and security by reducing repeated logins and ensuring session continuity.

### How It Works in Firebase
Firebase Authentication automatically manages session persistence using secure tokens stored on the device. No manual storage is needed. The app only needs to listen to authentication state changes and route screens accordingly.

### Auto-Login Flow Implementation
The app uses `authStateChanges()` to listen for login, logout, and session changes. The main widget is wrapped in a `StreamBuilder` to switch between screens based on the user's authentication state.

#### Code Snippet: Auto-Login with StreamBuilder
```dart
home: StreamBuilder<User?>(
  stream: FirebaseAuth.instance.authStateChanges(),
  builder: (ctx, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return SplashScreen(); // Show loading or logo screen
    }
    if (snapshot.hasData) {
      return HomeScreen();
    }
    return AuthScreen();
  },
),
```

#### Flow Explanation
- If a user is logged in → go to HomeScreen
- If no user is logged in → go to AuthScreen
- While checking → show loading indicator (SplashScreen)

#### Logout Handling
Calling `FirebaseAuth.instance.signOut();` logs the user out and automatically redirects to the login screen.

#### Session Persistence
- Login state is preserved after closing and reopening the app.
- If the session becomes invalid, the user is redirected to the login screen.

#### Testing Steps
1. Login → HomeScreen appears
2. Close and reopen the app → HomeScreen appears automatically
3. Logout → Redirects to AuthScreen
4. Repeat after restart to confirm behavior

#### Screenshots
- Before restart: ![Before Restart](path/to/before-restart.png)
- After restart (auto-login): ![After Restart](path/to/after-restart.png)
- Logout behavior: ![Logout](path/to/logout.png)

### Reflection
- Persistent login is essential for a seamless user experience.
- Firebase simplifies session management by handling tokens and state internally.
- No manual session storage or refresh logic is required.


## 🔥 Firebase Setup

### Console Configuration

1. **Firebase Project:** `sprint2-icuisine-project`
2. **Enabled Authentication:**
   - Firebase Console → Authentication → Sign-in method
   - Enabled **Email/Password** provider
3. **Platforms Configured:** Android, iOS, Web, Windows, macOS

### Dependencies Added

```yaml
dependencies:
  firebase_core: ^3.0.0
  firebase_auth: ^5.0.0
  cloud_firestore: ^5.0.0
```

---

## 🎯 Features Implemented

### ✅ User Sign Up
- Email and password registration
- Email format validation
- Password strength requirements (min 6 characters)
- Error handling for duplicate accounts
- Auto-login after successful registration

### ✅ User Login
- Email/password authentication
- Form validation
- Invalid credential error handling
- Session persistence
- Secure password visibility toggle

### ✅ User Logout
- Clean session termination
- Redirect to login screen
- State cleanup

---

## 🔑 Authentication Flow Details

### Sign Up Logic
- **Method Used:** `createUserWithEmailAndPassword()`
- **Flow:**
  1. User enters email and password.
  2. Firebase validates and creates a new account.
  3. On success, user is auto-logged in and redirected to `HomeScreen`.
- **Error Handling:**
  - Duplicate accounts show appropriate error messages.
  - Weak passwords are rejected with a minimum length requirement.

### Login Logic
- **Method Used:** `signInWithEmailAndPassword()`
- **Flow:**
  1. User enters email and password.
  2. Firebase authenticates the credentials.
  3. On success, user is redirected to `HomeScreen`.
- **Error Handling:**
  - Invalid credentials show error messages.
  - Network issues display connection error messages.

### Logout Logic
- **Method Used:** `FirebaseAuth.instance.signOut()`
- **Flow:**
  1. User clicks the logout button.
  2. Firebase clears the session.
  3. User is redirected to `AuthScreen`.

### `authStateChanges()`
- **Purpose:** Listens to authentication state changes in real-time.
- **Implementation:**
  - Automatically navigates between `AuthScreen` and `HomeScreen` based on user session.
  - Simplifies navigation logic and ensures seamless transitions.

---

## 📂 Implementation Files

### Key Files Created/Modified

```
lib/
├── main.dart                      # Firebase initialization
├── firebase_options.dart          # Auto-generated Firebase config
├── services/
│   └── auth_service.dart         # Authentication service
├── screens/
│   ├── login_screen.dart         # Login UI
│   ├── signup_screen.dart        # Registration UI
│   └── home_screen.dart          # Protected dashboard
└── widgets/
    └── primary_button.dart        # Reusable button component
```

### Core Implementation

**Firebase Initialization (main.dart):**
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
```

**Authentication Service:**
```dart
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<User?> signUp(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  Future<User?> signIn(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
```

---

## 🧪 Testing Completed

### Manual Testing Checklist

- ✅ New user can create account with valid email/password
- ✅ Duplicate email shows appropriate error message
- ✅ Invalid email format is rejected
- ✅ Password less than 6 characters shows error
- ✅ Existing user can login with correct credentials
- ✅ Wrong password shows authentication error
- ✅ User can logout successfully
- ✅ Users appear in Firebase Console → Authentication → Users
- ✅ Session persists after app restart

### Error Handling

| Scenario | Error Message | Handled |
|----------|---------------|---------|
| Invalid email format | "Please enter a valid email" | ✅ |
| Weak password | "Password should be at least 6 characters" | ✅ |
| Duplicate account | Firebase exception displayed | ✅ |
| Wrong credentials | Firebase auth error shown | ✅ |
| Network error | Connection error message | ✅ |

---

## 💡 Reflection

### How Firebase Simplifies Authentication

- **No Custom Backend Required:** Firebase handles all server-side authentication logic
- **Built-in Security:** Automatic encryption, password hashing, and token management
- **Session Management:** Persistent authentication across app restarts
- **Multi-platform Support:** Single codebase works on Android, iOS, Web, Windows, macOS
- **Real-time Sync:** User state updates automatically across the app

### Security Advantages Over Custom Systems

1. **Enterprise-Grade Encryption:** Industry-standard security protocols
2. **Attack Prevention:** Built-in protection against SQL injection, XSS, brute force
3. **Token-Based Auth:** Secure JWT tokens for session management
4. **Password Management:** Automatic hashing and salting
5. **Regular Updates:** Google maintains security patches
6. **Compliance Ready:** GDPR and privacy standards built-in

### Challenges Faced & Solutions

| Challenge | Solution |
|-----------|----------|
| Understanding async/await patterns | Studied Flutter async documentation and examples |
| Widget lifecycle with auth state | Used StreamBuilder for auth state changes |
| Syntax errors in complex widget trees | Careful bracket matching and code formatting |
| Buffer overflow from animations | Removed infinite animation loops |
| Navigation parameter errors | Fixed Navigator.pushReplacement arguments |

---

## 🚀 Quick Start

```bash
# Install dependencies
flutter pub get

# Configure Firebase (if needed)
flutterfire configure

# Run the app
flutter run
```

---

## 📚 Resources

- [Firebase Authentication Documentation](https://firebase.google.com/docs/auth)
- [FlutterFire Setup Guide](https://firebase.google.com/docs/flutter/setup)
- [firebase_auth Package](https://pub.dev/packages/firebase_auth)
- [Flutter Async Programming](https://dart.dev/codelabs/async-await)

---

## 📸 Screenshots

### AuthScreen UI
![AuthScreen](path/to/authscreen-screenshot.png)

### HomeScreen UI
![HomeScreen](path/to/homescreen-screenshot.png)

### Firebase Console
![Firebase Console](path/to/firebase-console-screenshot.png)

---

## 💭 Reflection

### Hardest Part of the Flow
- Managing real-time state changes with `StreamBuilder`.
- Debugging navigation issues during auth state transitions.

### How `StreamBuilder` Simplifies Navigation
- Eliminates manual routing logic.
- Automatically updates the UI based on user session.

### Importance of Logout
- Ensures session security by clearing sensitive data.
- Prevents unauthorized access to user accounts.

---

**Task Status:** ✅ Complete  
**Sprint:** 2  
**Completion Date:** February 3, 2026  
**Firebase Project ID:** sprint2-icuisine-project