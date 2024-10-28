import 'package:app/app/router/go_router_refresh_stream.dart';
import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/features/accueil/presentation/pages/home_page.dart';
import 'package:app/features/actions/detail/presentation/pages/action_detail_page.dart';
import 'package:app/features/actions/list/presentation/pages/action_list_page.dart';
import 'package:app/features/aides/item/presentation/pages/aide_page.dart';
import 'package:app/features/aides/list/presentation/pages/aides_page.dart';
import 'package:app/features/articles/presentation/pages/article_page.dart';
import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentication/domain/authentication_status.dart';
import 'package:app/features/authentification/creer_compte/presentation/pages/creer_compte_page.dart';
import 'package:app/features/authentification/mot_de_passe_oublie/pages/mot_de_passe_oublie_page.dart';
import 'package:app/features/authentification/mot_de_passe_oublie_code/pages/mot_de_passe_oublie_code_page.dart';
import 'package:app/features/authentification/question_code_postal/presentation/pages/question_code_postal_page.dart';
import 'package:app/features/authentification/question_themes/presentation/pages/question_themes_page.dart';
import 'package:app/features/authentification/questions/presentation/pages/app_est_encore_en_experimentation_page.dart';
import 'package:app/features/authentification/questions/presentation/pages/tout_est_pret_page.dart';
import 'package:app/features/authentification/saisie_code/presentation/pages/saisie_code_page.dart';
import 'package:app/features/authentification/se_connecter/presentation/pages/se_connecter_page.dart';
import 'package:app/features/bibliotheque/presentation/pages/bibliotheque_page.dart';
import 'package:app/features/environmental_performance/questions/presentation/page/environmental_performance_question_page.dart';
import 'package:app/features/environmental_performance/summary/presentation/page/environmental_performance_summary_page.dart';
import 'package:app/features/first_name/presentation/pages/first_name_page.dart';
import 'package:app/features/know_your_customer/list/presentation/pages/know_your_customers_page.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/pages/mieux_vous_connaitre_edit_page.dart';
import 'package:app/features/pre_onboarding/presentation/pages/pre_onboarding_page.dart';
import 'package:app/features/profil/informations/presentation/pages/mes_informations_page.dart';
import 'package:app/features/profil/logement/presentation/pages/mon_logement_page.dart';
import 'package:app/features/profil/options_avancees/presentation/pages/options_avancees_page.dart';
import 'package:app/features/profil/profil/presentation/pages/profil_page.dart';
import 'package:app/features/quiz/presentation/pages/quiz_page.dart';
import 'package:app/features/recommandations/presentation/widgets/mes_recommandations.dart';
import 'package:app/features/simulateur_velo/presentation/pages/aide_simulateur_velo_disponibles_page.dart';
import 'package:app/features/simulateur_velo/presentation/pages/aide_simulateur_velo_page.dart';
import 'package:app/features/theme/presentation/pages/mission_kyc_page.dart';
import 'package:app/features/theme/presentation/pages/mission_page.dart';
import 'package:app/features/theme/presentation/pages/theme_page.dart';
import 'package:go_router/go_router.dart';

GoRouter goRouter({
  required final AuthenticationService authenticationService,
  required final Tracker tracker,
}) =>
    GoRouter(
      routes: [
        GoRoute(
          path: '/',
          redirect: (final context, final state) => state.uri.path == '/'
              ? '/unauthenticated/${PreOnboardingPage.path}'
              : null,
          routes: [
            GoRoute(
              path: 'unauthenticated',
              redirect: (final context, final state) =>
                  state.uri.path == '/unauthenticated'
                      ? '/unauthenticated/${PreOnboardingPage.path}'
                      : null,
              routes: [
                PreOnboardingPage.route,
                CreerComptePage.route,
                SeConnecterPage.route,
                MotDePasseOubliePage.route,
                MotDePasseOublieCodePage.route,
                SaisieCodePage.route,
              ],
            ),
            GoRoute(
              path: 'authenticated',
              redirect: (final context, final state) =>
                  state.uri.path == '/authenticated'
                      ? '/authenticated/${HomePage.path}'
                      : null,
              routes: [
                FirstNamePage.route,
                QuestionCodePostalPage.route,
                AppEstEncoreEnExperimentationPage.route,
                QuestionThemesPage.route,
                ToutEstPretPage.route,
                HomePage.route,
                EnvironmentalPerformanceSummaryPage.route,
                EnvironmentalPerformanceQuestionPage.route,
                MissionPage.route,
                MissionKycPage.route,
                AidesPage.route,
                AidePage.route,
                AideSimulateurVeloPage.route(
                  routes: [AideSimulateurVeloDisponiblePage.route],
                ),
                ArticlePage.route,
                BibliothequePage.route,
                QuizPage.route,
                ProfilPage.route,
                MesInformationsPage.route,
                MonLogementPage.route,
                KnowYourCustomersPage.route,
                MieuxVousConnaitreEditPage.route,
                ActionListPage.route,
                ActionDetailPage.route,
                OptionsAvanceesPage.route,
              ],
            ),
          ],
        ),
      ],
      redirect: (final context, final state) {
        final path = state.uri.path;

        final statutActuel = authenticationService.status;

        switch (statutActuel) {
          case Authenticated():
            if (path.startsWith('/unauthenticated')) {
              return '/authenticated/${HomePage.path}';
            }
          case Unauthenticated():
            if (path.startsWith('/authenticated')) {
              return '/unauthenticated/${PreOnboardingPage.path}';
            }
        }

        return null;
      },
      refreshListenable: GoRouterRefreshStream(authenticationService),
      initialLocation: '/unauthenticated/${PreOnboardingPage.path}',
      observers: [
        mesRecommandationsRouteObserver,
        missionRouteObserver,
        themeRouteObserver,
        tracker.navigatorObserver,
      ],
    );
