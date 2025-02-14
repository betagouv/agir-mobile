import 'package:app/core/infrastructure/endpoints.dart';
import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';

/// Usage: I have recipe detail in my library
Future<void> iHaveRecipeDetailInMyLibrary(final WidgetTester tester, final bdd.DataTable dataTable) async {
  dataTable
      .asMaps()
      .map(
        (final e) => {
          'id': e['id'],
          'image_url': 'https://res.cloudinary.com/dq023imd8/image/upload/v1726729974/plat_41956db95a.svg',
          'titre': e['title'],
          'difficulty_plat': 'Facile',
          'temps_prepa_min': e['preparation_time'],
          'ingredients': <dynamic>[],
          'etapes_recette': <dynamic>[],
        },
      )
      .forEach((final e) {
        FeatureContext.instance.dioMock.getM(Endpoints.recipe(e['id'] as String), responseData: e);
      });
}
