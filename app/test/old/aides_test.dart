import 'package:app/features/aides/core/domain/aide.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/iel_a_les_aides_suivantes.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_ne_voit_pas_le_texte.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/iel_voit_le_texte_dans_texte_riche.dart';

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
      contenu: '<p>Contenu</p>',
      montantMax: 1500,
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
        "iel voit le titre sur la page d'accueil",
        (final tester) async {
          setUpWidgets(tester);
          ielEstConnecte();
          await ielLanceLapplication(tester);
          ielVoitLeTexte(Localisation.mesAides);
        },
      );

      testWidgets(
        "iel voit les 2 premieres sur la page d'accueil",
        (final tester) async {
          setUpWidgets(tester);
          ielALesAidesSuivantes([aide1, aide2, aide3]);
          ielEstConnecte();
          await ielLanceLapplication(tester);
          ielVoitLeTexte(aide1.titre);
          ielVoitLeTexte(aide2.titre);
          ielNeVoitPasLeTexte(aide3.titre);
        },
      );

      testWidgets(
        'iel clique sur la premiere aide alors iel arrive sur la page de détail',
        (final tester) async {
          setUpWidgets(tester);
          ielALesAidesSuivantes([aide1, aide2, aide3]);
          ielEstConnecte();
          await ielLanceLapplication(tester);
          await ielAppuieSur(tester, aide2.titre);
          ielVoitLeTexte(aide2.thematique);
          ielVoitLeTexte(aide2.titre);
          ielVoitLeTexteDansTexteRiche(Localisation.euro(aide2.montantMax!));
          ielVoitLeTexteDansTexteRiche('Contenu');
        },
      );
    });

    group('Vos aides', () {
      testWidgets('iel voit toutes les aides', (final tester) async {
        setUpWidgets(tester);
        ielALesAidesSuivantes([aide1, aide2, aide3, aide4]);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        await ielAppuieSur(tester, Localisation.mesAidesLien);
        ielVoitLeTexte(Localisation.mesAidesDisponibles);

        ielVoitLeTexte(aide1.thematique);
        ielVoitLeTexte(aide1.titre);

        ielVoitLeTexte(aide2.thematique);
        ielVoitLeTexte(aide2.titre);

        ielVoitLeTexte(aide3.thematique);
        ielVoitLeTexte(aide3.titre);
        ielVoitLeTexte(aide4.titre);
      });
    });
  });
}
