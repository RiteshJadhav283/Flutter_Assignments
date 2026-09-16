import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:assignment_4/main.dart';
import 'package:assignment_4/screens/form_screen.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  void setStandardScreenSize(WidgetTester tester) {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  }

  testWidgets('HomeScreen renders with concept navigation cards', (WidgetTester tester) async {
    setStandardScreenSize(tester);
    await tester.pumpWidget(const Assignment4App());
    await tester.pumpAndSettle();

    // Verify AppBar title
    expect(find.text('Flutter Concepts Hub'), findsOneWidget);

    // Verify concept cards exist on HomeScreen
    expect(find.text('User Input & Forms'), findsOneWidget);
    expect(find.text('Images, Assets & Fonts'), findsOneWidget);
    expect(find.text('Interactive Animations'), findsOneWidget);
  });

  testWidgets('Navigation to FormScreen and form validation test', (WidgetTester tester) async {
    setStandardScreenSize(tester);
    await tester.pumpWidget(const Assignment4App());
    await tester.pumpAndSettle();

    // Tap on the "User Input & Forms" card to navigate using named route
    await tester.tap(find.text('User Input & Forms'));
    await tester.pumpAndSettle();

    // Verify we are on FormScreen
    expect(find.text('Form & Validation Demo'), findsOneWidget);

    // Submit form when empty to trigger validators
    await tester.tap(find.text('Submit Form'));
    await tester.pump();

    // Verify validation error messages are displayed
    expect(find.text('Please enter your full name'), findsOneWidget);
    expect(find.text('Please enter your email address'), findsOneWidget);
    expect(find.text('Please enter your phone number'), findsOneWidget);
    expect(find.text('Please enter a password'), findsOneWidget);

    // Enter valid inputs
    await tester.enterText(find.widgetWithText(TextFormField, 'Full Name'), 'Alice Johnson');
    await tester.enterText(find.widgetWithText(TextFormField, 'Email Address'), 'alice@example.com');
    await tester.enterText(find.widgetWithText(TextFormField, 'Phone Number'), '9876543210');
    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'Pass1234');
    await tester.pump();

    // Submit valid form
    await tester.tap(find.text('Submit Form'));
    await tester.pumpAndSettle();

    // Verify dialog with submission details appears
    expect(find.text('Submission Details'), findsOneWidget);
    expect(
      find.descendant(of: find.byType(AlertDialog), matching: find.text('Alice Johnson')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: find.byType(AlertDialog), matching: find.text('alice@example.com')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: find.byType(AlertDialog), matching: find.text('9876543210')),
      findsOneWidget,
    );

    // Close the dialog
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();

    // Dismiss previous SnackBar before interacting with Reset
    ScaffoldMessenger.of(tester.element(find.byType(FormScreen))).hideCurrentSnackBar();
    await tester.pumpAndSettle();

    // Test Reset button
    await tester.tap(find.text('Reset'));
    await tester.pumpAndSettle();
    expect(find.text('Form fields have been reset.'), findsOneWidget);

    // Verify input fields were cleared
    final nameField = tester.widget<TextFormField>(find.widgetWithText(TextFormField, 'Full Name'));
    expect(nameField.controller?.text, isEmpty);

    // Navigate back to HomeScreen
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Flutter Concepts Hub'), findsOneWidget);
  });

  testWidgets('Navigation to ImageGridScreen test', (WidgetTester tester) async {
    setStandardScreenSize(tester);
    await tester.pumpWidget(const Assignment4App());
    await tester.pumpAndSettle();

    // Tap on the "Images, Assets & Fonts" card
    await tester.tap(find.text('Images, Assets & Fonts'));
    await tester.pumpAndSettle();

    // Verify ImageGridScreen renders with title & font banner
    expect(find.text('Custom Typography: Poppins'), findsOneWidget);
    expect(find.text('Alpine Peak'), findsOneWidget);
    expect(find.text('Ocean Horizon'), findsOneWidget);

    // Test tapping an image card to open details modal
    await tester.tap(find.text('Alpine Peak'));
    await tester.pumpAndSettle();
    expect(find.text('assets/images/nature_mountain.png'), findsOneWidget);

    // Close dialog
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();

    // Test switching grid columns
    await tester.tap(find.byTooltip('Switch Grid Columns'));
    await tester.pumpAndSettle();

    // Navigate back
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Flutter Concepts Hub'), findsOneWidget);
  });

  testWidgets('Navigation to AnimationScreen and AnimatedContainer test', (WidgetTester tester) async {
    setStandardScreenSize(tester);
    await tester.pumpWidget(const Assignment4App());
    await tester.pumpAndSettle();

    // Tap on "Interactive Animations" card
    await tester.tap(find.text('Interactive Animations'));
    await tester.pumpAndSettle();

    // Verify AnimationScreen renders
    expect(find.text('AnimatedContainer Demo'), findsOneWidget);
    expect(find.byKey(const Key('animated_container_target')), findsOneWidget);
    expect(find.text('150 × 150'), findsOneWidget);

    // Trigger animation via main button
    await tester.tap(find.byKey(const Key('toggle_animation_button')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600)); // wait for animation curve to finish

    // Verify updated state and dimensions
    expect(find.text('260 × 200'), findsOneWidget);
    expect(find.text('Reverse Animation'), findsOneWidget);

    // Test preset chip selection (Circle Mode)
    await tester.tap(find.text('Circle Mode'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.text('180 × 180'), findsOneWidget);

    // Test Randomize button
    await tester.tap(find.text('Randomize All Attributes'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    // Navigate back to HomeScreen
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Flutter Concepts Hub'), findsOneWidget);
  });
}
