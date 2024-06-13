import 'package:app/features/aides/domain/entities/aide.dart';

import '../scenario_context.dart';

/// Iel a les aides suivantes.
void ielALesAidesSuivantes(final List<Aide> aides) {
  ScenarioContext().aides = aides;
}
