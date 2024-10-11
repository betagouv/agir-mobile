import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/quiz/domain/quiz.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'scenario_context.dart';
import 'set_up_widgets.dart';
import 'steps/iel_a_le_quiz_suivant.dart';
import 'steps/iel_a_les_recommandations_suivantes.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_scrolle.dart';
import 'steps/iel_voit_le_texte.dart';

void main() {
  testWidgets(
    'Iel voir un quiz après avoir cliqué sur une recommandation',
    (final tester) async {
      setUpWidgets(tester);

      await mockNetworkImages(() async {
        const titre = 'Une assiette plus durable';

        const recommandation = Recommandation(
          id: '42',
          type: TypeDuContenu.quiz,
          titre: titre,
          sousTitre: null,
          imageUrl:
              'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1702068380/jonathan_ford_6_Zg_T_Etv_D16_I_unsplash_00217cb281.jpg',
          points: 20,
          thematique: 'consommation',
          thematiqueLabel: '🛒 Consommation durable',
        );
        ielALesRecommandationsSuivantes([recommandation]);
        const question =
            'Quelle action est la plus efficace pour une alimentation plus durable ?';
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
        await ielScrolle(tester, recommandation.titre);
        await ielAppuieSur(tester, recommandation.titre);
        ielVoitLeTexte(question);
      });
    },
  );

  testWidgets(
    "La bonne réponse affiche l'explication ok",
    (final tester) async {
      setUpWidgets(tester);
      await mockNetworkImages(() async {
        const titre = 'Une assiette plus durable';

        const recommandation = Recommandation(
          id: '42',
          type: TypeDuContenu.quiz,
          titre: titre,
          sousTitre: null,
          imageUrl:
              'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1702068380/jonathan_ford_6_Zg_T_Etv_D16_I_unsplash_00217cb281.jpg',
          points: 20,
          thematique: 'consommation',
          thematiqueLabel: '🛒 Consommation durable',
        );
        ielALesRecommandationsSuivantes([recommandation]);
        const reponse = 'Diminuer la consommation de viande';
        ielALeQuizSuivant(
          const Quiz(
            id: 42,
            thematique: '🥦 Alimentation',
            question:
                'Quelle action est la plus efficace pour une alimentation plus durable ?',
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
            article: Article(
              id: '2',
              titre: "Comprendre le concept d'empreinte carbone en 2 minutes",
              sousTitre: "L'empreinte que nous laissons derrière nous",
              contenu:
                  "<p>Que l’on se rende dans un magasin de quartier pour faire ses courses, qu’on allume la lumière ou qu’on chauffe son logement, l’ensemble de nos actions quotidiennes a un impact sur l’environnement. Cet impact, c’est ce que l’on appelle l’<strong>empreinte carbone</strong>, comme une trace invisible que nous laissons derrière nous.</p><p>Elle mesure la quantité totale de gaz à effet de serre (dioxyde de carbone (CO2), protoxyde d'azote, méthane, ...) liés à notre consommation et permet donc de quantifier nos émissions selon notre mode de vie. Elle peut concerner les émissions d’un individu (son mode de vie), d’une entreprise (ses activités) ou d’une population, d'un territoire.</p><ul><li><p>Au niveau des entreprises, la loi Grenelle II impose depuis juillet 2020 le Bilan GES Réglementaire à un nombre de structures publiques et privées. Cela concerne les entreprises publiques de plus de 250 personnes, 500 personnes pour les privées (250 en outre-mer), les collectivités de plus de 50 000 habitants et l’État.</p></li><li><p>A l'échelle du pays, l'empreinte carbone moyenne d'un Français est estimée à <strong>8,9 tonnes d'équivalent CO2</strong> en 2021. Or, pour respecter les objectifs de l’Accord de Paris et maintenir le réchauffement planétaire sous les 2°C, il nous faudrait réduire ce nombre à <strong>deux tonnes</strong>, autrement dit : le diviser presque par cinq !</p></li></ul><p><em>Pour en savoir plus sur l'empreinte carbone de la France, </em><a target=\"_self\" rel=\"\" href=\"/article/L'empreinte carbone de la France/11\"><em>c'est par ici.</em></a></p><h2>Comment connaître votre empreinte carbone ?</h2><p>L’empreinte carbone se calcule aussi au niveau individuel, et elle dépend directement d’un ensemble d’activités que nous effectuons quotidiennement. Calculer son empreinte carbone, c'est prendre conscience de ses activités quotidiennes et de leurs conséquences pour l'environnement.</p><p>On peut ainsi cibler les activités les plus polluantes et ajuster nos usages et nos habitudes de consommation pour diminuer notre impact. Faites le bilan avec le calculateur de l'Ademe : <a target=\"_blank\" rel=\"\" class=\"in-cell-link\" href=\"https://nosgestesclimat.fr/\"><span style=\"color: rgb(17, 85, 204)\">Nos Gestes Climat</span></a>.</p>",
              partenaire: null,
              sources: [],
              isFavorite: false,
              isRead: true,
            ),
          ),
        );
        ielEstConnecte();
        await ielLanceLapplication(tester);
        await ielScrolle(tester, recommandation.titre);
        await ielAppuieSur(tester, recommandation.titre);
        await ielAppuieSur(tester, reponse);
        await ielAppuieSur(tester, Localisation.valider);
        ielVoitLeTexte(Localisation.pourquoi);

        final quizPort = ScenarioContext().quizPortMock;
        expect(quizPort!.isTerminerQuizCalled, isTrue);
        expect(quizPort.isExact, isTrue);
        final articlesPort = ScenarioContext().articlesPortMock;
        expect(articlesPort!.estMarquerCommeLuAppele, isTrue);
      });
    },
  );

  testWidgets(
    "N'appelle pas la fonction marquerCommeLu si l'article n'est pas présent",
    (final tester) async {
      setUpWidgets(tester);
      await mockNetworkImages(() async {
        const titre = 'Une assiette plus durable';

        const recommandation = Recommandation(
          id: '42',
          type: TypeDuContenu.quiz,
          titre: titre,
          sousTitre: null,
          imageUrl:
              'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1702068380/jonathan_ford_6_Zg_T_Etv_D16_I_unsplash_00217cb281.jpg',
          points: 20,
          thematique: 'consommation',
          thematiqueLabel: '🛒 Consommation durable',
        );
        ielALesRecommandationsSuivantes([recommandation]);
        const reponse = 'Diminuer la consommation de viande';
        ielALeQuizSuivant(
          const Quiz(
            id: 42,
            thematique: '🥦 Alimentation',
            question:
                'Quelle action est la plus efficace pour une alimentation plus durable ?',
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
        await ielScrolle(tester, recommandation.titre);
        await ielAppuieSur(tester, recommandation.titre);
        await ielAppuieSur(tester, reponse);
        await ielAppuieSur(tester, Localisation.valider);
        ielVoitLeTexte(Localisation.pourquoi);

        final quizPort = ScenarioContext().quizPortMock;
        expect(quizPort!.isTerminerQuizCalled, isTrue);
        expect(quizPort.isExact, isTrue);
        final articlesPort = ScenarioContext().articlesPortMock;
        expect(articlesPort!.estMarquerCommeLuAppele, isFalse);
      });
    },
  );

  testWidgets(
    "Les mauvaises réponses affiche l'explication ko",
    (final tester) async {
      setUpWidgets(tester);
      await mockNetworkImages(() async {
        const titre = 'Une assiette plus durable';

        const recommandation = Recommandation(
          id: '42',
          type: TypeDuContenu.quiz,
          titre: titre,
          sousTitre: null,
          imageUrl:
              'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1702068380/jonathan_ford_6_Zg_T_Etv_D16_I_unsplash_00217cb281.jpg',
          points: 20,
          thematique: 'consommation',
          thematiqueLabel: '🛒 Consommation durable',
        );
        ielALesRecommandationsSuivantes([recommandation]);
        const reponse = 'Manger moins de produits de saison';
        ielALeQuizSuivant(
          const Quiz(
            id: 42,
            thematique: '🥦 Alimentation',
            question:
                'Quelle action est la plus efficace pour une alimentation plus durable ?',
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
            article: Article(
              id: '2',
              titre: "Comprendre le concept d'empreinte carbone en 2 minutes",
              sousTitre: "L'empreinte que nous laissons derrière nous",
              contenu:
                  "<p>Que l’on se rende dans un magasin de quartier pour faire ses courses, qu’on allume la lumière ou qu’on chauffe son logement, l’ensemble de nos actions quotidiennes a un impact sur l’environnement. Cet impact, c’est ce que l’on appelle l’<strong>empreinte carbone</strong>, comme une trace invisible que nous laissons derrière nous.</p><p>Elle mesure la quantité totale de gaz à effet de serre (dioxyde de carbone (CO2), protoxyde d'azote, méthane, ...) liés à notre consommation et permet donc de quantifier nos émissions selon notre mode de vie. Elle peut concerner les émissions d’un individu (son mode de vie), d’une entreprise (ses activités) ou d’une population, d'un territoire.</p><ul><li><p>Au niveau des entreprises, la loi Grenelle II impose depuis juillet 2020 le Bilan GES Réglementaire à un nombre de structures publiques et privées. Cela concerne les entreprises publiques de plus de 250 personnes, 500 personnes pour les privées (250 en outre-mer), les collectivités de plus de 50 000 habitants et l’État.</p></li><li><p>A l'échelle du pays, l'empreinte carbone moyenne d'un Français est estimée à <strong>8,9 tonnes d'équivalent CO2</strong> en 2021. Or, pour respecter les objectifs de l’Accord de Paris et maintenir le réchauffement planétaire sous les 2°C, il nous faudrait réduire ce nombre à <strong>deux tonnes</strong>, autrement dit : le diviser presque par cinq !</p></li></ul><p><em>Pour en savoir plus sur l'empreinte carbone de la France, </em><a target=\"_self\" rel=\"\" href=\"/article/L'empreinte carbone de la France/11\"><em>c'est par ici.</em></a></p><h2>Comment connaître votre empreinte carbone ?</h2><p>L’empreinte carbone se calcule aussi au niveau individuel, et elle dépend directement d’un ensemble d’activités que nous effectuons quotidiennement. Calculer son empreinte carbone, c'est prendre conscience de ses activités quotidiennes et de leurs conséquences pour l'environnement.</p><p>On peut ainsi cibler les activités les plus polluantes et ajuster nos usages et nos habitudes de consommation pour diminuer notre impact. Faites le bilan avec le calculateur de l'Ademe : <a target=\"_blank\" rel=\"\" class=\"in-cell-link\" href=\"https://nosgestesclimat.fr/\"><span style=\"color: rgb(17, 85, 204)\">Nos Gestes Climat</span></a>.</p>",
              partenaire: null,
              sources: [],
              isFavorite: false,
              isRead: true,
            ),
          ),
        );
        ielEstConnecte();
        await ielLanceLapplication(tester);
        await ielScrolle(tester, recommandation.titre);
        await ielAppuieSur(tester, recommandation.titre);
        await ielAppuieSur(tester, reponse);
        await ielAppuieSur(tester, Localisation.valider);
        ielVoitLeTexte(Localisation.pourquoi);

        final quizPort = ScenarioContext().quizPortMock;
        expect(quizPort!.isTerminerQuizCalled, isTrue);
        expect(quizPort.isExact, isFalse);
        final articlesPort = ScenarioContext().articlesPortMock;
        expect(articlesPort!.estMarquerCommeLuAppele, isTrue);
      });
    },
  );
}
