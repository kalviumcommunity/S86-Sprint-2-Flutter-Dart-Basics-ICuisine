# Cloud Functions for ICuisine

This directory contains Firebase Cloud Functions for the ICuisine application.

## 🎯 Functions Overview

### Callable Functions (Invoked from Flutter)

#### 1. `sayHello`
**Purpose:** Greet users by name with a personalized message.

**Input:**
```javascript
{
  name: string  // User's name (optional, defaults to "User")
}
```

**Output:**
```javascript
{
  message: string,      // Greeting message
  timestamp: Timestamp, // Server timestamp
  userId: string | null // User ID if authenticated
}
```

**Use Case:** Testing Cloud Functions, personalized greetings, welcome messages

---

#### 2. `processOrder`
**Purpose:** Validate and process orders with custom business logic.

**Input:**
```javascript
{
  orderId: string,        // Order ID
  items: Array<Object>,   // Order items
  totalAmount: number     // Total order amount
}
```

**Output:**
```javascript
{
  success: boolean,
  message: string,
  orderId: string
}
```

**Use Case:** Order validation, payment processing, inventory updates

**Security:** Requires user authentication

---

### Event-Based Functions (Auto-triggered)

#### 3. `newUserCreated`
**Trigger:** Firestore document created at `users/{userId}`

**Purpose:** Automatically initialize user profile with default values when a new user signs up.

**Auto-generated fields:**
- `createdAt` - Server timestamp
- `profileComplete` - false
- `orderCount` - 0
- `totalSpent` - 0
- `loyaltyPoints` - 100 (welcome bonus!)
- `accountStatus` - "active"

**Use Case:** Welcome bonuses, profile initialization, analytics tracking

---

#### 4. `onOrderStatusChanged`
**Trigger:** Firestore document updated at `orders/{orderId}`

**Purpose:** Log order status changes to a separate audit collection.

**Creates log entries in:**
- Collection: `order_logs`
- Fields: orderId, previousStatus, newStatus, changedAt

**Use Case:** Audit trails, push notifications, analytics, email confirmations

---

#### 5. `onOrderDeleted`
**Trigger:** Firestore document deleted at `orders/{orderId}`

**Purpose:** Archive deleted orders for record-keeping and compliance.

**Archives to:**
- Collection: `deleted_orders`
- Adds: deletedAt timestamp

**Use Case:** Data archiving, audit trails, compliance, recovery

---

## 🚀 Deployment

### First Time Setup
```bash
# Install dependencies
npm install

# Login to Firebase
firebase login

# Deploy all functions
firebase deploy --only functions
```

### Update Functions
```bash
# Deploy all functions
firebase deploy --only functions

# Deploy specific function
firebase deploy --only functions:sayHello
```

### View Logs
```bash
# All logs
firebase functions:log

# Specific function
firebase functions:log --only sayHello

# Tail logs (real-time)
firebase functions:log --only sayHello --tail
```

---

## 📊 Monitoring

### Firebase Console
1. Go to Firebase Console
2. Navigate to **Functions**
3. Click **Logs** tab
4. View execution logs, errors, and performance

### Log Levels
- `console.log()` - Info messages
- `console.warn()` - Warnings
- `console.error()` - Errors

---

## 🔒 Security

### Callable Functions
- User authentication verified via `context.auth`
- Input validation performed
- Custom error messages with proper error codes

### Event-Based Functions
- Triggered automatically (no external access)
- Use Firebase Admin SDK (full permissions)
- Secure server-side execution

---

## 🧪 Testing

### Test Callable Functions
From the Flutter app:
```dart
final result = await CloudFunctionsService().callSayHello(name: 'Alex');
print(result['message']);
```

### Test Event-Based Functions
Create/update/delete documents in Firestore:
```dart
// This will trigger newUserCreated
await FirestoreService().createDocument(
  collection: 'users',
  data: {'name': 'Test User'}
);
```

---

## 💰 Cost

Cloud Functions pricing (Blaze Plan):
- **Free Tier:**
  - 2M invocations/month
  - 400,000 GB-seconds
  - 200,000 CPU-seconds

**Estimated cost for this app:** $0/month (within free tier)

---

## 📦 Dependencies

- `firebase-admin` - Firebase Admin SDK for server-side operations
- `firebase-functions` - Cloud Functions SDK
- `firebase-functions-test` - Testing utilities

---

## 🛠️ Development

### Local Testing (Emulators)
```bash
# Start emulators
firebase emulators:start

# Functions emulator runs on:
# http://localhost:5001
```

### Function Shell (Interactive Testing)
```bash
npm run shell
```

---

## 📝 File Structure

```
functions/
├── index.js           # All function definitions
├── package.json       # Dependencies and scripts
├── .gitignore        # Git ignore rules
└── README.md         # This file
```

---

## 🎓 Learning Resources

- [Cloud Functions Docs](https://firebase.google.com/docs/functions)
- [Callable Functions](https://firebase.google.com/docs/functions/callable)
- [Firestore Triggers](https://firebase.google.com/docs/functions/firestore-events)
- [Error Handling](https://firebase.google.com/docs/functions/callable#handle_errors)

---

## 🐛 Troubleshooting

### Function not found
- Ensure functions are deployed: `firebase deploy --only functions`
- Check function name spelling

### Permission denied
- Verify user is authenticated (for callable functions)
- Check Firestore security rules (for event-based functions)

### Function not triggering
- Check logs for errors
- Verify collection/document paths match
- Ensure proper data structure

---

**Built for ICuisine Sprint-2 Task**
