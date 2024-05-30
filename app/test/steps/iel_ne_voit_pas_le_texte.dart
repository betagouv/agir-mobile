import 'package:flutter_test/flutter_test.dart';

/// Iel ne voit pas le texte
Future<void> ielNeVoitPasLeTexte(
  final WidgetTester tester,
  final String texte,
) async {
  expect(find.text(texte), findsNothing);
}
