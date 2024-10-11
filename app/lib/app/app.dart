import 'package:app/app/router/app_router.dart';
import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/features/accueil/presentation/cubit/home_disclaimer_cubit.dart';
import 'package:app/features/actions/detail/infrastructure/action_repository.dart';
import 'package:app/features/actions/list/domain/actions_port.dart';
import 'package:app/features/aides/core/domain/aides_port.dart';
import 'package:app/features/aides/core/presentation/bloc/aides_accueil_bloc.dart';
import 'package:app/features/aides/item/presentation/bloc/aide_bloc.dart';
import 'package:app/features/aides/list/presentation/bloc/aides_disclaimer/aides_disclaimer_cubit.dart';
import 'package:app/features/articles/domain/articles_port.dart';
import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentification/core/domain/authentification_port.dart';
import 'package:app/features/bibliotheque/domain/bibliotheque_port.dart';
import 'package:app/features/bibliotheque/presentation/bloc/bibliotheque_bloc.dart';
import 'package:app/features/communes/domain/communes_port.dart';
import 'package:app/features/first_name/domain/first_name_port.dart';
import 'package:app/features/gamification/domain/gamification_port.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_event.dart';
import 'package:app/features/know_your_customer/list/infrastructure/know_your_customers_repository.dart';
import 'package:app/features/mieux_vous_connaitre/core/domain/mieux_vous_connaitre_port.dart';
import 'package:app/features/profil/core/domain/profil_port.dart';
import 'package:app/features/quiz/domain/quiz_port.dart';
import 'package:app/features/recommandations/domain/recommandations_port.dart';
import 'package:app/features/recommandations/presentation/bloc/recommandations_bloc.dart';
import 'package:app/features/simulateur_velo/domain/aide_velo_port.dart';
import 'package:app/features/simulateur_velo/presentation/bloc/aide_velo_bloc.dart';
import 'package:app/features/univers/core/domain/univers_port.dart';
import 'package:app/features/univers/presentation/bloc/accueil_univers_bloc.dart';
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
    required this.tracker,
    required this.clock,
    required this.authenticationService,
    required this.authentificationPort,
    required this.universPort,
    required this.aidesPort,
    required this.bibliothequePort,
    required this.recommandationsPort,
    required this.articlesPort,
    required this.quizPort,
    required this.versionPort,
    required this.communesPort,
    required this.aideVeloPort,
    required this.firstNamePort,
    required this.profilPort,
    required this.knowYourCustomersRepository,
    required this.mieuxVousConnaitrePort,
    required this.actionsPort,
    required this.actionRepository,
    required this.gamificationPort,
    super.key,
  });

  final Tracker tracker;
  final Clock clock;
  final AuthenticationService authenticationService;
  final AuthentificationPort authentificationPort;
  final UniversPort universPort;
  final AidesPort aidesPort;
  final BibliothequePort bibliothequePort;
  final RecommandationsPort recommandationsPort;
  final ArticlesPort articlesPort;
  final QuizPort quizPort;
  final VersionPort versionPort;
  final CommunesPort communesPort;
  final AideVeloPort aideVeloPort;
  final FirstNamePort firstNamePort;
  final ProfilPort profilPort;
  final KnowYourCustomersRepository knowYourCustomersRepository;
  final MieuxVousConnaitrePort mieuxVousConnaitrePort;
  final ActionsPort actionsPort;
  final ActionRepository actionRepository;
  final GamificationPort gamificationPort;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _goRouter;

  @override
  void initState() {
    super.initState();
    _goRouter = goRouter(
      authenticationService: widget.authenticationService,
      tracker: widget.tracker,
    );
  }

  @override
  void dispose() {
    _goRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: widget.tracker),
          RepositoryProvider.value(value: widget.clock),
          RepositoryProvider.value(value: widget.authentificationPort),
          RepositoryProvider.value(value: widget.universPort),
          RepositoryProvider.value(value: widget.aidesPort),
          RepositoryProvider.value(value: widget.articlesPort),
          RepositoryProvider.value(value: widget.quizPort),
          RepositoryProvider.value(value: widget.profilPort),
          RepositoryProvider.value(value: widget.communesPort),
          RepositoryProvider.value(value: widget.knowYourCustomersRepository),
          RepositoryProvider.value(value: widget.mieuxVousConnaitrePort),
          RepositoryProvider.value(value: widget.gamificationPort),
          RepositoryProvider.value(value: widget.actionsPort),
          RepositoryProvider.value(value: widget.actionRepository),
          RepositoryProvider.value(value: widget.firstNamePort),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (final context) => HomeDisclaimerCubit()),
            BlocProvider(create: (final context) => AidesDisclaimerCubit()),
            BlocProvider(
              create: (final context) => UtilisateurBloc(
                authentificationPort: widget.authentificationPort,
              ),
            ),
            BlocProvider(
              create: (final context) => AccueilUniversBloc(
                universPort: widget.universPort,
              ),
            ),
            BlocProvider(
              create: (final context) => AidesAccueilBloc(
                aidesPort: widget.aidesPort,
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
          ],
          child: MaterialApp.router(
            routerConfig: _goRouter,
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
      );
}
