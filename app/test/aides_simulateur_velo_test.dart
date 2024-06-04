import 'package:app/src/fonctionnalites/aides/domain/aide.dart';
import 'package:app/src/fonctionnalites/utilisateur/domain/utilisateur.dart';
import 'package:app/src/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/steps.dart';

void main() {
  group('Aides Simulateur vélo', () {
    const aide2 = Aide(
      titre: 'Acheter un vélo',
      thematique: '🚗 Transports',
      montantMax: 1500,
      contenu: '<p>Contenu</p>',
      urlSimulateur: '/vos-aides/velo',
    );

    testWidgets("Iel voit le tag simulateur sur la page d'accueil",
        (final tester) async {
      setUpWidgets(tester);
      await ielADebloqueCesFonctionnalites(tester, [Fonctionnalites.aides]);
      await ielALesAidesSuivantes(tester, [aide2]);
      await ielEstConnecte(tester);
      await ielLanceLapplication(tester);
      await ielVoitLeTexteDansTexteRiche(tester, Localisation.simulateur);
    });

    testWidgets('Iel voit le tag simulateur sur la page des aides',
        (final tester) async {
      setUpWidgets(tester);
      await ielADebloqueCesFonctionnalites(tester, [Fonctionnalites.aides]);
      await ielALesAidesSuivantes(tester, [aide2]);
      await ielEstConnecte(tester);
      await ielLanceLapplication(tester);
      await ielAppuieSur(tester, Localisation.accueilMesAidesLien);
      await ielVoitLeTexteDansTexteRiche(tester, Localisation.simulateur);
    });

    testWidgets("Iel voit le tag simulateur sur la page de l'aide",
        (final tester) async {
      setUpWidgets(tester);
      await ielADebloqueCesFonctionnalites(tester, [Fonctionnalites.aides]);
      await ielALesAidesSuivantes(tester, [aide2]);
      await ielEstConnecte(tester);
      await ielLanceLapplication(tester);
      await ielAppuieSur(tester, Localisation.accueilMesAidesLien);
      await ielAppuieSur(tester, aide2.titre);
      await ielVoitLeTexteDansTexteRiche(tester, Localisation.simulateur);
      await ielVoitLeTexte(tester, Localisation.accederAuSimulateur);
    });

    testWidgets("Iel voit le tag simulateur sur la page de l'aide",
        (final tester) async {
      setUpWidgets(tester);
      await ielADebloqueCesFonctionnalites(tester, [Fonctionnalites.aides]);
      await ielALesAidesSuivantes(tester, [aide2]);
      await ielEstConnecte(tester);
      await ielLanceLapplication(tester);
      await ielAppuieSur(tester, Localisation.accueilMesAidesLien);
      await ielAppuieSur(tester, aide2.titre);
      await ielAppuieSur(tester, Localisation.accederAuSimulateur);
      await ielVoitLeTexte(tester, Localisation.simulerMonAide);
    });
  });
}
