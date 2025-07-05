// This is a basic Flutter widget test for the QuizOn app.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:quizon/main.dart';

void main() {
  testWidgets('QuizOn app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(QuizOnApp());

    // Verify that the login screen is displayed.
    expect(find.text('QuizOn! Login'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);

    // Verify that we can interact with the username field.
    await tester.enterText(find.byType(TextFormField).first, 'testuser');
    expect(find.text('testuser'), findsOneWidget);

    // Verify that we can interact with the password field.
    await tester.enterText(find.byType(TextFormField).last, 'testpass');
    
    // Try to tap the login button (though it won't actually log in without proper auth)
    await tester.tap(find.text('Login'));
    await tester.pump();
  });
}
