import 'package:app/features/authentication/domain/authentication_status.dart';
import 'package:app/features/authentication/domain/user_id.dart';

import '../api/constants.dart';
import '../scenario_context.dart';

/// Iel est connecté.
void ielEstConnecte() {
  ScenarioContext().authentificationStatut =
      const AuthenticationStatus.authenticated(UserId(utilisateurId));
}
