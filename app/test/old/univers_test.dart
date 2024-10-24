import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/univers/core/domain/mission_liste.dart';
import 'package:app/features/univers/core/domain/tuile_univers.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'set_up_widgets.dart';
import 'steps/iel_a_les_recommandations_suivantes.dart';
import 'steps/iel_a_les_univers_thematiques_suivantes.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_ne_voit_pas_le_texte.dart';
import 'steps/iel_scrolle.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/le_serveur_retourne_ces_univers.dart';

void main() {
  group('Accueil', () {
    testWidgets(
      "iel voit le titre sur la page d'accueil",
      (final tester) async {
        setUpWidgets(tester);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        ielVoitLeTexte(Localisation.univers);
      },
    );

    testWidgets(
      "L'univers est terminée alors iel voit le texte terminé",
      (final tester) async {
        await mockNetworkImages(() async {
          setUpWidgets(tester);
          const univers = TuileUnivers(
            type: 'alimentation',
            titre: 'En cuisine',
            imageUrl: 'https://example.com/image.jpg',
            estTerminee: true,
          );
          leServeurRetourneCesUnivers([univers]);
          ielEstConnecte();
          await ielLanceLapplication(tester);
          ielVoitLeTexte(univers.titre, n: 2);
          ielVoitLeTexte(Localisation.termine);
        });
      },
    );
  });

  testWidgets("On va sur la page d'univers", (final tester) async {
    await mockNetworkImages(() async {
      setUpWidgets(tester);
      const univers = TuileUnivers(
        type: 'alimentation',
        titre: 'Me nourrir',
        imageUrl: 'https://example.com/image.jpg',
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
    "On voit les thematiques pour l'univers",
    (final tester) async {
      await mockNetworkImages(() async {
        setUpWidgets(tester);
        const univers = TuileUnivers(
          type: 'alimentation',
          titre: 'Me nourrir',
          imageUrl: 'https://example.com/image.jpg',
          estTerminee: false,
        );
        const universThematique = MissionListe(
          id: 'manger_saison_1',
          titre: 'Pourquoi manger de saison ?',
          progression: 2,
          progressionCible: 8,
          estNouvelle: false,
          imageUrl:
              'https://res.cloudinary.com/dq023imd8/image/upload/v1718631224/fruits_1_dec0e90839.png',
          niveau: 1,
        );
        ielALesMissionsSuivantes([universThematique]);
        leServeurRetourneCesUnivers([univers]);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        await ielScrolle(tester, univers.titre);
        await ielAppuieSur(tester, univers.titre);
        ielVoitLeTexte(universThematique.titre);
      });
    },
  );

  testWidgets(
    "On voit les recommandations pour l'univers",
    (final tester) async {
      await mockNetworkImages(() async {
        setUpWidgets(tester);
        const univers = TuileUnivers(
          type: 'alimentation',
          titre: 'Me nourrir',
          imageUrl: 'https://example.com/image.jpg',
          estTerminee: false,
        );
        const recommandation = Recommandation(
          id: '42',
          type: TypeDuContenu.article,
          titre: 'Manger local, c’est bon pour la planète',
          sousTitre: null,
          imageUrl: 'https://example.com/image.jpg',
          points: 20,
          thematique: 'alimentation',
          thematiqueLabel: '🛒 Consommation durable',
        );
        const recommandation2 = Recommandation(
          id: '43',
          type: TypeDuContenu.article,
          titre: 'Réchauffement et montée des eaux : quel est le lien ?',
          sousTitre: null,
          imageUrl: 'https://example.com/image.jpg',
          points: 20,
          thematique: 'climat',
          thematiqueLabel: '☀️ Environnement',
        );
        ielALesRecommandationsSuivantes([recommandation, recommandation2]);
        leServeurRetourneCesUnivers([univers]);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        await ielScrolle(tester, univers.titre);
        await ielAppuieSur(tester, univers.titre);
        ielVoitLeTexte(recommandation.titre);
        ielNeVoitPasLeTexte(recommandation2.titre);
      });
    },
  );
}
