import 'package:app/features/authentification/core/domain/authentification_statut.dart';

import '../scenario_context.dart';

/// Iel est connecté.
void ielEstConnecte() {
  ScenarioContext().authentificationStatut = AuthentificationStatut.connecte;
}
