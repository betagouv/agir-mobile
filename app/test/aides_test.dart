import 'package:app/src/fonctionnalites/aides/domain/aide.dart';
import 'package:app/src/fonctionnalites/utilisateur/domain/utilisateur.dart';
import 'package:app/src/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/steps.dart';

void main() {
  testWidgets(
      "Iel n'a pas débloqué les aides alors iel ne les voit pas sur la page d'accueil",
      (final tester) async {
    setUpWidgets(tester);
    await ielEstConnecte(tester);
    await ielLanceLapplication(tester);
    await ielNeVoitPasLeTexte(tester, Localisation.mesAides);
  });

  testWidgets(
      "Iel a débloqué les aides alors iel voit le titre sur la page d'accueil",
      (final tester) async {
    setUpWidgets(tester);
    await ielADebloqueCesFonctionnalites(tester, [Fonctionnalites.aides]);
    await ielEstConnecte(tester);
    await ielLanceLapplication(tester);
    await ielVoitLeTexte(tester, Localisation.mesAides);
  });

  testWidgets(
      "Iel a débloqué les aides alors iel voit les 2 premieres sur la page d'accueil",
      (final tester) async {
    setUpWidgets(tester);
    await ielADebloqueCesFonctionnalites(tester, [Fonctionnalites.aides]);
    const aide1 = 'Rénover son logement';
    const aide2 = 'Acheter un vélo';
    const aide3 = 'Composter ses déchets';
    await ielALesAidesSuivantes(
      tester,
      [
        const Aide(titre: aide1),
        const Aide(titre: aide2),
        const Aide(titre: aide3),
      ],
    );
    await ielEstConnecte(tester);
    await ielLanceLapplication(tester);
    await ielVoitLeTexte(tester, aide1);
    await ielVoitLeTexte(tester, aide2);
    await ielNeVoitPasLeTexte(tester, aide3);
  });
}
