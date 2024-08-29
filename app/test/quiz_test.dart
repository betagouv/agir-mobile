import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/quiz/domain/quiz.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'scenario_context.dart';
import 'set_up_widgets.dart';
import 'steps/iel_a_le_quiz_suivant.dart';
import 'steps/iel_a_les_recommandations_suivantes.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_voit_le_texte.dart';

void main() {
  testWidgets(
    'Iel voir un quiz après avoir cliqué sur une recommandation',
    (final tester) async {
      setUpWidgets(tester);
      const titre = 'Une assiette plus durable';

      const recommandation = Recommandation(
        id: '42',
        type: TypeDuContenu.quiz,
        titre: titre,
        sousTitre: null,
        imageUrl:
            'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1702068380/jonathan_ford_6_Zg_T_Etv_D16_I_unsplash_00217cb281.jpg',
        points: 20,
        thematique: Thematique.consommation,
        thematiqueLabel: '🛒 Consommation durable',
      );
      ielALesRecommandationsSuivantes([recommandation]);
      const question =
          'Quelle action est la plus efficace pour une alimentation plus durable ?';
      ielALeQuizSuivant(
        const Quiz(
          id: 42,
          thematique: '🥦 Alimentation',
          question: question,
          reponses: [
            QuizReponse(
              reponse: 'Manger moins de produits de saison',
              exact: false,
            ),
            QuizReponse(
              reponse: 'Diminuer la consommation de viande',
              exact: true,
            ),
            QuizReponse(
              reponse: 'Privilégier la volaille et le porc',
              exact: false,
            ),
            QuizReponse(reponse: 'Réduire ses déchets', exact: false),
          ],
          points: 5,
          explicationOk:
              '<p><span>Le secteur de l’élevage génère à lui seul près de 15 % des émissions mondiales de gaz à effet de serre. Réduire notre consommation de viande permet d’agir sur la production et de diminuer les impacts qui lui sont associés.<br><br>Pour rendre notre alimentation plus durable, on peut aussi privilégier les produits locaux, de saison et biologiques, limiter l’achat de produits transformés et réduire le gaspillage alimentaire.</span></p>',
          explicationKo:
              "<p><span>Au contraire ! Pour rendre notre alimentation plus durable, nous pouvons manger davantage de produits de saison et augmenter la part de repas végétariens dans les menus de la semaine. Diminuer notre consommation de viande permet en effet de réduire les impacts écologiques du secteur de l’élevage, qui génère à lui seul près de 15 % des émissions mondiales de gaz à effet de serre : c'est donc l'action la plus efficace pour limiter l'impact de notre alimentation.<br><br>On peut aussi privilégier les produits locaux et biologiques, limiter l’achat de produits transformés et réduire le gaspillage alimentaire.</span></p>",
          article: null,
        ),
      );
      ielEstConnecte();
      await ielLanceLapplication(tester);
      await ielAppuieSur(tester, recommandation.titre);
      ielVoitLeTexte(question);
    },
  );

  testWidgets(
    "La bonne réponse affiche l'explication ok",
    (final tester) async {
      setUpWidgets(tester);
      const titre = 'Une assiette plus durable';

      const recommandation = Recommandation(
        id: '42',
        type: TypeDuContenu.quiz,
        titre: titre,
        sousTitre: null,
        imageUrl:
            'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1702068380/jonathan_ford_6_Zg_T_Etv_D16_I_unsplash_00217cb281.jpg',
        points: 20,
        thematique: Thematique.consommation,
        thematiqueLabel: '🛒 Consommation durable',
      );
      ielALesRecommandationsSuivantes([recommandation]);
      const reponse = 'Diminuer la consommation de viande';
      ielALeQuizSuivant(
        const Quiz(
          id: 42,
          thematique: '🥦 Alimentation',
          question:
              'Quelle action est la plus efficace pour une alimentation plus durable ?',
          reponses: [
            QuizReponse(
              reponse: 'Manger moins de produits de saison',
              exact: false,
            ),
            QuizReponse(reponse: reponse, exact: true),
            QuizReponse(
              reponse: 'Privilégier la volaille et le porc',
              exact: false,
            ),
            QuizReponse(reponse: 'Réduire ses déchets', exact: false),
          ],
          points: 5,
          explicationOk:
              '<p><span>Le secteur de l’élevage génère à lui seul près de 15 % des émissions mondiales de gaz à effet de serre. Réduire notre consommation de viande permet d’agir sur la production et de diminuer les impacts qui lui sont associés.<br><br>Pour rendre notre alimentation plus durable, on peut aussi privilégier les produits locaux, de saison et biologiques, limiter l’achat de produits transformés et réduire le gaspillage alimentaire.</span></p>',
          explicationKo:
              "<p><span>Au contraire ! Pour rendre notre alimentation plus durable, nous pouvons manger davantage de produits de saison et augmenter la part de repas végétariens dans les menus de la semaine. Diminuer notre consommation de viande permet en effet de réduire les impacts écologiques du secteur de l’élevage, qui génère à lui seul près de 15 % des émissions mondiales de gaz à effet de serre : c'est donc l'action la plus efficace pour limiter l'impact de notre alimentation.<br><br>On peut aussi privilégier les produits locaux et biologiques, limiter l’achat de produits transformés et réduire le gaspillage alimentaire.</span></p>",
          article: null,
        ),
      );
      ielEstConnecte();
      await ielLanceLapplication(tester);
      await ielAppuieSur(tester, recommandation.titre);
      await ielAppuieSur(tester, reponse);
      await ielAppuieSur(tester, Localisation.valider);
      ielVoitLeTexte(Localisation.pourquoi);

      final quizPort = ScenarioContext().quizPortMock;
      expect(quizPort!.isTerminerQuizCalled, isTrue);
      expect(quizPort.isExact, isTrue);
    },
  );

  testWidgets(
    "Les mauvaises réponses affiche l'explication ko",
    (final tester) async {
      setUpWidgets(tester);
      const titre = 'Une assiette plus durable';

      const recommandation = Recommandation(
        id: '42',
        type: TypeDuContenu.quiz,
        titre: titre,
        sousTitre: null,
        imageUrl:
            'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1702068380/jonathan_ford_6_Zg_T_Etv_D16_I_unsplash_00217cb281.jpg',
        points: 20,
        thematique: Thematique.consommation,
        thematiqueLabel: '🛒 Consommation durable',
      );
      ielALesRecommandationsSuivantes([recommandation]);
      const reponse = 'Manger moins de produits de saison';
      ielALeQuizSuivant(
        const Quiz(
          id: 42,
          thematique: '🥦 Alimentation',
          question:
              'Quelle action est la plus efficace pour une alimentation plus durable ?',
          reponses: [
            QuizReponse(reponse: reponse, exact: false),
            QuizReponse(
              reponse: 'Diminuer la consommation de viande',
              exact: true,
            ),
            QuizReponse(
              reponse: 'Privilégier la volaille et le porc',
              exact: false,
            ),
            QuizReponse(reponse: 'Réduire ses déchets', exact: false),
          ],
          points: 5,
          explicationOk:
              '<p><span>Le secteur de l’élevage génère à lui seul près de 15 % des émissions mondiales de gaz à effet de serre. Réduire notre consommation de viande permet d’agir sur la production et de diminuer les impacts qui lui sont associés.<br><br>Pour rendre notre alimentation plus durable, on peut aussi privilégier les produits locaux, de saison et biologiques, limiter l’achat de produits transformés et réduire le gaspillage alimentaire.</span></p>',
          explicationKo:
              "<p><span>Au contraire ! Pour rendre notre alimentation plus durable, nous pouvons manger davantage de produits de saison et augmenter la part de repas végétariens dans les menus de la semaine. Diminuer notre consommation de viande permet en effet de réduire les impacts écologiques du secteur de l’élevage, qui génère à lui seul près de 15 % des émissions mondiales de gaz à effet de serre : c'est donc l'action la plus efficace pour limiter l'impact de notre alimentation.<br><br>On peut aussi privilégier les produits locaux et biologiques, limiter l’achat de produits transformés et réduire le gaspillage alimentaire.</span></p>",
          article: null,
        ),
      );
      ielEstConnecte();
      await ielLanceLapplication(tester);
      await ielAppuieSur(tester, recommandation.titre);
      await ielAppuieSur(tester, reponse);
      await ielAppuieSur(tester, Localisation.valider);
      ielVoitLeTexte(Localisation.pourquoi);

      final quizPort = ScenarioContext().quizPortMock;
      expect(quizPort!.isTerminerQuizCalled, isTrue);
      expect(quizPort.isExact, isFalse);
    },
  );
}
