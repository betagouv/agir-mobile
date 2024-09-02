import 'package:app/features/univers/domain/mission_liste.dart';

import '../scenario_context.dart';

/// Iel a les univers thématiques suivantes.
void ielALesMissionsSuivantes(final List<MissionListe> valeur) {
  ScenarioContext().missionListe = valeur;
}
