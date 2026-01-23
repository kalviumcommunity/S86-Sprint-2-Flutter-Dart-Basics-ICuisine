# Screenshots Folder

## Required Screenshots for Flutter Setup Verification

Place your 4 screenshots in this folder:

### 1. flutter_doctor.png
Screenshot of Flutter Doctor output showing all green checks
- Command: `flutter doctor -v`
- Should show: Flutter version, Android toolchain, Chrome, etc.
- Status: All items with ✓ (green checks)

### 2. app_running_chrome.png
Screenshot of iCuisine app running in Chrome browser
- URL: localhost:51738 (or your port)
- Should show: Login screen or dashboard
- Visible: Firebase authentication working

### 3. vscode_setup.png
Screenshot of VS Code with Flutter project open
- Should show: File explorer with project structure
- Visible: lib folder with services and screens
- Bonus: Terminal with successful flutter run

### 4. firebase_console.png
Screenshot of Firebase Console with your project
- URL: console.firebase.google.com
- Project: sprint2-icuisine-project
- Should show: Authentication tab or Firestore tab
- Visible: Your project configuration

---

## How to Take Screenshots

### Windows:
- **Snip Tool:** `Win + Shift + S` (recommended)
- **Full Screen:** `Win + PrtScn`
- **Active Window:** `Alt + PrtScn`

### Where Screenshots Are Saved:
- Snip Tool: Clipboard (paste into Paint or Word, then save)
- PrtScn: `C:\Users\YourName\Pictures\Screenshots`

---

## File Naming Convention

Use exactly these names:
- `flutter_doctor.png`
- `app_running_chrome.png`
- `vscode_setup.png`
- `firebase_console.png`

This matches the references in documentation files.

---

## Current Status

- [ ] flutter_doctor.png
- [ ] app_running_chrome.png
- [ ] vscode_setup.png
- [ ] firebase_console.png

Once all 4 screenshots are in this folder, you're ready to commit and push!

---

## Quick Command to Check

```bash
# Navigate to screenshots folder
cd E:\WSI-ICuisine\screenshots

# List all files
dir

# Should see 4 .png files
```

---

**Note:** Screenshots will be automatically referenced in your documentation and PR!
