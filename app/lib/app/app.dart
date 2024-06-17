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
    required this.authentificationPort,
    required this.utilisateurPort,
    required this.aidesPort,
    required this.versionPort,
    required this.communesPort,
    required this.aideVeloPort,
    required this.profilPort,
    super.key,
  });

  final AuthentificationStatutManager authentificationStatusManager;
  final AuthentificationPort authentificationPort;
  final UtilisateurPort utilisateurPort;
  final AidesPort aidesPort;
  final VersionPort versionPort;
  final CommunesPort communesPort;
  final AideVeloPort aideVeloPort;
  final ProfilPort profilPort;

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
          RepositoryProvider.value(value: widget.authentificationPort),
          RepositoryProvider.value(value: widget.aidesPort),
          RepositoryProvider.value(value: widget.profilPort),
          RepositoryProvider.value(value: widget.communesPort),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (final context) => SeConnecterBloc(
                authentificationPort: widget.authentificationPort,
              ),
            ),
            BlocProvider(
              create: (final context) => UtilisateurBloc(
                utilisateurPort: widget.utilisateurPort,
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
