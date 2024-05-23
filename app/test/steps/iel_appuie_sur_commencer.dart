import 'package:agir/src/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

/// Iel appuie sur commencer
Future<void> ielAppuieSurCommencer(final WidgetTester tester) async {
  await tester.tap(find.text(Localisation.commencer));
  await tester.pumpAndSettle();
}
