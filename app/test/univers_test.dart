import 'package:app/features/univers/domain/tuile_univers.dart';
import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/iel_a_debloque_ces_fonctionnalites.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_ne_voit_pas_l_icone.dart';
import 'steps/iel_ne_voit_pas_le_texte.dart';
import 'steps/iel_voit_l_icone.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/le_serveur_retourne_ces_univers.dart';

void main() {
  group('Accueil', () {
    testWidgets(
      "Iel n'a pas débloqué les univers alors iel ne les voit pas sur la page d'accueil",
      (final tester) async {
        setUpWidgets(tester);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        ielNeVoitPasLeTexte(Localisation.univers);
      },
    );

    testWidgets(
      "Iel a débloqué les univers alors iel voit le titre sur la page d'accueil",
      (final tester) async {
        setUpWidgets(tester);
        ielADebloqueCesFonctionnalites([Fonctionnalites.univers]);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        ielVoitLeTexte(Localisation.univers);
      },
    );

    testWidgets(
      "L'univers est verrouillé alors iel voit l'icône de verrouillage",
      (final tester) async {
        setUpWidgets(tester);
        ielADebloqueCesFonctionnalites([Fonctionnalites.univers]);
        const univers = TuileUnivers(
          titre: 'En cuisine',
          imageUrl: 'https://example.com/image.jpg',
          estVerrouille: true,
          estTerminee: false,
        );
        leServeurRetourneCesUnivers([univers]);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        ielVoitLeTexte(univers.titre);
        ielVoitLIcone(DsfrIcons.systemLockFill);
      },
    );

    testWidgets(
      "L'univers est déverrouillé alors iel ne voit pas l'icône de verrouillage",
      (final tester) async {
        setUpWidgets(tester);
        ielADebloqueCesFonctionnalites([Fonctionnalites.univers]);
        const univers = TuileUnivers(
          titre: 'En cuisine',
          imageUrl: 'https://example.com/image.jpg',
          estVerrouille: false,
          estTerminee: false,
        );
        leServeurRetourneCesUnivers([univers]);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        ielVoitLeTexte(univers.titre);
        ielNeVoitPasLIcone(DsfrIcons.systemLockFill);
      },
    );

    testWidgets(
      "L'univers est terminée alors iel ne voit le texte terminé",
      (final tester) async {
        setUpWidgets(tester);
        ielADebloqueCesFonctionnalites([Fonctionnalites.univers]);
        const univers = TuileUnivers(
          titre: 'En cuisine',
          imageUrl: 'https://example.com/image.jpg',
          estVerrouille: false,
          estTerminee: true,
        );
        leServeurRetourneCesUnivers([univers]);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        ielVoitLeTexte(univers.titre);
        ielNeVoitPasLIcone(DsfrIcons.systemLockFill);
        ielVoitLeTexte(Localisation.termine);
      },
    );
  });
}
