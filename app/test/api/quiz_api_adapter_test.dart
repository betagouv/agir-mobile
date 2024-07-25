import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_token_storage.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/cms_api_client.dart';
import 'package:app/features/quiz/domain/quiz.dart';
import 'package:app/features/quiz/infrastructure/adapters/quiz_api_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'client_mock.dart';
import 'constants.dart';
import 'custom_response.dart';
import 'flutter_secure_storage_mock.dart';
import 'request_mathcher.dart';

void main() {
  test('recupererQuiz', () async {
    final client = ClientMock()
      ..getSuccess(
        path:
            '/api/quizzes/14?populate[0]=questions.reponses,thematique_gamification,articles.partenaire.logo',
        response: CustomResponse('''
{
  "data": {
    "id": 14,
    "attributes": {
      "titre": "Une assiette plus durable",
      "duree": "⏱️ 2 minutes",
      "points": 5,
      "sousTitre": "Comment réduire l'impact de notre alimentation ?",
      "frequence": null,
      "difficulty": 1,
      "createdAt": "2023-11-30T16:25:30.878Z",
      "updatedAt": "2024-06-21T15:36:44.215Z",
      "publishedAt": "2023-12-05T20:42:21.203Z",
      "categorie": null,
      "mois": null,
      "questions": [
        {
          "id": 12,
          "libelle": "Quelle action est la plus efficace pour une alimentation plus durable ?",
          "explicationOk": "<p><span>Le secteur de l’élevage génère à lui seul près de 15 % des émissions mondiales de gaz à effet de serre. Réduire notre consommation de viande permet d’agir sur la production et de diminuer les impacts qui lui sont associés.<br><br>Pour rendre notre alimentation plus durable, on peut aussi privilégier les produits locaux, de saison et biologiques, limiter l’achat de produits transformés et réduire le gaspillage alimentaire.</span></p>",
          "explicationKO": "<p><span>Au contraire ! Pour rendre notre alimentation plus durable, nous pouvons manger davantage de produits de saison et augmenter la part de repas végétariens dans les menus de la semaine. Diminuer notre consommation de viande permet en effet de réduire les impacts écologiques du secteur de l’élevage, qui génère à lui seul près de 15 % des émissions mondiales de gaz à effet de serre : c'est donc l'action la plus efficace pour limiter l'impact de notre alimentation.<br><br>On peut aussi privilégier les produits locaux et biologiques, limiter l’achat de produits transformés et réduire le gaspillage alimentaire.</span></p>",
          "reponses": [
            {
              "id": 38,
              "reponse": "Manger moins de produits de saison",
              "exact": false
            },
            {
              "id": 39,
              "reponse": "Diminuer la consommation de viande",
              "exact": true
            },
            {
              "id": 453,
              "reponse": "Privilégier la volaille et le porc",
              "exact": false
            },
            {
              "id": 452,
              "reponse": "Réduire ses déchets",
              "exact": false
            }
          ]
        }
      ],
      "thematique_gamification": {
        "data": {
          "id": 1,
          "attributes": {
            "titre": "🥦 Alimentation",
            "createdAt": "2023-09-20T12:16:53.011Z",
            "updatedAt": "2023-11-29T10:10:12.741Z",
            "publishedAt": "2023-12-05T20:38:49.216Z",
            "code": null
          }
        }
      },
      "articles": {
        "data": [
          {
            "id": 168,
            "attributes": {
              "titre": "L'impact de la viande sur l'environnement : chiffres et explications",
              "sousTitre": null,
              "contenu": "<h2><span>1. Les émissions de gaz à effet de serre</span></h2><p><span>L'élevage est responsable de 14,5 % des émissions mondiales de gaz à effet de serre (GES), soit environ 7,1 gigatonnes de CO2 par an​. Les principaux gaz émis sont le méthane (CH4), le dioxyde de carbone (CO2) et le protoxyde d'azote (N2O). Le méthane, principalement émis par les rots des bovins, est environ 25 fois plus puissant que le CO2 sur une période de 100 ans. Par ailleurs, 80% des émissions liées à l'agriculture viennent de la production de viande, d’œufs et de produits laitiers.</span></p><h2><span>2. L’utilisation des ressources</span></h2><p><span>L'élevage consomme d'énormes quantités de ressources naturelles. Environ 70% des terres agricoles mondiales sont utilisées pour l'élevage ou la production de cultures fourragères​​. La viande par exemple nécessite environ 3 fois plus d'eau que la production de la même quantité de légumineuses, en prenant en compte l'eau pour l'irrigation des cultures destinées à l'alimentation des animaux, leur boisson, et le traitement.</span></p><h2><span>3. Déforestation et perte de biodiversité</span></h2><p><span>L'expansion des pâturages et des cultures pour l'alimentation animale est un facteur majeur de la déforestation, notamment en Amazonie​​. Environ 80% de la déforestation mondiale est liée à l'agriculture, avec l'élevage jouant un rôle prépondérant. La conversion des forêts en terres agricoles a de lourds impacts sur les habitats naturels, entraînant une perte massive de biodiversité. Par exemple, chaque année, environ 13 millions d'hectares de forêt sont perdus à cause de l'agriculture et de l'élevage.</span></p>",
              "source": null,
              "codes_postaux": null,
              "duree": "⏱️ 5 minutes",
              "frequence": null,
              "points": 5,
              "difficulty": 1,
              "createdAt": "2024-06-17T21:39:45.339Z",
              "updatedAt": "2024-06-17T21:39:46.963Z",
              "publishedAt": "2024-06-17T21:39:46.958Z",
              "categorie": "mission",
              "mois": null,
              "include_codes_commune": null,
              "exclude_codes_commune": null,
              "codes_departement": null,
              "codes_region": null,
              "partenaire": {
                "data": null
              }
            }
          }
        ]
      }
    }
  },
  "meta": {}
}'''),
      );

    final authentificationTokenStorage = AuthentificationTokenStorage(
      secureStorage: FlutterSecureStorageMock(),
      authentificationStatusManagerWriter: AuthentificationStatutManager(),
    );
    await authentificationTokenStorage.sauvegarderToken(token);
    final adapter = QuizApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authentificationTokenStorage: authentificationTokenStorage,
        inner: client,
      ),
      cmsApiClient:
          CmsApiClient(apiUrl: cmsApiUrl, token: 'le_token', inner: client),
    );

    final result = await adapter.recupererQuiz('14');
    expect(
      result.getRight().getOrElse(() => throw Exception()),
      const Quiz(
        id: 14,
        thematique: '🥦 Alimentation',
        question:
            'Quelle action est la plus efficace pour une alimentation plus durable ?',
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
        article: Article(
          titre:
              "L'impact de la viande sur l'environnement : chiffres et explications",
          sousTitre: null,
          contenu:
              "<h2><span>1. Les émissions de gaz à effet de serre</span></h2><p><span>L'élevage est responsable de 14,5 % des émissions mondiales de gaz à effet de serre (GES), soit environ 7,1 gigatonnes de CO2 par an​. Les principaux gaz émis sont le méthane (CH4), le dioxyde de carbone (CO2) et le protoxyde d'azote (N2O). Le méthane, principalement émis par les rots des bovins, est environ 25 fois plus puissant que le CO2 sur une période de 100 ans. Par ailleurs, 80% des émissions liées à l'agriculture viennent de la production de viande, d’œufs et de produits laitiers.</span></p><h2><span>2. L’utilisation des ressources</span></h2><p><span>L'élevage consomme d'énormes quantités de ressources naturelles. Environ 70% des terres agricoles mondiales sont utilisées pour l'élevage ou la production de cultures fourragères​​. La viande par exemple nécessite environ 3 fois plus d'eau que la production de la même quantité de légumineuses, en prenant en compte l'eau pour l'irrigation des cultures destinées à l'alimentation des animaux, leur boisson, et le traitement.</span></p><h2><span>3. Déforestation et perte de biodiversité</span></h2><p><span>L'expansion des pâturages et des cultures pour l'alimentation animale est un facteur majeur de la déforestation, notamment en Amazonie​​. Environ 80% de la déforestation mondiale est liée à l'agriculture, avec l'élevage jouant un rôle prépondérant. La conversion des forêts en terres agricoles a de lourds impacts sur les habitats naturels, entraînant une perte massive de biodiversité. Par exemple, chaque année, environ 13 millions d'hectares de forêt sont perdus à cause de l'agriculture et de l'élevage.</span></p>",
          partenaire: null,
        ),
      ),
    );
  });

  test('recupererQuiz articles vide', () async {
    final client = ClientMock()
      ..getSuccess(
        path:
            '/api/quizzes/14?populate[0]=questions.reponses,thematique_gamification,articles.partenaire.logo',
        response: CustomResponse('''
{
  "data": {
    "id": 14,
    "attributes": {
      "titre": "Une assiette plus durable",
      "duree": "⏱️ 2 minutes",
      "points": 5,
      "sousTitre": "Comment réduire l'impact de notre alimentation ?",
      "frequence": null,
      "difficulty": 1,
      "createdAt": "2023-11-30T16:25:30.878Z",
      "updatedAt": "2024-06-21T15:36:44.215Z",
      "publishedAt": "2023-12-05T20:42:21.203Z",
      "categorie": null,
      "mois": null,
      "questions": [
        {
          "id": 12,
          "libelle": "Quelle action est la plus efficace pour une alimentation plus durable ?",
          "explicationOk": "<p><span>Le secteur de l’élevage génère à lui seul près de 15 % des émissions mondiales de gaz à effet de serre. Réduire notre consommation de viande permet d’agir sur la production et de diminuer les impacts qui lui sont associés.<br><br>Pour rendre notre alimentation plus durable, on peut aussi privilégier les produits locaux, de saison et biologiques, limiter l’achat de produits transformés et réduire le gaspillage alimentaire.</span></p>",
          "explicationKO": "<p><span>Au contraire ! Pour rendre notre alimentation plus durable, nous pouvons manger davantage de produits de saison et augmenter la part de repas végétariens dans les menus de la semaine. Diminuer notre consommation de viande permet en effet de réduire les impacts écologiques du secteur de l’élevage, qui génère à lui seul près de 15 % des émissions mondiales de gaz à effet de serre : c'est donc l'action la plus efficace pour limiter l'impact de notre alimentation.<br><br>On peut aussi privilégier les produits locaux et biologiques, limiter l’achat de produits transformés et réduire le gaspillage alimentaire.</span></p>",
          "reponses": [
            {
              "id": 38,
              "reponse": "Manger moins de produits de saison",
              "exact": false
            },
            {
              "id": 39,
              "reponse": "Diminuer la consommation de viande",
              "exact": true
            },
            {
              "id": 453,
              "reponse": "Privilégier la volaille et le porc",
              "exact": false
            },
            {
              "id": 452,
              "reponse": "Réduire ses déchets",
              "exact": false
            }
          ]
        }
      ],
      "thematique_gamification": {
        "data": {
          "id": 1,
          "attributes": {
            "titre": "🥦 Alimentation",
            "createdAt": "2023-09-20T12:16:53.011Z",
            "updatedAt": "2023-11-29T10:10:12.741Z",
            "publishedAt": "2023-12-05T20:38:49.216Z",
            "code": null
          }
        }
      },
      "articles": {
        "data": []
      }
    }
  },
  "meta": {}
}'''),
      );

    final authentificationTokenStorage = AuthentificationTokenStorage(
      secureStorage: FlutterSecureStorageMock(),
      authentificationStatusManagerWriter: AuthentificationStatutManager(),
    );
    await authentificationTokenStorage.sauvegarderToken(token);
    final adapter = QuizApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authentificationTokenStorage: authentificationTokenStorage,
        inner: client,
      ),
      cmsApiClient:
          CmsApiClient(apiUrl: cmsApiUrl, token: 'le_token', inner: client),
    );

    final result = await adapter.recupererQuiz('14');
    expect(
      result.getRight().getOrElse(() => throw Exception()),
      const Quiz(
        id: 14,
        thematique: '🥦 Alimentation',
        question:
            'Quelle action est la plus efficace pour une alimentation plus durable ?',
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
  });

  test('terminerQuiz', () async {
    final client = ClientMock()
      ..postSuccess(
        path: '/utilisateurs/$utilisateurId/events',
        response: OkResponse(),
      );

    final authentificationTokenStorage = AuthentificationTokenStorage(
      secureStorage: FlutterSecureStorageMock(),
      authentificationStatusManagerWriter: AuthentificationStatutManager(),
    );
    await authentificationTokenStorage.sauvegarderToken(token);

    final adapter = QuizApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authentificationTokenStorage: authentificationTokenStorage,
        inner: client,
      ),
      cmsApiClient:
          CmsApiClient(apiUrl: cmsApiUrl, token: 'le_token', inner: client),
    );

    await adapter.terminerQuiz(id: 1, estExacte: true);

    verify(
      () => client.send(
        any(
          that: const RequestMathcher(
            '/utilisateurs/$utilisateurId/events',
            body: '{"content_id":"1","number_value":100,"type":"quizz_score"}',
          ),
        ),
      ),
    );
  });
}
