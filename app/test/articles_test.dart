import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/iel_a_debloque_ces_fonctionnalites.dart';
import 'steps/iel_a_l_article_suivant.dart';
import 'steps/iel_a_les_recommandations_suivantes.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_voit_le_texte.dart';

void main() {
  testWidgets(
    'Iel peut lire un article après avoir cliqué sur une recommandation',
    (final tester) async {
      setUpWidgets(tester);
      ielADebloqueCesFonctionnalites([Fonctionnalites.recommandations]);
      const titre = 'Recette : velouté crémeux de patates douces';
      const sousTitre = "Une recette cocooning pour l'hiver";

      const recommandation = Recommandation(
        id: '42',
        type: TypeDuContenu.article,
        titre: titre,
        imageUrl:
            'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1702068380/jonathan_ford_6_Zg_T_Etv_D16_I_unsplash_00217cb281.jpg',
        points: 20,
        thematique: Thematique.climat,
      );
      ielALesRecommandationsSuivantes([recommandation]);
      ielALArticleSuivant(
        const Article(
          titre: titre,
          sousTitre: sousTitre,
          contenu:
              "<h2>Ingrédients</h2><p><strong><span>Pour 4 personnes</span></strong></p><ul><li><p><span>700g de patates douces</span></p></li><li><p><span>300g de carottes</span></p></li><li><p><span>1 gros oignon</span></p></li><li><p><span>400ml de lait de coco</span></p></li><li><p><span>2 cuillères à soupe d'épices en poudre (curry, cumin, curcuma...)</span></p></li><li><p><span>Huile d'olive</span></p></li><li><p><span>Sel et poivre</span></p></li></ul><h2><span>Préparation</span></h2><ol><li><p><span>Émincer l'oignon et le faire revenir dans une cocotte avec un peu d'huile d'olive</span></p></li><li><p><span>Éplucher les patates douces, laver et éplucher les carottes. Les couper en gros morceaux et verser le tout dans la cocotte. Recouvrir d'un litre d'eau bouillante et laisser cuire à feu moyen pendant 15 à 20 minutes.</span></p></li><li><p><span>Mixer à l'aide d'un mixeur plongeant, dans un blender ou un robot.</span></p></li><li><p><span>Ajouter le lait de coco et les épices. Mixer de nouveau. Saler et poivrer.</span></p></li></ol>",
          partenaire: Partenaire(
            nom: 'ADEME',
            logo:
                'https://res.cloudinary.com/dq023imd8/image/upload/v1701947358/Logo_Ademe_2020_c234624ba3.jpg',
          ),
        ),
      );
      ielEstConnecte();
      await ielLanceLapplication(tester);
      await ielAppuieSur(tester, recommandation.titre);
      ielVoitLeTexte(sousTitre);
    },
  );
}
