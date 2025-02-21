import 'package:app/app/app.dart';
import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/authentication/domain/authentication_status.dart';
import 'package:app/core/authentication/infrastructure/authentication_storage.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/core/infrastructure/tracker.dart';
import 'package:clock/clock.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../environmental_performance/summary/environmental_performance_data.dart';
import '../../features/helper/notification_service_fake.dart';
import '../../features/helper/package_info_fake.dart';
import '../../mission/mission_test.dart';
import '../api/constants.dart';
import '../mocks/flutter_secure_storage_fake.dart';
import 'scenario_context.dart';

class _TrackerMock extends Mock implements Tracker {}

/// Iel lance l'application.
Future<void> ielLanceLapplication(final WidgetTester tester) async {
  final clock = Clock.fixed(DateTime(1992));
  final authenticationService = AuthenticationService(
    authenticationStorage: AuthenticationStorage(FlutterSecureStorageFake()),
    clock: clock,
  );
  if (ScenarioContext().authentificationStatut is Authenticated) {
    await authenticationService.login(token);
  }

  final tracker = _TrackerMock();
  when(() => tracker.navigatorObserver).thenAnswer((final _) => RouteObserver<ModalRoute<void>>());
  ScenarioContext().dioMock!
    ..getM(Endpoints.bilan, responseData: environmentalPerformancePartialData)
    ..getM(Endpoints.utilisateur, responseData: {'prenom': 'Lucas', 'is_onboarding_done': true})
    ..getM('/utilisateurs/%7BuserId%7D/defis_v2?status=en_cours', responseData: <dynamic>[])
    ..getM('/utilisateurs/%7BuserId%7D/defis_v2?status=en_cours&thematique=alimentation', responseData: <dynamic>[])
    ..getM(Endpoints.gamification, responseData: {'points': 650})
    ..getM(Endpoints.missionsRecommandees, responseData: missionThematiques)
    ..getM(
      Endpoints.aids,
      responseData: {
        'couverture_aides_ok': true,
        'liste_aides': <Map<String, dynamic>>[
          {
            'titre': 'Acheter un vélo',
            'contenu':
                "<p>Vous souhaitez acheter un vélo neuf ou d'occasion, qu'il soit électrique ou classique ? Cette aide est faite pour vous !</p><p></p><h3><strong>Votre éligibilité</strong></h3><p><strong>1 aide nationale disponible</strong> pour les <strong>majeurs, domiciliés en France</strong></p><p><strong>Plusieurs aides sous conditions</strong></p><p></p><h3><strong>Types de vélo</strong></h3><ul><li><p>Mécanique / Électrique</p></li><li><p>Classique / Pliant / Cargo</p></li></ul><p></p><h3><strong>En quoi cela a de l'impact ?</strong></h3><p>Le vélo est un des moyens de transport les moins carbonés.</p><p>Il peut remplacer la voiture dans de nombreux cas et c'est bon pour la santé !</p>",
            'url_simulateur': '/aides/velo',
            'thematiques': ['transport'],
            'montant_max': 1500,
            'est_gratuit': false,
          },
        ],
      },
    )
    ..getM(Endpoints.missionsRecommandeesParThematique('alimentation'), responseData: <dynamic>[])
    ..getM(Endpoints.servicesParThematique('alimentation'), responseData: <dynamic>[]);

  await mockNetworkImages(() async {
    await tester.pumpFrames(
      App(
        clock: clock,
        tracker: tracker,
        messageBus: MessageBus(),
        dioHttpClient: DioHttpClient(dio: ScenarioContext().dioMock!, authenticationService: authenticationService),
        packageInfo: const PackageInfoFake(version: '1.2.3', buildNumber: '4'),
        notificationService: const NotificationServiceFake(AuthorizationStatus.denied),
        authenticationService: authenticationService,
      ),
      Durations.short1,
    );
  });
}
