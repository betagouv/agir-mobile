import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_token_storage.dart';
import 'package:app/features/profil/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/recommandations/infrastructure/adapters/recommandations_api_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import 'client_mock.dart';
import 'constants.dart';
import 'custom_response.dart';
import 'flutter_secure_storage_mock.dart';

void main() {
  test('recupererProfil', () async {
    final client = ClientMock()
      ..getSuccess(
        path: '/utilisateurs/$utilisateurId/recommandations_v2',
        response: CustomResponse('''
[
  {
    "content_id": "31",
    "type": "article",
    "titre": "Réchauffement et montée des eaux : quel est le lien ?",
    "soustitre": "Ça ne coule pas de source",
    "duree": "⏱️ 3 minutes",
    "thematique_gamification": "☀️ Environnement",
    "thematique_principale": "climat",
    "thematique_principale_label": "☀️ Environnement",
    "image_url": "https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1702068380/jonathan_ford_6_Zg_T_Etv_D16_I_unsplash_00217cb281.jpg",
    "points": 20,
    "score": 50.04187220652
  }
]'''),
      );

    final authentificationTokenStorage = AuthentificationTokenStorage(
      secureStorage: FlutterSecureStorageMock(),
      authentificationStatusManager: AuthentificationStatutManager(),
    );
    await authentificationTokenStorage.sauvegarderTokenEtUtilisateurId(
      token,
      utilisateurId,
    );

    final adapter = RecommandationsApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authentificationTokenStorage: authentificationTokenStorage,
        inner: client,
      ),
    );

    final result = await adapter.recuperer();
    expect(
      result.getRight().getOrElse(() => throw Exception()),
      [
        const Recommandation(
          id: '31',
          titre: 'Réchauffement et montée des eaux : quel est le lien ?',
          imageUrl:
              'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1702068380/jonathan_ford_6_Zg_T_Etv_D16_I_unsplash_00217cb281.jpg',
          points: 20,
          thematique: Thematique.climat,
        ),
      ],
    );
  });
}
