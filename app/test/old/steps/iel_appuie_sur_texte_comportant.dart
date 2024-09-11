import 'package:flutter_test/flutter_test.dart';

/// Iel appuie sur texte comportant.
Future<void> ielAppuieSurTexteComportant(
  final WidgetTester tester,
  final String text,
) async {
  await tester.tap(find.textContaining(text));
  await tester.pumpAndSettle();
}
