import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_sappelle.dart';
import 'steps/iel_voit_le_texte.dart';

void main() {
  testWidgets(
    'Iel va sur la page profil et voit les éléments disponibles',
    (final tester) async {
      setUpWidgets(tester);
      await _allerSurMonProfil(tester);
      ielVoitLeTexte(Localisation.monProfil);
      ielVoitLeTexte(Localisation.mesInformations);
      ielVoitLeTexte(Localisation.monLogement);
      ielVoitLeTexte(Localisation.optionsAvancees);
    },
  );

  testWidgets('Allez sur la page Mes informations', (final tester) async {
    setUpWidgets(tester);
    await _allerSurMonProfil(tester);
    await ielAppuieSur(tester, Localisation.mesInformations);
    ielVoitLeTexte(Localisation.mesInformations);
  });

  testWidgets('Allez sur la page Mon logement', (final tester) async {
    setUpWidgets(tester);
    await _allerSurMonProfil(tester);
    await ielAppuieSur(tester, Localisation.monLogement);
    ielVoitLeTexte(Localisation.monLogement);
  });

  testWidgets('Allez sur la page Options avancées', (final tester) async {
    setUpWidgets(tester);
    await _allerSurMonProfil(tester);
    await ielAppuieSur(tester, Localisation.optionsAvancees);
    ielVoitLeTexte(Localisation.optionsAvancees);
  });
}

Future<void> _allerSurMonProfil(final WidgetTester tester) async {
  const prenom = 'Michel';
  const nom = 'Dupont';
  ielSappelle(prenom, nom: nom);
  ielEstConnecte();
  await ielLanceLapplication(tester);
  await ielAppuieSurAccessibilite(tester, Localisation.menu);
  await ielAppuieSur(tester, Localisation.monProfil);
}
