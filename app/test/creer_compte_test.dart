import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'scenario_context.dart';
import 'set_up_widgets.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_ecrit_dans_le_champ.dart';
import 'steps/iel_ecrit_le_code.dart';
import 'steps/iel_glisse_de_la_droite_vers_la_gauche.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_n_a_pas_terminee_son_integration.dart';
import 'steps/iel_sappelle.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/iel_voit_le_texte_dans_texte_riche.dart';

void main() {
  testWidgets(
    "Iel lance l'application pour la première fois et créer un compte",
    (final tester) async {
      setUpWidgets(tester);
      ielNAPasTermineeSonIntegration();
      await _allerSurLaPageCreerCompte(tester);
      ielVoitLeTexte(Localisation.creezVotreCompte);
      const email = 'joe@doe.com';
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.adresseEmail,
        enterText: email,
      );
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.motDePasse,
        enterText: 'ceciEstUnMotDePasseValide!1',
      );
      await ielAppuieSur(tester, Localisation.creerMonCompte);
      final authentificationPort = ScenarioContext().authentificationPortMock!;
      expect(authentificationPort.creerCompteAppele, true);
      ielVoitLeTexte(Localisation.entrezLeCodeRecuParMail);
      ielVoitLeTexte(Localisation.entrezLeCodeRecuParMailDetails(email));
      await ielEcritLeCode(tester, enterText: '123456');
      expect(authentificationPort.validationAppele, true);
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      ielVoitLeTexte(Localisation.bienvenuSurAgir);
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.votrePrenom,
        enterText: 'Lucas',
      );
      await ielAppuieSur(tester, Localisation.continuer);
      ielVoitLeTexte(Localisation.enchanteDetails);
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.votreCodePostal,
        enterText: '39100',
      );
      await ielAppuieSur(tester, Localisation.continuer);
      ielVoitLeTexteDansTexteRiche(Localisation.bonjour);
    },
  );

  testWidgets('Iel demande de renvoyer le mail', (final tester) async {
    setUpWidgets(tester);
    await _allerSurLaPageCreerCompte(tester);
    ielVoitLeTexte(Localisation.creezVotreCompte);
    const email = 'joe@doe.com';
    await ielEcritDansLeChamp(
      tester,
      label: Localisation.adresseEmail,
      enterText: email,
    );
    await ielEcritDansLeChamp(
      tester,
      label: Localisation.motDePasse,
      enterText: 'ceciEstUnMotDePasseValide!1',
    );
    await ielAppuieSur(tester, Localisation.creerMonCompte);
    await ielAppuieSur(tester, Localisation.renvoyerEmailDeConnexion);
    final authentificationPort = ScenarioContext().authentificationPortMock!;
    expect(authentificationPort.renvoyerCodeAppele, true);
    ielVoitLeTexte(Localisation.emailDeConnexionRenvoye);
  });

  test('cacherEmail', () {
    expect(Localisation.cacherEmail('ml@mail.com'), equals('ml@mail.com'));
    expect(Localisation.cacherEmail('mail@mail.com'), equals('m**l@mail.com'));
    expect(
      Localisation.cacherEmail('email@mail.com'),
      equals('e***l@mail.com'),
    );
  });
}

Future<void> _allerSurLaPageCreerCompte(final WidgetTester tester) async {
  ielSappelle('');
  await ielLanceLapplication(tester);
  await ielAppuieSur(tester, Localisation.commencer);
  await ielGlisseDeLaDroiteVersLaGauche(tester);
  await ielGlisseDeLaDroiteVersLaGauche(tester);
  await ielGlisseDeLaDroiteVersLaGauche(tester);
  await ielAppuieSur(tester, Localisation.suivant);
}
