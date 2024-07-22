import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/univers/domain/tuile_univers.dart';
import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'set_up_widgets.dart';
import 'steps/iel_a_debloque_ces_fonctionnalites.dart';
import 'steps/iel_a_les_recommandations_suivantes.dart';
import 'steps/iel_appuie_sur.dart';
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
        await mockNetworkImages(() async {
          setUpWidgets(tester);
          ielADebloqueCesFonctionnalites([Fonctionnalites.univers]);
          const univers = TuileUnivers(
            type: Thematique.alimentation,
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
        });
      },
    );

    testWidgets(
      "L'univers est déverrouillé alors iel ne voit pas l'icône de verrouillage",
      (final tester) async {
        await mockNetworkImages(() async {
          setUpWidgets(tester);
          ielADebloqueCesFonctionnalites([Fonctionnalites.univers]);
          const univers = TuileUnivers(
            type: Thematique.alimentation,
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
        });
      },
    );

    testWidgets(
      "L'univers est terminée alors iel ne voit le texte terminé",
      (final tester) async {
        await mockNetworkImages(() async {
          setUpWidgets(tester);
          ielADebloqueCesFonctionnalites([Fonctionnalites.univers]);
          const univers = TuileUnivers(
            type: Thematique.alimentation,
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
        });
      },
    );
  });

  testWidgets("On va sur la page d'univers", (final tester) async {
    await mockNetworkImages(() async {
      setUpWidgets(tester);
      ielADebloqueCesFonctionnalites([Fonctionnalites.univers]);
      const univers = TuileUnivers(
        type: Thematique.alimentation,
        titre: 'En cuisine',
        imageUrl: 'https://example.com/image.jpg',
        estVerrouille: true,
        estTerminee: false,
      );
      leServeurRetourneCesUnivers([univers]);
      ielEstConnecte();
      await ielLanceLapplication(tester);
      await ielAppuieSur(tester, univers.titre);
      ielVoitLeTexte(univers.titre);
    });
  });

  testWidgets(
    "On voit les recommandations pour l'univers",
    (final tester) async {
      await mockNetworkImages(() async {
        setUpWidgets(tester);
        ielADebloqueCesFonctionnalites(
          [Fonctionnalites.univers, Fonctionnalites.recommandations],
        );
        const univers = TuileUnivers(
          type: Thematique.alimentation,
          titre: 'En cuisine',
          imageUrl: 'https://example.com/image.jpg',
          estVerrouille: false,
          estTerminee: false,
        );
        const recommandation = Recommandation(
          id: '42',
          type: TypeDuContenu.article,
          titre: 'Manger local, c’est bon pour la planète',
          sousTitre: null,
          imageUrl: 'https://example.com/image.jpg',
          points: 20,
          thematique: Thematique.alimentation,
          thematiqueLabel: '🛒 Consommation durable',
        );
        const recommandation2 = Recommandation(
          id: '43',
          type: TypeDuContenu.article,
          titre: 'Réchauffement et montée des eaux : quel est le lien ?',
          sousTitre: null,
          imageUrl: 'https://example.com/image.jpg',
          points: 20,
          thematique: Thematique.climat,
          thematiqueLabel: '☀️ Environnement',
        );
        ielALesRecommandationsSuivantes([recommandation, recommandation2]);
        leServeurRetourneCesUnivers([univers]);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        await ielAppuieSur(tester, univers.titre);
        ielVoitLeTexte(recommandation.titre);
        ielNeVoitPasLeTexte(recommandation2.titre);
      });
    },
  );
}
