import 'package:app/src/fonctionnalites/aides/bloc/aide/aide_bloc.dart';
import 'package:app/src/fonctionnalites/aides/domain/ports/aides_repository.dart';
import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut_manager.dart';
import 'package:app/src/fonctionnalites/authentification/domain/ports/authentification_repository.dart';
import 'package:app/src/fonctionnalites/se_connecter/bloc/se_connecter_bloc.dart';
import 'package:app/src/fonctionnalites/utilisateur/bloc/utilisateur_bloc.dart';
import 'package:app/src/fonctionnalites/utilisateur/domain/ports/utilisateur_repository.dart';
import 'package:app/src/router/app_router.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class App extends StatefulWidget {
  const App({
    required this.authentificationStatusManager,
    required this.authentificationRepository,
    required this.utilisateurRepository,
    required this.aidesRepository,
    super.key,
  });

  final AuthentificationStatutManager authentificationStatusManager;
  final AuthentificationRepository authentificationRepository;
  final UtilisateurRepository utilisateurRepository;
  final AidesRepository aidesRepository;

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
  Widget build(final BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthentificationRepository>.value(
            value: widget.authentificationRepository,
          ),
          RepositoryProvider<AidesRepository>.value(
            value: widget.aidesRepository,
          ),
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
          ],
          child: MaterialApp.router(
            routerConfig: _goRouter,
            theme: ThemeData(
              colorSchemeSeed: DsfrColors.blueFranceSun113,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
            ),
          ),
        ),
      );
}
