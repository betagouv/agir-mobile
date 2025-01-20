// ignore_for_file: prefer_final_parameters

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I see {'Créer mon compte J’agis'}
Future<void> iSee(WidgetTester tester, String text) async {
  expect(
    find.byWidgetPredicate(
      (final widget) =>
          widget is RichText &&
          widget.text.toPlainText().replaceAll('￼', ' ').trim() == text,
      description: 'text "$text"',
    ),
    findsOneWidget,
  );
}
