import 'package:app/features/recommandations/domain/recommandation.dart';

import '../scenario_context.dart';

/// Iel a les recommandations suivantes.
void ielALesRecommandationsSuivantes(final List<Recommandation> valeur) {
  ScenarioContext().recommandations = valeur;
}
