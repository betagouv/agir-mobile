import 'package:app/features/gamification/domain/gamification.dart';

import '../scenario_context.dart';

/// Le serveur retourne cette gamification.
void leServeurRetourneCetteGamification(final Gamification gamification) {
  ScenarioContext().gamification = gamification;
}
