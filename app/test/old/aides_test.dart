import 'package:app/features/assistances/core/domain/aide.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'set_up_widgets.dart';
import 'steps/iel_a_les_aides_suivantes.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_ne_voit_pas_le_texte.dart';
import 'steps/iel_scrolle.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/iel_voit_le_texte_dans_texte_riche.dart';

void main() {
  group('Aides', () {
    const aide1 = Assistance(
      titre: 'Rénover son logement',
      themeType: ThemeType.logement,
      contenu: '',
    );
    const aide2 = Assistance(
      titre: 'Acheter un vélo',
      themeType: ThemeType.transport,
      contenu: '<p>Contenu</p>',
      montantMax: 1500,
    );
    const aide3 = Assistance(
      titre: 'Composter ses déchets',
      themeType: ThemeType.consommation,
      contenu: '',
    );

    group('Accueil', () {
      testWidgets(
        "iel voit les 2 premieres sur la page d'accueil",
        (final tester) async {
          setUpWidgets(tester);
          await mockNetworkImages(() async {
            ielALesAidesSuivantes([aide1, aide2, aide3]);
            ielEstConnecte();
            await ielLanceLapplication(tester);
            await ielScrolle(tester, Localisation.mesAidesLien);
            ielVoitLeTexte(aide1.titre);
            ielVoitLeTexte(aide2.titre);
            ielNeVoitPasLeTexte(aide3.titre);
          });
        },
      );

      testWidgets(
        'iel clique sur la premiere aide alors iel arrive sur la page de détail',
        (final tester) async {
          setUpWidgets(tester);
          await mockNetworkImages(() async {
            ielALesAidesSuivantes([aide1, aide2, aide3]);
            ielEstConnecte();
            await ielLanceLapplication(tester);
            await ielScrolle(tester, Localisation.mesAidesLien);
            await ielAppuieSur(tester, aide2.titre);
            ielVoitLeTexte(aide2.titre);
            ielVoitLeTexteDansTexteRiche(Localisation.euro(aide2.montantMax!));
            ielVoitLeTexteDansTexteRiche('Contenu');
          });
        },
      );
    });
  });
}
