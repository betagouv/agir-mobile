import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'scenario_context.dart';
import 'set_up_widgets.dart';
import 'steps/iel_a_ces_informations_de_profile.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_ecrit_dans_le_champ.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_sappelle.dart';
import 'steps/iel_scrolle.dart';
import 'steps/iel_voit_le_bouton_radio_avec_ce_texte_selectionne.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/iel_voit_le_texte_markdown.dart';

void main() {
  testWidgets('Voir tous les textes', (final tester) async {
    setUpWidgets(tester);
    await _allerSurMesInformations(tester);
    ielVoitLeTexte(Localisation.mesInformations);
    ielVoitLeTexte(Localisation.votreIdentite);
    ielVoitLeTexte(Localisation.prenom);
    ielVoitLeTexte(Localisation.nom);
    ielVoitLeTexte(Localisation.adresseCourrierElectronique);
    ielVoitLeTexte(Localisation.adresseCourrierElectroniqueDescription);
    ielVoitLeTexte(Localisation.donneesPersonnelles);
    ielVoitLeTexte(Localisation.nombreDePartsFiscales);
    ielVoitLeTexte(Localisation.nombreDePartsFiscalesDescription);
    await ielScrolle(tester, Localisation.revenuFiscal);
    ielVoitLeTexte(Localisation.revenuFiscal);
    ielVoitLeTexte(Localisation.tranche0);
    ielVoitLeTexte(Localisation.tranche1);
    ielVoitLeTexte(Localisation.tranche2);
    ielVoitLeTexteMarkdown(tester, Localisation.pourquoiCesQuestionsReponse);
    ielVoitLeTexte(Localisation.mettreAJourVosInformations);
  });

  testWidgets('Iel voit les informations prérempli', (final tester) async {
    setUpWidgets(tester);
    await _allerSurMesInformations(tester);
    ielVoitLeTexte(ScenarioContext().nom);
    ielVoitLeTexte(ScenarioContext().prenom);
    ielVoitLeTexte(ScenarioContext().email);
    await ielScrolle(tester, Localisation.revenuFiscal);
    ielVoitLeTexte(ScenarioContext().nombreDePartsFiscales.toString());
    ielVoitLeBoutonRadioAvecCeTexteSelectionne(Localisation.tranche1);
  });

  testWidgets(
    'Iel rempli ces informations et appuie sur mettre à jour',
    (final tester) async {
      setUpWidgets(tester);
      await _allerSurMesInformations(tester);
      const nom = 'Nouveau nom';
      const prenom = 'Nouveau prenom';
      const email = 'nouveau@email.com';
      const nombreDePartsFiscales = 2.5;
      const tranche = Localisation.tranche2;
      const trancheValeur = 35000;

      await ielEcritDansLeChamp(
        tester,
        label: Localisation.nom,
        enterText: nom,
      );
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.prenom,
        enterText: prenom,
      );
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.adresseCourrierElectronique,
        enterText: email,
      );
      await ielScrolle(tester, Localisation.revenuFiscal);
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.nombreDePartsFiscales,
        enterText: nombreDePartsFiscales.toString(),
      );
      await ielAppuieSur(tester, tranche);
      await ielAppuieSur(tester, Localisation.mettreAJourVosInformations);

      final profilPortMock = ScenarioContext().profilPortMock!;
      expect(profilPortMock.nom, nom);
      expect(profilPortMock.prenom, prenom);
      expect(profilPortMock.email, email);
      expect(profilPortMock.nombreDePartsFiscales, nombreDePartsFiscales);
      expect(profilPortMock.revenuFiscal, trancheValeur);
    },
  );
}

Future<void> _allerSurMesInformations(final WidgetTester tester) async {
  const prenom = 'Michel';
  const nom = 'Dupont';
  ielSappelle(prenom, nom: nom);
  ielACesInformationsDeProfil(
    codePostal: '75018',
    ville: 'Paris',
    nombreDePartsFiscales: 1,
    revenuFiscal: 16000,
  );
  ielEstConnecte();
  await ielLanceLapplication(tester);
  await ielAppuieSurAccessibilite(tester, Localisation.menu);
  await ielAppuieSur(tester, Localisation.monProfil);
  await ielAppuieSur(tester, Localisation.vosInformations);
}
