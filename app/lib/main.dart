// ignore_for_file: do_not_use_environment, avoid-long-functions

import 'dart:async';

import 'package:app/app/app.dart';
import 'package:app/core/error/infrastructure/crash_reporting.dart';
import 'package:app/core/error/infrastructure/missing_environment_key_exception.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/core/presentation/pages/error_page.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/actions/detail/infrastructure/action_repository.dart';
import 'package:app/features/actions/list/infrastructure/actions_adapter.dart';
import 'package:app/features/aides/core/infrastructure/aides_api_adapter.dart';
import 'package:app/features/articles/infrastructure/articles_api_adapter.dart';
import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentication/infrastructure/authentication_repository.dart';
import 'package:app/features/authentification/core/infrastructure/api_url.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_api_adapter.dart';
import 'package:app/features/authentification/core/infrastructure/cms_api_client.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/bibliotheque/infrastructure/bibliotheque_api_adapter.dart';
import 'package:app/features/communes/infrastructure/communes_api_adapter.dart';
import 'package:app/features/environmental_performance/questions/infrastructure/environment_performance_question_repository.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_repository.dart';
import 'package:app/features/first_name/infrastructure/first_name_adapter.dart';
import 'package:app/features/gamification/infrastructure/gamification_api_adapter.dart';
import 'package:app/features/know_your_customer/list/infrastructure/know_your_customers_repository.dart';
import 'package:app/features/mieux_vous_connaitre/core/infrastructure/mieux_vous_connaitre_api_adapter.dart';
import 'package:app/features/mission/home/infrastructure/mission_home_repository.dart';
import 'package:app/features/profil/core/infrastructure/profil_api_adapter.dart';
import 'package:app/features/quiz/infrastructure/quiz_api_adapter.dart';
import 'package:app/features/recommandations/infrastructure/recommandations_api_adapter.dart';
import 'package:app/features/simulateur_velo/infrastructure/aide_velo_api_adapter.dart';
import 'package:app/features/theme/core/infrastructure/univers_api_adapter.dart';
import 'package:app/features/version/infrastructure/version_adapter.dart';
import 'package:app/l10n/l10n.dart';
import 'package:clock/clock.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_dio/sentry_dio.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  if (!kDebugMode) {
    await CrashReporting.init();
  }
  _registerErrorHandlers();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _clock = const Clock();
  late final Tracker _tracker;
  late final AuthenticationService _authenticationService;
  late final String _apiUrl;
  late final String _apiCmsUrl;
  late final String _apiCmsToken;
  late final PackageInfo _packageInfo;
  late final Future<void> _initApp;

  @override
  void initState() {
    super.initState();
    // ignore: avoid-async-call-in-sync-function
    _initApp = _initializeApp();
  }

  Future<void> _initializeApp() async {
    _packageInfo = await PackageInfo.fromPlatform();
    const matomoSiteIdKey = 'MATOMO_SITE_ID';
    const matomoSiteId = String.fromEnvironment(matomoSiteIdKey);

    const matomoUrlKey = 'MATOMO_URL';
    const matomoUrl = String.fromEnvironment(matomoUrlKey);

    _tracker = const Tracker();
    if (!kDebugMode && matomoSiteId.isNotEmpty && matomoUrl.isNotEmpty) {
      await _tracker.init(siteId: matomoSiteId, url: matomoUrl);
    }

    const apiUrlKey = 'API_URL';
    _apiUrl = const String.fromEnvironment(apiUrlKey);
    if (_apiUrl.isEmpty) {
      throw const MissingEnvironmentKeyException(apiUrlKey);
    }

    const apiCmsUrlKey = 'API_CMS_URL';
    _apiCmsUrl = const String.fromEnvironment(apiCmsUrlKey);
    if (_apiCmsUrl.isEmpty) {
      throw const MissingEnvironmentKeyException(apiCmsUrlKey);
    }

    const apiCmsTokenKey = 'API_CMS_TOKEN';
    _apiCmsToken = const String.fromEnvironment(apiCmsTokenKey);
    if (_apiCmsToken.isEmpty) {
      throw const MissingEnvironmentKeyException(apiCmsTokenKey);
    }

    _authenticationService = AuthenticationService(
      authenticationRepository: AuthenticationRepository(
        const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
        ),
      ),
      clock: _clock,
    );
    await _authenticationService.checkAuthenticationStatus();
  }

  @override
  Future<void> dispose() async {
    _tracker.dispose();
    await _authenticationService.dispose();
    super.dispose();
  }

  @override
  Widget build(final context) => FutureBuilder<void>(
        future: _initApp,
        builder: (final context, final snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          } else if (snapshot.hasError) {
            FlutterNativeSplash.remove();
            _captureException(
              snapshot.error!.toString(),
              snapshot.stackTrace,
            );

            return ErrorScreen(packageInfo: _packageInfo);
          }
          FlutterNativeSplash.remove();

          final url = Uri.parse(_apiUrl);
          final dio = Dio(
            BaseOptions(
              baseUrl: url.toString(),
              validateStatus: (final status) => true,
            ),
          )
            ..httpClientAdapter = NativeAdapter()
            ..addSentry();

          final client = DioHttpClient(
            dio: dio,
            authenticationService: _authenticationService,
          );
          final cmsClient = CmsApiClient(
            apiUrl: ApiUrl(Uri.parse(_apiCmsUrl)),
            token: _apiCmsToken,
          );

          final messageBus = MessageBus();

          final gamificationApiAdapter = GamificationApiAdapter(
            client: client,
            messageBus: messageBus,
          );

          return App(
            tracker: _tracker,
            clock: _clock,
            missionHomeRepository: MissionHomeRepository(client: client),
            dioHttpClient: client,
            authenticationService: _authenticationService,
            authentificationPort: AuthentificationApiAdapter(
              client: client,
              authenticationService: _authenticationService,
            ),
            themePort: UniversApiAdapter(client: client),
            aidesPort: AidesApiAdapter(client: client),
            bibliothequePort: BibliothequeApiAdapter(client: client),
            recommandationsPort: RecommandationsApiAdapter(client: client),
            articlesPort: ArticlesApiAdapter(
              client: client,
              cmsApiClient: cmsClient,
            ),
            quizPort: QuizApiAdapter(client: client, cmsApiClient: cmsClient),
            versionPort: VersionAdapter(packageInfo: _packageInfo),
            communesPort: CommunesApiAdapter(client: client),
            aideVeloPort: AideVeloApiAdapter(client: client),
            firstNamePort: FirstNameAdapter(client: client),
            profilPort: ProfilApiAdapter(client: client),
            knowYourCustomersRepository:
                KnowYourCustomersRepository(client: client),
            environmentalPerformanceSummaryRepository:
                EnvironmentalPerformanceSummaryRepository(client: client),
            environmentalPerformanceQuestionRepository:
                EnvironmentalPerformanceQuestionRepository(client: client),
            mieuxVousConnaitrePort: MieuxVousConnaitreApiAdapter(
              client: client,
              messageBus: messageBus,
            ),
            actionsPort: ActionsAdapter(client: client),
            actionRepository:
                ActionRepository(client: client, messageBus: messageBus),
            gamificationPort: gamificationApiAdapter,
          );
        },
      );
}

void _registerErrorHandlers() {
  FlutterError.onError = (final details) {
    FlutterError.presentError(details);
    _captureException(details.exception, details.stack);
  };

  PlatformDispatcher.instance.onError = (final error, final stack) {
    _captureException(error, stack);

    return true;
  };

  ErrorWidget.builder = (final details) {
    _captureException(details.exception, details.stack);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text(Localisation.erreurInattendue)),
        body: Padding(
          padding: const EdgeInsets.all(paddingVerticalPage),
          child: Center(child: Text(details.exceptionAsString())),
        ),
      ),
    );
  };
}

void _captureException(final Object error, final StackTrace? stack) {
  debugPrint('Error: $error${stack == null ? '' : '\n$stack'}');
  unawaited(CrashReporting.captureException(error, stackTrace: stack));
}
