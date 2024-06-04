import 'package:flutter_test/flutter_test.dart';

import '../scenario_context.dart';

/// Le serveur retourne cette liste de communes.
Future<void> leServeurRetourneCetteListeDeCommunes(
  final WidgetTester tester,
  final List<String> communes,
) async {
  ScenarioContext().communes = communes;
}
