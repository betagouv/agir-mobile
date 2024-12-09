import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I tap on the menu button
Future<void> iTapOnTheMenuButton(final WidgetTester tester) async {
  await tester.tap(find.bySemanticsLabel(Localisation.menu));
  await tester.pumpAndSettle();
}
