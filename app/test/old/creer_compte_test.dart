import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'scenario_context.dart';
import 'set_up_widgets.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_appuie_sur_la_liste_deroulante.dart';
import 'steps/iel_ecrit_dans_le_champ.dart';
import 'steps/iel_ecrit_le_code.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_n_a_pas_terminee_son_integration.dart';
import 'steps/iel_sappelle.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/iel_voit_le_texte_dans_texte_riche.dart';
import 'steps/le_serveur_retourne_ces_questions.dart';
import 'steps/le_serveur_retourne_cette_liste_de_communes.dart';

void main() {
  testWidgets(
    "Iel lance l'application pour la première fois et créer un compte",
    (final tester) async {
      setUpWidgets(tester);
      await mockNetworkImages(() async {
        const commune = 'DOLE';
        leServeurRetourneCetteListeDeCommunes(['AUTHUME', commune]);
        const response = "La cuisine et l'alimentation";
        leServeurRetourneCesQuestions([
          const QuestionMultipleChoice(
            id: QuestionCode('KYC_preference'),
            theme: ThemeType.decouverte,
            label:
                'Sur quels thèmes recherchez-vous en priorité des aides et conseils ?',
            isAnswered: false,
            responses: [
              ResponseChoice(code: '', label: response, isSelected: false),
              ResponseChoice(
                code: '',
                label: 'Mes déplacements',
                isSelected: false,
              ),
              ResponseChoice(
                code: '',
                label: 'Mon logement',
                isSelected: false,
              ),
              ResponseChoice(
                code: '',
                label: 'Ma consommation',
                isSelected: false,
              ),
              ResponseChoice(
                code: '',
                label: 'Je ne sais pas encore',
                isSelected: false,
              ),
            ],
            points: 5,
          ),
        ]);
        ielNAPasTermineeSonIntegration();
        const email = 'joe@doe.com';
        await _allerSurLaPageSaisieCode(tester, email: email);
        final authentificationPort =
            ScenarioContext().authentificationPortMock!;
        expect(authentificationPort.creerCompteAppele, true);
        ielVoitLeTexte(Localisation.entrezLeCodeRecuParMail);
        ielVoitLeTexte(Localisation.entrezLeCodeRecuParMailDetails(email));
        await ielEcritLeCode(tester, enterText: '123456');
        expect(authentificationPort.validationAppele, true);
        await tester.pumpAndSettle();
        await tester.pumpAndSettle();

        ielVoitLeTexte(Localisation.bienvenueSur);
        await ielEcritDansLeChamp(
          tester,
          label: Localisation.monPrenom,
          enterText: 'Lucas',
        );
        await tester.pumpAndSettle();

        ielVoitLeTexte(Localisation.enchanteDetails);
        await ielEcritDansLeChamp(
          tester,
          label: Localisation.codePostal,
          enterText: '39100',
        );
        await ielAppuieSurLaListeDeroulante(tester);
        await ielAppuieSur(tester, commune);
        await ielAppuieSur(tester, Localisation.continuer);

        ielVoitLeTexte(Localisation.appEstEncoreEnExperimentation);
        await ielAppuieSur(tester, Localisation.jaiCompris);

        ielVoitLeTexte(Localisation.cestPresqueTermine);
        await ielAppuieSur(tester, response);
        await ielAppuieSur(tester, Localisation.continuer);

        ielVoitLeTexte(Localisation.toutEstPret);
        await ielAppuieSur(tester, Localisation.cestParti);

        ielVoitLeTexteDansTexteRiche(Localisation.bonjour);
      });
    },
  );

  testWidgets('Iel demande de renvoyer le mail', (final tester) async {
    setUpWidgets(tester);
    await mockNetworkImages(() async {
      const email = 'joe@doe.com';
      await _allerSurLaPageSaisieCode(tester, email: email);
      await ielAppuieSur(tester, Localisation.renvoyerEmailDeConnexion);
      final authentificationPort = ScenarioContext().authentificationPortMock!;
      expect(authentificationPort.renvoyerCodeAppele, true);
      ielVoitLeTexte(Localisation.emailDeConnexionRenvoye);
    });
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

Future<void> _allerSurLaPageSaisieCode(
  final WidgetTester tester, {
  required final String email,
}) async {
  await _allerSurLaPageCreerCompte(tester);
  ielVoitLeTexte(Localisation.creerMonCompteApp);

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
  await tester.tap(
    find.bySemanticsLabel("J'accepte les conditions générales d'utilisation"),
  );
  await tester.pumpAndSettle();

  await ielAppuieSur(tester, Localisation.creerMonCompte);
}

Future<void> _allerSurLaPageCreerCompte(final WidgetTester tester) async {
  ielSappelle('');
  await ielLanceLapplication(tester);
  await ielAppuieSur(tester, Localisation.jeCreeMonCompte);
}
