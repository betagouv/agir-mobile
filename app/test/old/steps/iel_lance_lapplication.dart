import 'package:app/app/app.dart';
import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/features/actions/detail/infrastructure/action_repository.dart';
import 'package:app/features/actions/list/domain/actions_port.dart';
import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentication/domain/authentication_status.dart';
import 'package:app/features/authentication/infrastructure/authentication_repository.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../api/constants.dart';
import '../api/flutter_secure_storage_fake.dart';
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
import '../mocks/version_port_mock.dart';
import '../scenario_context.dart';

class _TrackerMock extends Mock implements Tracker {}

class _ActionsPortMock extends Mock implements ActionsPort {}

class _ActionRepositoryMock extends Mock implements ActionRepository {}

/// Iel lance l'application.
Future<void> ielLanceLapplication(final WidgetTester tester) async {
  final authenticationService = AuthenticationService(
    authenticationRepository:
        AuthenticationRepository(FlutterSecureStorageFake()),
    clock: Clock.fixed(DateTime(1992)),
  );
  if (ScenarioContext().authentificationStatut is Authenticated) {
    await authenticationService.login(token);
  }
  ScenarioContext().aideVeloPortMock = AideVeloPortMock(
    aideVeloParType: ScenarioContext().aideVeloParType,
  );
  final prenom = ScenarioContext().prenom;
  ScenarioContext().profilPortMock = ProfilPortMock(
    email: ScenarioContext().email,
    prenom: prenom,
    nom: ScenarioContext().nom,
    anneeDeNaissance: ScenarioContext().anneeDeNaissance,
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
  ScenarioContext().authentificationPortMock = AuthentificationPortMock(
    authenticationService,
    prenom: prenom,
    estIntegrationTerminee: ScenarioContext().estIntegrationTerminee,
  );
  ScenarioContext().universPortMock = UniversPortMock(
    univers: ScenarioContext().tuileUnivers,
    missionListe: ScenarioContext().missionListe,
    mission: ScenarioContext().mission,
  );

  final profilPort = ScenarioContext().profilPortMock!;
  final tracker = _TrackerMock();
  when(() => tracker.navigatorObserver)
      .thenAnswer((final _) => RouteObserver<ModalRoute<void>>());
  await tester.pumpFrames(
    App(
      tracker: tracker,
      authenticationService: authenticationService,
      authentificationPort: ScenarioContext().authentificationPortMock!,
      universPort: ScenarioContext().universPortMock!,
      aidesPort: AidesPortMock(ScenarioContext().aides),
      bibliothequePort: BibliothequePortMock(ScenarioContext().bibliotheque),
      recommandationsPort:
          RecommandationsPortMock(ScenarioContext().recommandations),
      articlesPort: ScenarioContext().articlesPortMock!,
      quizPort: ScenarioContext().quizPortMock!,
      versionPort: const VersionPortMock(),
      communesPort: CommunesPortMock(ScenarioContext().communes),
      aideVeloPort: ScenarioContext().aideVeloPortMock!,
      firstNamePort: profilPort,
      profilPort: profilPort,
      mieuxVousConnaitrePort: ScenarioContext().mieuxVousConnaitrePortMock!,
      actionsPort: _ActionsPortMock(),
      actionRepository: _ActionRepositoryMock(),
      gamificationPort: GamificationPortMock(ScenarioContext().gamification),
    ),
    Durations.short1,
  );
}
