import 'package:app/src/fonctionnalites/aides/domain/aide_velo_par_type.dart';

import '../scenario_context.dart';

/// Le serveur retourne les aides vélo par type.
void leServeurRetourneLesAidesVeloParType(
  final AideVeloParType aideVeloParType,
) {
  ScenarioContext().aideVeloParType = aideVeloParType;
}