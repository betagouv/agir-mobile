import 'dart:convert';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/recommandations/infrastructure/recommandations_api_adapter.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/dio_mock.dart';
import '../mocks/authentication_service_fake.dart';

void main() {
  test('recuperer filtré par thematique', () async {
    const themeType = ThemeType.alimentation;
    final dio = DioMock()
      ..getM(
        Endpoints.recommandationsParThematique(themeType.name),
        responseData: jsonDecode('''
[
  {
    "content_id": "128",
    "type": "quizz",
    "titre": "Quelle céréale est idéale au petit-déjeuner ?",
    "soustitre": null,
    "duree": "⏱️ 2 minutes",
    "thematique_gamification": "Me nourrir",
    "thematique_principale": "alimentation",
    "thematique_principale_label": "Me nourrir",
    "image_url": "https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1718659831/pexels_jeshoots_216951_9d22d98896.jpg",
    "points": 5,
    "score": 50.0313119001
  },
  {
    "content_id": "76",
    "type": "quizz",
    "titre": "Saisonnalité et localité",
    "soustitre": "Comment sont-elles liées ?",
    "duree": "⏱️ 2 minutes",
    "thematique_gamification": "Me nourrir",
    "thematique_principale": "alimentation",
    "thematique_principale_label": "Me nourrir",
    "image_url": "https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1705408190/erwan_hesry_1q75_B_Re_Kpms_unsplash_41caf1f20b.jpg",
    "points": 20,
    "score": 50.02927918237
  }
]'''),
      );

    final adapter = RecommandationsApiAdapter(
      client: DioHttpClient(
        dio: dio,
        authenticationService: const AuthenticationServiceFake(),
      ),
    );
    await adapter.recuperer(themeType);
    verify(
      () => dio.get<dynamic>(
        Endpoints.recommandationsParThematique(themeType.name),
      ),
    );
  });
}
