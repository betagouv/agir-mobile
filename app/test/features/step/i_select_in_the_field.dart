import 'package:dsfr/dsfr.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I select {'DOLE'} in the {'Commune'} field
Future<void> iSelectInTheField(
  final WidgetTester tester,
  final String choice,
  final String field,
) async {
  await tester.tap(find.byIcon(DsfrIcons.systemArrowDownSLine).hitTestable());
  await tester.pump();
  await tester.tap(find.text(choice).hitTestable());
  await tester.pumpAndSettle();
}
