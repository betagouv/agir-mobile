import 'package:app/features/home/presentation/pages/home_page.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I see the home page
Future<void> iSeeTheHomePage(final WidgetTester tester) async {
  expect(find.byType(HomePage), findsOneWidget);
}
