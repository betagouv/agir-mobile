import 'package:app/features/univers/domain/tuile_univers.dart';

import '../scenario_context.dart';

/// Le serveur retourne ces univers.
void leServeurRetourneCesUnivers(final List<TuileUnivers> tuileUnivers) {
  ScenarioContext().tuileUnivers = tuileUnivers;
}
