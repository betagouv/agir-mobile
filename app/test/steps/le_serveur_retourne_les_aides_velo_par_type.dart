import 'package:app/features/aides/simulateur_velo/domain/value_objects/aide_velo_par_type.dart';

import '../scenario_context.dart';

/// Le serveur retourne les aides vélo par type.
void leServeurRetourneLesAidesVeloParType(
  final AideVeloParType aideVeloParType,
) {
  ScenarioContext().aideVeloParType = aideVeloParType;
}
