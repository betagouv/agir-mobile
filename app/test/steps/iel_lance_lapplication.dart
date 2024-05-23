import 'package:agir/src/app.dart';
import 'package:flutter_test/flutter_test.dart';

/// Iel lance l'application
Future<void> ielLanceLapplication(final WidgetTester tester) async {
  await tester.pumpWidget(const App());
}
