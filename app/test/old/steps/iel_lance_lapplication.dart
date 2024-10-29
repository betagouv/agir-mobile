import 'package:app/app/app.dart';
import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/features/actions/detail/infrastructure/action_repository.dart';
import 'package:app/features/actions/list/domain/actions_port.dart';
import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentication/domain/authentication_status.dart';
import 'package:app/features/authentication/infrastructure/authentication_repository.dart';
import 'package:app/features/environmental_performance/questions/infrastructure/environment_performance_question_repository.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_data.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_mapper.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_repository.dart';
import 'package:app/features/mission/home/infrastructure/mission_home_repository.dart';
import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/core/infrastructure/mission_liste_mapper.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../environmental_performance/summary/environmental_performance_data.dart';
import '../../mission/mission_home_test.dart';
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

class _MissionHomeRepositoryMock extends Mock implements MissionHomeRepository {
  @override
  Future<Either<Exception, List<MissionListe>>> fetch() async => Right(
        missionThematiques
            .map(
              (final e) =>
                  MissionListeMapper.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );
}

class _EnvironmentalPerformanceRepositoryMock extends Mock
    implements EnvironmentalPerformanceSummaryRepository {
  @override
  Future<Either<Exception, EnvironmentalPerformanceData>> fetch() async =>
      Right(
        EnvironmentalPerformanceSummaryMapperyMapper.fromJson(
          environmentalPerformancePartialData,
        ),
      );
}

class _EnvironmentalPerformanceQuestionRepositoryMock extends Mock
    implements EnvironmentalPerformanceQuestionRepository {}

/// Iel lance l'application.
Future<void> ielLanceLapplication(final WidgetTester tester) async {
  final clock = Clock.fixed(DateTime(1992));
  final authenticationService = AuthenticationService(
    authenticationRepository:
        AuthenticationRepository(FlutterSecureStorageFake()),
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
  ScenarioContext().articlesPortMock =
      ArticlesPortMock(ScenarioContext().article);
  ScenarioContext().authentificationPortMock = AuthentificationPortMock(
    authenticationService,
    prenom: prenom,
    estIntegrationTerminee: ScenarioContext().estIntegrationTerminee,
  );
  ScenarioContext().universPortMock = UniversPortMock(
    themeTile: ScenarioContext().themeTile,
    missionListe: ScenarioContext().missionListe,
    mission: ScenarioContext().mission,
  );

  final profilPort = ScenarioContext().profilPortMock!;
  final tracker = _TrackerMock();
  when(() => tracker.navigatorObserver)
      .thenAnswer((final _) => RouteObserver<ModalRoute<void>>());
  await mockNetworkImages(() async {
    await tester.pumpFrames(
      App(
        tracker: tracker,
        clock: clock,
        missionHomeRepository: _MissionHomeRepositoryMock(),
        authenticationService: authenticationService,
        authentificationPort: ScenarioContext().authentificationPortMock!,
        themePort: ScenarioContext().universPortMock!,
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
        knowYourCustomersRepository: mieuxVousConnaitrePort,
        environmentalPerformanceSummaryRepository:
            _EnvironmentalPerformanceRepositoryMock(),
        environmentalPerformanceQuestionRepository:
            _EnvironmentalPerformanceQuestionRepositoryMock(),
        mieuxVousConnaitrePort: mieuxVousConnaitrePort,
        actionsPort: _ActionsPortMock(),
        actionRepository: _ActionRepositoryMock(),
        gamificationPort: GamificationPortMock(ScenarioContext().gamification),
      ),
      Durations.short1,
    );
  });
}
