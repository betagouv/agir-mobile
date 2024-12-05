import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'set_up_widgets.dart';
import 'steps/iel_a_les_mission_suivantes.dart';
import 'steps/iel_a_les_recommandations_suivantes.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_ne_voit_pas_le_texte.dart';
import 'steps/iel_voit_le_texte.dart';

void main() {
  testWidgets('On va sur la page thématique', (final tester) async {
    await mockNetworkImages(() async {
      setUpWidgets(tester);
      ielEstConnecte();
      await ielLanceLapplication(tester);
      await tester.tap(find.text('Me nourrir').last);
      await tester.pumpAndSettle();
      ielVoitLeTexte('Me nourrir', n: 2);
    });
  });

  testWidgets(
    'On voit les missions pour la thématique',
    (final tester) async {
      await mockNetworkImages(() async {
        setUpWidgets(tester);
        const mission = MissionListe(
          code: 'manger_saison_1',
          titre: 'Pourquoi manger de saison ?',
          progression: 2,
          progressionCible: 8,
          estNouvelle: false,
          imageUrl:
              'https://res.cloudinary.com/dq023imd8/image/upload/v1718631224/fruits_1_dec0e90839.png',
          themeType: ThemeType.alimentation,
        );
        ielALesMissionsSuivantes([mission]);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        await tester.tap(find.text('Me nourrir').last);
        await tester.pumpAndSettle();
        ielVoitLeTexte(mission.titre);
      });
    },
  );

  testWidgets(
    'On voit les recommandations pour la thématique',
    (final tester) async {
      await mockNetworkImages(() async {
        setUpWidgets(tester);
        const recommandation = Recommandation(
          id: '42',
          type: TypeDuContenu.article,
          titre: 'Manger local, c’est bon pour la planète',
          sousTitre: null,
          imageUrl: 'https://example.com/image.jpg',
          points: 20,
          thematique: ThemeType.alimentation,
        );
        const recommandation2 = Recommandation(
          id: '43',
          type: TypeDuContenu.article,
          titre: 'Réchauffement et montée des eaux : quel est le lien ?',
          sousTitre: null,
          imageUrl: 'https://example.com/image.jpg',
          points: 20,
          thematique: ThemeType.decouverte,
        );
        ielALesRecommandationsSuivantes([recommandation, recommandation2]);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        await tester.tap(find.text('Me nourrir').last);
        await tester.pumpAndSettle();
        ielVoitLeTexte(recommandation.titre);
        ielNeVoitPasLeTexte(recommandation2.titre);
      });
    },
  );
}
