import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I enter {'joe@doe.fr'} in the {'Mon adresse email'} field
Future<void> iEnterInTheField(
  final WidgetTester tester,
  final String text,
  final String label,
) async {
  final field =
      find
          .byWidgetPredicate((final widget) => widget.key == ValueKey(label))
          .first;
  await tester.enterText(field, text);
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle();
}
