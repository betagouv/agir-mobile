import 'package:app/core/infrastructure/endpoints.dart';
import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';

/// Usage: I have actions in my library
Future<void> iHaveActionsInMyLibrary(final WidgetTester tester, final bdd.DataTable dataTable) async {
  final list =
      dataTable
          .asMaps()
          .map(
            (final e) => {
              'type': e['type'],
              'code': e['code'],
              'titre': e['title'],
              'sous_titre': Faker().lorem.sentence(),
              'nombre_actions_en_cours': e['nb_actions_completed'],
              'nombre_aides_disponibles': e['nb_aids_available'],
            },
          )
          .toList();
  FeatureContext.instance.dioMock.getM(Endpoints.actions, responseData: list);
}
