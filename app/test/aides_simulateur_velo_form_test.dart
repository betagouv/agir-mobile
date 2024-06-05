// ignore_for_file: avoid-missing-interpolation

import 'package:app/src/fonctionnalites/aides/domain/aide.dart';
import 'package:app/src/fonctionnalites/aides/domain/velo_pour_simulateur.dart';
import 'package:app/src/fonctionnalites/utilisateur/domain/utilisateur.dart';
import 'package:app/src/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'api/aide_velo_api_adapter_test.dart';
import 'scenario_context.dart';
import 'set_up_widgets.dart';
import 'steps/iel_a_debloque_ces_fonctionnalites.dart';
import 'steps/iel_a_les_aides_suivantes.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_appuie_sur_la_liste_deroulante.dart';
import 'steps/iel_appuie_sur_texte_comportant.dart';
import 'steps/iel_ecrit_dans_le_champ.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_scrolle.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/le_serveur_retourne_cette_liste_de_communes.dart';

void main() {
  group('Aides Simulateur vélo formulaire', () {
    const aide2 = Aide(
      titre: 'Acheter un vélo',
      thematique: '🚗 Transports',
      contenu: '<p>Contenu</p>',
      montantMax: 3500,
      urlSimulateur: '/vos-aides/velo',
    );
    const prixParDefaut = 1000;
    const codePostal = '39100';
    const commune = 'BAVERANS';
    const nombreDePart = 2.5;
    const revenuFiscal = 16000;

    testWidgets(
      'Iel voit le prix de 1000 euros par défaut',
      (final tester) async {
        setUpWidgets(tester);
        await _allerSurLeSimulateurVelo(tester, aide2);
        ielVoitLeTexte(prixParDefaut.toString());
      },
    );

    testWidgets(
      'Iel tape sur Vélo pliant standard pour changer le prix du vélo',
      (final tester) async {
        setUpWidgets(tester);
        await _allerSurLeSimulateurVelo(tester, aide2);
        ielVoitLeTexte(prixParDefaut.toString());
        await ielAppuieSurTexteComportant(
          tester,
          Localisation.veloLabel(VeloPourSimulateur.pliantStandard.label),
        );
        ielVoitLeTexte('500');
      },
    );

    testWidgets(
      'Taper le code postal met à jour la liste déroulante',
      (final tester) async {
        setUpWidgets(tester);
        leServeurRetourneCetteListeDeCommunes(['AUTHUME', commune]);
        await _allerSurLeSimulateurVelo(tester, aide2);
        await ielEcritDansLeChamp(
          tester,
          label: Localisation.codePostal,
          enterText: codePostal,
        );
        await ielAppuieSurLaListeDeroulante(tester);
        ielVoitLeTexte(commune);
      },
    );

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

        leServeurRetourneCetteListeDeCommunes(['AUTHUME', commune]);
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

        ielVoitLeTexte(Localisation.vosAidesDisponibles);
        ielVoitLeTexte(Localisation.aucuneAideDisponible, n: 2);
      },
    );
  });
}

Future<void> _allerSurLeSimulateurVelo(
  final WidgetTester tester,
  final Aide aide,
) async {
  ielADebloqueCesFonctionnalites([Fonctionnalites.aides]);
  ielALesAidesSuivantes([aide]);
  ielEstConnecte();
  await ielLanceLapplication(tester);
  await ielAppuieSur(tester, Localisation.accueilMesAidesLien);
  await ielAppuieSur(tester, aide.titre);
  await ielAppuieSur(tester, Localisation.accederAuSimulateur);
}
