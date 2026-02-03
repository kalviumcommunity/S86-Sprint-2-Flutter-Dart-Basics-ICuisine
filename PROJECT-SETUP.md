# iCuisine Project Setup Guide

This guide will help you set up and run the iCuisine Flutter application after cloning the repository.

**🎯 Sprint 2 Status**: Firebase Authentication with Email & Password is fully implemented and ready to test!

## Prerequisites

Before you begin, ensure you have the following installed on your system:

### Required Software

1. **Flutter SDK** (version 3.38.7 or higher)
   - Download: https://docs.flutter.dev/get-started/install
   - Verify installation: `flutter --version`

2. **Dart SDK** (version 3.10.7 or higher)
   - Comes bundled with Flutter

3. **Git**
   - Download: https://git-scm.com/downloads

4. **IDE/Code Editor** (Choose one)
   - VS Code with Flutter/Dart extensions
   - Android Studio with Flutter plugin

### Platform-Specific Requirements

#### For Android Development:
- **Android Studio** (latest version)
- **Android SDK** (API level 21 or higher)
- **Java JDK** (version 21 or higher)
- Android device or emulator

#### For iOS Development (macOS only):
- **Xcode** (latest version)
- **CocoaPods**: `sudo gem install cocoapods`
- iOS device or simulator

#### For Web Development:
- **Chrome browser** (for debugging)

#### For Windows Development:
- **Visual Studio 2022** with C++ development tools

---

## Step-by-Step Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/WSI-ICuisine.git
cd WSI-ICuisine/icuisine
```

### 2. Verify Flutter Installation

```bash
flutter doctor
```

This command checks your environment and displays a report. Resolve any issues marked with ❌ before proceeding.

### 3. Install Flutter Dependencies

```bash
flutter pub get
```

This downloads all the required packages listed in `pubspec.yaml`.

### 4. Firebase Configuration

#### ⚠️ Important: Firebase Configuration Files Are Not Included

For security reasons, Firebase configuration files are **excluded from the repository** (listed in `.gitignore`). 

**You MUST generate your own Firebase configuration** after cloning:
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `lib/firebase_options.dart`

#### Generate Your Firebase Configuration

1. **Go to Firebase Console**: https://console.firebase.google.com

2. **Use Existing Project or Create New**:
   - **Current Team Project**: `sprint2-icuisine-project` (already configured)
   - **OR Create Your Own**: Click "Add project", name it `icuisine-[your-name]`
   - Disable Google Analytics (optional)
   - Click "Create project"

3. **Install FlutterFire CLI**:
   ```bash
   dart pub global activate flutterfire_cli
   ```

4. **Configure Firebase for Flutter**:
   ```bash
   flutterfire configure
   ```
   
   This command will:
   - Log you into your Google account
   - List your Firebase projects
   - Select **`sprint2-icuisine-project`** (or your own project)
   - Choose platforms: **Android, iOS, Web, Windows, macOS**
   - Automatically generate all required configuration files:
     - `lib/firebase_options.dart`
     - `android/app/google-services.json`
     - `ios/Runner/GoogleService-Info.plist`

5. **Enable Firebase Services**:

   **Enable Email/Password Authentication:**
   - In Firebase Console → **Authentication** → **Sign-in method**
   - Enable **Email/Password** provider
   - Click "Save"

   **Enable Cloud Firestore:**
   - Go to **Firestore Database** → **Create database**
   - Start in **Test mode** (allows read/write for 30 days)
   - Choose a location (e.g., `us-central1`)
   - Click "Enable"

6. **Update Firestore Security Rules** (for production):
   
   In Firebase Console → Firestore Database → Rules, replace with:
   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       // Users collection
       match /users/{userId} {
         allow read, write: if request.auth != null && request.auth.uid == userId;
       }
       
       // Orders collection
       match /orders/{orderId} {
         allow read: if request.auth != null;
         allow create: if request.auth != null;
         allow update, delete: if request.auth != null && 
           (resource.data.userId == request.auth.uid || 
            get(/databases/$(database)/documents/users/$(request.auth.uid)).data.userType == 'vendor');
       }
       
       // Menu items collection
       match /menu_items/{itemId} {
         allow read: if request.auth != null;
         allow write: if request.auth != null && 
           get(/databases/$(database)/documents/users/$(request.auth.uid)).data.userType == 'vendor';
       }
     }
   }
   ```

