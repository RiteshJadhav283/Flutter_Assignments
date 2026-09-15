import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:assignment_3/main.dart';

void main() {
  testWidgets('IdentityCardPage widget tree and mandatory requirements test', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // 1. Verify Scaffold and AppBar
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Digital Identity Card'), findsOneWidget);

    // 2. Verify Center & Container
    expect(find.byType(Center), findsWidgets);
    expect(find.byType(Container), findsWidgets);

    // 3. Verify CircleAvatar
    expect(find.byType(CircleAvatar), findsWidgets);

    // 4. Verify Personal Information Texts
    expect(find.text('Ritesh Jadhav'), findsOneWidget);
    expect(find.text('Software Developer'), findsOneWidget);
    expect(find.text('Mumbai, India'), findsOneWidget);
    expect(find.text('21 Years'), findsOneWidget);
    expect(find.text('ID2026001'), findsOneWidget);
    expect(find.text('O+'), findsOneWidget);
    expect(find.text('ritesh6798@hotmail.com'), findsOneWidget);

    // 5. Verify Rows and Columns
    expect(find.byType(Row), findsWidgets);
    expect(find.byType(Column), findsWidgets);

    // 6. Verify Icons
    expect(find.byIcon(Icons.cake_rounded), findsOneWidget);
    expect(find.byIcon(Icons.badge_rounded), findsOneWidget);
    expect(find.byIcon(Icons.bloodtype_rounded), findsOneWidget);
    expect(find.byIcon(Icons.email_outlined), findsOneWidget);
  });
}
