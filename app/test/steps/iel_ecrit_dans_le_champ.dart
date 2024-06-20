import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Iel écrit dans le champ.
Future<void> ielEcritDansLeChamp(
  final WidgetTester tester, {
  required final String label,
  required final String enterText,
}) async {
  await tester.enterText(
    find.byWidgetPredicate(
      (final widget) =>
          widget is DsfrInputHeadless && widget.key == ValueKey(label),
    ),
    enterText,
  );

  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pump();
}
