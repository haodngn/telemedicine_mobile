// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:telemedicine_mobile/Screens/form_after_login_screen.dart';

import 'package:telemedicine_mobile/main.dart';

void main() {
  testWidgets('finds a Text widget', (WidgetTester tester) async {
  // Build an App with a Text widget that displays the letter 'H'.
  await tester.pumpWidget(const UserInformation());

  // Find a widget that displays the letter 'H'.
  expect(find.text('H'), findsOneWidget);
});
}
