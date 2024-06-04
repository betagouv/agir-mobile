import 'package:dsfr/dsfr.dart';
import 'package:flutter_test/flutter_test.dart';

/// Iel appuie sur le champ.
Future<void> ielAppuieSurLeChamp(
  final WidgetTester tester, {
  required final String label,
}) async {
  await tester.tap(
    find.byWidgetPredicate(
      (final widget) => widget is DsfrInput && widget.label == label,
    ),
  );
  await tester.pump();
}
