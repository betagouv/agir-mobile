import 'package:flutter_test/flutter_test.dart';

/// Iel voit le texte dans texte riche.
void ielVoitLeTexteDansTexteRiche(final String texte) {
  expect(find.textContaining(texte, findRichText: true), findsOneWidget);
}
