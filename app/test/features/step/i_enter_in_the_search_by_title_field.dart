import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';
import 'i_enter_in_the_field.dart';

/// Usage: I enter {'vêtements'} in the search by title field
Future<void> iEnterInTheSearchByTitleField(final WidgetTester tester, final String text) async {
  FeatureContext.instance.dioMock.getM(
    Uri.parse('/utilisateurs/{userId}/bibliotheque?titre=$text').toString(),
    responseData: {
      'contenu': [
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
      ],
      'filtres': [
        {'code': 'alimentation', 'label': '🥦 Alimentation', 'selected': false},
        {'code': 'transport', 'label': '🚗 Transports', 'selected': false},
        {'code': 'logement', 'label': '🏡 Logement', 'selected': false},
        {'code': 'consommation', 'label': '🛒 Consommation durable', 'selected': false},
        {'code': 'climat', 'label': '☀️ Environnement', 'selected': false},
        {'code': 'dechet', 'label': '🗑️ Déchets', 'selected': false},
        {'code': 'loisir', 'label': '⚽ Loisirs', 'selected': false},
      ],
    },
  );
  await iEnterInTheField(tester, text, Localisation.rechercherParTitre);
  await tester.pumpAndSettle(const Duration(milliseconds: 500));
}
