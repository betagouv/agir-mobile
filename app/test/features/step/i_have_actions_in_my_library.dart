import 'package:app/core/infrastructure/endpoints.dart';
import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';

/// Usage: I have actions in my library
Future<void> iHaveActionsInMyLibrary(
  final WidgetTester tester,
  final bdd.DataTable dataTable,
) async {
  final list = dataTable
      .asMaps()
      .map(
        (final e) => {
          'code': Faker().guid.guid(),
          'titre': e['title'],
          'sous_titre': Faker().lorem.sentence(),
          'nombre_actions_en_cours': e['nb_actions_completed'],
          'nombre_aides_disponibles': e['nb_aids_available'],
        },
      )
      .toList();
  FeatureContext.instance.dioMock.getM(
    Endpoints.actions,
    responseData: list,
  );
  final code = list.first['code'] as String;
  FeatureContext.instance.dioMock.getM(
    Endpoints.action(code),
    responseData: {
      'nombre_actions_en_cours': 113,
      'nombre_aides_disponibles': 5,
      'code': code,
      'titre': 'Faire réparer une **paire de chaussures**',
      'sous_titre':
          'Faites des économies en donnant une seconde vie à vos paires de chaussures',
      'besoins': ['reparer_vet_chauss'],
      'comment':
          '# Nos astuces\n\n- **Choisissez un cordonnier agréé** : pour profiter de l’aide d’État sur vos réparations\n\n- **Bottes, chaussures de ski, baskets** : toutes les chaussures sont éligibles\n\n- **Si vos chaussures sont trop abimées** : Déposez-les dans un point de collecte pour que valoriser les matériaux utilisés',
      'pourquoi':
          '# En quelques mots\n\n- Pour chaque paire de chaussure réparée, vous économisez **entre 20 et 60€**\n\n- Les paires de chaussures jetées représentent plusieurs **milliers de tonnes** de déchets généralement non recyclables. \n\n- Chaque année, un Français achète en moyenne 4 paires de chaussures.',
      'type': 'classique',
      'thematique': 'consommation',
      'aides': [
        {
          'content_id': '19',
          'titre': 'Réparer des vêtements ou des chaussures',
          'montant_max': 25,
          'partenaire_nom': 'Gouvernement Français',
          'partenaire_url': null,
          'partenaire_logo_url':
              'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1737976576/Bloc_Marianne_svg_1_417e9eebad.png',
          'echelle': 'National',
        },
      ],
      'services': [
        {'categorie': 'reparer', 'recherche_service_id': 'longue_vie_objets'},
      ],
    },
  );
}
