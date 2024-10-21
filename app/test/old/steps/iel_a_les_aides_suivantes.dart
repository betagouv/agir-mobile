import 'package:app/features/aides/core/domain/aide.dart';

import '../scenario_context.dart';

/// Iel a les aides suivantes.
void ielALesAidesSuivantes(final List<Aid> aides) {
  ScenarioContext().aides = aides;
}
