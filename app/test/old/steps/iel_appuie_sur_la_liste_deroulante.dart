import 'package:dsfr/dsfr.dart';
import 'package:flutter_test/flutter_test.dart';

/// Iel appuie sur la liste déroulante.
Future<void> ielAppuieSurLaListeDeroulante(final WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.tap(find.byIcon(DsfrIcons.systemArrowDownSLine).hitTestable());
  await tester.pump();
}
