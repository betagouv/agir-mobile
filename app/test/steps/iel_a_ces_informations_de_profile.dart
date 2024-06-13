import 'package:app/features/aides/simulateur_velo/domain/value_objects/aide_velo_informations.dart';

import '../scenario_context.dart';

/// Iel a ces informations de profile.
void ielACesInformationsDeProfile(
  final AideVeloInformations aideVeloInformations,
) {
  ScenarioContext().aideVeloInformations = aideVeloInformations;
}
