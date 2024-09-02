import 'package:app/features/univers/domain/entities/defi.dart';

import '../scenario_context.dart';

/// Iel a le défi suivant.
void ielALeDefiSuivant(final Defi valeur) {
  ScenarioContext().defi = valeur;
}
