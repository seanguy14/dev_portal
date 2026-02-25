// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dev_portal/main.dart';

void main() {
  testWidgets('DevPortalApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DevPortalApp());

    // Verify that the portfolio title is present.
    expect(find.text('Dev Portfolio'), findsOneWidget);
    expect(find.text("Hi, I'm a Flutter Developer"), findsOneWidget);
  });

  testWidgets('Privacy Policy navigation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DevPortalApp());

    // Tap the Privacy Policy button.
    await tester.tap(find.widgetWithText(TextButton, 'Privacy Policy'));
    await tester.pumpAndSettle();

    // Verify that the Privacy Policy page content is displayed.
    expect(find.textContaining('Last updated: January 1, 2024'), findsOneWidget);
  });
}
