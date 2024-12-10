import 'package:app/app/router/app_router.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/features/accueil/presentation/cubit/home_disclaimer_cubit.dart';
import 'package:app/features/actions/detail/infrastructure/action_repository.dart';
import 'package:app/features/actions/list/infrastructure/actions_adapter.dart';
import 'package:app/features/articles/domain/articles_port.dart';
import 'package:app/features/articles/infrastructure/articles_api_adapter.dart';
import 'package:app/features/assistances/core/presentation/bloc/aides_accueil_bloc.dart';
import 'package:app/features/assistances/item/presentation/bloc/aide_bloc.dart';
import 'package:app/features/assistances/list/infrastructure/assistances_repository.dart';
import 'package:app/features/assistances/list/presentation/bloc/aides_disclaimer/aides_disclaimer_cubit.dart';
import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentication/infrastructure/authentication_injection.dart';
import 'package:app/features/authentication/infrastructure/authentication_redirection.dart';
import 'package:app/features/authentification/core/domain/authentification_port.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/bibliotheque/domain/bibliotheque_port.dart';
import 'package:app/features/bibliotheque/presentation/bloc/bibliotheque_bloc.dart';
import 'package:app/features/communes/domain/communes_port.dart';
import 'package:app/features/environmental_performance/questions/infrastructure/environment_performance_question_repository.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_bloc.dart';
import 'package:app/features/environmental_performance/summary/application/fetch_environmental_performance.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_repository.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_bloc.dart';
import 'package:app/features/first_name/domain/first_name_port.dart';
import 'package:app/features/gamification/domain/gamification_port.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_event.dart';
import 'package:app/features/know_your_customer/core/domain/mieux_vous_connaitre_port.dart';
import 'package:app/features/know_your_customer/list/infrastructure/know_your_customers_repository.dart';
import 'package:app/features/mission/actions/infrastructure/mission_actions_repository.dart';
import 'package:app/features/mission/home/infrastructure/mission_home_repository.dart';
import 'package:app/features/mission/home/presentation/bloc/mission_home_bloc.dart';
import 'package:app/features/mission/mission/infrastructure/mission_repository.dart';
import 'package:app/features/profil/core/domain/profil_port.dart';
import 'package:app/features/quiz/domain/quiz_port.dart';
import 'package:app/features/recommandations/domain/recommandations_port.dart';
import 'package:app/features/recommandations/presentation/bloc/recommandations_bloc.dart';
import 'package:app/features/simulateur_velo/domain/aide_velo_port.dart';
import 'package:app/features/simulateur_velo/presentation/bloc/aide_velo_bloc.dart';
import 'package:app/features/theme/core/domain/theme_port.dart';
import 'package:app/features/upgrade/infrastructure/upgrade_interceptor.dart';
import 'package:app/features/upgrade/presentation/bloc/upgrade_bloc.dart';
import 'package:app/features/upgrade/presentation/widgets/upgrade_widget.dart';
import 'package:app/features/utilisateur/presentation/bloc/utilisateur_bloc.dart';
import 'package:app/features/version/domain/version_port.dart';
import 'package:app/features/version/presentation/bloc/version_bloc.dart';
import 'package:app/features/version/presentation/bloc/version_event.dart';
import 'package:clock/clock.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.clock,
    required this.tracker,
    required this.messageBus,
    required this.dioHttpClient,
    required this.authenticationService,
    required this.authentificationPort,
    required this.themePort,
    required this.assistancesRepository,
    required this.bibliothequePort,
    required this.recommandationsPort,
    required this.quizPort,
    required this.versionPort,
    required this.communesPort,
    required this.aideVeloPort,
    required this.firstNamePort,
    required this.profilPort,
    required this.knowYourCustomersRepository,
    required this.mieuxVousConnaitrePort,
    required this.gamificationPort,
  });

  final Clock clock;
  final Tracker tracker;
  final MessageBus messageBus;
  final DioHttpClient dioHttpClient;
  final AuthenticationService authenticationService;
  final AuthentificationPort authentificationPort;
  final ThemePort themePort;
  final AssistancesRepository assistancesRepository;
  final BibliothequePort bibliothequePort;
  final RecommandationsPort recommandationsPort;
  final QuizPort quizPort;
  final VersionPort versionPort;
  final CommunesPort communesPort;
  final AideVeloPort aideVeloPort;
  final FirstNamePort firstNamePort;
  final ProfilPort profilPort;
  final KnowYourCustomersRepository knowYourCustomersRepository;
  final MieuxVousConnaitrePort mieuxVousConnaitrePort;
  final GamificationPort gamificationPort;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _goRouter;

  @override
  void initState() {
    super.initState();
    _goRouter = goRouter(tracker: widget.tracker);
  }

  @override
  void dispose() {
    _goRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(final context) {
    final upgradeBloc = UpgradeBloc();
    widget.dioHttpClient.add(UpgradeInterceptor(upgradeBloc));

    return InheritedGoRouter(
      goRouter: _goRouter,
      child: AuthenticationInjection(
        authenticationService: widget.authenticationService,
        child: AuthenticationRedirection(
          child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider.value(value: widget.tracker),
              RepositoryProvider.value(value: widget.clock),
              RepositoryProvider.value(value: widget.authentificationPort),
              RepositoryProvider.value(value: widget.themePort),
              RepositoryProvider.value(value: widget.assistancesRepository),
              RepositoryProvider.value(value: widget.quizPort),
              RepositoryProvider.value(value: widget.profilPort),
              RepositoryProvider.value(value: widget.communesPort),
              RepositoryProvider.value(
                value: widget.knowYourCustomersRepository,
              ),
              RepositoryProvider.value(value: widget.mieuxVousConnaitrePort),
              RepositoryProvider.value(value: widget.gamificationPort),
              RepositoryProvider.value(value: widget.firstNamePort),
              RepositoryProvider<ArticlesPort>(
                create: (final context) =>
                    ArticlesApiAdapter(client: widget.dioHttpClient),
              ),
              RepositoryProvider(
                create: (final context) =>
                    ActionsAdapter(client: widget.dioHttpClient),
              ),
              RepositoryProvider(
                create: (final context) => ActionRepository(
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
                    MissionActionsRepository(client: widget.dioHttpClient),
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: upgradeBloc),
                BlocProvider(create: (final context) => HomeDisclaimerCubit()),
                BlocProvider(create: (final context) => AidesDisclaimerCubit()),
                BlocProvider(
                  create: (final context) => UtilisateurBloc(
                    authentificationPort: widget.authentificationPort,
                  ),
                ),
                BlocProvider(
                  create: (final context) => AidesAccueilBloc(
                    assistancesRepository: widget.assistancesRepository,
                  ),
                ),
                BlocProvider(
                  create: (final context) => MissionHomeBloc(
                    repository:
                        MissionHomeRepository(client: widget.dioHttpClient),
                  ),
                ),
                BlocProvider(create: (final context) => AideBloc()),
                BlocProvider(
                  create: (final context) =>
                      VersionBloc(versionPort: widget.versionPort)
                        ..add(const VersionDemandee()),
                ),
                BlocProvider(
                  create: (final context) => AideVeloBloc(
                    profilPort: widget.profilPort,
                    communesPort: widget.communesPort,
                    aideVeloPort: widget.aideVeloPort,
                  ),
                ),
                BlocProvider(
                  create: (final context) => RecommandationsBloc(
                    recommandationsPort: widget.recommandationsPort,
                  ),
                ),
                BlocProvider(
                  create: (final context) => GamificationBloc(
                    gamificationPort: widget.gamificationPort,
                    authenticationService: widget.authenticationService,
                  )..add(const GamificationAbonnementDemande()),
                ),
                BlocProvider(
                  create: (final context) => BibliothequeBloc(
                    bibliothequePort: widget.bibliothequePort,
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
                locale: const Locale('fr', 'FR'),
                localizationsDelegates: const [
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: const [Locale('fr', 'FR')],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
