import 'dart:convert';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/core/infrastructure/theme_api_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../helpers/dio_mock.dart';
import '../mocks/authentication_service_fake.dart';

void main() {
  test('missions', () async {
    final dio = DioMock()
      ..getM(
        Endpoints.missionsRecommandeesParThematique('alimentation'),
        responseData: jsonDecode('''
[
    {
        "titre": "Me loger : premiers pas",
        "progression": 0,
        "cible_progression": 8,
        "code": "intro_logement",
        "is_new": false,
        "image_url": "https://example.com/image.png",
        "thematique": "logement"
    },
    {
        "titre": "Gérer sa consommation d'eau",
        "progression": 0,
        "cible_progression": 8,
        "code": "conso_eau",
        "is_new": true,
        "image_url": "https://example.com/image.png",
        "thematique": "logement"
    }
]
'''),
      );

    final adapter = initializeAdapter(dio);
    final result = await adapter.getMissions(ThemeType.alimentation);

    expect(
      result.getRight().getOrElse(() => throw Exception()),
      const [
        MissionListe(
          code: 'intro_logement',
          titre: 'Me loger : premiers pas',
          progression: 0,
          progressionCible: 8,
          estNouvelle: false,
          imageUrl: 'https://example.com/image.png',
          themeType: ThemeType.logement,
        ),
        MissionListe(
          code: 'conso_eau',
          titre: "Gérer sa consommation d'eau",
          progression: 0,
          progressionCible: 8,
          estNouvelle: true,
          imageUrl: 'https://example.com/image.png',
          themeType: ThemeType.logement,
        ),
      ],
    );
  });
}

ThemeApiAdapter initializeAdapter(final DioMock client) => ThemeApiAdapter(
      client: DioHttpClient(
        dio: client,
        authenticationService: const AuthenticationServiceFake(),
      ),
    );
