import 'package:app/src/fonctionnalites/aides/domain/aide_velo_informations.dart';

import '../scenario_context.dart';

/// Iel a ces informations de profile.
void ielACesInformationsDeProfile(
  final AideVeloInformations aideVeloInformations,
) {
  ScenarioContext().aideVeloInformations = aideVeloInformations;
}
