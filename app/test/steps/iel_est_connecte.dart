import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut.dart';
import 'package:flutter_test/flutter_test.dart';

import '../scenario_context.dart';

/// Iel est connecté
Future<void> ielEstConnecte(final WidgetTester tester) async {
  ScenarioContext().authentificationStatut = AuthentificationStatut.connecte;
}
