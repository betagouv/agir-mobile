import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';

import '../scenario_context.dart';

/// Iel a débloqué ces fonctionnalités.
void ielADebloqueCesFonctionnalites(
  final List<Fonctionnalites> fonctionnalitesDebloquees,
) {
  ScenarioContext().fonctionnalitesDebloquees = fonctionnalitesDebloquees;
}
