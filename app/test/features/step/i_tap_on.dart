import 'package:flutter_test/flutter_test.dart';

/// Usage: I tap on {'Je crée mon compte'}
Future<void> iTapOn(final WidgetTester tester, final String text) async {
  await tester.tap(find.text(text));
  await tester.pumpAndSettle();
}
