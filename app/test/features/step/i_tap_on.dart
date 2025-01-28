import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../helper/finders.dart';

/// Usage: I tap on {'Je crée mon compte'}
Future<void> iTapOn(final WidgetTester tester, final String text) async {
  await mockNetworkImages(() async {
    await tester.tap(
      find.descendant(
        of: find.byType(GestureDetector),
        matching: findText(text),
      ),
    );
    await tester.pumpAndSettle();
  });
}
