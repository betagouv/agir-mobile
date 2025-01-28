import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Finder findText(final String text) => find.byWidgetPredicate(
      (final widget) => switch (widget) {
        RichText() => _matchRichText(widget, text),
        EditableText() => _matchEditableText(widget, text),
        _ => false,
      },
      description: 'text "$text"',
    );

bool _matchEditableText(final EditableText widget, final String text) =>
    widget.controller.text == text;

bool _matchRichText(final RichText widget, final String text) =>
    widget.text.toPlainText().replaceAll('￼', ' ').trim() == text;
