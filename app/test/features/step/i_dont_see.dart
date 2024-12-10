import 'package:flutter_test/flutter_test.dart';

/// Usage: I don't see {"Qu'est-ce qu'une alimentation durable ?"}
Future<void> iDontSee(final WidgetTester tester, final String text) async {
  expect(find.text(text), findsNothing);
}
