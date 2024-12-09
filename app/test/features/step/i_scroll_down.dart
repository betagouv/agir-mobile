import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I scroll down
Future<void> iScrollDown(final WidgetTester tester) async {
  await tester.drag(find.byType(Scrollable).first, const Offset(0, -300));
  await tester.pumpAndSettle();
}
