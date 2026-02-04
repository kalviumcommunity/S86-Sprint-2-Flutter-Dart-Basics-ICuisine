# 🗄️ Firestore Database Schema Design - ICuisine
## 📦 Firestore Data Reading & Real-Time UI

### Project Title: Firestore Data Integration in ICuisine

This project demonstrates how to read data from Firestore collections and documents in a Flutter app using the `cloud_firestore` package. The app connects to Firestore, fetches data, and displays it dynamically in the UI, updating instantly when Firestore data changes.

---

## 🔗 Firestore Read Operations

### 1. Collection Read (All Documents)
```dart
final snapshot = await FirebaseFirestore.instance
    .collection('products')
    .get();
for (var doc in snapshot.docs) {
  print(doc.data());
}
```

### 2. Document Read (Single Document)
```dart
final doc = await FirebaseFirestore.instance
    .collection('users')
    .doc('userId')
    .get();
print(doc.data());
```

### 3. Real-Time Stream (Recommended)
```dart
FirebaseFirestore.instance
  .collection('tasks')
  .snapshots()
```

### 4. Query with Filters
```dart
FirebaseFirestore.instance
  .collection('orders')
  .where('status', isEqualTo: 'pending')
  .snapshots();
```

---

## 🖥️ Displaying Data in UI

### StreamBuilder (Real-Time Updates)
```dart
StreamBuilder(
  stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) return CircularProgressIndicator();
    final tasks = snapshot.data!.docs;
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          title: Text(task['title']),
          subtitle: Text(task['description']),
        );
      },
    );
  },
)
```

### FutureBuilder (Single Document)
```dart
FutureBuilder(
  future: FirebaseFirestore.instance
      .collection('users')
      .doc('userId')
      .get(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) return CircularProgressIndicator();
    final data = snapshot.data!.data()!;
    return Text("Name: ${data['name']}");
  },
)
```

---

## 🛡️ Handling Null or Missing Data
Always check for missing or null data to avoid crashes:
```dart
if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
  return Text("No data available");
}
```
Validate field existence, use default values, and add try/catch around read operations.

---

## 🖼️ Screenshots
- Firestore data in Firebase Console
- Flutter UI displaying Firestore data (ListView, Text, etc.)

---

## 💡 Reflection

**Read Method Used:**
- Real-time streams with `StreamBuilder` for live updates
- `FutureBuilder` for one-time document reads

**Why Real-Time Streams?**
- Streams ensure the UI updates instantly when Firestore data changes, making the app interactive and responsive without manual refresh.

**Challenges Faced:**
- Handling null/missing data safely
- Validating field existence to prevent runtime errors
- Ensuring Firestore is initialized before reading data

---

## 🖋️ Writing and Updating Data to Firestore Securely

Writing data to Firestore is one of the most essential capabilities of any mobile app — whether you’re storing user profiles, tasks, orders, messages, or analytics.

### Firestore Write Operations

#### 1. Add a New Document
```dart
await FirebaseFirestore.instance
  .collection('tasks')
  .add({\n    'title': 'Learn Flutter',\n    'completed': false,\n    'createdAt': Timestamp.now(),\n  });
```

#### 2. Set Data to a Specific Document
```dart
await FirebaseFirestore.instance
  .collection('tasks')
  .doc('taskId123')
  .set({\n    'title': 'New Task',\n    'completed': false,\n  });
```

#### 3. Update Specific Fields
```dart
await FirebaseFirestore.instance
  .collection('tasks')
  .doc('taskId123')
  .update({'completed': true});
```

### Best Practices for Secure Writes
- Validate user input before writing.
- Use correct data types.
- Add timestamps for record tracking.
- Avoid overwriting full documents accidentally — prefer `update()`.
- Use `.set({...}, SetOptions(merge: true))` for partial merges.
- Avoid storing sensitive user info in Firestore unless rules permit.

