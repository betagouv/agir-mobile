import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I see {'650'} points
Future<void> iSeePoints(final WidgetTester tester, final String points) async {
  expect(
    find.bySemanticsLabel(Localisation.nombrePoints(int.parse(points))),
    findsOneWidget,
  );
}