### 5. Platform-Specific Setup

#### Android Setup

1. **Update Gradle** (if needed):
   - Open `android/gradle/wrapper/gradle-wrapper.properties`
   - Ensure: `distributionUrl=https\://services.gradle.org/distributions/gradle-8.13-bin.zip`

2. **Accept Android Licenses**:
   ```bash
   flutter doctor --android-licenses
   ```

#### iOS Setup (macOS only)

1. **Install CocoaPods Dependencies**:
   ```bash
   cd ios
   pod install
   cd ..
   ```

2. **Open in Xcode** (optional):
   ```bash
   open ios/Runner.xcworkspace
   ```

#### Web Setup

No additional setup required! Web support is built-in.

### 6. Run the Application

#### List Available Devices:
```bash
flutter devices
```

#### Run on Specific Platform:

**Android Emulator:**
```bash
flutter run -d android
```

**Chrome (Web):**
```bash
flutter run -d chrome
```

**Windows Desktop:**
```bash
flutter run -d windows
```

**iOS Simulator (macOS only):**
```bash
flutter run -d ios
```

#### Run with Hot Reload:
Once running, you can:
- Press `r` to hot reload
- Press `R` to hot restart
- Press `q` to quit

### 7. Create Test Account

When the app launches:

1. The **Login Screen** appears
2. Click **"Sign Up"** button at the bottom
3. Fill in the registration form:
   - Email: test@example.com (or any valid email)
   - Password: password123 (minimum 6 characters)
4. Click **"Sign Up"**
5. Account is created in Firebase
6. You'll be automatically logged in and redirected to the Home Screen

**To test Login:**
1. Click **Logout** from Home Screen
2. Enter your registered email and password
3. Click **"Log In"**
4. You'll be redirected back to Home Screen

---

## Project Structure

```
icuisine/
├── lib/
│   ├── main.dart                    # App entry point & Firebase init
│   ├── firebase_options.dart        # Firebase configuration (auto-generated)
│   ├── screens/
│   │   ├── home_screen.dart         # ✅ Protected dashboard (Sprint 2)
│   │   ├── login_screen.dart        # ✅ User login (Sprint 2)
│   │   ├── signup_screen.dart       # ✅ User registration (Sprint 2)
│   │   └── user_dashboard.dart      # User dashboard
│   ├── services/
│   │   ├── auth_service.dart        # ✅ Firebase Auth service (Sprint 2)
│   │   └── firestore_service.dart   # Firestore operations
│   ├── widgets/
│   │   └── primary_button.dart      # Reusable button component
│   └── animations/
│       ├── animated_widgets.dart    # Custom animations
│       └── page_transitions.dart    # Navigation transitions
├── android/                         # Android platform code
├── ios/                            # iOS platform code
├── web/                            # Web platform code
├── windows/                        # Windows platform code
├── assets/
│   ├── images/                     # App images
│   └── icons/                      # App icons
├── test/                           # Unit tests
├── pubspec.yaml                    # Dependencies
└── README.md                       # Sprint 2 implementation details
```

---

## Common Issues & Solutions

### Issue 1: "firebase_options.dart not found"
**Solution**: 
- Firebase configuration files are NOT included in the repository
- You MUST run `flutterfire configure` to generate them
- See Step 4 in the setup instructions above

### Issue 2: "google-services.json not found" (Android)
**Solution**: 
- This file is excluded from Git for security
- Run `flutterfire configure` to generate it automatically
- The file will be created at `android/app/google-services.json`

### Issue 3: "Gradle version mismatch"
**Solution**: Update `android/gradle/wrapper/gradle-wrapper.properties` to use Gradle 8.13+

### Issue 4: "Cloud Firestore API not enabled"
**Solution**: 
- Go to Firebase Console
- Enable Firestore Database
- Wait 2-3 minutes for propagation

### Issue 5: "Pod install failed" (iOS)
**Solution**:
```bash
cd ios
pod repo update
pod install
cd ..
```

