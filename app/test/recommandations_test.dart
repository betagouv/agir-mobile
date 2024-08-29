import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/iel_a_les_recommandations_suivantes.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_voit_le_texte.dart';

void main() {
  group('Accueil', () {
    testWidgets(
      "Iel voit le titre sur la page d'accueil",
      (final tester) async {
        setUpWidgets(tester);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        ielVoitLeTexte(Localisation.accueilRecommandationsTitre);
      },
    );

    testWidgets(
      "Iel voit les recommandations sur la page d'accueil",
      (final tester) async {
        setUpWidgets(tester);
        const recommandation = Recommandation(
          id: '42',
          type: TypeDuContenu.article,
          titre: 'Réchauffement et montée des eaux : quel est le lien ?',
          sousTitre: null,
          imageUrl:
              'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1702068380/jonathan_ford_6_Zg_T_Etv_D16_I_unsplash_00217cb281.jpg',
          points: 20,
          thematique: Thematique.climat,
          thematiqueLabel: '🛒 Consommation durable',
        );
        ielALesRecommandationsSuivantes([recommandation]);
        ielEstConnecte();
        await ielLanceLapplication(tester);
        ielVoitLeTexte(recommandation.titre);
      },
    );
  });
}
