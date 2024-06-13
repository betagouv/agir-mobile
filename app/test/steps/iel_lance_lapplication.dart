import 'package:app/app/app.dart';
import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/aide_velo_port_mock.dart';
import '../mocks/aides_port_mock.dart';
import '../mocks/authentification_port_mock.dart';
import '../mocks/communes_port_mock.dart';
import '../mocks/profil_port_mock.dart';
import '../mocks/utilisateur_port_mock.dart';
import '../mocks/version_port_mock.dart';
import '../scenario_context.dart';

/// Iel lance l'application.
Future<void> ielLanceLapplication(final WidgetTester tester) async {
  final authentificationStatusManager = AuthentificationStatutManager()
    ..gererAuthentificationStatut(ScenarioContext().authentificationStatut);
  ScenarioContext().aideVeloRepositoryMock = AideVeloPortMock(
    aideVeloParType: ScenarioContext().aideVeloParType,
    profil: ScenarioContext().aideVeloInformations,
  );
  final prenom = ScenarioContext().prenom;
  await tester.pumpFrames(
    App(
      authentificationStatusManager: authentificationStatusManager,
      authentificationRepository:
          AuthentificationPortMock(authentificationStatusManager),
      utilisateurRepository: UtilisateurPortMock(
        prenom: prenom,
        fonctionnalitesDebloquees: ScenarioContext().fonctionnalitesDebloquees,
      ),
      aidesRepository: AidesPortMock(ScenarioContext().aides),
      versionRepository: const VersionPortMock(),
      communesRepository: CommunesPortMock(ScenarioContext().communes),
      aideVeloRepository: ScenarioContext().aideVeloRepositoryMock!,
      profilRepository: ProfilPortMock(
        prenom: prenom,
        nom: ScenarioContext().nom,
        adresseElectronique: ScenarioContext().adresseElectronique,
      ),
    ),
    Durations.short1,
  );
}
