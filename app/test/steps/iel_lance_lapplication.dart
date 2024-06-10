import 'package:app/src/app.dart';
import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../aide_velo_repository_mock.dart';
import '../aides_repository_mock.dart';
import '../authentification_repository_mock.dart';
import '../communes_repository_mock.dart';
import '../scenario_context.dart';
import '../utilisateur_repository_mock.dart';
import '../version_repository_mock.dart';

/// Iel lance l'application.
Future<void> ielLanceLapplication(final WidgetTester tester) async {
  final authentificationStatusManager = AuthentificationStatutManager()
    ..gererAuthentificationStatut(ScenarioContext().authentificationStatut);
  ScenarioContext().aideVeloRepositoryMock = AideVeloRepositoryMock(
    aideVeloParType: ScenarioContext().aideVeloParType,
    profil: ScenarioContext().aideVeloInformations,
  );
  await tester.pumpFrames(
    App(
      authentificationStatusManager: authentificationStatusManager,
      authentificationRepository:
          AuthentificationRepositoryMock(authentificationStatusManager),
      utilisateurRepository: UtilisateurRepositoryMock(
        prenom: ScenarioContext().prenom,
        fonctionnalitesDebloquees: ScenarioContext().fonctionnalitesDebloquees,
      ),
      aidesRepository: AidesRepositoryMock(ScenarioContext().aides),
      versionRepository: const VersionRepositoryMock(),
      communesRepository: CommunesRepositoryMock(ScenarioContext().communes),
      aideVeloRepository: ScenarioContext().aideVeloRepositoryMock!,
    ),
    Durations.short1,
  );
}
