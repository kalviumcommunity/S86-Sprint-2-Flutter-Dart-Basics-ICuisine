# Screenshots Guide for Flutter Setup Verification

## Required Screenshots

Take these 4 screenshots to complete your setup verification:

### 1. Flutter Doctor Output ✅
**What to capture:** Terminal showing `flutter doctor -v` output with all green checks

**How to take:**
1. Open PowerShell/CMD
2. Run: `flutter doctor -v`
3. Take screenshot of the complete output
4. Save as: `screenshots/flutter_doctor.png`

**Status:** Can be taken now - command already run above!

---

### 2. App Running on Chrome ✅
**What to capture:** iCuisine app login screen in Chrome browser

**How to take:**
1. Your app is already running on Chrome
2. Open Chrome and go to the app URL
3. Show the login/signup screen
4. Take full browser screenshot (Ctrl + Shift + S on Windows)
5. Save as: `screenshots/app_running_chrome.png`

**Status:** App is already running - just take screenshot!

---

### 3. VS Code with Flutter Project ✅
**What to capture:** VS Code showing your Flutter project structure

**How to take:**
1. Open VS Code with your icuisine project
2. Expand the lib folder to show files
3. Take screenshot showing:
   - File explorer with project structure
   - A Dart file open (like main.dart)
   - Terminal showing successful flutter run
4. Save as: `screenshots/vscode_setup.png`

---

### 4. Firebase Console ✅
**What to capture:** Firebase Console showing your project

**How to take:**
1. Go to https://console.firebase.google.com/
2. Open your project: sprint2-icuisine-project
3. Show Authentication and Firestore sections
4. Take screenshot
5. Save as: `screenshots/firebase_console.png`

---

## Quick Screenshot Taking Commands

### Windows Screenshot Shortcuts:
- **Full Screen:** `Win + PrtScn` (saves to Pictures/Screenshots)
- **Snip Tool:** `Win + Shift + S` (select area to capture)
- **Active Window:** `Alt + PrtScn` (captures current window)

### Screenshot File Organization:
```
E:\WSI-ICuisine\
├── screenshots/
│   ├── flutter_doctor.png
│   ├── app_running_chrome.png
│   ├── vscode_setup.png
│   └── firebase_console.png
```

---

## After Taking Screenshots

1. **Move screenshots to folder:**
   ```bash
   # Create screenshots folder if not exists
   mkdir E:\WSI-ICuisine\screenshots
   
   # Move your screenshots there
   move C:\path\to\your\screenshot.png E:\WSI-ICuisine\screenshots\
   ```

2. **Reference in documentation:**
   The screenshots are already referenced in FLUTTER_SETUP_VERIFICATION.md

3. **Include in PR:**
   Upload screenshots to GitHub in your PR

---

## Quick Actions to Complete Now

Since your Flutter is already set up and running:

### Action 1: Take Flutter Doctor Screenshot (2 min)
```bash
# Open PowerShell
flutter doctor -v

# Take screenshot (Win + Shift + S)
# Save as: screenshots/flutter_doctor.png
```

### Action 2: Take App Screenshot (1 min)
- Your app is running in Chrome
- Open Chrome, go to localhost:51738
- Take screenshot of login screen
- Save as: screenshots/app_running_chrome.png

### Action 3: Take VS Code Screenshot (1 min)
- Open VS Code with icuisine project
- Show file structure
- Take screenshot
- Save as: screenshots/vscode_setup.png

### Action 4: Take Firebase Console Screenshot (2 min)
- Go to Firebase Console
- Open your project
- Take screenshot showing Authentication/Firestore
- Save as: screenshots/firebase_console.png

---

## Video Demo Script (1-2 minutes)

**What to show in your video:**

1. **Introduction (10 sec)**
   - "Hi, this is my Flutter Environment Setup verification"

2. **Flutter Doctor (20 sec)**
   - Open terminal
   - Run `flutter doctor -v`
   - Show all green checks
   - "As you can see, Flutter is fully configured with no issues"

3. **App Running (30 sec)**
   - Show Chrome with app running
   - Show login/signup screens
   - "This is my iCuisine app running successfully on Chrome"
   - Add an order, show real-time updates

4. **Development Environment (20 sec)**
   - Show VS Code with project open
   - Show file structure
   - "Here's my development environment with all files"

5. **Firebase Console (20 sec)**
   - Show Firebase Console
   - Show Authentication users
   - Show Firestore data
   - "Firebase is connected and working"

6. **Conclusion (10 sec)**
   - "My Flutter environment is complete and ready for development"

---

## Recording Tools

**Free options:**
- **OBS Studio** (Windows/Mac/Linux) - Professional, free
- **Windows Game Bar** (Win + G) - Built into Windows
- **Loom** (Web-based) - Easy, 5-minute free limit
- **ShareX** (Windows) - Free, open source

**Quick Record with Windows:**
```
Press: Win + G
Click: Record button
Show: Your screen following the script above
Press: Win + G again to stop
```

---

## Upload Video

1. **Record video** (1-2 minutes)
2. **Upload to:**
   - Google Drive (set to "Anyone with link")
   - Loom (get shareable link)
   - YouTube (set to Unlisted)
3. **Copy link** for PR description

---

**Total Time Needed: ~10 minutes for screenshots + 5 minutes for video = 15 minutes total!**
