import 'package:flutter_test/flutter_test.dart';

/// Iel appuie sur
Future<void> ielAppuieSur(final WidgetTester tester, final String text) async {
  await tester.tap(find.text(text));
  await tester.pumpAndSettle();
}
