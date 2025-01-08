import 'package:app/app/app.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentication/domain/authentication_status.dart';
import 'package:app/features/authentication/infrastructure/authentication_storage.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:clock/clock.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../environmental_performance/summary/environmental_performance_data.dart';
import '../../features/helper/notification_service_fake.dart';
import '../../helpers/dio_mock.dart';
import '../../mission/mission_test.dart';
import '../api/constants.dart';
import '../api/flutter_secure_storage_fake.dart';
import '../mocks/aide_velo_port_mock.dart';
import '../mocks/assistances_repository_mock.dart';
import '../mocks/authentification_port_mock.dart';
import '../mocks/bibliotheque_port_mock.dart';
import '../mocks/communes_port_mock.dart';
import '../mocks/gamification_port_mock.dart';
import '../mocks/mieux_vous_connaitre_port_mock.dart';
import '../mocks/profil_port_mock.dart';
import '../mocks/quiz_port_mock.dart';
import '../mocks/recommandations_port_mock.dart';
import '../mocks/theme_port_mock.dart';
import '../mocks/version_port_mock.dart';
import '../scenario_context.dart';

class _TrackerMock extends Mock implements Tracker {}

/// Iel lance l'application.
Future<void> ielLanceLapplication(final WidgetTester tester) async {
  final clock = Clock.fixed(DateTime(1992));
  final authenticationService = AuthenticationService(
    authenticationRepository: AuthenticationStorage(FlutterSecureStorageFake()),
    clock: clock,
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
    plusDe15Ans: ScenarioContext().plusDe15Ans,
    dpe: ScenarioContext().dpe,
    nombreDePartsFiscales: ScenarioContext().nombreDePartsFiscales,
    revenuFiscal: ScenarioContext().revenuFiscal,
  );

  ScenarioContext().mieuxVousConnaitrePortMock =
      MieuxVousConnaitrePortMock(questions: ScenarioContext().questions);
  final mieuxVousConnaitrePort = ScenarioContext().mieuxVousConnaitrePortMock!;

  ScenarioContext().quizPortMock = QuizPortMock(ScenarioContext().quiz);
  ScenarioContext().authentificationPortMock = AuthentificationPortMock(
    authenticationService,
    prenom: prenom,
    estIntegrationTerminee: ScenarioContext().estIntegrationTerminee,
  );
  ScenarioContext().themePortMock = ThemePortMock(
    missionListe: ScenarioContext().missionListe,
  );

  final profilPort = ScenarioContext().profilPortMock!;
  final tracker = _TrackerMock();
  when(() => tracker.navigatorObserver)
      .thenAnswer((final _) => RouteObserver<ModalRoute<void>>());
  final dioMock = DioMock()
    ..getM(
      Endpoints.bilan,
      responseData: environmentalPerformancePartialData,
    )
    ..getM(
      '/utilisateurs/%7BuserId%7D/defis_v2?status=en_cours',
      responseData: <dynamic>[],
    )
    ..getM(
      '/utilisateurs/%7BuserId%7D/defis_v2?status=en_cours&thematique=alimentation',
      responseData: <dynamic>[],
    )
    ..getM(Endpoints.missionsRecommandees, responseData: missionThematiques);

  await mockNetworkImages(() async {
    await tester.pumpFrames(
      App(
        clock: clock,
        tracker: tracker,
        messageBus: MessageBus(),
        dioHttpClient: DioHttpClient(
          dio: dioMock,
          authenticationService: authenticationService,
        ),
        notificationService:
            const NotificationServiceFake(AuthorizationStatus.denied),
        authenticationService: authenticationService,
        authentificationPort: ScenarioContext().authentificationPortMock!,
        themePort: ScenarioContext().themePortMock!,
        assistancesRepository:
            AssistancesRepositoryMock(ScenarioContext().aides),
        bibliothequePort: BibliothequePortMock(ScenarioContext().bibliotheque),
        recommandationsPort:
            RecommandationsPortMock(ScenarioContext().recommandations),
        quizPort: ScenarioContext().quizPortMock!,
        versionPort: const VersionPortMock(),
        communesPort: CommunesPortMock(ScenarioContext().communes),
        aideVeloPort: ScenarioContext().aideVeloPortMock!,
        firstNamePort: profilPort,
        profilPort: profilPort,
        knowYourCustomersRepository: mieuxVousConnaitrePort,
        mieuxVousConnaitrePort: mieuxVousConnaitrePort,
        gamificationPort: GamificationPortMock(ScenarioContext().gamification),
      ),
      Durations.short1,
    );
  });
}
