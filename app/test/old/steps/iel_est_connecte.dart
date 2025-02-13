import 'package:app/core/authentication/domain/authentication_status.dart';
import 'package:app/core/authentication/domain/user_id.dart';

import '../api/constants.dart';
import 'scenario_context.dart';

/// Iel est connecté.
void ielEstConnecte() {
  ScenarioContext().authentificationStatut = const Authenticated(UserId(utilisateurId));
}
