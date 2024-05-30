import 'package:app/src/fonctionnalites/aides/domain/aide.dart';
import 'package:flutter_test/flutter_test.dart';

import '../scenario_context.dart';

/// Iel a les aides suivantes
Future<void> ielALesAidesSuivantes(
  final WidgetTester tester,
  final List<Aide> aides,
) async {
  ScenarioContext().aides = aides;
}
