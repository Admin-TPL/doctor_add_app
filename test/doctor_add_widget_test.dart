import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:doctor_add_app/main.dart';

import 'mock.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });
  testWidgets('Doctor form test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Find text fields and button
    final nameField = find.bySemanticsLabel('Doctor Name');
    final expertiseField = find.bySemanticsLabel('Expertise');
    final addressField = find.bySemanticsLabel('Address');
    final ratingField = find.bySemanticsLabel('Rating');
    final latitudeField = find.bySemanticsLabel('Latitude');
    final longitudeField = find.bySemanticsLabel('Longitude');
    final addButton = find.byKey(const ValueKey('add doctor'));

    // Enter data
    await tester.enterText(nameField, 'Dr. Smith');
    await tester.enterText(expertiseField, 'Cardiology');
    await tester.enterText(addressField, '123 Main St');
    await tester.enterText(ratingField, '4.5');
    await tester.enterText(latitudeField, '12.34');
    await tester.enterText(longitudeField, '56.78');

    // Tap the 'Add Doctor' button
    await tester.tap(addButton);

    // Wait till it loadds
    await tester.pumpAndSettle(const Duration(seconds: 10));

    // Check for a success message
    expect(find.text('Doctor added successfully!'), findsOneWidget);
  });
}
