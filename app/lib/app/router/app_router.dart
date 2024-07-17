import 'package:app/app/router/go_router_refresh_stream.dart';
import 'package:app/features/accueil/presentation/pages/accueil_page.dart';
import 'package:app/features/aides/presentation/pages/aide_page.dart';
import 'package:app/features/aides/presentation/pages/aides_page.dart';
import 'package:app/features/aides/simulateur_velo/presentation/pages/aide_simulateur_velo_disponibles_page.dart';
import 'package:app/features/aides/simulateur_velo/presentation/pages/aide_simulateur_velo_page.dart';
import 'package:app/features/articles/presentation/pages/article_page.dart';
import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/domain/value_objects/authentification_statut.dart';
import 'package:app/features/authentification/presentation/pages/se_connecter_page.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/pages/mieux_vous_connaitre_edit_page.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/liste/pages/mieux_vous_connaitre_page.dart';
import 'package:app/features/pre_onboarding/presentation/pages/pre_onboarding_carrousel_page.dart';
import 'package:app/features/pre_onboarding/presentation/pages/pre_onboarding_page.dart';
import 'package:app/features/profil/informations/presentation/pages/mes_informations_page.dart';
import 'package:app/features/profil/logement/presentation/pages/mon_logement_page.dart';
import 'package:app/features/profil/presentation/pages/options_avancees_page.dart';
import 'package:app/features/profil/presentation/pages/profil_page.dart';
import 'package:app/features/quiz/presentation/pages/quiz_page.dart';
import 'package:app/features/recommandations/presentation/widgets/mes_recommandations.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

GoRouter goRouter({
  required final AuthentificationStatutManagerReader
      authentificationStatusManagerReader,
}) =>
    GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (final context, final state) => const SizedBox(),
          routes: [
            GoRoute(
              path: 'unauthenticated',
              builder: (final context, final state) => const SizedBox(),
              routes: [
                PreOnboardingPage.route,
                PreOnboardingCarrouselPage.route,
                SeConnecterPage.route,
              ],
            ),
            GoRoute(
              path: 'authenticated',
              builder: (final context, final state) => const SizedBox(),
              routes: [
                AccueilPage.route,
                AidesPage.route,
                AidePage.route,
                AideSimulateurVeloPage.route(
                  routes: [AideSimulateurVeloDisponiblePage.route],
                ),
                ArticlePage.route,
                QuizPage.route,
                ProfilPage.route,
                MesInformationsPage.route,
                MonLogementPage.route,
                MieuxVousConnaitrePage.route,
                MieuxVousConnaitreEditPage.route,
                OptionsAvanceesPage.route,
              ],
            ),
          ],
        ),
      ],
      redirect: (final context, final state) {
        final path = state.uri.path;

        final statutActuel = authentificationStatusManagerReader.statutActuel;
        switch (statutActuel) {
          case AuthentificationStatut.inconnu:
            return '/unauthenticated/${PreOnboardingPage.path}';

          case AuthentificationStatut.connecte:
            if (path.startsWith('/unauthenticated')) {
              return '/authenticated/${AccueilPage.path}';
            }

          case AuthentificationStatut.pasConnecte:
            if (path.startsWith('/authenticated')) {
              return '/unauthenticated/${PreOnboardingPage.path}';
            }
        }

        return null;
      },
      refreshListenable:
          GoRouterRefreshStream(authentificationStatusManagerReader.statut),
      initialLocation: '/unauthenticated/${PreOnboardingPage.path}',
      observers: [routeObserver],
    );
