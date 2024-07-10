import 'package:app/app/app.dart';
import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/aide_velo_port_mock.dart';
import '../mocks/aides_port_mock.dart';
import '../mocks/authentification_port_mock.dart';
import '../mocks/communes_port_mock.dart';
import '../mocks/mieux_vous_connaitre_port_mock.dart';
import '../mocks/profil_port_mock.dart';
import '../mocks/recommandations_port_mock.dart';
import '../mocks/utilisateur_port_mock.dart';
import '../mocks/version_port_mock.dart';
import '../scenario_context.dart';

/// Iel lance l'application.
Future<void> ielLanceLapplication(final WidgetTester tester) async {
  final authentificationStatusManager = AuthentificationStatutManager()
    ..gererAuthentificationStatut(ScenarioContext().authentificationStatut);
  ScenarioContext().aideVeloPortMock = AideVeloPortMock(
    aideVeloParType: ScenarioContext().aideVeloParType,
  );
  final prenom = ScenarioContext().prenom;
  ScenarioContext().profilPortMock = ProfilPortMock(
    prenom: prenom,
    nom: ScenarioContext().nom,
    email: ScenarioContext().email,
    codePostal: ScenarioContext().codePostal,
    commune: ScenarioContext().commune,
    nombreAdultes: ScenarioContext().nombreAdultes,
    nombreEnfants: ScenarioContext().nombreEnfants,
    typeDeLogement: ScenarioContext().typeDeLogement,
    estProprietaire: ScenarioContext().estProprietaire,
    superficie: ScenarioContext().superficie,
    chauffage: ScenarioContext().chauffage,
    plusDe15Ans: ScenarioContext().plusDe15Ans,
    dpe: ScenarioContext().dpe,
    nombreDePartsFiscales: ScenarioContext().nombreDePartsFiscales,
    revenuFiscal: ScenarioContext().revenuFiscal,
  );

  ScenarioContext().mieuxVousConnaitrePortMock =
      MieuxVousConnaitrePortMock(questions: ScenarioContext().questions);

  await tester.pumpFrames(
    App(
      authentificationStatusManager: authentificationStatusManager,
      authentificationPort:
          AuthentificationPortMock(authentificationStatusManager),
      utilisateurPort: UtilisateurPortMock(
        prenom: prenom,
        fonctionnalitesDebloquees: ScenarioContext().fonctionnalitesDebloquees,
      ),
      aidesPort: AidesPortMock(ScenarioContext().aides),
      recommandationsPort:
          RecommandationsPortMock(ScenarioContext().recommandations),
      versionPort: const VersionPortMock(),
      communesPort: CommunesPortMock(ScenarioContext().communes),
      aideVeloPort: ScenarioContext().aideVeloPortMock!,
      profilPort: ScenarioContext().profilPortMock!,
      mieuxVousConnaitrePort: ScenarioContext().mieuxVousConnaitrePortMock!,
    ),
    Durations.short1,
  );
}
