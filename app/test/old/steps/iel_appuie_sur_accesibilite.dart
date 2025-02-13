import 'package:flutter_test/flutter_test.dart';

/// Iel appuie sur accessibilite.
Future<void> ielAppuieSurAccessibilite(final WidgetTester tester, final String label) async {
  final bySemanticsLabel = find.bySemanticsLabel(label);
  expect(bySemanticsLabel, findsOneWidget);
  await tester.tap(bySemanticsLabel);
  await tester.pumpAndSettle();
}
