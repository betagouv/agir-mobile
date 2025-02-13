import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Iel scrolle.
Future<void> ielScrolle(final WidgetTester tester, final String text) async {
  await tester.scrollUntilVisible(
    find.textContaining(text, findRichText: true),
    300,
    scrollable:
        find
            .byWidgetPredicate(
              (final widget) =>
                  widget is Scrollable &&
                  widget.axisDirection == AxisDirection.down,
            )
            .first,
  );
  await tester.pumpAndSettle();
}
