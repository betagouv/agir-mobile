import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';
import 'i_tap_on.dart';

/// Usage: I filter with {'🥦 Alimentation'} theme
Future<void> iFilterWithTheme(
  final WidgetTester tester,
  final String theme,
) async {
  FeatureContext.instance.dioMock.getM(
    '/utilisateurs/%7BuserId%7D/bibliotheque?filtre_thematiques=alimentation',
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
      ],
      'filtres': [
        {
          'code': 'alimentation',
          'label': '🥦 Alimentation',
          'selected': true,
        },
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
  await iTapOn(tester, theme);
}