### Issue 6: "Authentication configuration not found"
**Solution**:
- Ensure you ran `flutterfire configure` and selected your Firebase project
- Enable Email/Password authentication in Firebase Console
- Wait a few minutes, then restart the app

### Issue 7: Build fails on first run
**Solution**: 
- First Android builds take 5-10 minutes
- Ensure stable internet connection
- Run `flutter clean` then `flutter pub get`

### Issue 8: "Missing Firebase configuration files after cloning"
**Solution**: 
- This is EXPECTED behavior - Firebase files are not in the repository
- Follow Step 4 to generate your own Firebase configuration
- Run: `flutterfire configure`

---

## Development Workflow

### 1. Running Tests
```bash
flutter test
```

### 2. Building for Production

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

**iOS (macOS only):**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

**Windows:**
```bash
flutter build windows --release
```

### 3. Code Quality Checks

**Analyze Code:**
```bash
flutter analyze
```

**Format Code:**
```bash
dart format .
```

### 4. Clean Build
If you encounter persistent issues:
```bash
flutter clean
flutter pub get
flutter run
```

---

## Environment Variables (Optional)

If you want to use different Firebase projects for development and production:

1. Create `.env` file in project root:
   ```env
   FIREBASE_API_KEY=your_api_key
   FIREBASE_PROJECT_ID=your_project_id
   FIREBASE_APP_ID=your_app_id
   ```

2. Add to `.gitignore` (already done)

3. Use `flutter_dotenv` package to load variables

---

## Dependencies

### Core Dependencies
- `firebase_core: ^3.0.0` - Firebase initialization
- `firebase_auth: ^5.0.0` - User authentication
- `cloud_firestore: ^5.0.0` - Database operations
- `flutter: sdk` - Flutter framework

### Dev Dependencies
- `flutter_test: sdk` - Testing framework
- `flutter_lints: ^5.0.0` - Code quality rules

---

## Additional Resources

- **Flutter Documentation**: https://docs.flutter.dev
- **Firebase for Flutter**: https://firebase.google.com/docs/flutter/setup
- **FlutterFire Documentation**: https://firebase.flutter.dev
- **Project README**: [README.md](README.md)
- **Firebase Setup Guide**: [FIREBASE_SETUP.md](FIREBASE_SETUP.md)

---

## Getting Help

If you encounter issues:

1. **Check Flutter Doctor**: `flutter doctor -v`
2. **Check Firebase Console**: Ensure all services are enabled
3. **Check Logs**: Run with `flutter run --verbose`
4. **Search Issues**: Check GitHub Issues for similar problems
5. **Ask Team**: Contact project maintainers

---

## Quick Start Checklist

- [ ] Installed Flutter SDK (3.38.7+)
- [ ] Installed required IDE (VS Code/Android Studio)
- [ ] Cloned repository
- [ ] Ran `flutter doctor` (all checks pass)
- [ ] Ran `flutter pub get`
- [ ] **IMPORTANT**: Ran `flutterfire configure` to generate Firebase files
- [ ] Created/Selected Firebase project in FlutterFire CLI
- [ ] Verified Firebase files created (firebase_options.dart, google-services.json)
- [ ] Enabled Authentication in Firebase Console
- [ ] Enabled Firestore in Firebase Console
- [ ] Created emulator/simulator or connected device
- [ ] Ran `flutter run`
- [ ] App launched successfully
- [ ] Created test account and logged in

---

## Next Steps After Setup

1. **Explore the App**: Test all features (login, signup, orders)
2. **Read Documentation**: Check [README.md](README.md) for detailed features
3. **Review Code**: Understand the project structure
4. **Make Changes**: Try modifying UI or adding features
5. **Test Changes**: Use hot reload (`r`) to see updates instantly
6. **Contribute**: Create a branch and submit pull requests

---

## License

This project is part of the WSI-ICuisine coursework.

## Support

For questions or issues, please contact the project team or create an issue on GitHub.

---

**Sprint 2 Status**: ✅ Complete (Firebase Authentication Implemented)
**Last Updated**: February 3, 2026
**Flutter Version**: 3.38.7
**Dart Version**: 3.10.7
**Firebase Project**: sprint2-icuisine-project
