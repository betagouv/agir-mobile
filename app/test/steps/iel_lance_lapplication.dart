import 'package:app/app/app.dart';
import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/aide_velo_port_mock.dart';
import '../mocks/aides_port_mock.dart';
import '../mocks/articles_port_mock.dart';
import '../mocks/authentification_port_mock.dart';
import '../mocks/bibliotheque_port_mock.dart';
import '../mocks/communes_port_mock.dart';
import '../mocks/gamification_port_mock.dart';
import '../mocks/mieux_vous_connaitre_port_mock.dart';
import '../mocks/profil_port_mock.dart';
import '../mocks/quiz_port_mock.dart';
import '../mocks/recommandations_port_mock.dart';
import '../mocks/univers_port_mock.dart';
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

  ScenarioContext().quizPortMock = QuizPortMock(ScenarioContext().quiz);
  ScenarioContext().articlesPortMock =
      ArticlesPortMock(ScenarioContext().article);
  ScenarioContext().authentificationPortMock =
      AuthentificationPortMock(authentificationStatusManager);

  await tester.pumpFrames(
    App(
      authentificationStatusManager: authentificationStatusManager,
      authentificationPort: ScenarioContext().authentificationPortMock!,
      utilisateurPort: UtilisateurPortMock(
        prenom: prenom,
        fonctionnalitesDebloquees: ScenarioContext().fonctionnalitesDebloquees,
        estIntegrationTerminee: ScenarioContext().estIntegrationTerminee,
      ),
      universPort: UniversPortMock(ScenarioContext().tuileUnivers),
      aidesPort: AidesPortMock(ScenarioContext().aides),
      bibliothequePort: BibliothequePortMock(ScenarioContext().bibliotheque),
      recommandationsPort:
          RecommandationsPortMock(ScenarioContext().recommandations),
      articlesPort: ScenarioContext().articlesPortMock!,
      quizPort: ScenarioContext().quizPortMock!,
      versionPort: const VersionPortMock(),
      communesPort: CommunesPortMock(ScenarioContext().communes),
      aideVeloPort: ScenarioContext().aideVeloPortMock!,
      profilPort: ScenarioContext().profilPortMock!,
      mieuxVousConnaitrePort: ScenarioContext().mieuxVousConnaitrePortMock!,
      gamificationPort: GamificationPortMock(ScenarioContext().gamification),
    ),
    Durations.short1,
  );
}
