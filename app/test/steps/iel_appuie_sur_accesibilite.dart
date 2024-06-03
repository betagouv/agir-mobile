import 'package:flutter_test/flutter_test.dart';

/// Iel appuie sur accessibilite
Future<void> ielAppuieSurAccessibilite(
  final WidgetTester tester,
  final String label,
) async {
  await tester.tap(find.bySemanticsLabel(label));
  await tester.pumpAndSettle();
}
