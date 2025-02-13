import 'package:flutter_test/flutter_test.dart';
import 'package:pinput/pinput.dart';

/// Usage: I enter {'999999'} in the pin field
Future<void> iEnterInThePinField(final WidgetTester tester, final String code) async {
  await tester.enterText(find.byType(Pinput), code);
  await tester.pump();
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
}
