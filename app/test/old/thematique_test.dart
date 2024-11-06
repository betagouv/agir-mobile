import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/core/domain/theme_tile.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'set_up_widgets.dart';
import 'steps/iel_a_les_recommandations_suivantes.dart';
import 'steps/iel_a_les_univers_thematiques_suivantes.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_ne_voit_pas_le_texte.dart';
import 'steps/iel_voit_le_texte.dart';
import 'steps/le_serveur_retourne_ces_univers.dart';

void main() {
  testWidgets('On va sur la page thématique', (final tester) async {
    await mockNetworkImages(() async {
      setUpWidgets(tester);
      const theme = ThemeTile(
        type: 'alimentation',
        title: 'En cuisine',
        imageUrl: 'https://example.com/image.jpg',
      );
      leServeurRetourneCesThematiques([theme]);
      ielEstConnecte();
      await ielLanceLapplication(tester);
      await tester.tap(find.text('Me nourrir'));
      await tester.pumpAndSettle();
      ielVoitLeTexte(theme.title);
    });
  });

  testWidgets(
    'On voit les missions pour la thématique',
    (final tester) async {
      await mockNetworkImages(() async {
        setUpWidgets(tester);
        const theme = ThemeTile(
          type: 'alimentation',
          title: 'Me nourrir',
          imageUrl: 'https://example.com/image.jpg',
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
          themeType: ThemeType.alimentation,
        );
        ielALesMissionsSuivantes([universThematique]);
        leServeurRetourneCesThematiques([theme]);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        await tester.tap(find.text(theme.title));
        await tester.pumpAndSettle();
        ielVoitLeTexte(universThematique.titre);
      });
    },
  );

  testWidgets(
    'On voit les recommandations pour la thématique',
    (final tester) async {
      await mockNetworkImages(() async {
        setUpWidgets(tester);
        const theme = ThemeTile(
          type: 'alimentation',
          title: 'Me nourrir',
          imageUrl: 'https://example.com/image.jpg',
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
        leServeurRetourneCesThematiques([theme]);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        await tester.tap(find.text(theme.title));
        await tester.pumpAndSettle();
        ielVoitLeTexte(recommandation.titre);
        ielNeVoitPasLeTexte(recommandation2.titre);
      });
    },
  );
}
