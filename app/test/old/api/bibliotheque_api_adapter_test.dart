import 'dart:convert';

import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/bibliotheque/domain/bibliotheque.dart';
import 'package:app/features/bibliotheque/infrastructure/bibliotheque_api_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/dio_mock.dart';
import '../mocks/authentication_service_fake.dart';

void main() {
  test('recuperer', () async {
    final dio = DioMock()
      ..getM(
        '/utilisateurs/%7BuserId%7D/bibliotheque',
        responseData: jsonDecode('''
{
  "contenu": [
    {
      "content_id": "94",
      "type": "article",
      "titre": "Manger de saison : quel impact sur l'environnement ?",
      "soustitre": "Le cas de la tomate",
      "thematique_principale": "alimentation",
      "thematique_principale_label": "🥦 Alimentation",
      "thematiques": [
        "alimentation"
      ],
      "image_url": "https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1705407336/josephine_baran_g4wzh_Y8qi_Mw_unsplash_f7aaf757df.jpg",
      "points": 5,
      "favoris": false,
      "read_date": "2024-07-16T15:05:05.551Z"
    },
    {
      "content_id": "168",
      "type": "article",
      "titre": "L'impact de la viande sur l'environnement : chiffres et explications",
      "soustitre": null,
      "thematique_principale": "alimentation",
      "thematique_principale_label": "🥦 Alimentation",
      "thematiques": [
        "alimentation"
      ],
      "image_url": "https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1718635565/pexels_matthiaszomer_325257_2655b228d0.jpg",
      "points": 5,
      "favoris": false,
      "read_date": "2024-07-15T07:49:43.101Z"
    }
  ],
  "filtres": [
    {
      "code": "alimentation",
      "label": "🥦 Alimentation",
      "selected": true
    },
    {
      "code": "transport",
      "label": "🚗 Transports",
      "selected": false
    },
    {
      "code": "logement",
      "label": "🏡 Logement",
      "selected": false
    },
    {
      "code": "consommation",
      "label": "🛒 Consommation durable",
      "selected": false
    },
    {
      "code": "climat",
      "label": "☀️ Environnement",
      "selected": false
    },
    {
      "code": "dechet",
      "label": "🗑️ Déchets",
      "selected": false
    },
    {
      "code": "loisir",
      "label": "⚽ Loisirs",
      "selected": false
    }
  ]
}'''),
      );

    final adapter = BibliothequeApiAdapter(
      client: DioHttpClient(
        dio: dio,
        authenticationService: const AuthenticationServiceFake(),
      ),
    );

    final result = await adapter.recuperer(
      thematiques: null,
      titre: null,
      isFavorite: null,
    );

    final bibliotheque = result.getRight().getOrElse(() => throw Exception());
    expect(bibliotheque, isA<Bibliotheque>());
    expect(bibliotheque.contenus, hasLength(2));
    expect(
      bibliotheque.contenus.first.titre,
      "Manger de saison : quel impact sur l'environnement ?",
    );
    expect(bibliotheque.filtres, hasLength(7));
  });

  test('recuperer filtre avec le titre', () async {
    final dio = DioMock()
      ..getM(
        '/utilisateurs/%7BuserId%7D/bibliotheque?titre=quel+impact',
        responseData: jsonDecode('''
{
  "contenu": [
    {
      "content_id": "94",
      "type": "article",
      "titre": "Manger de saison : quel impact sur l'environnement ?",
      "soustitre": "Le cas de la tomate",
      "thematique_principale": "alimentation",
      "thematique_principale_label": "🥦 Alimentation",
      "thematiques": [
        "alimentation"
      ],
      "image_url": "https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1705407336/josephine_baran_g4wzh_Y8qi_Mw_unsplash_f7aaf757df.jpg",
      "points": 5,
      "favoris": false,
      "read_date": "2024-07-16T15:05:05.551Z"
    }
  ],
  "filtres": [
    {
      "code": "alimentation",
      "label": "🥦 Alimentation",
      "selected": false
    }
  ]
}'''),
      );

    final adapter = BibliothequeApiAdapter(
      client: DioHttpClient(
        dio: dio,
        authenticationService: const AuthenticationServiceFake(),
      ),
    );

    await adapter.recuperer(
      thematiques: null,
      titre: 'quel impact',
      isFavorite: null,
    );

    verify(
      () => dio.get<dynamic>(
        '/utilisateurs/%7BuserId%7D/bibliotheque?titre=quel+impact',
      ),
    );
  });

  test('recuperer filtre avec les thématiques', () async {
    final dio = DioMock()
      ..getM(
        '/utilisateurs/%7BuserId%7D/bibliotheque?filtre_thematiques=alimentation%2Cloisir',
        responseData: jsonDecode('''
{
  "contenu": [
    {
      "content_id": "94",
      "type": "article",
      "titre": "Manger de saison : quel impact sur l'environnement ?",
      "soustitre": "Le cas de la tomate",
      "thematique_principale": "alimentation",
      "thematique_principale_label": "🥦 Alimentation",
      "thematiques": [
        "alimentation"
      ],
      "image_url": "https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1705407336/josephine_baran_g4wzh_Y8qi_Mw_unsplash_f7aaf757df.jpg",
      "points": 5,
      "favoris": false,
      "read_date": "2024-07-16T15:05:05.551Z"
    }
  ],
  "filtres": [
    {
      "code": "alimentation",
      "label": "🥦 Alimentation",
      "selected": false
    }
  ]
}'''),
      );

    final adapter = BibliothequeApiAdapter(
      client: DioHttpClient(
        dio: dio,
        authenticationService: const AuthenticationServiceFake(),
      ),
    );

    await adapter.recuperer(
      thematiques: ['alimentation', 'loisir'],
      titre: null,
      isFavorite: null,
    );

    verify(
      () => dio.get<dynamic>(
        '/utilisateurs/%7BuserId%7D/bibliotheque?filtre_thematiques=alimentation%2Cloisir',
      ),
    );
  });

  test('recuperer filtre avec les favoris', () async {
    final dio = DioMock()
      ..getM(
        '/utilisateurs/%7BuserId%7D/bibliotheque?favoris=true',
        responseData: jsonDecode('''
{
  "contenu": [
    {
      "content_id": "94",
      "type": "article",
      "titre": "Manger de saison : quel impact sur l'environnement ?",
      "soustitre": "Le cas de la tomate",
      "thematique_principale": "alimentation",
      "thematique_principale_label": "🥦 Alimentation",
      "thematiques": [
        "alimentation"
      ],
      "image_url": "https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1705407336/josephine_baran_g4wzh_Y8qi_Mw_unsplash_f7aaf757df.jpg",
      "points": 5,
      "favoris": true,
      "read_date": "2024-07-16T15:05:05.551Z"
    }
  ],
  "filtres": [
    {
      "code": "alimentation",
      "label": "🥦 Alimentation",
      "selected": false
    }
  ]
}'''),
      );

    final adapter = BibliothequeApiAdapter(
      client: DioHttpClient(
        dio: dio,
        authenticationService: const AuthenticationServiceFake(),
      ),
    );

    await adapter.recuperer(
      thematiques: null,
      titre: null,
      isFavorite: true,
    );

    verify(
      () => dio.get<dynamic>(
        '/utilisateurs/%7BuserId%7D/bibliotheque?favoris=true',
      ),
    );
  });
}
