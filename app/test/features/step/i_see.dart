import 'package:flutter_test/flutter_test.dart';

import '../helper/finders.dart';

/// Usage: I see {'Créer votre compte J’agis'}
Future<void> iSee(final WidgetTester tester, final String text) async {
  expect(findText(text), findsOneWidget);
}
