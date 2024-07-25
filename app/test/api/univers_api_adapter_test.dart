import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_token_storage.dart';
import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/univers/domain/tuile_univers.dart';
import 'package:app/features/univers/infrastructure/adapters/univers_api_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import 'client_mock.dart';
import 'constants.dart';
import 'custom_response.dart';
import 'flutter_secure_storage_mock.dart';

void main() {
  test('recuperer', () async {
    final client = ClientMock()
      ..getSuccess(
        path: '/utilisateurs/$utilisateurId/univers',
        response: CustomResponse('''
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

    final authentificationTokenStorage = AuthentificationTokenStorage(
      secureStorage: FlutterSecureStorageMock(),
      authentificationStatusManagerWriter: AuthentificationStatutManager(),
    );
    await authentificationTokenStorage.sauvegarderToken(token);

    final adapter = UniversApiAdapter(
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
        const TuileUnivers(
          type: Thematique.alimentation,
          titre: 'En cuisine',
          imageUrl:
              'https://res.cloudinary.com/dq023imd8/image/upload/v1714635428/univers_cuisine_b903b5fb1c.jpg',
          estVerrouille: true,
          estTerminee: false,
        ),
        const TuileUnivers(
          type: Thematique.loisir,
          titre: 'Les vacances',
          imageUrl:
              'https://res.cloudinary.com/dq023imd8/image/upload/v1714635518/univers_loisirs_596c3b0599.jpg',
          estVerrouille: false,
          estTerminee: true,
        ),
      ],
    );
  });
}
