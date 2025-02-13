import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';

/// Usage: I have {2} articles in my library
Future<void> iHaveArticlesInMyLibrary(
  final WidgetTester tester,
  final int number,
) async {
  FeatureContext.instance.dioMock.getM(
    '/utilisateurs/%7BuserId%7D/bibliotheque',
    responseData: {
      'contenu': [
        {
          'content_id': '15',
          'type': 'article',
          'titre': "Qu'est-ce qu'une alimentation durable ?",
          'soustitre':
              "Comment réduire l'impact de notre alimentation sur le climat ?",
          'thematique_principale': 'alimentation',
          'thematique_principale_label': '🥦 Alimentation',
          'thematiques': ['alimentation'],
          'image_url': 'https://example.com/image.jpg',
          'points': 5,
          'favoris': true,
          'read_date': '2024-12-10T08:38:25.847Z',
        },
        {
          'content_id': '197',
          'type': 'article',
          'titre': "Comment réduire l'impact de ses vêtements ?",
          'soustitre': null,
          'thematique_principale': 'consommation',
          'thematique_principale_label': '🛒 Consommation durable',
          'thematiques': ['consommation'],
          'image_url': 'https://example.com/image.jpg',
          'points': 5,
          'favoris': false,
          'read_date': '2024-12-09T09:31:01.537Z',
        },
      ].sublist(0, number),
      'filtres': [
        {'code': 'alimentation', 'label': '🥦 Alimentation', 'selected': false},
        {'code': 'transport', 'label': '🚗 Transports', 'selected': false},
        {'code': 'logement', 'label': '🏡 Logement', 'selected': false},
        {
          'code': 'consommation',
          'label': '🛒 Consommation durable',
          'selected': false,
        },
        {'code': 'climat', 'label': '☀️ Environnement', 'selected': false},
        {'code': 'dechet', 'label': '🗑️ Déchets', 'selected': false},
        {'code': 'loisir', 'label': '⚽ Loisirs', 'selected': false},
      ],
    },
  );
}
