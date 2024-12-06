// ignore_for_file: prefer_final_parameters

import 'package:flutter_test/flutter_test.dart';

/// Usage: I see {'Créer mon compte J’agis'}
Future<void> iSee(WidgetTester tester, String text) async {
  expect(find.text(text), findsOneWidget);
}
