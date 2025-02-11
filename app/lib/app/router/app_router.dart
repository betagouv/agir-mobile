import 'package:app/core/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:app/core/authentication/presentation/bloc/authentication_state.dart';
import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/core/presentation/pages/error_route_page.dart';
import 'package:app/features/action/presentation/pages/action_page.dart';
import 'package:app/features/actions/presentation/pages/actions_page.dart';
import 'package:app/features/aids/item/presentation/pages/aid_page.dart';
import 'package:app/features/aids/list/presentation/pages/aids_page.dart';
import 'package:app/features/articles/presentation/pages/article_page.dart';
import 'package:app/features/authentification/creer_compte/presentation/pages/creer_compte_page.dart';
import 'package:app/features/authentification/france_connect/presentation/pages/france_connect_page.dart';
import 'package:app/features/authentification/mot_de_passe_oublie/pages/mot_de_passe_oublie_page.dart';
import 'package:app/features/authentification/mot_de_passe_oublie_code/pages/mot_de_passe_oublie_code_page.dart';
import 'package:app/features/authentification/saisie_code/presentation/pages/saisie_code_page.dart';
import 'package:app/features/authentification/se_connecter/presentation/pages/se_connecter_page.dart';
import 'package:app/features/bibliotheque/presentation/pages/bibliotheque_page.dart';
import 'package:app/features/challenges/detail/presentation/pages/challenge_detail_page.dart';
import 'package:app/features/challenges/list/presentation/pages/challenge_list_page.dart';
import 'package:app/features/environmental_performance/questions/presentation/page/environmental_performance_question_page.dart';
import 'package:app/features/environmental_performance/summary/presentation/page/environmental_performance_summary_page.dart';
import 'package:app/features/home/presentation/pages/home_page.dart';
import 'package:app/features/know_your_customer/detail/presentation/pages/mieux_vous_connaitre_edit_page.dart';
import 'package:app/features/know_your_customer/list/presentation/pages/know_your_customers_page.dart';
import 'package:app/features/mission/mission/presentation/pages/mission_page.dart';
import 'package:app/features/options_avancees/presentation/pages/options_avancees_page.dart';
import 'package:app/features/pre_onboarding/presentation/pages/pre_onboarding_page.dart';
import 'package:app/features/profil/informations/presentation/pages/mes_informations_page.dart';
import 'package:app/features/profil/logement/presentation/pages/mon_logement_page.dart';
import 'package:app/features/profil/profil/presentation/pages/profil_page.dart';
import 'package:app/features/questions/first_name/presentation/pages/first_name_page.dart';
import 'package:app/features/questions/presentation/pages/app_est_encore_en_experimentation_page.dart';
import 'package:app/features/questions/presentation/pages/tout_est_pret_page.dart';
import 'package:app/features/questions/question_code_postal/presentation/pages/question_code_postal_page.dart';
import 'package:app/features/questions/question_themes/presentation/pages/question_themes_page.dart';
import 'package:app/features/quiz/presentation/pages/quiz_page.dart';
import 'package:app/features/services/recipes/item/presentation/pages/recipe_page.dart';
import 'package:app/features/services/recipes/list/presentation/pages/recipes_page.dart';
import 'package:app/features/services/seasonal_fruits_and_vegetables/presentation/pages/seasonal_fruits_and_vegetables_page.dart';
import 'package:app/features/simulateur_velo/presentation/pages/aide_simulateur_velo_disponibles_page.dart';
import 'package:app/features/simulateur_velo/presentation/pages/aide_simulateur_velo_page.dart';
import 'package:app/features/theme/presentation/pages/theme_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

GoRouter goRouter({required final Tracker tracker}) => GoRouter(
  routes: [
    GoRoute(path: '/loading', builder: (final context, final state) => const ColoredBox(color: Color(0xFFEDFEE7))),
    GoRoute(
      path: '/unauthenticated',
      redirect:
          (final context, final state) =>
              state.uri.path == '/unauthenticated' ? '/unauthenticated/${PreOnboardingPage.path}' : null,
      routes: [
        PreOnboardingPage.route,
        CreerComptePage.route,
        SeConnecterPage.route,
        MotDePasseOubliePage.route,
        MotDePasseOublieCodePage.route,
        SaisieCodePage.route,
      ],
    ),
    FranceConnectPage.route,
    HomePage.route(
      routes: [
        FirstNamePage.route,
        QuestionCodePostalPage.route,
        AppEstEncoreEnExperimentationPage.route,
        QuestionThemesPage.route,
        ToutEstPretPage.route,
        EnvironmentalPerformanceSummaryPage.route,
        EnvironmentalPerformanceQuestionPage.route,
        MissionPage.route,
        AidsPage.route,
        AidPage.route,
        AideSimulateurVeloPage.route(routes: [AideSimulateurVeloDisponiblePage.route]),
        ArticlePage.route,
        BibliothequePage.route,
        ActionsPage.route,
        ActionPage.route,
        RecipesPage.route,
        RecipePage.route,
        QuizPage.route,
        ProfilPage.route,
        MesInformationsPage.route,
        MonLogementPage.route,
        KnowYourCustomersPage.route,
        MieuxVousConnaitreEditPage.route,
        ChallengeListPage.route,
        ChallengeDetailPage.route,
        SeasonalFruitsAndVegetablesPage.route,
        OptionsAvanceesPage.route,
      ],
    ),
  ],
  errorPageBuilder: (final context, final state) => const NoTransitionPage(child: FnvErrorRoutePage()),
  redirect:
      (final context, final state) => switch (context.read<AuthenticationBloc>().state) {
        AuthenticationInitial() => null,
        AuthenticationUnauthenticated() =>
          state.uri.path.startsWith('/unauthenticated') || state.uri.path.startsWith(FranceConnectPage.path)
              ? null
              : '/unauthenticated/${PreOnboardingPage.path}',
        AuthenticationAuthenticated() =>
          state.uri.path.startsWith('/unauthenticated') || state.uri.path.startsWith(FranceConnectPage.path)
              ? HomePage.path
              : null,
      },
  initialLocation: '/loading',
  observers: [themeRouteObserver, tracker.navigatorObserver],
  navigatorKey: navigatorKey,
);
