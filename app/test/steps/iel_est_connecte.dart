import 'package:app/features/authentification/domain/value_objects/authentification_statut.dart';

import '../scenario_context.dart';

/// Iel est connecté.
void ielEstConnecte() {
  ScenarioContext().authentificationStatut = AuthentificationStatut.connecte;
}
