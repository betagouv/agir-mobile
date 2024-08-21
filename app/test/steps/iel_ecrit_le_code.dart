import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Iel écrit le code.
Future<void> ielEcritLeCode(
  final WidgetTester tester, {
  required final String enterText,
}) async {
  await tester.enterText(find.byType(EditableText), enterText);
  await tester.pump();
}
