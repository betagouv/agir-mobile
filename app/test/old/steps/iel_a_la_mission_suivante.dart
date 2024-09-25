import 'package:app/features/univers/core/domain/mission.dart';

import '../scenario_context.dart';

/// Iel a la mission suivante.
void ielALaMissionSuivante(final Mission valeur) {
  ScenarioContext().mission = valeur;
}
