import 'package:app/src/fonctionnalites/utilisateur/domain/utilisateur.dart';
import 'package:flutter_test/flutter_test.dart';

import '../scenario_context.dart';

/// Iel a débloqué ces fonctionnalités
Future<void> ielADebloqueCesFonctionnalites(
  final WidgetTester tester,
  final List<Fonctionnalites> fonctionnalitesDebloquees,
) async {
  ScenarioContext().fonctionnalitesDebloquees = fonctionnalitesDebloquees;
}
