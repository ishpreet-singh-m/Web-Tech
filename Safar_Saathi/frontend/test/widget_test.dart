import 'package:SafarSathi/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
 // ✅ correct import

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());  // ✅ removed const

    // Verify that the HomeScreen is being displayed
    expect(find.textContaining('Good morning!'), findsOneWidget);

    // Verify that an old, irrelevant icon is not present.
    expect(find.byIcon(Icons.add), findsNothing);
  });
}
