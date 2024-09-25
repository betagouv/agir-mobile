import 'package:app/features/univers/core/domain/defi.dart';

import '../scenario_context.dart';

/// Iel a le défi suivant.
void ielALeDefiSuivant(final Defi valeur) {
  ScenarioContext().defi = valeur;
}
