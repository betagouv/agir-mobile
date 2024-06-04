import 'package:app/src/fonctionnalites/aides/domain/aide.dart';
import 'package:app/src/fonctionnalites/aides/domain/velo_pour_simulateur.dart';
import 'package:app/src/fonctionnalites/utilisateur/domain/utilisateur.dart';
import 'package:app/src/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'api/aide_velo_api_adapter_test.dart';
import 'scenario_context.dart';
import 'set_up_widgets.dart';
import 'steps/steps.dart';

void main() {
  group('Aides Simulateur vélo formulaire', () {
    const aide2 = Aide(
      titre: 'Acheter un vélo',
      thematique: '🚗 Transports',
      montantMax: 3500,
      contenu: '<p>Contenu</p>',
      urlSimulateur: '/vos-aides/velo',
    );
    const prixParDefaut = 1000;
    const codePostal = '39100';
    const commune = 'BAVERANS';
    const nombreDePart = 2.5;
    const revenuFiscal = 16000;

    testWidgets('Iel voit le prix de 1000 euros par défaut',
        (final tester) async {
      setUpWidgets(tester);
      await _allerSurLeSimulateurVelo(tester, aide2);
      await ielVoitLeTexte(tester, prixParDefaut.toString());
    });

    testWidgets(
        'Iel tape sur Vélo pliant standard pour changer le prix du vélo',
        (final tester) async {
      setUpWidgets(tester);
      await _allerSurLeSimulateurVelo(tester, aide2);
      await ielVoitLeTexte(tester, prixParDefaut.toString());
      await ielAppuieSurTexteComportant(
        tester,
        Localisation.veloLabel(VeloPourSimulateur.pliantStandard.label),
      );
      await ielVoitLeTexte(tester, '500');
    });

    testWidgets('Taper le code postal met à jour la liste déroulante',
        (final tester) async {
      setUpWidgets(tester);
      await leServeurRetourneCetteListeDeCommunes(tester, ['AUTHUME', commune]);
      await _allerSurLeSimulateurVelo(tester, aide2);
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.codePostal,
        enterText: codePostal,
      );
      await ielAppuieSurLaListeDeroulante(tester);
      await ielVoitLeTexte(tester, commune);
    });

    testWidgets(
        "Iel rempli le formulaire et iel demande l'estimation de l'aide alors il arrive sur la page des aides disponibles",
        (final tester) async {
      setUpWidgets(tester);
      when(
        () => ScenarioContext().aideVeloRepositoryMock.simuler(
              prix: any(named: 'prix'),
              codePostal: any(named: 'codePostal'),
              ville: any(named: 'ville'),
              nombreDePartsFiscales: any(named: 'nombreDePartsFiscales'),
              revenuFiscal: any(named: 'revenuFiscal'),
            ),
      ).thenAnswer((final invocation) async => aideVeloParType);

      await leServeurRetourneCetteListeDeCommunes(tester, ['AUTHUME', commune]);
      await _allerSurLeSimulateurVelo(tester, aide2);
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.codePostal,
        enterText: codePostal,
      );
      await ielAppuieSurLaListeDeroulante(tester);
      await ielAppuieSur(tester, commune);
      await ielScrolle(tester, Localisation.nombrePartsFiscales);
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.nombrePartsFiscales,
        enterText: nombreDePart.toString(),
      );
      await ielAppuieSur(tester, Localisation.tranche1);
      await ielAppuieSur(tester, Localisation.estimerMesAides);

      verify(
        () => ScenarioContext().aideVeloRepositoryMock.simuler(
              prix: prixParDefaut,
              codePostal: codePostal,
              ville: commune,
              nombreDePartsFiscales: nombreDePart,
              revenuFiscal: revenuFiscal,
            ),
      );

      await ielVoitLeTexte(tester, Localisation.vosAidesDisponibles);
      await ielVoitLeTexte(tester, Localisation.aucuneAideDisponible, n: 2);
    });
  });
}

Future<void> _allerSurLeSimulateurVelo(
  final WidgetTester tester,
  final Aide aide,
) async {
  await ielADebloqueCesFonctionnalites(tester, [Fonctionnalites.aides]);
  await ielALesAidesSuivantes(tester, [aide]);
  await ielEstConnecte(tester);
  await ielLanceLapplication(tester);
  await ielAppuieSur(tester, Localisation.accueilMesAidesLien);
  await ielAppuieSur(tester, aide.titre);
  await ielAppuieSur(tester, Localisation.accederAuSimulateur);
}
