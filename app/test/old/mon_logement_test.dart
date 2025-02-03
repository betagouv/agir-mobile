import 'package:app/features/profil/logement/presentation/bloc/mon_logement_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'scenario_context.dart';
import 'set_up_widgets.dart';
import 'steps/iel_a_ces_informations_de_profile.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_appuie_sur_la_liste_deroulante.dart';
import 'steps/iel_ecrit_dans_le_champ.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_scrolle.dart';
import 'steps/iel_voit_le_bouton_radio_avec_ce_texte_selectionne.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/le_serveur_retourne_cette_liste_de_communes.dart';

const _codePostal = '39100';
const _commune = 'DOLE';
const _nombreAdultes = 2;
const _nombreEnfants = 1;

void main() {
  testWidgets('Voir tous les textes', (final tester) async {
    setUpWidgets(tester);
    leServeurRetourneCetteListeDeCommunes(['AUTHUME', _commune]);
    await _allerSurMonLogement(tester);
    ielVoitLeTexte(Localisation.monLogement);
    ielVoitLeTexte(Localisation.codePostal);
    ielVoitLeTexte(Localisation.commune);
    ielVoitLeTexte(Localisation.combienEtesVousDansVotreLogement);
    ielVoitLeTexte(Localisation.adultes);
    ielVoitLeTexte(Localisation.enfants);
    ielVoitLeTexte(Localisation.maResidencePrincipaleEst);
    ielVoitLeTexte(Localisation.unAppartement);
    ielVoitLeTexte(Localisation.uneMaison);
    await ielScrolle(tester, Localisation.vousEtesProprietaireDeVotreLogement);
    ielVoitLeTexte(Localisation.vousEtesProprietaireDeVotreLogement);
    ielVoitLeTexte(Localisation.oui, n: 2);
    ielVoitLeTexte(Localisation.non, n: 2);
    ielVoitLeTexte(Localisation.quelleEstLaSuperficie);
    ielVoitLeTexte(Localisation.moinsDe35m2);
    ielVoitLeTexte(Localisation.entre35et70m2);
    ielVoitLeTexte(Localisation.entre70et100m2);
    ielVoitLeTexte(Localisation.entre100et150m2);
    ielVoitLeTexte(Localisation.plusDe150m2);
    await ielScrolle(tester, Localisation.monLogementPlusDe15Ans);
    ielVoitLeTexte(Localisation.monLogementPlusDe15Ans);
    ielVoitLeTexte(Localisation.consommationsEnergetiques);
    ielVoitLeTexte(Localisation.dpeA);
    ielVoitLeTexte(Localisation.dpeB);
    ielVoitLeTexte(Localisation.dpeC);
    ielVoitLeTexte(Localisation.dpeD);
    ielVoitLeTexte(Localisation.dpeE);
    ielVoitLeTexte(Localisation.dpeF);
    ielVoitLeTexte(Localisation.dpeG);
    ielVoitLeTexte(Localisation.dpeJeNeSaisPas);
  });

  testWidgets('Iel voit les informations préremplis', (final tester) async {
    setUpWidgets(tester);
    leServeurRetourneCetteListeDeCommunes(['AUTHUME', _commune]);
    await _allerSurMonLogement(tester);
    ielVoitLeTexte(_codePostal);
    ielVoitLeTexte(_commune);
    ielVoitLeTexte(_nombreAdultes.toString());
    ielVoitLeTexte(_nombreEnfants.toString());
    await ielScrolle(tester, Localisation.maResidencePrincipaleEst);
    ielVoitLeBoutonRadioAvecCeTexteSelectionne(Localisation.uneMaison);
    ielVoitLeBoutonRadioAvecCeTexteSelectionne(Localisation.non);
    ielVoitLeBoutonRadioAvecCeTexteSelectionne(Localisation.entre70et100m2);
    await ielScrolle(tester, Localisation.monLogementPlusDe15Ans);
    ielVoitLeBoutonRadioAvecCeTexteSelectionne(Localisation.non);
    ielVoitLeBoutonRadioAvecCeTexteSelectionne(Localisation.dpeG);
  });

  testWidgets(
    'Iel rempli ces informations et appuie sur mettre à jour',
    (final tester) async {
      setUpWidgets(tester);
      const codePostal = '39100';
      const commune = 'CHOISEY';
      const nombreAdultes = 1;
      const nombreEnfants = 2;
      const typeDeLogement = TypeDeLogement.appartement;
      const estProprietaire = true;
      const superficie = Superficie.s35;
      const plusDe15Ans = true;
      const dpe = Dpe.c;
      leServeurRetourneCetteListeDeCommunes(['AUTHUME', _commune, commune]);
      await _allerSurMonLogement(tester);
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.codePostal,
        enterText: codePostal,
      );
      await ielAppuieSurLaListeDeroulante(tester);
      await ielAppuieSur(tester, commune);
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.adultes,
        enterText: nombreAdultes.toString(),
      );
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.enfants,
        enterText: nombreEnfants.toString(),
      );
      await ielScrolle(tester, Localisation.maResidencePrincipaleEst);
      await ielAppuieSur(tester, Localisation.unAppartement);
      await ielAppuieSur(tester, Localisation.oui);
      await ielAppuieSur(tester, Localisation.moinsDe35m2);

      await ielScrolle(tester, Localisation.monLogementPlusDe15Ans);
      await ielAppuieSur(tester, Localisation.oui);
      await ielScrolle(tester, Localisation.consommationsEnergetiques);
      await ielAppuieSur(tester, Localisation.dpeC);

      await ielAppuieSur(tester, Localisation.mettreAJourMesInformations);

      final profilPortMock = ScenarioContext().profilPortMock!;
      expect(profilPortMock.codePostal, codePostal);
      expect(profilPortMock.commune, commune);
      expect(profilPortMock.nombreAdultes, nombreAdultes);
      expect(profilPortMock.nombreEnfants, nombreEnfants);
      expect(profilPortMock.typeDeLogement, typeDeLogement);
      expect(profilPortMock.estProprietaire, estProprietaire);
      expect(profilPortMock.superficie, superficie);
      expect(profilPortMock.plusDe15Ans, plusDe15Ans);
      expect(profilPortMock.dpe, dpe);
    },
  );
}

Future<void> _allerSurMonLogement(final WidgetTester tester) async {
  ielACesInformationsDeProfil(
    codePostal: _codePostal,
    commune: _commune,
    nombreAdultes: _nombreAdultes,
    nombreEnfants: _nombreEnfants,
    typeDeLogement: TypeDeLogement.maison,
    estProprietaire: false,
    superficie: Superficie.s100,
    plusDe15Ans: false,
    dpe: Dpe.g,
  );
  ielEstConnecte();
  await ielLanceLapplication(tester);
  await ielAppuieSurAccessibilite(tester, Localisation.menu);
  await ielAppuieSur(tester, Localisation.monProfil);
  await ielAppuieSur(tester, Localisation.monLogement);
}
