import 'package:app/src/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/steps.dart';

void main() {
  testWidgets("Iel n'est pas connecté", (final tester) async {
    setUpWidgets(tester);
    await ielLanceLapplication(tester);
    await ielVoitLeTexte(tester, Localisation.preOnboardingTitre);
  });

  testWidgets('Iel est connecté', (final tester) async {
    setUpWidgets(tester);
    await ielEstConnecte(tester);
    await ielLanceLapplication(tester);
    await ielVoitLeTexteDansTexteRiche(tester, Localisation.bonjour);
  });

  testWidgets("Iel lance l'application pour la première fois",
      (final tester) async {
    setUpWidgets(tester);
    await ielLanceLapplication(tester);
    await ielVoitLeTexte(tester, Localisation.preOnboardingTitre);
    await ielAppuieSur(tester, Localisation.commencer);
    await ielVoitLeTexteMarkdown(tester, Localisation.preOnboarding1);
    await ielGlisseDeLaDroiteVersLaGauche(tester);
    await ielVoitLeTexteMarkdown(tester, Localisation.preOnboarding2);
    await ielGlisseDeLaDroiteVersLaGauche(tester);
    await ielVoitLeTexteMarkdown(tester, Localisation.preOnboarding3);
    await ielGlisseDeLaDroiteVersLaGauche(tester);
    await ielVoitLeTexte(tester, Localisation.preOnboardingFinTitre);
  });

  testWidgets("Iel lance l'application pour la première fois et se connecte",
      (final tester) async {
    setUpWidgets(tester);
    await ielLanceLapplication(tester);
    await ielVoitLeTexte(tester, Localisation.preOnboardingTitre);
    await ielAppuieSur(tester, Localisation.commencer);
    await ielVoitLeTexteMarkdown(tester, Localisation.preOnboarding1);
    await ielGlisseDeLaDroiteVersLaGauche(tester);
    await ielVoitLeTexteMarkdown(tester, Localisation.preOnboarding2);
    await ielGlisseDeLaDroiteVersLaGauche(tester);
    await ielVoitLeTexteMarkdown(tester, Localisation.preOnboarding3);
    await ielGlisseDeLaDroiteVersLaGauche(tester);
    await ielAppuieSur(tester, Localisation.jaiDejaUnCompte);
    await ielVoitLeTexte(tester, Localisation.seConnecterAvecSonCompte);
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
    await ielVoitLeTexteDansTexteRiche(tester, Localisation.bonjour);
  });
}
