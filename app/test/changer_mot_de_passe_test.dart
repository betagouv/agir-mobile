import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter_test/flutter_test.dart';

import 'scenario_context.dart';
import 'set_up_widgets.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_ecrit_dans_le_champ.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_voit_le_message_de_formulaire.dart';

void main() {
  testWidgets(
    'Écrire un mot de passe et appuie sur Changer votre mot de passe',
    (final tester) async {
      setUpWidgets(tester);
      await _allerSurOptionsAvancees(tester);
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.motDePasse,
        enterText: 'ceciEstUnMotDePasseValide!1',
      );
      await ielAppuieSur(tester, Localisation.changerVotreMotDePasse);
      final profilPortMock = ScenarioContext().profilPortMock!;
      expect(profilPortMock.changerLeMotDePasseAppele, true);
    },
  );

  testWidgets(
    'Écrire un mot de passe invalide et appuie sur Changer votre mot de passe ne fait rien',
    (final tester) async {
      setUpWidgets(tester);
      await _allerSurOptionsAvancees(tester);
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.motDePasse,
        enterText: 'pasvalide',
      );
      await ielAppuieSur(tester, Localisation.changerVotreMotDePasse);
      final profilPortMock = ScenarioContext().profilPortMock!;
      expect(profilPortMock.changerLeMotDePasseAppele, false);
    },
  );

  testWidgets('a plus de 12 caractères', (final tester) async {
    setUpWidgets(tester);
    await _allerSurOptionsAvancees(tester);
    await ielEcritDansLeChamp(
      tester,
      label: Localisation.motDePasse,
      enterText: 'plusde12caracteres',
    );
    ielVoitLeMessageDeFormulaire(
      label: Localisation.motDePasse12CaractresMinimum,
      type: DsfrFormMessageType.valid,
    );
  });

  testWidgets("n'a pas plus de 12 caractères", (final tester) async {
    setUpWidgets(tester);
    await _allerSurOptionsAvancees(tester);
    await ielEcritDansLeChamp(
      tester,
      label: Localisation.motDePasse,
      enterText: 'moinsDe12',
    );
    ielVoitLeMessageDeFormulaire(
      label: Localisation.motDePasse12CaractresMinimum,
      type: DsfrFormMessageType.info,
    );
  });

  testWidgets('a au moins 1 majuscule et 1 minuscule', (final tester) async {
    setUpWidgets(tester);
    await _allerSurOptionsAvancees(tester);
    await ielEcritDansLeChamp(
      tester,
      label: Localisation.motDePasse,
      enterText: 'auMoins1MajusculeEt1Minuscule',
    );
    ielVoitLeMessageDeFormulaire(
      label: Localisation.motDePasse1MajusculeEt1Minuscule,
      type: DsfrFormMessageType.valid,
    );
  });

  testWidgets(
    "n'a pas au moins 1 majuscule et 1 minuscule",
    (final tester) async {
      setUpWidgets(tester);
      await _allerSurOptionsAvancees(tester);
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.motDePasse,
        enterText: 'pasdemajuscule',
      );
      ielVoitLeMessageDeFormulaire(
        label: Localisation.motDePasse1MajusculeEt1Minuscule,
        type: DsfrFormMessageType.info,
      );
    },
  );

  testWidgets('a 1 caractère spécial minimum', (final tester) async {
    setUpWidgets(tester);
    await _allerSurOptionsAvancees(tester);
    await ielEcritDansLeChamp(
      tester,
      label: Localisation.motDePasse,
      enterText: 'auMoins1CaractereSpecial!',
    );
    ielVoitLeMessageDeFormulaire(
      label: Localisation.motDePasse1CaractreSpecialMinimum,
      type: DsfrFormMessageType.valid,
    );
  });

  testWidgets("n'a pas 1 caractère spécial minimum", (final tester) async {
    setUpWidgets(tester);
    await _allerSurOptionsAvancees(tester);
    await ielEcritDansLeChamp(
      tester,
      label: Localisation.motDePasse,
      enterText: 'pasDeCaractereSpecial',
    );
    ielVoitLeMessageDeFormulaire(
      label: Localisation.motDePasse1CaractreSpecialMinimum,
      type: DsfrFormMessageType.info,
    );
  });

  testWidgets('a 1 chiffre minimum', (final tester) async {
    setUpWidgets(tester);
    await _allerSurOptionsAvancees(tester);
    await ielEcritDansLeChamp(
      tester,
      label: Localisation.motDePasse,
      enterText: 'auMoins1Chiffre',
    );
    ielVoitLeMessageDeFormulaire(
      label: Localisation.motDePasse1ChiffreMinimum,
      type: DsfrFormMessageType.valid,
    );
  });

  testWidgets("n'a pas 1 chiffre minimum", (final tester) async {
    setUpWidgets(tester);
    await _allerSurOptionsAvancees(tester);
    await ielEcritDansLeChamp(
      tester,
      label: Localisation.motDePasse,
      enterText: 'pasDeChiffre',
    );
    ielVoitLeMessageDeFormulaire(
      label: Localisation.motDePasse1ChiffreMinimum,
      type: DsfrFormMessageType.info,
    );
  });
}

Future<void> _allerSurOptionsAvancees(final WidgetTester tester) async {
  ielEstConnecte();
  await ielLanceLapplication(tester);
  await ielAppuieSurAccessibilite(tester, Localisation.menu);
  await ielAppuieSur(tester, Localisation.monProfil);
  await ielAppuieSur(tester, Localisation.optionsAvancees);
}
