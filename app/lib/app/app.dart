import 'package:app/app/router/app_router.dart';
import 'package:app/features/aides/domain/ports/aides_port.dart';
import 'package:app/features/aides/presentation/blocs/aide/aide_bloc.dart';
import 'package:app/features/aides/simulateur_velo/domain/ports/aide_velo_port.dart';
import 'package:app/features/aides/simulateur_velo/presentation/blocs/aide_velo_bloc.dart';
import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/authentification/presentation/blocs/se_connecter_bloc.dart';
import 'package:app/features/communes/domain/ports/communes_port.dart';
import 'package:app/features/profil/domain/ports/profil_port.dart';
import 'package:app/features/profil/presentation/blocs/profil_bloc.dart';
import 'package:app/features/utilisateur/domain/ports/utilisateur_port.dart';
import 'package:app/features/utilisateur/presentation/blocs/utilisateur_bloc.dart';
import 'package:app/features/version/domain/ports/version_port.dart';
import 'package:app/features/version/presentation/blocs/version_bloc.dart';
import 'package:app/features/version/presentation/blocs/version_event.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

class App extends StatefulWidget {
  const App({
    required this.authentificationStatusManager,
    required this.authentificationRepository,
    required this.utilisateurRepository,
    required this.aidesRepository,
    required this.versionRepository,
    required this.communesRepository,
    required this.aideVeloRepository,
    required this.profilRepository,
    super.key,
  });

  final AuthentificationStatutManager authentificationStatusManager;
  final AuthentificationPort authentificationRepository;
  final UtilisateurPort utilisateurRepository;
  final AidesPort aidesRepository;
  final VersionPort versionRepository;
  final CommunesPort communesRepository;
  final AideVeloPort aideVeloRepository;
  final ProfilPort profilRepository;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _goRouter;

  @override
  void initState() {
    super.initState();
    _goRouter = goRouter(
      authentificationStatusManager: widget.authentificationStatusManager,
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
          RepositoryProvider.value(value: widget.authentificationRepository),
          RepositoryProvider.value(value: widget.aidesRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (final context) => SeConnecterBloc(
                authentificationRepository: widget.authentificationRepository,
              ),
            ),
            BlocProvider(
              create: (final context) => UtilisateurBloc(
                utilisateurRepository: widget.utilisateurRepository,
              ),
            ),
            BlocProvider(create: (final context) => AideBloc()),
            BlocProvider(
              create: (final context) =>
                  VersionBloc(versionRepository: widget.versionRepository)
                    ..add(const VersionDemandee()),
            ),
            BlocProvider(
              create: (final context) => AideVeloBloc(
                communesRepository: widget.communesRepository,
                aideVeloRepository: widget.aideVeloRepository,
              ),
            ),
            BlocProvider(
              create: (final context) =>
                  ProfilBloc(profilRepository: widget.profilRepository),
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
