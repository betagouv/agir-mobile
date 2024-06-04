import '../scenario_context.dart';

/// Iel s'appelle.
void ielSappelle(final String prenom, {final String? nom}) {
  ScenarioContext().prenom = prenom;
  if (nom != null) {
    ScenarioContext().nom = nom;
  }
}
