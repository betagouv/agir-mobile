import 'package:app/features/authentification/core/infrastructure/authentification_api_client.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/recommandations/infrastructure/recommandations_api_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/authentication_service_fake.dart';
import 'client_mock.dart';
import 'constants.dart';
import 'custom_response.dart';
import 'request_mathcher.dart';

void main() {
  test('recuperer', () async {
    final client = ClientMock()
      ..getSuccess(
        path: '/utilisateurs/$utilisateurId/recommandations_v2',
        response: CustomResponse('''
[
  {
    "content_id": "KYC008",
    "type": "kyc",
    "titre": "Votre employeur vous permet-il de télétravailler ?",
    "thematique_gamification": "☀️ Environnement",
    "thematique_principale": "climat",
    "thematique_principale_label": "☀️ Environnement",
    "image_url": "https://www.google.com/url?sa=i&url=https%3A%2F%2Fopenclipart.org%2Fdetail%2F321572%2Fi-have-a-small-question&psig=AOvVaw1_ErxUJbZIoqQ8u-1sbgB5&ust=1711202048405000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCLijtMOCiIUDFQAAAAAdAAAAABAS",
    "points": 5,
    "score": 100.04227464872
  },
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

    final adapter = RecommandationsApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authenticationService: const AuthenticationServiceFake(),
        inner: client,
      ),
    );

    final result = await adapter.recuperer(null);
    expect(
      result.getRight().getOrElse(() => throw Exception()),
      [
        const Recommandation(
          id: 'KYC008',
          type: TypeDuContenu.kyc,
          titre: 'Votre employeur vous permet-il de télétravailler ?',
          sousTitre: null,
          imageUrl:
              'https://www.google.com/url?sa=i&url=https%3A%2F%2Fopenclipart.org%2Fdetail%2F321572%2Fi-have-a-small-question&psig=AOvVaw1_ErxUJbZIoqQ8u-1sbgB5&ust=1711202048405000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCLijtMOCiIUDFQAAAAAdAAAAABAS',
          points: 5,
          thematique: 'climat',
          thematiqueLabel: '☀️ Environnement',
        ),
        const Recommandation(
          id: '31',
          type: TypeDuContenu.article,
          titre: 'Réchauffement et montée des eaux : quel est le lien ?',
          sousTitre: 'Ça ne coule pas de source',
          imageUrl:
              'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1702068380/jonathan_ford_6_Zg_T_Etv_D16_I_unsplash_00217cb281.jpg',
          points: 20,
          thematique: 'climat',
          thematiqueLabel: '☀️ Environnement',
        ),
      ],
    );
  });

  test('recuperer filtré par univers', () async {
    final client = ClientMock()
      ..getSuccess(
        path: '/utilisateurs/$utilisateurId/recommandations_v2?univers=climat',
        response: CustomResponse('''
[
  {
    "content_id": "KYC008",
    "type": "kyc",
    "titre": "Votre employeur vous permet-il de télétravailler ?",
    "thematique_gamification": "☀️ Environnement",
    "thematique_principale": "climat",
    "thematique_principale_label": "☀️ Environnement",
    "image_url": "https://www.google.com/url?sa=i&url=https%3A%2F%2Fopenclipart.org%2Fdetail%2F321572%2Fi-have-a-small-question&psig=AOvVaw1_ErxUJbZIoqQ8u-1sbgB5&ust=1711202048405000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCLijtMOCiIUDFQAAAAAdAAAAABAS",
    "points": 5,
    "score": 100.04227464872
  },
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

    final adapter = RecommandationsApiAdapter(
      apiClient: AuthentificationApiClient(
        apiUrl: apiUrl,
        authenticationService: const AuthenticationServiceFake(),
        inner: client,
      ),
    );

    await adapter.recuperer('climat');
    verify(
      () => client.send(
        any(
          that: const RequestMathcher(
            '/utilisateurs/$utilisateurId/recommandations_v2?univers=climat',
          ),
        ),
      ),
    );
  });
}
