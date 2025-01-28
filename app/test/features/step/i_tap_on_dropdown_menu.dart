import 'package:dsfr/dsfr.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I tap on dropdown menu
Future<void> iTapOnDropdownMenu(final WidgetTester tester) async {
  await tester.tap(find.byIcon(DsfrIcons.systemArrowDownSLine).hitTestable());
  await tester.pump();
}
