import '../scenario_context.dart';

/// Le serveur retourne cette liste de communes.
void leServeurRetourneCetteListeDeCommunes(final List<String> communes) {
  ScenarioContext().communes = communes;
}
