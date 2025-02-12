import 'dart:async';

import 'package:app/app/router/app_router.dart';
import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/authentication/infrastructure/authentication_injection.dart';
import 'package:app/core/authentication/infrastructure/authentication_redirection.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/core/notifications/domain/notification_data.dart';
import 'package:app/core/notifications/domain/notification_page_type.dart';
import 'package:app/core/notifications/infrastructure/notification_repository.dart';
import 'package:app/core/notifications/infrastructure/notification_service.dart';
import 'package:app/features/action/infrastructure/action_repository.dart';
import 'package:app/features/actions/infrastructure/actions_repository.dart';
import 'package:app/features/aids/core/presentation/bloc/aids_home_bloc.dart';
import 'package:app/features/aids/item/presentation/bloc/aid_bloc.dart';
import 'package:app/features/aids/list/infrastructure/aids_repository.dart';
import 'package:app/features/aids/list/presentation/bloc/aids_disclaimer/aids_disclaimer_cubit.dart';
import 'package:app/features/articles/infrastructure/articles_repository.dart';
import 'package:app/features/articles/presentation/pages/article_page.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_repository.dart';
import 'package:app/features/bibliotheque/infrastructure/bibliotheque_repository.dart';
import 'package:app/features/bibliotheque/presentation/bloc/bibliotheque_bloc.dart';
import 'package:app/features/challenges/detail/infrastructure/challenge_repository.dart';
import 'package:app/features/challenges/list/infrastructure/challenge_list_repository.dart';
import 'package:app/features/challenges/section/infrastructure/challenges_repository.dart';
import 'package:app/features/challenges/section/presentation/bloc/challenges_bloc.dart';
import 'package:app/features/communes/infrastructure/communes_repository.dart';
import 'package:app/features/environmental_performance/questions/infrastructure/environment_performance_question_repository.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_bloc.dart';
import 'package:app/features/environmental_performance/summary/application/fetch_environmental_performance.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_repository.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_bloc.dart';
import 'package:app/features/gamification/infrastructure/gamification_repository.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_event.dart';
import 'package:app/features/home/presentation/cubit/home_disclaimer_cubit.dart';
import 'package:app/features/know_your_customer/core/infrastructure/mieux_vous_connaitre_repository.dart';
import 'package:app/features/know_your_customer/list/infrastructure/know_your_customers_repository.dart';
import 'package:app/features/mission/challenges/infrastructure/mission_challenges_repository.dart';
import 'package:app/features/mission/home/infrastructure/mission_home_repository.dart';
import 'package:app/features/mission/home/presentation/bloc/mission_home_bloc.dart';
import 'package:app/features/mission/mission/infrastructure/mission_repository.dart';
import 'package:app/features/mission/mission/presentation/pages/mission_page.dart';
import 'package:app/features/profil/core/infrastructure/profil_repository.dart';
import 'package:app/features/questions/first_name/infrastructure/first_name_repository.dart';
import 'package:app/features/quiz/infrastructure/quiz_repository.dart';
import 'package:app/features/quiz/presentation/pages/quiz_page.dart';
import 'package:app/features/recommandations/infrastructure/recommandations_repository.dart';
import 'package:app/features/recommandations/presentation/bloc/recommandations_bloc.dart';
import 'package:app/features/seasonal_fruits_and_vegetables/infrastructure/seasonal_fruits_and_vegetables_repository.dart';
import 'package:app/features/simulateur_velo/infrastructure/aide_velo_repository.dart';
import 'package:app/features/simulateur_velo/presentation/bloc/aide_velo_bloc.dart';
import 'package:app/features/theme/core/infrastructure/theme_repository.dart';
import 'package:app/features/upgrade/infrastructure/upgrade_interceptor.dart';
import 'package:app/features/upgrade/presentation/bloc/upgrade_bloc.dart';
import 'package:app/features/upgrade/presentation/widgets/upgrade_widget.dart';
import 'package:app/features/utilisateur/infrastructure/user_repository.dart';
import 'package:app/features/utilisateur/presentation/bloc/user_bloc.dart';
import 'package:app/features/version/infrastructure/version_repository.dart';
import 'package:app/features/version/presentation/bloc/version_bloc.dart';
import 'package:app/features/version/presentation/bloc/version_event.dart';
import 'package:clock/clock.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.clock,
    required this.tracker,
    required this.messageBus,
    required this.dioHttpClient,
    required this.packageInfo,
    required this.notificationService,
    required this.authenticationService,
  });

  final Clock clock;
  final Tracker tracker;
  final MessageBus messageBus;
  final DioHttpClient dioHttpClient;
  final PackageInfo packageInfo;
  final NotificationService notificationService;
  final AuthenticationService authenticationService;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _goRouter;
  late final StreamSubscription<NotificationData> _messageOpenedSubscription;

  @override
  void initState() {
    super.initState();
    _goRouter = goRouter(tracker: widget.tracker);
    _messageOpenedSubscription =
        widget.notificationService.onMessageOpenedApp.listen(
      (final event) async {
        widget.tracker.trackNotificationOpened(
          '${event.pageType} - ${event.pageId}',
        );

        return _handleNotification(goRouter: _goRouter, data: event);
      },
    );
  }

  Future<void> _handleNotification({
    required final GoRouter goRouter,
    required final NotificationData data,
  }) async {
    switch (data.pageType) {
      case NotificationPageType.quiz:
        await _handleQuizNotification(goRouter: goRouter, pageId: data.pageId);
      case NotificationPageType.article:
        await _handleArticleNotification(
          goRouter: goRouter,
          pageId: data.pageId,
        );
      case NotificationPageType.mission:
        await _handleMissionNotification(
          goRouter: goRouter,
          pageId: data.pageId,
        );
    }
  }

  Future<void> _handleQuizNotification({
    required final GoRouter goRouter,
    required final String pageId,
  }) async {
    await goRouter.pushNamed(QuizPage.name, pathParameters: {'id': pageId});
  }

  Future<void> _handleArticleNotification({
    required final GoRouter goRouter,
    required final String pageId,
  }) async {
    await goRouter.pushNamed(
      ArticlePage.name,
      pathParameters: {'titre': 'titre', 'id': pageId},
    );
  }

  Future<void> _handleMissionNotification({
    required final GoRouter goRouter,
    required final String pageId,
  }) async {
    await goRouter.pushNamed(
      MissionPage.name,
      pathParameters: {'mission': pageId, 'thematique': 'thematique'},
    );
  }

  @override
  void dispose() {
    unawaited(_messageOpenedSubscription.cancel());
    _goRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(final context) {
    const locale = Locale('fr', 'FR');

    final upgradeBloc = UpgradeBloc();
    widget.dioHttpClient.add(UpgradeInterceptor(upgradeBloc));

    final gamificationRepository = GamificationRepository(
      client: widget.dioHttpClient,
      messageBus: widget.messageBus,
    );

    final aidsRepository = AidsRepository(client: widget.dioHttpClient);

    final communesRepository = CommunesRepository(
      client: widget.dioHttpClient,
    );

    final profilRepository = ProfilRepository(client: widget.dioHttpClient);

    return InheritedGoRouter(
      goRouter: _goRouter,
      child: AuthenticationInjection(
        authenticationService: widget.authenticationService,
        child: AuthenticationRedirection(
          child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider.value(value: widget.notificationService),
              RepositoryProvider.value(value: widget.tracker),
              RepositoryProvider.value(value: widget.clock),
              RepositoryProvider.value(value: communesRepository),
              RepositoryProvider.value(value: gamificationRepository),
              RepositoryProvider.value(value: profilRepository),
              RepositoryProvider(
                create: (final context) =>
                    QuizRepository(client: widget.dioHttpClient),
              ),
              RepositoryProvider(create: (final context) => aidsRepository),
              RepositoryProvider(
                create: (final context) => MieuxVousConnaitreRepository(
                  client: widget.dioHttpClient,
                  messageBus: widget.messageBus,
                ),
              ),
              RepositoryProvider(
                create: (final context) => KnowYourCustomersRepository(
                  client: widget.dioHttpClient,
                ),
              ),
              RepositoryProvider(
                create: (final context) => FirstNameRepository(
                  client: widget.dioHttpClient,
                ),
              ),
              RepositoryProvider(
                create: (final context) => AuthentificationRepository(
                  client: widget.dioHttpClient,
                  authenticationService: widget.authenticationService,
                ),
              ),
              RepositoryProvider(
                create: (final context) => ThemeRepository(
                  client: widget.dioHttpClient,
                ),
              ),
              RepositoryProvider(
                create: (final context) =>
                    ActionsRepository(client: widget.dioHttpClient),
              ),
              RepositoryProvider(
                create: (final context) =>
                    ActionRepository(client: widget.dioHttpClient),
              ),
              RepositoryProvider(
                create: (final context) =>
                    ArticlesRepository(client: widget.dioHttpClient),
              ),
              RepositoryProvider(
                create: (final context) =>
                    ChallengeListRepository(client: widget.dioHttpClient),
              ),
              RepositoryProvider(
                create: (final context) => ChallengeRepository(
                  client: widget.dioHttpClient,
                  messageBus: widget.messageBus,
                ),
              ),
              RepositoryProvider(
                create: (final context) =>
                    MissionRepository(client: widget.dioHttpClient),
              ),
              RepositoryProvider(
                create: (final context) =>
                    MissionChallengesRepository(client: widget.dioHttpClient),
              ),
              RepositoryProvider(
                create: (final context) => NotificationRepository(
                  client: widget.dioHttpClient,
                  notificationService: widget.notificationService,
                ),
              ),
              RepositoryProvider(
                create: (final context) =>
                    SeasonalFruitsAndVegetablesRepository(
                  client: widget.dioHttpClient,
                ),
              ),
              RepositoryProvider(
                create: (final context) =>
                    ActionsRepository(client: widget.dioHttpClient),
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: upgradeBloc),
                BlocProvider(create: (final context) => HomeDisclaimerCubit()),
                BlocProvider(create: (final context) => AidsDisclaimerCubit()),
                BlocProvider(
                  create: (final context) => UserBloc(
                    repository: UserRepository(client: widget.dioHttpClient),
                  ),
                ),
                BlocProvider(
                  create: (final context) => AidsHomeBloc(
                    aidsRepository: aidsRepository,
                  ),
                ),
                BlocProvider(
                  create: (final context) => MissionHomeBloc(
                    repository:
                        MissionHomeRepository(client: widget.dioHttpClient),
                  ),
                ),
                BlocProvider(
                  create: (final context) => ChallengesBloc(
                    repository: ChallengesRepository(
                      client: widget.dioHttpClient,
                    ),
                  ),
                ),
                BlocProvider(create: (final context) => AidBloc()),
                BlocProvider(
                  create: (final context) => VersionBloc(
                    repository:
                        VersionRepository(packageInfo: widget.packageInfo),
                  )..add(const VersionFetched()),
                ),
                BlocProvider(
                  create: (final context) => AideVeloBloc(
                    profilRepository: profilRepository,
                    communesRepository: communesRepository,
                    aideVeloRepository: AideVeloRepository(
                      client: widget.dioHttpClient,
                    ),
                  ),
                ),
                BlocProvider(
                  create: (final context) => RecommandationsBloc(
                    recommandationsRepository:
                        RecommandationsRepository(client: widget.dioHttpClient),
                  ),
                ),
                BlocProvider(
                  create: (final context) => GamificationBloc(
                    repository: gamificationRepository,
                    authenticationService: widget.authenticationService,
                  )..add(const GamificationAbonnementDemande()),
                ),
                BlocProvider(
                  create: (final context) => BibliothequeBloc(
                    repository: BibliothequeRepository(
                      client: widget.dioHttpClient,
                    ),
                  ),
                ),
                BlocProvider(
                  create: (final context) =>
                      EnvironmentalPerformanceQuestionBloc(
                    repository: EnvironmentalPerformanceQuestionRepository(
                      client: widget.dioHttpClient,
                    ),
                  ),
                ),
                BlocProvider(
                  create: (final context) => EnvironmentalPerformanceBloc(
                    useCase: FetchEnvironmentalPerformance(
                      EnvironmentalPerformanceSummaryRepository(
                        client: widget.dioHttpClient,
                      ),
                    ),
                  ),
                ),
              ],
              child: MaterialApp.router(
                routerConfig: _goRouter,
                builder: (final context, final child) => UpgradeWidget(
                  navigatorKey: _goRouter.routerDelegate.navigatorKey,
                  child: child ?? const SizedBox(),
                ),
                theme: ThemeData(
                  colorSchemeSeed: DsfrColors.blueFranceSun113,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
                ),
                locale: locale,
                localizationsDelegates: const [
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: const [locale],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
