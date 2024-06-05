import 'package:flutter_test/flutter_test.dart';

/// Iel voit le texte.
void ielVoitLeTexte(final String texte, {final int n = 1}) {
  expect(find.text(texte), findsNWidgets(n));
}
