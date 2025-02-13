import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Iel voit le bouton radio avec ce texte selectionné.
void ielVoitLeBoutonRadioAvecCeTexteSelectionne(final String text) {
  expect(
    find.byWidgetPredicate((final w) => w is RadioIcon && w.key == ValueKey(text) && w.groupValue == w.value),
    findsOneWidget,
  );
}
