import 'package:flutter_test/flutter_test.dart';

/// Iel voit le texte
Future<void> ielVoitLeTexte(
  final WidgetTester tester,
  final String texte,
) async {
  expect(find.text(texte), findsOneWidget);
}
