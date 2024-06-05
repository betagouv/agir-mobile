import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut.dart';

import '../scenario_context.dart';

/// Iel est connecté.
void ielEstConnecte() {
  ScenarioContext().authentificationStatut = AuthentificationStatut.connecte;
}
