import 'dart:convert';

import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/theme/core/domain/content_id.dart';
import 'package:app/features/theme/core/domain/mission.dart';
import 'package:app/features/theme/core/domain/mission_defi.dart';
import 'package:app/features/theme/core/domain/mission_kyc.dart';
import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/core/domain/mission_quiz.dart';
import 'package:app/features/theme/core/domain/theme_tile.dart';
import 'package:app/features/theme/core/infrastructure/univers_api_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/dio_mock.dart';
import '../mocks/authentication_service_fake.dart';

void main() {
  test('recuperer', () async {
    final dio = DioMock()
      ..getM(
        '/utilisateurs/{userId}/univers',
        responseData: jsonDecode('''
[
  {
    "titre": "En cuisine",
    "etoiles": 0,
    "type": "alimentation",
    "is_locked": true,
    "reason_locked": null,
    "image_url": "https://res.cloudinary.com/dq023imd8/image/upload/v1714635428/univers_cuisine_b903b5fb1c.jpg",
    "is_done": false
  },
  {
    "titre": "Les vacances",
    "etoiles": 0,
    "type": "loisir",
    "is_locked": false,
    "reason_locked": null,
    "image_url": "https://res.cloudinary.com/dq023imd8/image/upload/v1714635518/univers_loisirs_596c3b0599.jpg",
    "is_done": true
  }
]'''),
      );

    final adapter = initializeAdapter(dio);
    final result = await adapter.getTheme('alimentation');

    expect(
      result.getRight().getOrElse(() => throw Exception()),
      const ThemeTile(
        type: 'alimentation',
        title: 'En cuisine',
        imageUrl:
            'https://res.cloudinary.com/dq023imd8/image/upload/v1714635428/univers_cuisine_b903b5fb1c.jpg',
      ),
    );
  });

  test('missions', () async {
    final dio = DioMock()
      ..getM(
        '/utilisateurs/{userId}/univers/alimentation/thematiques',
        responseData: jsonDecode('''
[
    {
        "titre": "Pourquoi manger de saison ?",
        "progression": 2,
        "cible_progression": 8,
        "type": "manger_saison_1",
        "is_locked": false,
        "reason_locked": null,
        "is_new": false,
        "niveau": 1,
        "image_url": "https://res.cloudinary.com/dq023imd8/image/upload/v1718631224/fruits_1_dec0e90839.png",
        "univers_parent": "alimentation",
        "univers_parent_label": "En cuisine"
    },
    {
        "titre": "Comment bien choisir ses aliments ?",
        "progression": 0,
        "cible_progression": 6,
        "type": "manger_saison_2",
        "is_locked": false,
        "reason_locked": null,
        "is_new": true,
        "niveau": 2,
        "image_url": "https://res.cloudinary.com/dq023imd8/image/upload/v1718701364/fruits_2_cfbf4b47b9.png",
        "univers_parent": "alimentation",
        "univers_parent_label": "En cuisine"
    }
]
'''),
      );

    final adapter = initializeAdapter(dio);
    final result = await adapter.recupererMissions('alimentation');

    expect(
      result.getRight().getOrElse(() => throw Exception()),
      const [
        MissionListe(
          id: 'manger_saison_1',
          titre: 'Pourquoi manger de saison ?',
          progression: 2,
          progressionCible: 8,
          estNouvelle: false,
          imageUrl:
              'https://res.cloudinary.com/dq023imd8/image/upload/v1718631224/fruits_1_dec0e90839.png',
          niveau: 1,
        ),
        MissionListe(
          id: 'manger_saison_2',
          titre: 'Comment bien choisir ses aliments ?',
          progression: 0,
          progressionCible: 6,
          estNouvelle: true,
          imageUrl:
              'https://res.cloudinary.com/dq023imd8/image/upload/v1718701364/fruits_2_cfbf4b47b9.png',
          niveau: 2,
        ),
      ],
    );
  });

  test('mission', () async {
    final dio = DioMock()
      ..getM(
        '/utilisateurs/{userId}/thematiques/manger_saison_2/mission',
        responseData: jsonDecode('''
{
    "id": "5",
    "titre": "Comment bien choisir ses aliments ?",
    "done_at": null,
    "objectifs": [
        {
            "id": "9e01405f-f511-4aee-b69b-4ead3d50acde",
            "titre": "Mieux vous connaître 1",
            "content_id": "KYC_saison_alternative",
            "is_locked": false,
            "done": true,
            "done_at": "2024-09-02T08:49:57.137Z",
            "type": "kyc",
            "points": 5,
            "sont_points_en_poche": true,
            "is_reco": false
        },
        {
            "id": "ec0ab600-b72f-4995-b496-1f80067d4c81",
            "titre": "Comment repérer si les produits sont de saison ou pas lors de l'achat ?",
            "content_id": "88",
            "is_locked": false,
            "done": true,
            "done_at": "2024-09-03T14:26:38.788Z",
            "type": "quizz",
            "points": 5,
            "sont_points_en_poche": false,
            "is_reco": true
        },
        {
            "id": "7e80fb6a-3bf8-420c-87e5-dad8c7a3c1cb",
            "titre": "Comment remplacer un produit qui n'est pas de saison ?",
            "content_id": "89",
            "is_locked": false,
            "done": false,
            "done_at": null,
            "type": "quizz",
            "points": 5,
            "sont_points_en_poche": false,
            "is_reco": false
        },
        {
            "id": "0184bece-fe34-4518-8c20-2a5f4c95febc",
            "titre": "La saisonnalité des produits : il n'y en a pas que pour les fruits et légumes !",
            "content_id": "90",
            "is_locked": false,
            "done": false,
            "done_at": null,
            "type": "quizz",
            "points": 5,
            "sont_points_en_poche": false,
            "is_reco": true
        },
        {
            "id": "9b4c32f9-9364-4902-814f-591b17d0d64b",
            "titre": "Aider la communauté en partageant un lieu où faire ses courses de saison à Dole ou une astuce pour remplacer un fruit ou légume hors saison",
            "content_id": "39",
            "is_locked": true,
            "done": false,
            "done_at": null,
            "type": "defi",
            "points": 10,
            "sont_points_en_poche": false,
            "is_reco": false,
            "defi_status": "todo"
        },
        {
            "id": "7ce5c001-dd77-406c-9c2e-52216d107003",
            "titre": "Remplacer un fruit ou un légume qui n'est pas de saison par la conserve, surgelé ou un autre produit frais",
            "content_id": "38",
            "is_locked": true,
            "done": false,
            "done_at": null,
            "type": "defi",
            "points": 50,
            "sont_points_en_poche": false,
            "is_reco": true,
            "defi_status": "todo"
        },
        {
            "id": "92427ef6-5f4a-4684-b260-54cd93152948",
            "titre": "Faire ses propres conserves ou confitures d'un fruit ou légume de saison",
            "content_id": "89",
            "is_locked": true,
            "done": false,
            "done_at": null,
            "type": "defi",
            "points": 50,
            "sont_points_en_poche": false,
            "is_reco": false,
            "defi_status": "todo"
        }
    ],
    "thematique_univers": "manger_saison_2",
    "thematique_univers_label": "Comment bien choisir ses aliments ?",
    "univers_label": "En cuisine",
    "univers": "alimentation",
    "progression": {"current": 2, "target": 6},
    "is_new": false,
    "progression_kyc": {"current": 1, "target": 1},
    "image_url": "https://res.cloudinary.com/dq023imd8/image/upload/v1718701364/fruits_2_cfbf4b47b9.png",
    "terminable": false
}
'''),
      );

    final adapter = initializeAdapter(dio);
    final result = await adapter.recupererMission(
      missionId: 'manger_saison_2',
    );

    expect(
      result.getRight().getOrElse(() => throw Exception()),
      const Mission(
        titre: 'Comment bien choisir ses aliments ?',
        imageUrl:
            'https://res.cloudinary.com/dq023imd8/image/upload/v1718701364/fruits_2_cfbf4b47b9.png',
        kycListe: [
          MissionKyc(
            id: ObjectifId('9e01405f-f511-4aee-b69b-4ead3d50acde'),
            titre: 'Mieux vous connaître 1',
            contentId: ContentId('KYC_saison_alternative'),
            estFait: true,
            estVerrouille: false,
            points: 5,
            aEteRecolte: true,
          ),
        ],
        quizListe: [
          MissionQuiz(
            id: ObjectifId('ec0ab600-b72f-4995-b496-1f80067d4c81'),
            titre:
                "Comment repérer si les produits sont de saison ou pas lors de l'achat ?",
            contentId: ContentId('88'),
            estFait: true,
            estVerrouille: false,
            points: 5,
            aEteRecolte: false,
          ),
          MissionQuiz(
            id: ObjectifId('7e80fb6a-3bf8-420c-87e5-dad8c7a3c1cb'),
            titre: "Comment remplacer un produit qui n'est pas de saison ?",
            contentId: ContentId('89'),
            estFait: false,
            estVerrouille: false,
            points: 5,
            aEteRecolte: false,
          ),
          MissionQuiz(
            id: ObjectifId('0184bece-fe34-4518-8c20-2a5f4c95febc'),
            titre:
                "La saisonnalité des produits : il n'y en a pas que pour les fruits et légumes !",
            contentId: ContentId('90'),
            estFait: false,
            estVerrouille: false,
            points: 5,
            aEteRecolte: false,
          ),
        ],
        articles: [],
        defis: [
          MissionDefi(
            id: ObjectifId('9b4c32f9-9364-4902-814f-591b17d0d64b'),
            titre:
                'Aider la communauté en partageant un lieu où faire ses courses de saison à Dole ou une astuce pour remplacer un fruit ou légume hors saison',
            contentId: ContentId('39'),
            estFait: false,
            estVerrouille: true,
            points: 10,
            aEteRecolte: false,
            status: MissionDefiStatus.toDo,
            isRecommended: false,
          ),
          MissionDefi(
            id: ObjectifId('7ce5c001-dd77-406c-9c2e-52216d107003'),
            titre:
                "Remplacer un fruit ou un légume qui n'est pas de saison par la conserve, surgelé ou un autre produit frais",
            contentId: ContentId('38'),
            estFait: false,
            estVerrouille: true,
            points: 50,
            aEteRecolte: false,
            status: MissionDefiStatus.toDo,
            isRecommended: true,
          ),
          MissionDefi(
            id: ObjectifId('92427ef6-5f4a-4684-b260-54cd93152948'),
            titre:
                "Faire ses propres conserves ou confitures d'un fruit ou légume de saison",
            contentId: ContentId('89'),
            estFait: false,
            estVerrouille: true,
            points: 50,
            aEteRecolte: false,
            status: MissionDefiStatus.toDo,
            isRecommended: false,
          ),
        ],
        peutEtreTermine: false,
        estTermine: false,
      ),
    );
  });
  test('gagnerPoints', () async {
    const objectifId = 'cce0f6fd-7fee-48ff-90a4-17b1f4421c54';
    final dio = DioMock()
      ..postM(
        '/utilisateurs/{userId}/objectifs/$objectifId/gagner_points',
        requestData: jsonEncode({'element_id': objectifId}),
      );

    final adapter = initializeAdapter(dio);
    await adapter.gagnerPoints(id: const ObjectifId(objectifId));

    verify(
      () => dio.post<dynamic>(
        '/utilisateurs/{userId}/objectifs/$objectifId/gagner_points',
        data: '{"element_id":"cce0f6fd-7fee-48ff-90a4-17b1f4421c54"}',
      ),
    );
  });

  test('terminer', () async {
    const missionId = 'manger_saison_3';
    final dio = DioMock()
      ..postM(
        '/utilisateurs/{userId}/thematiques/$missionId/mission/terminer',
        responseData: '',
      );

    final adapter = initializeAdapter(dio);
    await adapter.terminer(missionId: missionId);

    verify(
      () => dio.post<dynamic>(
        '/utilisateurs/{userId}/thematiques/$missionId/mission/terminer',
      ),
    );
  });
}

UniversApiAdapter initializeAdapter(final DioMock client) => UniversApiAdapter(
      client: DioHttpClient(
        dio: client,
        authenticationService: const AuthenticationServiceFake(),
      ),
    );
