import 'package:flutter/widgets.dart';

extension IterableExtension on Iterable<Widget> {
  Iterable<Widget> separator(final Widget element) sync* {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      yield iterator.current;
      while (iterator.moveNext()) {
        yield element;
        yield iterator.current;
      }
    }
  }
}
