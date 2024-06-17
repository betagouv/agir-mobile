import 'package:app/app/router/go_router_refresh_stream.dart';
import 'package:app/features/accueil/presentation/pages/accueil_page.dart';
import 'package:app/features/aides/presentation/pages/aide_page.dart';
import 'package:app/features/aides/presentation/pages/aides_page.dart';
import 'package:app/features/aides/simulateur_velo/presentation/pages/aide_simulateur_velo_disponibles_page.dart';
import 'package:app/features/aides/simulateur_velo/presentation/pages/aide_simulateur_velo_page.dart';
import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/domain/value_objects/authentification_statut.dart';
import 'package:app/features/authentification/presentation/pages/se_connecter_page.dart';
import 'package:app/features/pre_onboarding/presentation/pages/pre_onboarding_carrousel_page.dart';
import 'package:app/features/pre_onboarding/presentation/pages/pre_onboarding_page.dart';
import 'package:app/features/profil/mes_informations/presentation/pages/mes_informations_page.dart';
import 'package:app/features/profil/mon_logement/presentation/pages/mon_logement_page.dart';
import 'package:app/features/profil/presentation/pages/profil_page.dart';
import 'package:go_router/go_router.dart';

GoRouter goRouter({
  required final AuthentificationStatutManager authentificationStatusManager,
}) =>
    GoRouter(
      routes: [
        PreOnboardingPage.route,
        PreOnboardingCarrouselPage.route,
        SeConnecterPage.route,
        AccueilPage.route,
        AidesPage.route,
        AidePage.route,
        AideSimulateurVeloPage.route(
          routes: [AideSimulateurVeloDisponiblePage.route],
        ),
        ProfilPage.route,
        MesInformationsPage.route,
        MonLogementPage.route,
      ],
      redirect: (final context, final state) {
        final path = state.uri.path;

        final statutActuel = authentificationStatusManager.statutActuel;
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
                path.startsWith(AidePage.path) ||
                path.startsWith(AideSimulateurVeloPage.path) ||
                path.startsWith(AideSimulateurVeloDisponiblePage.path) ||
                path.startsWith(ProfilPage.path) ||
                path.startsWith(MesInformationsPage.path) ||
                path.startsWith(MonLogementPage.path)) {
              return PreOnboardingPage.path;
            }
        }

        return null;
      },
      refreshListenable:
          GoRouterRefreshStream(authentificationStatusManager.statutModifie),
      initialLocation: PreOnboardingPage.path,
      debugLogDiagnostics: true,
    );
