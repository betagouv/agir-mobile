import 'package:app/core/infrastructure/endpoints.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';

/// Usage: I have recipe services in my library
Future<void> iHaveRecipeServicesInMyLibrary(final WidgetTester tester) async {
  FeatureContext.instance.dioMock.postM(
    Endpoints.recipesSearch,
    requestData: {'categorie': 'vegan', 'nombre_max_resultats': 4, 'rayon_metres': 5000},
    responseData: {
      'encore_plus_resultats_dispo': true,
      'resultats': [
        {
          'titre': 'Salade de pâtes complètes et lentilles',
          'difficulty_plat': 'Facile',
          'temps_prepa_min': 5,
          'image_url': 'https://res.cloudinary.com/dq023imd8/image/upload/v1726729974/plat_41956db95a.svg',
        },
        {
          'titre': 'Tagliatelles sauce au bleu et aux noix',
          'difficulty_plat': 'Facile',
          'temps_prepa_min': 10,
          'image_url': 'https://res.cloudinary.com/dq023imd8/image/upload/v1726729974/plat_41956db95a.svg',
        },
        {
          'titre': 'Poivrons farcis aux lentilles corail',
          'type_plat': 'Plat',
          'difficulty_plat': 'Intérmédiaire',
          'temps_prepa_min': 10,
          'image_url': 'https://res.cloudinary.com/dq023imd8/image/upload/v1726729974/plat_41956db95a.svg',
        },
        {
          'titre': 'Riz cantonais végétarien',
          'difficulty_plat': 'Facile',
          'temps_prepa_min': 10,
          'image_url': 'https://res.cloudinary.com/dq023imd8/image/upload/v1726729974/plat_41956db95a.svg',
        },
      ],
    },
  );
}
