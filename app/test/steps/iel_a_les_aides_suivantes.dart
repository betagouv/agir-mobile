import 'package:app/src/fonctionnalites/aides/domain/aide.dart';

import '../scenario_context.dart';

/// Iel a les aides suivantes.
void ielALesAidesSuivantes(final List<Aide> aides) {
  ScenarioContext().aides = aides;
}
