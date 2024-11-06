import 'package:app/features/assistances/core/domain/aide.dart';

import '../scenario_context.dart';

/// Iel a les aides suivantes.
void ielALesAidesSuivantes(final List<Assistance> aides) {
  ScenarioContext().aides = aides;
}
