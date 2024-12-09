import 'package:app/app/app.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/features/articles/infrastructure/articles_api_adapter.dart';
import 'package:app/features/assistances/list/infrastructure/assistances_repository.dart';
import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentication/infrastructure/authentication_storage.dart';
import 'package:app/features/authentification/core/infrastructure/api_url.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_api_adapter.dart';
import 'package:app/features/authentification/core/infrastructure/cms_api_client.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/bibliotheque/infrastructure/bibliotheque_api_adapter.dart';
import 'package:app/features/communes/infrastructure/communes_api_adapter.dart';
import 'package:app/features/first_name/infrastructure/first_name_adapter.dart';
import 'package:app/features/gamification/infrastructure/gamification_api_adapter.dart';
import 'package:app/features/know_your_customer/core/infrastructure/mieux_vous_connaitre_api_adapter.dart';
import 'package:app/features/know_your_customer/list/infrastructure/know_your_customers_repository.dart';
import 'package:app/features/profil/core/infrastructure/profil_api_adapter.dart';
import 'package:app/features/quiz/infrastructure/quiz_api_adapter.dart';
import 'package:app/features/recommandations/infrastructure/recommandations_api_adapter.dart';
import 'package:app/features/simulateur_velo/infrastructure/aide_velo_api_adapter.dart';
import 'package:app/features/theme/core/infrastructure/theme_api_adapter.dart';
import 'package:app/features/version/infrastructure/version_adapter.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/feature_context.dart';
import '../helper/package_info_fake.dart';

class _TrackerMock extends Mock implements Tracker {}

/// Usage: the application is launched
Future<void> theApplicationIsLaunched(final WidgetTester tester) async {
  final clock = Clock.fixed(DateTime(1992, 9));
  final authenticationStorage =
      AuthenticationStorage(FeatureContext.instance.secureStorage);
  await authenticationStorage.init();
  final authenticationService = AuthenticationService(
    authenticationRepository: authenticationStorage,
    clock: clock,
  );
  await authenticationService.checkAuthenticationStatus();
  final dioHttpClient = DioHttpClient(
    dio: FeatureContext.instance.dioMock,
    authenticationService: authenticationService,
  );
  final cmsHttpClient = CmsApiClient(
    apiUrl: ApiUrl(Uri.parse('_apiCmsUrl')),
    token: '_apiCmsToken',
  );
  final tracker = _TrackerMock();
  when(() => tracker.navigatorObserver)
      .thenAnswer((final _) => RouteObserver<ModalRoute<void>>());
  final messageBus = MessageBus();
  await tester.pumpFrames(
    App(
      clock: clock,
      tracker: tracker,
      messageBus: messageBus,
      dioHttpClient: dioHttpClient,
      authenticationService: authenticationService,
      authentificationPort: AuthentificationApiAdapter(
        client: dioHttpClient,
        authenticationService: authenticationService,
      ),
      themePort: ThemeApiAdapter(client: dioHttpClient),
      assistancesRepository: AssistancesRepository(client: dioHttpClient),
      bibliothequePort: BibliothequeApiAdapter(client: dioHttpClient),
      recommandationsPort: RecommandationsApiAdapter(client: dioHttpClient),
      articlesPort: ArticlesApiAdapter(
        client: dioHttpClient,
        cmsApiClient: cmsHttpClient,
      ),
      quizPort:
          QuizApiAdapter(client: dioHttpClient, cmsApiClient: cmsHttpClient),
      versionPort: const VersionAdapter(packageInfo: PackageInfoFake()),
      communesPort: CommunesApiAdapter(client: dioHttpClient),
      aideVeloPort: AideVeloApiAdapter(client: dioHttpClient),
      firstNamePort: FirstNameAdapter(client: dioHttpClient),
      profilPort: ProfilApiAdapter(client: dioHttpClient),
      knowYourCustomersRepository:
          KnowYourCustomersRepository(client: dioHttpClient),
      mieuxVousConnaitrePort: MieuxVousConnaitreApiAdapter(
        client: dioHttpClient,
        messageBus: messageBus,
      ),
      gamificationPort:
          GamificationApiAdapter(client: dioHttpClient, messageBus: messageBus),
    ),
    Durations.short1,
  );
}
