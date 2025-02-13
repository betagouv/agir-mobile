import 'package:flutter_test/flutter_test.dart';

/// Usage: I accept the terms of use
Future<void> iAcceptTheTermsOfUse(final WidgetTester tester) async {
  await tester.tap(find.bySemanticsLabel('J’accepte les conditions générales d’utilisation'));
  await tester.pumpAndSettle();
}
