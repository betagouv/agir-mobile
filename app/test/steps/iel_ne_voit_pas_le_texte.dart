import 'package:flutter_test/flutter_test.dart';

/// Iel ne voit pas le texte.
void ielNeVoitPasLeTexte(final String texte) {
  expect(find.text(texte), findsNothing);
}
