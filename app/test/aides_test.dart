import 'package:app/src/fonctionnalites/aides/domain/aide.dart';
import 'package:app/src/fonctionnalites/utilisateur/domain/utilisateur.dart';
import 'package:app/src/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/steps.dart';

void main() {
  group('Aides', () {
    const aide1 = Aide(
      titre: 'Rénover son logement',
      thematique: '🏡 Logement',
      contenu: '',
    );
    const aide2 = Aide(
      titre: 'Acheter un vélo',
      thematique: '🚗 Transports',
      montantMax: 1500,
      contenu: '<p>Contenu</p>',
    );
    const aide3 = Aide(
      titre: 'Composter ses déchets',
      thematique: '🗑️ Déchets',
      contenu: '',
    );
    const aide4 = Aide(
      titre: 'Gérer ses déchets verts',
      thematique: '🗑️ Déchets',
      contenu: '',
    );

    group('Accueil', () {
      testWidgets(
          "Iel n'a pas débloqué les aides alors iel ne les voit pas sur la page d'accueil",
          (final tester) async {
        setUpWidgets(tester);
        await ielEstConnecte(tester);
        await ielLanceLapplication(tester);
        await ielNeVoitPasLeTexte(tester, Localisation.accueilMesAides);
      });

      testWidgets(
          "Iel a débloqué les aides alors iel voit le titre sur la page d'accueil",
          (final tester) async {
        setUpWidgets(tester);
        await ielADebloqueCesFonctionnalites(tester, [Fonctionnalites.aides]);
        await ielEstConnecte(tester);
        await ielLanceLapplication(tester);
        await ielVoitLeTexte(tester, Localisation.accueilMesAides);
      });

      testWidgets(
          "Iel a débloqué les aides alors iel voit les 2 premieres sur la page d'accueil",
          (final tester) async {
        setUpWidgets(tester);
        await ielADebloqueCesFonctionnalites(tester, [Fonctionnalites.aides]);
        await ielALesAidesSuivantes(tester, [aide1, aide2, aide3]);
        await ielEstConnecte(tester);
        await ielLanceLapplication(tester);
        await ielVoitLeTexte(tester, aide1.titre);
        await ielVoitLeTexte(tester, aide2.titre);
        await ielNeVoitPasLeTexte(tester, aide3.titre);
      });

      testWidgets(
          'Iel a débloqué les aides et iel clique sur la premiere aide alors iel arrive sur la page de détail',
          (final tester) async {
        setUpWidgets(tester);
        await ielADebloqueCesFonctionnalites(tester, [Fonctionnalites.aides]);
        await ielALesAidesSuivantes(tester, [aide1, aide2, aide3]);
        await ielEstConnecte(tester);
        await ielLanceLapplication(tester);
        await ielAppuieSur(tester, aide2.titre);
        await ielVoitLeTexte(tester, aide2.thematique);
        await ielVoitLeTexte(tester, aide2.titre);
        await ielVoitLeTexteDansTexteRiche(
          tester,
          Localisation.euro(aide2.montantMax!),
        );
        await ielVoitLeTexteDansTexteRiche(tester, 'Contenu');
      });
    });

    group('Vos aides', () {
      testWidgets('Iel a débloqué les aides alors iel voit toutes les aides',
          (final tester) async {
        setUpWidgets(tester);
        await ielADebloqueCesFonctionnalites(tester, [Fonctionnalites.aides]);
        await ielALesAidesSuivantes(tester, [aide1, aide2, aide3, aide4]);
        await ielEstConnecte(tester);
        await ielLanceLapplication(tester);
        await ielAppuieSur(tester, Localisation.accueilMesAidesLien);
        await ielVoitLeTexte(tester, Localisation.vosAidesTitre);

        await ielVoitLeTexte(tester, aide1.thematique);
        await ielVoitLeTexte(tester, aide1.titre);

        await ielVoitLeTexte(tester, aide2.thematique);
        await ielVoitLeTexte(tester, aide2.titre);

        await ielVoitLeTexte(tester, aide3.thematique);
        await ielVoitLeTexte(tester, aide3.titre);
        await ielVoitLeTexte(tester, aide4.titre);
      });
    });
  });
}
