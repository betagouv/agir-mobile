// ignore_for_file: do_not_use_environment, avoid-long-functions

import 'dart:async';

import 'package:app/app/app.dart';
import 'package:app/features/aides/infrastructure/adapters/aide_velo_api_adapter.dart';
import 'package:app/features/aides/infrastructure/adapters/aides_api_adapter.dart';
import 'package:app/features/articles/infrastructure/adapters/articles_api_adapter.dart';
import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/infrastructure/adapters/api_url.dart';
import 'package:app/features/authentification/infrastructure/adapters/authentification_api_adapter.dart';
import 'package:app/features/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/features/authentification/infrastructure/adapters/authentification_token_storage.dart';
import 'package:app/features/authentification/infrastructure/adapters/cms_api_client.dart';
import 'package:app/features/authentification/infrastructure/adapters/dio_http_client.dart';
import 'package:app/features/bibliotheque/infrastructure/adapters/bibliotheque_api_adapter.dart';
import 'package:app/features/communes/infrastructure/adapters/communes_api_adapter.dart';
import 'package:app/features/first_name/infrastructure/first_name_adapter.dart';
import 'package:app/features/gamification/infrastructure/adapters/gamification_api_adapter.dart';
import 'package:app/features/mieux_vous_connaitre/infrastructure/adapters/mieux_vous_connaitre_api_adapter.dart';
import 'package:app/features/profil/infrastructure/adapters/profil_api_adapter.dart';
import 'package:app/features/quiz/infrastructure/adapters/quiz_api_adapter.dart';
import 'package:app/features/recommandations/infrastructure/adapters/recommandations_api_adapter.dart';
import 'package:app/features/univers/infrastructure/adapters/univers_api_adapter.dart';
import 'package:app/features/version/infrastructure/adapters/version_adapter.dart';
import 'package:app/shared/wrappers/crash_reporting.dart';
import 'package:app/shared/wrappers/tracker.dart';
import 'package:dio/dio.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const matomoSiteIdKey = 'MATOMO_SITE_ID';
  const matomoSiteId = String.fromEnvironment(matomoSiteIdKey);
  if (matomoSiteId.isEmpty) {
    throw Exception(matomoSiteIdKey);
  }

  const matomoUrlKey = 'MATOMO_URL';
  const matomoUrl = String.fromEnvironment(matomoUrlKey);
  if (matomoUrl.isEmpty) {
    throw Exception(matomoUrlKey);
  }

  const tracker = Tracker();
  if (!kDebugMode) {
    await CrashReporting.init();
    await tracker.init(siteId: matomoSiteId, url: matomoUrl);
  }

  _registerErrorHandlers();

  const apiUrlKey = 'API_URL';
  const apiUrl = String.fromEnvironment(apiUrlKey);
  if (apiUrl.isEmpty) {
    throw Exception(apiUrlKey);
  }

  const apiCmsUrlKey = 'API_CMS_URL';
  const apiCmsUrl = String.fromEnvironment(apiCmsUrlKey);
  if (apiCmsUrl.isEmpty) {
    throw Exception(apiCmsUrlKey);
  }

  const apiCmsTokenKey = 'API_CMS_TOKEN';
  const apiCmsToken = String.fromEnvironment(apiCmsTokenKey);
  if (apiCmsToken.isEmpty) {
    throw Exception(apiCmsTokenKey);
  }

  final packageInfo = await PackageInfo.fromPlatform();

  final authentificationStatusManager = AuthentificationStatutManager();

  final authentificationTokenStorage = AuthentificationTokenStorage(
    secureStorage: const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ),
    authentificationStatusManagerWriter: authentificationStatusManager,
  );

  await authentificationTokenStorage.initialise();

  final url = Uri.parse(apiUrl);
  final apiClient = AuthentificationApiClient(
    apiUrl: ApiUrl(url),
    authentificationTokenStorage: authentificationTokenStorage,
  );
  final dioHttpClient = DioHttpClient(
    dio: Dio(BaseOptions(baseUrl: url.toString())),
    authentificationTokenStorage: authentificationTokenStorage,
  );
  final cmsClient = CmsApiClient(
    apiUrl: ApiUrl(Uri.parse(apiCmsUrl)),
    token: apiCmsToken,
  );

  runApp(
    App(
      tracker: tracker,
      authentificationStatusManager: authentificationStatusManager,
      authentificationPort: AuthentificationApiAdapter(apiClient: apiClient),
      universPort: UniversApiAdapter(apiClient: apiClient),
      aidesPort: AidesApiAdapter(client: dioHttpClient),
      bibliothequePort: BibliothequeApiAdapter(apiClient: apiClient),
      recommandationsPort: RecommandationsApiAdapter(apiClient: apiClient),
      articlesPort:
          ArticlesApiAdapter(apiClient: apiClient, cmsApiClient: cmsClient),
      quizPort: QuizApiAdapter(
        apiClient: apiClient,
        cmsApiClient: cmsClient,
      ),
      versionPort: VersionAdapter(packageInfo: packageInfo),
      communesPort: CommunesApiAdapter(apiClient: apiClient),
      aideVeloPort: AideVeloApiAdapter(client: dioHttpClient),
      firstNamePort: FirstNameAdapter(apiClient: apiClient),
      profilPort: ProfilApiAdapter(apiClient: apiClient),
      mieuxVousConnaitrePort:
          MieuxVousConnaitreApiAdapter(apiClient: apiClient),
      gamificationPort: GamificationApiAdapter(apiClient: apiClient),
    ),
  );
}

void _registerErrorHandlers() {
  FlutterError.onError = (final details) {
    FlutterError.presentError(details);
    debugPrint('FlutterError: ${details.exception}\n${details.stack ?? ''}');
    _captureException(details.exception, details.stack);
  };

  PlatformDispatcher.instance.onError = (final error, final stack) {
    debugPrint('PlatformDispatcher: $error\n$stack');
    _captureException(error, stack);

    return true;
  };

  ErrorWidget.builder = (final details) {
    _captureException(details.exception, details.stack);

    return Scaffold(
      appBar: AppBar(
        title: const Text('An error occurred'),
        backgroundColor: DsfrColors.redMarianneMain472,
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}

void _captureException(final Object error, final StackTrace? stack) {
  unawaited(CrashReporting.captureException(error, stackTrace: stack));
}
