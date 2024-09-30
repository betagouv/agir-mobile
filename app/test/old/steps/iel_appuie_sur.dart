import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Iel appuie sur.
Future<void> ielAppuieSur(final WidgetTester tester, final String text) async {
  await tester.tap(findTextInGestureDetector(text).first);
  await tester.pumpAndSettle();
}

Finder findTextInGestureDetector(final String text) => find.descendant(
      of: find.byType(GestureDetector),
      matching: find.byWidgetPredicate((final widget) {
        if (widget is RichText) {
          final combinedText = _extractTextFromRichText(widget);

          return combinedText.contains(text);
        }

        return false;
      }),
    );

String _extractTextFromRichText(final RichText richText) =>
    _extractTextFromTextSpan(richText.text);

String _extractTextFromTextSpan(final InlineSpan textSpan) {
  final buffer = StringBuffer();
  textSpan.visitChildren((final span) {
    if (span is TextSpan && span.text != null) {
      buffer.write(span.text);
    }

    return true;
  });

  return buffer.toString();
}
