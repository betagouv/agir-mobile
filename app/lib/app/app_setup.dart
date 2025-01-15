// ignore_for_file: do_not_use_environment, avoid-long-functions

import 'dart:async';

import 'package:app/app/app.dart';
import 'package:app/core/error/infrastructure/crash_reporting.dart';
import 'package:app/core/error/infrastructure/missing_environment_key_exception.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/core/presentation/pages/error_page.dart';
import 'package:app/features/assistances/list/infrastructure/assistances_repository.dart';
import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentication/infrastructure/authentication_storage.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_api_adapter.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/bibliotheque/infrastructure/bibliotheque_api_adapter.dart';
import 'package:app/features/communes/infrastructure/communes_api_adapter.dart';
import 'package:app/features/gamification/infrastructure/gamification_api_adapter.dart';
import 'package:app/features/know_your_customer/core/infrastructure/mieux_vous_connaitre_api_adapter.dart';
import 'package:app/features/know_your_customer/list/infrastructure/know_your_customers_repository.dart';
import 'package:app/features/notifications/infrastructure/notification_service.dart';
import 'package:app/features/profil/core/infrastructure/profil_api_adapter.dart';
import 'package:app/features/questions/first_name/infrastructure/first_name_adapter.dart';
import 'package:app/features/quiz/infrastructure/quiz_api_adapter.dart';
import 'package:app/features/recommandations/infrastructure/recommandations_api_adapter.dart';
import 'package:app/features/simulateur_velo/infrastructure/aide_velo_api_adapter.dart';
import 'package:app/features/theme/core/infrastructure/theme_api_adapter.dart';
import 'package:app/features/version/infrastructure/version_adapter.dart';
import 'package:clock/clock.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_dio/sentry_dio.dart';

class AppSetup extends StatefulWidget {
  const AppSetup({super.key});

  @override
  State<AppSetup> createState() => _AppSetupState();
}

class _AppSetupState extends State<AppSetup> {
  final _clock = const Clock();
  late final Tracker _tracker;
  late final NotificationService _notificationService;
  late final AuthenticationService _authenticationService;
  late final String _apiUrl;
  late final PackageInfo _packageInfo;

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
    final authenticationStorage = AuthenticationStorage(
      const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      ),
    );
    await authenticationStorage.init();

    _authenticationService = AuthenticationService(
      authenticationRepository: authenticationStorage,
      clock: _clock,
    );
    await _authenticationService.checkAuthenticationStatus();

    _notificationService = NotificationService();
    await _notificationService.initializeApp();
  }

  @override
  Future<void> dispose() async {
    _tracker.dispose();
    await _authenticationService.dispose();
    await CrashReporting.dispose();
    super.dispose();
  }

  @override
  Widget build(final context) => FutureBuilder<void>(
        future: _initializeApp(),
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

          final messageBus = MessageBus();

          final gamificationApiAdapter = GamificationApiAdapter(
            client: client,
            messageBus: messageBus,
          );

          return App(
            clock: _clock,
            tracker: _tracker,
            messageBus: messageBus,
            dioHttpClient: client,
            notificationService: _notificationService,
            authenticationService: _authenticationService,
            authentificationPort: AuthentificationApiAdapter(
              client: client,
              authenticationService: _authenticationService,
            ),
            themePort: ThemeApiAdapter(client: client),
            assistancesRepository: AssistancesRepository(client: client),
            bibliothequePort: BibliothequeApiAdapter(client: client),
            recommandationsPort: RecommandationsApiAdapter(client: client),
            quizPort: QuizApiAdapter(client: client),
            versionPort: VersionAdapter(packageInfo: _packageInfo),
            communesPort: CommunesApiAdapter(client: client),
            aideVeloPort: AideVeloApiAdapter(client: client),
            firstNamePort: FirstNameAdapter(client: client),
            profilPort: ProfilApiAdapter(client: client),
            knowYourCustomersRepository:
                KnowYourCustomersRepository(client: client),
            mieuxVousConnaitrePort: MieuxVousConnaitreApiAdapter(
              client: client,
              messageBus: messageBus,
            ),
            gamificationPort: gamificationApiAdapter,
          );
        },
      );
}

void _captureException(final Object error, final StackTrace? stack) {
  debugPrint('Error: $error${stack == null ? '' : '\n$stack'}');
  unawaited(CrashReporting.captureException(error, stackTrace: stack));
}
