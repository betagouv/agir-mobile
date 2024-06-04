import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Iel scrolle.
Future<void> ielScrolle(final WidgetTester tester, final String text) async {
  await tester.scrollUntilVisible(
    find.text(text),
    300,
    scrollable: find.descendant(
      of: find.byType(ListView),
      matching: find.byType(Scrollable).first,
    ),
  );
}
