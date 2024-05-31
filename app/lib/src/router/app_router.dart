import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut.dart';
import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut_manager.dart';
import 'package:app/src/pages/accueil/accueil_page.dart';
import 'package:app/src/pages/aides/aide_page.dart';
import 'package:app/src/pages/aides/aides_page.dart';
import 'package:app/src/pages/authentification/se_connecter_page.dart';
import 'package:app/src/pages/pre_onboarding/pre_onboarding_carrousel_page.dart';
import 'package:app/src/pages/pre_onboarding/pre_onboarding_page.dart';
import 'package:app/src/router/go_router_refresh_stream.dart';
import 'package:go_router/go_router.dart';

GoRouter goRouter({
  required final AuthentificationStatutManager authentificationStatusManager,
}) =>
    GoRouter(
      debugLogDiagnostics: true,
      initialLocation: PreOnboardingPage.path,
      redirect: (final context, final state) {
        final path = state.uri.path;

        final statutActuel = authentificationStatusManager.statutActuel();
        switch (statutActuel) {
          case AuthentificationStatut.inconnu:
            return PreOnboardingPage.path;
          case AuthentificationStatut.connecte:
            if (path.startsWith(PreOnboardingPage.path) ||
                path.startsWith(PreOnboardingCarrouselPage.path) ||
                path.startsWith(SeConnecterPage.path)) {
              return AccueilPage.path;
            }
          case AuthentificationStatut.pasConnecte:
            if (path.startsWith(AccueilPage.path) ||
                path.startsWith(AidesPage.path) ||
                path.startsWith(AidePage.path)) {
              return PreOnboardingPage.path;
            }
        }
        return null;
      },
      refreshListenable:
          GoRouterRefreshStream(authentificationStatusManager.statutModifie()),
      routes: [
        PreOnboardingPage.route(),
        PreOnboardingCarrouselPage.route(),
        SeConnecterPage.route(),
        AccueilPage.route(),
        AidesPage.route(),
        AidePage.route(),
      ],
    );
