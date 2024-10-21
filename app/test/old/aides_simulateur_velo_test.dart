import 'package:app/features/aides/core/domain/aide.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/iel_a_les_aides_suivantes.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/iel_voit_le_texte_dans_texte_riche.dart';

void main() {
  group('Aides Simulateur vélo', () {
    const aide2 = Aid(
      titre: 'Acheter un vélo',
      thematique: '🚗 Transports',
      contenu: '<p>Contenu</p>',
      montantMax: 1500,
      urlSimulateur: '/aides/velo',
    );

    testWidgets(
      "Iel voit le tag simulateur sur la page d'accueil",
      (final tester) async {
        setUpWidgets(tester);
        ielALesAidesSuivantes([aide2]);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        ielVoitLeTexteDansTexteRiche(Localisation.simulateur);
      },
    );

    testWidgets(
      'Iel voit le tag simulateur sur la page des aides',
      (final tester) async {
        setUpWidgets(tester);
        ielALesAidesSuivantes([aide2]);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        await ielAppuieSur(tester, Localisation.mesAidesLien);
        ielVoitLeTexteDansTexteRiche(Localisation.simulateur);
      },
    );

    testWidgets(
      "Iel voit le tag simulateur sur la page de l'aide",
      (final tester) async {
        setUpWidgets(tester);
        ielALesAidesSuivantes([aide2]);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        await ielAppuieSur(tester, Localisation.mesAidesLien);
        await ielAppuieSur(tester, aide2.titre);
        ielVoitLeTexteDansTexteRiche(Localisation.simulateur);
        ielVoitLeTexte(Localisation.accederAuSimulateur);
      },
    );

    testWidgets(
      "Iel voit le bouton simuler mon aide sur la page de l'aide",
      (final tester) async {
        setUpWidgets(tester);
        ielALesAidesSuivantes([aide2]);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        await ielAppuieSur(tester, Localisation.mesAidesLien);
        await ielAppuieSur(tester, aide2.titre);
        await ielAppuieSur(tester, Localisation.accederAuSimulateur);
        ielVoitLeTexte(Localisation.simulerMonAide);
      },
    );
  });
}
