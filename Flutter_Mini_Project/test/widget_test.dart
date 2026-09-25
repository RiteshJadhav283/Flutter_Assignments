import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mini_project/main.dart';

void main() {
  testWidgets('Job Finder App renders all main tabs and switches smoothly', (WidgetTester tester) async {
    await tester.pumpWidget(const JobFinderApp());
    await tester.pumpAndSettle();

    // Verify AppBar Title
    expect(find.text('JobSeek'), findsOneWidget);

    // Verify Explore tab components
    expect(find.text('Find Your Dream Job'), findsOneWidget);
    expect(find.text('FEATURED ROLE'), findsOneWidget);
    expect(find.text('Explore'), findsOneWidget);

    // Switch to Saved Tab
    await tester.tap(find.text('Saved'));
    await tester.pumpAndSettle();
    expect(find.text('My Activity'), findsOneWidget);
    expect(find.textContaining('Saved ('), findsOneWidget);
    expect(find.textContaining('Applied ('), findsOneWidget);

    // Verify Categories and Profile tabs are not present in bottom navigation
    expect(find.text('Categories'), findsNothing);
    expect(find.text('Profile'), findsNothing);
  });

  testWidgets('Search bar on Explore tab filters jobs dynamically', (WidgetTester tester) async {
    await tester.pumpWidget(const JobFinderApp());
    await tester.pumpAndSettle();

    // Search for Flutter
    final searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);

    await tester.enterText(searchField, 'Flutter');
    await tester.pumpAndSettle();

    // Should find Flutter jobs
    expect(find.text('Senior Flutter Developer'), findsOneWidget);
  });

  testWidgets('Verify slide bar (drawer) and notification are removed', (WidgetTester tester) async {
    await tester.pumpWidget(const JobFinderApp());
    await tester.pumpAndSettle();

    // Verify no Drawer is configured on the Scaffold
    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold).first);
    expect(scaffold.drawer, isNull);

    // Verify no notification icon or action button in AppBar
    expect(find.byIcon(Icons.notifications_outlined), findsNothing);
    expect(find.byIcon(Icons.notifications_active_rounded), findsNothing);
  });

  testWidgets('End-to-end flow: Open Job Details, Fill Application Form, and Submit', (WidgetTester tester) async {
    await tester.pumpWidget(const JobFinderApp());
    await tester.pumpAndSettle();

    // Tap "Explore Role" on Featured Banner
    final exploreButton = find.widgetWithText(ElevatedButton, 'Explore Role');
    expect(exploreButton, findsOneWidget);
    await tester.tap(exploreButton);
    await tester.pumpAndSettle();

    // Verify Job Details Screen loaded
    expect(find.text('Job Details'), findsOneWidget);
    expect(find.text('Job Overview'), findsOneWidget);
    expect(find.text('Key Responsibilities'), findsOneWidget);

    // Tap "Apply For This Position"
    final applyButton = find.widgetWithText(ElevatedButton, 'Apply For This Position');
    expect(applyButton, findsOneWidget);
    await tester.tap(applyButton);
    await tester.pumpAndSettle();

    // Verify Application Form Screen loaded
    expect(find.text('Job Application Form'), findsOneWidget);
    expect(find.text('1. Personal Details'), findsOneWidget);

    // Fill form fields
    await tester.enterText(find.widgetWithText(TextFormField, 'Full Name *'), 'Ritesh Jadhav');
    await tester.enterText(find.widgetWithText(TextFormField, 'Email Address *'), 'ritesh@example.com');
    await tester.enterText(find.widgetWithText(TextFormField, 'Phone Number *'), '9876543210');

    // Scroll down to Cover Note and Terms Checkbox
    await tester.scrollUntilVisible(
      find.text('Submit Application'),
      80.0,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextFormField).last,
      'I am an enthusiastic developer eager to apply my skills to your team!',
    );
    await tester.pumpAndSettle();

    // Check Terms Checkbox (the last checkbox on the screen)
    final termsCheckbox = find.byType(Checkbox).last;
    await tester.ensureVisible(termsCheckbox);
    await tester.pumpAndSettle();
    await tester.tap(termsCheckbox);
    await tester.pumpAndSettle();

    // Tap Submit Application
    final submitButton = find.widgetWithText(ElevatedButton, 'Submit Application');
    await tester.ensureVisible(submitButton);
    await tester.pumpAndSettle();
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    // Verify AlertDialog pops up
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Application Sent!'), findsOneWidget);
    expect(find.text('Ritesh Jadhav'), findsWidgets);

    // Tap "Done & View Jobs"
    final doneButton = find.widgetWithText(ElevatedButton, 'Done & View Jobs');
    await tester.tap(doneButton);
    await tester.pumpAndSettle();

    // Should return to Job Details and button should now say "Already Applied"
    expect(find.text('Already Applied'), findsOneWidget);
  });
}
