// ignore_for_file: do_not_use_environment, avoid-long-functions

import 'dart:async';

import 'package:app/app/app.dart';
import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/authentication/infrastructure/authentication_storage.dart';
import 'package:app/core/error/infrastructure/crash_reporting.dart';
import 'package:app/core/error/infrastructure/error_handler.dart';
import 'package:app/core/error/infrastructure/missing_environment_key_exception.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/core/presentation/pages/error_page.dart';
import 'package:app/features/assistances/list/infrastructure/assistances_repository.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_api_adapter.dart';
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
  late final PackageInfo _packageInfo;
  late final Tracker _tracker;
  late final NotificationService _notificationService;
  late final AuthenticationService _authenticationService;

  // HACK(lsaudon): Pour que la FutureBuilder soit appelée une seule fois
  late final _initializeDependenciesFuture = _initializeApp();

  Future<void> _initializeApp() async {
    _packageInfo = await PackageInfo.fromPlatform();
    _tracker = await _initializeTracker();
    _notificationService = await _initializeNotificationService();
    _authenticationService = await _initializeAuthenticationService();
  }

  Future<Tracker> _initializeTracker() async {
    const matomoSiteIdKey = 'MATOMO_SITE_ID';
    if (matomoSiteIdKey.isEmpty) {
      throw const MissingEnvironmentKeyException(matomoSiteIdKey);
    }
    const matomoSiteId = String.fromEnvironment(matomoSiteIdKey);

    const matomoUrlKey = 'MATOMO_URL';
    if (matomoUrlKey.isEmpty) {
      throw const MissingEnvironmentKeyException(matomoUrlKey);
    }
    const matomoUrl = String.fromEnvironment(matomoUrlKey);

    const tracker = Tracker();
    if (!kDebugMode && matomoSiteId.isNotEmpty && matomoUrl.isNotEmpty) {
      await tracker.init(siteId: matomoSiteId, url: matomoUrl);
    }

    return tracker;
  }

  Future<NotificationService> _initializeNotificationService() async {
    final notificationService = NotificationService();
    await notificationService.initializeApp();

    return notificationService;
  }

  Future<AuthenticationService> _initializeAuthenticationService() async {
    final authenticationStorage = AuthenticationStorage(
      const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      ),
    );
    await authenticationStorage.init();

    final authenticationService = AuthenticationService(
      authenticationRepository: authenticationStorage,
      clock: _clock,
    );
    await authenticationService.checkAuthenticationStatus();

    return authenticationService;
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
        future: _initializeDependenciesFuture,
        builder: (final context, final snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          } else if (snapshot.hasError) {
            FlutterNativeSplash.remove();
            ErrorHandler.captureException(
              snapshot.error!.toString(),
              snapshot.stackTrace,
            );

            return ErrorScreen(packageInfo: _packageInfo);
          }
          FlutterNativeSplash.remove();

          const apiUrlKey = 'API_URL';
          const apiUrl = String.fromEnvironment(apiUrlKey);
          if (apiUrl.isEmpty) {
            throw const MissingEnvironmentKeyException(apiUrlKey);
          }

          final dio = Dio(
            BaseOptions(
              baseUrl: Uri.parse(apiUrl).toString(),
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
            packageInfo: _packageInfo,
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
