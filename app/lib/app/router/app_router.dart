import 'package:app/core/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:app/core/authentication/presentation/bloc/authentication_state.dart';
import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/core/presentation/pages/error_route_page.dart';
import 'package:app/features/actions/detail/presentation/pages/action_detail_page.dart';
import 'package:app/features/actions/list/presentation/pages/action_list_page.dart';
import 'package:app/features/articles/presentation/pages/article_page.dart';
import 'package:app/features/assistances/item/presentation/pages/assistance_detail_page.dart';
import 'package:app/features/assistances/list/presentation/pages/assistance_list_page.dart';
import 'package:app/features/authentification/creer_compte/presentation/pages/creer_compte_page.dart';
import 'package:app/features/authentification/mot_de_passe_oublie/pages/mot_de_passe_oublie_page.dart';
import 'package:app/features/authentification/mot_de_passe_oublie_code/pages/mot_de_passe_oublie_code_page.dart';
import 'package:app/features/authentification/saisie_code/presentation/pages/saisie_code_page.dart';
import 'package:app/features/authentification/se_connecter/presentation/pages/se_connecter_page.dart';
import 'package:app/features/bibliotheque/presentation/pages/bibliotheque_page.dart';
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
import 'package:app/features/simulateur_velo/presentation/pages/aide_simulateur_velo_disponibles_page.dart';
import 'package:app/features/simulateur_velo/presentation/pages/aide_simulateur_velo_page.dart';
import 'package:app/features/theme/presentation/pages/theme_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

GoRouter goRouter({required final Tracker tracker}) => GoRouter(
      routes: [
        GoRoute(
          path: '/loading',
          builder: (final context, final state) =>
              const ColoredBox(color: Color(0xFFEDFEE7)),
        ),
        GoRoute(
          path: '/unauthenticated',
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
            AssistanceListPage.route,
            AssistanceDetailPage.route,
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
      errorPageBuilder: (final context, final state) => const NoTransitionPage(
        child: FnvErrorRoutePage(),
      ),
      redirect: (final context, final state) =>
          switch (context.read<AuthenticationBloc>().state) {
        AuthenticationInitial() => null,
        AuthenticationUnauthenticated() =>
          state.uri.path.startsWith('/unauthenticated')
              ? null
              : '/unauthenticated/${PreOnboardingPage.path}',
        AuthenticationAuthenticated() =>
          state.uri.path.startsWith('/unauthenticated') ? HomePage.path : null,
      },
      initialLocation: '/loading',
      observers: [themeRouteObserver, tracker.navigatorObserver],
    );
