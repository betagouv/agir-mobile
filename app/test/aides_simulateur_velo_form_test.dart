// ignore_for_file: avoid-missing-interpolation

import 'package:app/src/fonctionnalites/aides/domain/aide.dart';
import 'package:app/src/fonctionnalites/aides/domain/aide_velo_informations.dart';
import 'package:app/src/fonctionnalites/aides/domain/velo_pour_simulateur.dart';
import 'package:app/src/fonctionnalites/utilisateur/domain/utilisateur.dart';
import 'package:app/src/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'api/aide_velo_api_adapter_test.dart';
import 'scenario_context.dart';
import 'set_up_widgets.dart';
import 'steps/iel_a_ces_informations_de_profile.dart';
import 'steps/iel_a_debloque_ces_fonctionnalites.dart';
import 'steps/iel_a_les_aides_suivantes.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_appuie_sur_la_liste_deroulante.dart';
import 'steps/iel_appuie_sur_texte_comportant.dart';
import 'steps/iel_ecrit_dans_le_champ.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_ne_voit_pas_le_texte.dart';
import 'steps/iel_scrolle.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/iel_voit_le_texte_dans_texte_riche.dart';
import 'steps/le_serveur_retourne_cette_liste_de_communes.dart';
import 'steps/le_serveur_retourne_les_aides_velo_par_type.dart';

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
    const commune = 'DOLE';
    const nombreDePart = 2.5;
    const revenuFiscal = 16000;
    const tranche = Localisation.tranche1;

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
        await ielScrolle(tester, Localisation.modifier);
        await ielAppuieSurTexteComportant(tester, Localisation.modifier);
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
      'Taper le code postal, si une seule commune on la choisi directement',
      (final tester) async {
        setUpWidgets(tester);
        leServeurRetourneCetteListeDeCommunes([commune]);
        await _allerSurLeSimulateurVelo(tester, aide2);
        await ielScrolle(tester, Localisation.modifier);
        await ielAppuieSurTexteComportant(tester, Localisation.modifier);
        await ielEcritDansLeChamp(
          tester,
          label: Localisation.codePostal,
          enterText: codePostal,
        );
        ielVoitLeTexte(commune);
      },
    );

    testWidgets(
      "Iel rempli le formulaire et iel demande l'estimation de l'aide alors il arrive sur la page des aides disponibles",
      (final tester) async {
        setUpWidgets(tester);

        leServeurRetourneLesAidesVeloParType(aideVeloParType);
        leServeurRetourneCetteListeDeCommunes(['AUTHUME', commune]);
        await _allerSurLeSimulateurVelo(tester, aide2);
        await ielScrolle(tester, Localisation.modifier);
        await ielAppuieSurTexteComportant(tester, Localisation.modifier);
        await ielEcritDansLeChamp(
          tester,
          label: Localisation.codePostal,
          enterText: codePostal,
        );
        await ielAppuieSurLaListeDeroulante(tester);
        await ielAppuieSur(tester, commune);
        await ielScrolle(tester, Localisation.nombreDePartsFiscales);
        await ielEcritDansLeChamp(
          tester,
          label: Localisation.nombreDePartsFiscales,
          enterText: nombreDePart.toString(),
        );
        await ielAppuieSur(tester, tranche);
        await ielAppuieSur(tester, Localisation.estimerMesAides);

        final aideVeloRepositoryMock = ScenarioContext().aideVeloRepositoryMock;
        expect(aideVeloRepositoryMock!.prix, prixParDefaut);
        expect(aideVeloRepositoryMock.codePostal, codePostal);
        expect(aideVeloRepositoryMock.ville, commune);
        expect(aideVeloRepositoryMock.nombreDePartsFiscales, nombreDePart);
        expect(aideVeloRepositoryMock.revenuFiscal, revenuFiscal);

        ielVoitLeTexte(Localisation.vosAidesDisponibles);
        ielVoitLeTexte(Localisation.aucuneAideDisponible, n: 2);
      },
    );

    testWidgets(
      'Iel met le prix à 0 euros alors le bouton estimer mes aides est désactiver',
      (final tester) async {
        await _allerSurLeSimulateurVelo(tester, aide2);
        await ielEcritDansLeChamp(
          tester,
          label: Localisation.prixDuVelo,
          enterText: '',
        );
        await ielAppuieSur(tester, Localisation.estimerMesAides);
        ielNeVoitPasLeTexte(Localisation.vosAidesDisponibles);
      },
    );

    testWidgets(
      'Iel arrive sur la page avec les informations déjà renseignées',
      (final tester) async {
        ielACesInformationsDeProfile(
          const AideVeloInformations(
            codePostal: codePostal,
            ville: commune,
            nombreDePartsFiscales: nombreDePart,
            revenuFiscal: revenuFiscal,
          ),
        );
        await _allerSurLeSimulateurVelo(tester, aide2);
        await ielScrolle(tester, Localisation.modifier);
        ielVoitLeTexte(Localisation.elementsNecessaireAuCalcul);
        ielVoitLeTexteDansTexteRiche(
          Localisation.donneesUtiliseesCodePostalEtVille(
            codePostal: codePostal,
            ville: commune,
          ),
        );
        ielVoitLeTexteDansTexteRiche(
          Localisation.donneesUtiliseesNombreDeParts(nombreDePart),
        );
        ielVoitLeTexteDansTexteRiche(
          Localisation.donneesUtiliseesRevenuFiscal(tranche),
        );
      },
    );

    testWidgets(
      'Iel veut modifier ces informations, les données sont préremplis',
      (final tester) async {
        ielACesInformationsDeProfile(
          const AideVeloInformations(
            codePostal: codePostal,
            ville: commune,
            nombreDePartsFiscales: nombreDePart,
            revenuFiscal: revenuFiscal,
          ),
        );
        await _allerSurLeSimulateurVelo(tester, aide2);
        await ielScrolle(tester, Localisation.modifier);
        await ielAppuieSurTexteComportant(tester, Localisation.modifier);
        ielVoitLeTexteDansTexteRiche(codePostal);
        ielVoitLeTexteDansTexteRiche(commune);
        ielVoitLeTexteDansTexteRiche('$nombreDePart');
        ielVoitLeTexteDansTexteRiche(commune);
        ielVoitLeTexteDansTexteRiche(tranche);
      },
    );

    testWidgets(
      'Iel modifie le code postal alors la ville est réinitialisé',
      (final tester) async {
        leServeurRetourneCetteListeDeCommunes(['AUTHUME', commune]);
        ielACesInformationsDeProfile(
          const AideVeloInformations(
            codePostal: codePostal,
            ville: commune,
            nombreDePartsFiscales: nombreDePart,
            revenuFiscal: revenuFiscal,
          ),
        );
        await _allerSurLeSimulateurVelo(tester, aide2);
        await ielScrolle(tester, Localisation.modifier);
        await ielAppuieSurTexteComportant(tester, Localisation.modifier);
        await ielEcritDansLeChamp(
          tester,
          label: Localisation.codePostal,
          enterText: '3910',
        );
        ielNeVoitPasLeTexte(commune);
      },
    );

    testWidgets(
      "Après avoir clique sur modifier il retourne sur la page de l'aide et reclique sur accéder au simulateur, la page doit être réinitialisée",
      (final tester) async {
        ielACesInformationsDeProfile(
          const AideVeloInformations(
            codePostal: codePostal,
            ville: commune,
            nombreDePartsFiscales: nombreDePart,
            revenuFiscal: revenuFiscal,
          ),
        );
        await _allerSurLeSimulateurVelo(tester, aide2);
        await ielScrolle(tester, Localisation.modifier);
        await ielAppuieSurTexteComportant(tester, Localisation.modifier);
        await ielAppuieSurAccessibilite(tester, Localisation.retour);
        await ielAppuieSur(tester, Localisation.accederAuSimulateur);
        await ielScrolle(tester, Localisation.modifier);
        ielVoitLeTexteDansTexteRiche(Localisation.modifier);
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
