import 'package:dsfr/dsfr.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> ielEcritDansLeChamp(
  final WidgetTester tester, {
  required final String label,
  required final String enterText,
}) async {
  await tester.enterText(
    find.byWidgetPredicate(
      (final widget) => widget is DsfrInput && widget.label == label,
    ),
    enterText,
  );
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pump();
}
