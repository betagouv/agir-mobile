import 'package:app/features/theme/core/domain/mission_liste.dart';

import '../scenario_context.dart';

/// Iel a les missions suivantes.
void ielALesMissionsSuivantes(final List<MissionListe> valeur) {
  ScenarioContext().missionListe = valeur;
}
