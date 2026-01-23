# Flutter Project Structure — iCuisine

## Introduction
This document maps the core folders and files that Flutter generates for the iCuisine app and explains how they contribute to maintainability, scalability, and cross-platform delivery.

## Quick Hierarchy (high level)
```
icuisine/
├── lib/
│   ├── main.dart
│   ├── firebase_options.dart
│   ├── screens/
│   │   ├── login_screen.dart
│   │   ├── signup_screen.dart
│   │   ├── welcome_screen.dart
│   │   ├── user_dashboard.dart
│   │   └── responsive_home.dart
│   └── services/
│       ├── auth_service.dart
│       └── firestore_service.dart
├── android/            # Android-specific build files (Gradle, manifests)
├── ios/                # iOS-specific build files (Xcode configs, Info.plist)
├── web/                # Web runner, HTML shell, icons, manifest
├── windows/            # Windows desktop runner and CMake configs
├── macos/              # macOS desktop runner and Xcode configs
├── linux/              # Linux desktop runner and CMake configs
├── test/               # Automated tests (widget_test.dart)
├── pubspec.yaml        # Dependencies, assets, fonts, app metadata
├── analysis_options.yaml # Static analysis and lints
├── firebase.json       # Firebase hosting/runtime config
└── README.md           # Project overview and usage notes
```

## Folder and File Roles
| Path | Purpose | Notes for this project |
| --- | --- | --- |
| lib/ | Dart source for all app logic and UI. | Entry point in main.dart; separates screens and services for clarity. |
| lib/screens/ | UI surfaces and page flows. | Contains login, signup, dashboard, welcome, and responsive layout demos. |
| lib/services/ | Reusable service layer (API, auth, data). | auth_service.dart handles Firebase Auth; firestore_service.dart manages CRUD and streams. |
| lib/firebase_options.dart | Generated Firebase config per platform. | Created by FlutterFire CLI; keep out of version conflicts. |
| android/ | Android build system (Gradle), manifests, native hooks. | Adjust app ID, versioning, and platform-specific settings in android/app. |
| ios/ | iOS build settings, Info.plist, AppDelegate, assets. | Manage permissions, bundle ID, and signing here. |
| web/ | Web bootstrap (index.html), manifest, icons. | Customize PWA metadata or inject scripts carefully. |
| windows/, macos/, linux/ | Desktop runners and build configs. | Desktop support uses native shells plus CMake or Xcode; usually untouched unless adding native code. |
| test/ | Automated tests (unit/widget). | widget_test.dart scaffolds UI verification; add more as features grow. |
| pubspec.yaml | Central manifest for dependencies, SDK constraints, assets, and fonts. | Declare any assets here (e.g., assets/images/) before use. |
| analysis_options.yaml | Lint and analyzer rules. | Keeps style consistent across contributors. |
| firebase.json | Firebase hosting/emulator settings for web runs. | Align with Firebase Console project when deploying web builds. |
| README.md | Project-level documentation. | Summaries and quickstart; links to this structure guide. |
| .gitignore | Excludes build artifacts and local config. | Prevents noisy or secret files from entering version control. |
| .metadata | Flutter tool metadata. | Generated; do not edit manually. |
| build/ (generated) | Compiled outputs for each platform. | Safe to delete locally; never commit. |

## How the Structure Supports Scalability and Teamwork
- Separation of concerns keeps UI (screens) and logic (services) decoupled, reducing merge conflicts when multiple contributors work in parallel.
- Platform folders encapsulate native build settings, enabling web/mobile/desktop targets without polluting shared Dart code.
- A single pubspec.yaml centralizes dependency and asset declarations, making reviews and audits straightforward.
- Consistent lint rules (analysis_options.yaml) help enforce style and catch issues early across the team.
- Tests live beside the app in test/, enabling fast feedback loops for UI and logic changes.
- Clear Firebase configuration files (firebase_options.dart and firebase.json) isolate environment setup from application logic.

## Tips for Asset and Dependency Management
- Create an assets/ directory when needed (images, fonts, JSON) and list it under the flutter: assets: section in pubspec.yaml.
- Prefer feature-based subfolders inside lib/ (e.g., lib/features/orders/) as the codebase grows to keep ownership and reviews focused.
- Keep secrets out of the repo; rely on platform-specific configuration stores or CI/CD secret managers.

## Reflection
- Understanding each folder’s role reduces ramp-up time and lets contributors navigate quickly, which is critical during sprints.
- A clean, predictable structure minimizes merge friction, since teammates know where to place new code and where to review changes.
- Platform isolation plus shared Dart logic let the team iterate on features once and ship everywhere, preserving velocity.
