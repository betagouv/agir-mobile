import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'scenario_context.dart';
import 'set_up_widgets.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_sappelle.dart';
import 'steps/iel_voit_le_texte.dart';

void main() {
  testWidgets(
    'Voir la modal de la suppression de compte',
    (final tester) async {
      setUpWidgets(tester);
      await _allerSurSuppressionCompte(tester);
      await ielAppuieSur(tester, Localisation.annuler);
    },
  );

  testWidgets('Annuler la suppresion de compte', (final tester) async {
    setUpWidgets(tester);
    await _allerSurSuppressionCompte(tester);
    await ielAppuieSur(tester, Localisation.annuler);
    final profilPortMock = ScenarioContext().profilPortMock!;
    expect(profilPortMock.supprimerLeCompteAppele, false);
  });

  testWidgets('Confirmer la suppresion de compte', (final tester) async {
    setUpWidgets(tester);
    await _allerSurSuppressionCompte(tester);
    await ielAppuieSur(tester, Localisation.confirmer);
    final profilPortMock = ScenarioContext().profilPortMock!;
    expect(profilPortMock.supprimerLeCompteAppele, true);
    ielVoitLeTexte(Localisation.preOnboardingTitre);
  });
}

Future<void> _allerSurSuppressionCompte(final WidgetTester tester) async {
  const prenom = 'Michel';
  const nom = 'Dupont';
  ielSappelle(prenom, nom: nom);
  ielEstConnecte();
  await ielLanceLapplication(tester);
  await ielAppuieSurAccessibilite(tester, Localisation.menu);
  await ielAppuieSur(tester, Localisation.monProfil);
  await ielAppuieSur(tester, Localisation.optionsAvancees);
  await ielAppuieSur(tester, Localisation.supprimerVotreCompte);
}
