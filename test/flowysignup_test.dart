import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flowysignup/flowysignup.dart';

void main() {
  testWidgets('SignUpCustom widget renders correctly',
      (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FlowyUsernamePage(),
        ),
      ),
    );

    // Verify the widget renders
    expect(find.byType(FlowyUsernamePage), findsOneWidget);

    // You can add more specific tests here, for example:
    // expect(find.byType(TextField), findsWidgets); // If your widget has text fields
    // expect(find.byType(ElevatedButton), findsOneWidget); // If your widget has a button
  });
}
