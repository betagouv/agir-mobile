import 'package:app/src/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_ecrit_dans_le_champ.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_glisse_de_la_droite_vers_la_gauche.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/iel_voit_le_texte_dans_texte_riche.dart';
import 'steps/iel_voit_le_texte_markdown.dart';

void main() {
  testWidgets("Iel n'est pas connecté", (final tester) async {
    setUpWidgets(tester);
    await ielLanceLapplication(tester);
    ielVoitLeTexte(Localisation.preOnboardingTitre);
  });

  testWidgets('Iel est connecté', (final tester) async {
    setUpWidgets(tester);
    ielEstConnecte();
    await ielLanceLapplication(tester);
    ielVoitLeTexteDansTexteRiche(Localisation.bonjour);
  });

  testWidgets(
    "Iel lance l'application pour la première fois",
    (final tester) async {
      setUpWidgets(tester);
      await ielLanceLapplication(tester);
      ielVoitLeTexte(Localisation.preOnboardingTitre);
      await ielAppuieSur(tester, Localisation.commencer);
      ielVoitLeTexteMarkdown(tester, Localisation.preOnboarding1);
      await ielGlisseDeLaDroiteVersLaGauche(tester);
      ielVoitLeTexteMarkdown(tester, Localisation.preOnboarding2);
      await ielGlisseDeLaDroiteVersLaGauche(tester);
      ielVoitLeTexteMarkdown(tester, Localisation.preOnboarding3);
      await ielGlisseDeLaDroiteVersLaGauche(tester);
      ielVoitLeTexte(Localisation.preOnboardingFinTitre);
    },
  );

  testWidgets(
    "Iel lance l'application pour la première fois skip le preonboarding et se connecte",
    (final tester) async {
      setUpWidgets(tester);
      await ielLanceLapplication(tester);
      ielVoitLeTexte(Localisation.preOnboardingTitre);
      await ielAppuieSur(tester, Localisation.jaiDejaUnCompte);
      ielVoitLeTexte(Localisation.seConnecter, n: 2);
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.adresseElectronique,
        enterText: 'joe@doe.com',
      );
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.motDePasse,
        enterText: 'M07D3P4553',
      );
      await ielAppuieSur(tester, Localisation.seConnecter);
      ielVoitLeTexteDansTexteRiche(Localisation.bonjour);
    },
  );

  testWidgets(
    "Iel lance l'application pour la première fois et se connecte",
    (final tester) async {
      setUpWidgets(tester);
      await ielLanceLapplication(tester);
      ielVoitLeTexte(Localisation.preOnboardingTitre);
      await ielAppuieSur(tester, Localisation.commencer);
      ielVoitLeTexteMarkdown(tester, Localisation.preOnboarding1);
      await ielGlisseDeLaDroiteVersLaGauche(tester);
      ielVoitLeTexteMarkdown(tester, Localisation.preOnboarding2);
      await ielGlisseDeLaDroiteVersLaGauche(tester);
      ielVoitLeTexteMarkdown(tester, Localisation.preOnboarding3);
      await ielGlisseDeLaDroiteVersLaGauche(tester);
      await ielAppuieSur(tester, Localisation.jaiDejaUnCompte);
      ielVoitLeTexte(Localisation.seConnecter, n: 2);
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.adresseElectronique,
        enterText: 'joe@doe.com',
      );
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.motDePasse,
        enterText: 'M07D3P4553',
      );
      await ielAppuieSur(tester, Localisation.seConnecter);
      ielVoitLeTexteDansTexteRiche(Localisation.bonjour);
    },
  );
}
