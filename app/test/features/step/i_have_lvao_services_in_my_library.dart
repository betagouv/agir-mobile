import 'package:app/core/infrastructure/endpoints.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';

/// Usage: I have lvao services in my library
Future<void> iHaveLvaoServicesInMyLibrary(final WidgetTester tester) async {
  FeatureContext.instance.dioMock.postM(
    Endpoints.lvaoSearch,
    requestData: {
      'categorie': 'reparer',
      'nombre_max_resultats': 4,
      'rayon_metres': 5000,
    },
    responseData: {
      'encore_plus_resultats_dispo': true,
      'resultats': [
        {
          'id': 'octavent_148266_reparation_0613025768',
          'titre': 'Octavent',
          'adresse_rue': '17 RUE DES BLANCHERS, 31000, TOULOUSE',
          'est_favoris': false,
          'nombre_favoris': 0,
          'distance_metres': 387,
          'categories': ['reparer'],
          'latitude': 43.602354,
          'longitude': 1.437978,
          'ingredients': <dynamic>[],
          'etapes_recette': <dynamic>[],
          'categories_labels': ['Réparer'],
        },
        {
          'id': 'mortagua_de_oliveira_ana_paula_143716_reparation_0601185441',
          'titre': 'LA PLAGE DES POMMES',
          'adresse_rue': '67 R PARGAMINIERES, 31000, TOULOUSE',
          'est_favoris': false,
          'nombre_favoris': 0,
          'distance_metres': 478,
          'categories': ['reparer'],
          'latitude': 43.604451,
          'longitude': 1.439722,
          'ingredients': <dynamic>[],
          'etapes_recette': <dynamic>[],
          'categories_labels': ['Réparer'],
        },
        {
          'id': 'liu_jia_143446_reparation_0561446122',
          'titre': 'PCPRIX',
          'adresse_rue': '77 RUE DE PARGAMINIÈRES, 31000, TOULOUSE',
          'est_favoris': false,
          'nombre_favoris': 0,
          'distance_metres': 536,
          'categories': ['reparer'],
          'latitude': 43.604508,
          'longitude': 1.44043,
          'ingredients': <dynamic>[],
          'etapes_recette': <dynamic>[],
          'categories_labels': ['Réparer'],
        },
        {
          'id': 'labor_140540_reparation',
          'titre': 'Labor',
          'adresse_rue': '9 R LAKANAL, 31000, TOULOUSE',
          'est_favoris': false,
          'nombre_favoris': 0,
          'distance_metres': 543,
          'categories': ['reparer'],
          'latitude': 43.604019,
          'longitude': 1.440543,
          'ingredients': <dynamic>[],
          'etapes_recette': <dynamic>[],
          'categories_labels': ['Réparer'],
        },
      ],
    },
  );
}
