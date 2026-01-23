// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/testing.dart';

import 'package:icuisine/firebase_options.dart';
import 'package:icuisine/main.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    setupFirebaseCoreMocks();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  testWidgets('Login screen renders expected fields and actions', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Core login UI elements
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);
    expect(find.widgetWithIcon(TextFormField, Icons.email), findsOneWidget);
    expect(find.widgetWithIcon(TextFormField, Icons.lock), findsOneWidget);

    // Forgot password and sign-up navigation should be visible
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
  });
}