### Example: Adding a Task
```dart
Future<void> _addTask() async {
  final title = _titleController.text.trim();
  final desc = _descController.text.trim();

  if (title.isEmpty || desc.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please fill all fields')),
    );
    return;
  }

  await FirebaseFirestore.instance.collection('tasks').add({
    'title': title,
    'description': desc,
    'isCompleted': false,
    'createdAt': Timestamp.now(),
  });
}
```

### Example: Updating a Task
```dart
Future<void> _updateTask(String taskId) async {
  await FirebaseFirestore.instance
      .collection('tasks')
      .doc(taskId)
      .update({'title': 'Updated Title'});
}
```

---

## 📸 Screenshots
- App UI showing task addition and updates
- Firestore Console showing added/updated data

---

## 💡 Reflection

### Challenges Faced

1. **Deciding Between Embedding vs. References**
   - **Challenge:** Should menu items be embedded in vendor documents or separate?
   - **Solution:** Analyzed document size limits and query patterns. Separate collection won due to scalability and independent updates.

2. **Order Status Tracking**
   - **Challenge:** How to track order status changes over time without bloating the order document?
   - **Solution:** Used subcollections for status history, enabling unlimited tracking while keeping the main order document clean.

3. **Balancing Denormalization**
   - **Challenge:** Should order items reference menu items or embed the data?
   - **Solution:** Embedded snapshot of item details (name, price) to preserve order accuracy even if menu changes later.

4. **Location-Based Queries**
   - **Challenge:** How to enable "find vendors near me" functionality?
   - **Solution:** Used Firestore's `geopoint` type for vendor locations, enabling geoqueries with libraries like GeoFlutterFire.

### How This Schema Helps Performance

1. **Minimal Document Reads:**
   - Loading vendor list doesn't fetch menu items
   - Order list doesn't fetch user/vendor full profiles
   - Each screen loads only what it displays

2. **Efficient Real-time Updates:**
   - Order status changes update subcollection only
   - Vendor availability toggle updates single field
   - Menu item price change doesn't affect vendor document

3. **Future-Proof Scalability:**
   - Can handle thousands of vendors without restructuring
   - Unlimited menu items per vendor
   - Order history can grow indefinitely via subcollections

### Why This Structure Fits ICuisine

1. **Rush Hour Efficiency:**
   - Orders are processed quickly without complex nested queries
   - Status updates are real-time via subcollections
   - Vendors can manage multiple orders simultaneously

2. **Customer Experience:**
   - Fast vendor browsing (minimal data loaded)
   - Real-time order tracking (status subcollection)
   - Personalized favorites (separate collection)

3. **Vendor Management:**
   - Easy menu updates (individual menu items)
   - Order queue visibility (efficient queries)
   - Customer feedback integration (reviews collection)

4. **Business Scalability:**
   - Can onboard thousands of vendors
   - Supports millions of orders
   - Analytics-ready data structure

---

## 📚 Resources

- [Firestore Data Modeling Guide](https://firebase.google.com/docs/firestore/data-model)
- [Firestore Best Practices](https://firebase.google.com/docs/firestore/best-practices)
- [NoSQL vs SQL Comparison](https://firebase.google.com/docs/database/rtdb-vs-firestore)
- [GeoQueries in Firestore](https://firebase.google.com/docs/firestore/solutions/geoqueries)
- [Firestore Security Rules](https://firebase.google.com/docs/firestore/security/get-started)

---

## ✅ Task Completion Summary

**Schema Design Status:** ✅ Complete  
**Design Date:** February 4, 2026  
**Collections Defined:** 8 (Users, Vendors, Categories, MenuItems, Orders, Reviews, Favorites, Notifications)  
**Subcollections:** 1 (StatusHistory)  
**Sample Documents:** 7 complete examples  
**Diagrams:** Mermaid ERD + Text-based visual  
**Firebase Project ID:** sprint2-icuisine-project

---

**Next Steps:**
1. Implement CRUD operations for each collection
2. Set up Firestore security rules in Firebase Console
3. Create composite indexes for efficient queries
4. Build UI screens connected to Firestore data
