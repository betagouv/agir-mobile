import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

/// Usage: I tap on {'Je crée mon compte'}
Future<void> iTapOn(final WidgetTester tester, final String text) async {
  await mockNetworkImages(() async {
    await tester.tap(
      find.descendant(
        of: find.byType(GestureDetector),
        matching: find.text(text),
      ),
    );
    await tester.pumpAndSettle();
  });
}
