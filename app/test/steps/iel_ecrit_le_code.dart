import 'package:flutter_test/flutter_test.dart';
import 'package:pinput/pinput.dart';

/// Iel écrit le code.
Future<void> ielEcritLeCode(
  final WidgetTester tester, {
  required final String enterText,
}) async {
  await tester.enterText(find.byType(Pinput), enterText);
  await tester.pump();
}
