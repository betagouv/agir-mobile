import 'package:app/app/router/go_router_refresh_stream.dart';
import 'package:app/features/accueil/presentation/pages/accueil_page.dart';
import 'package:app/features/aides/presentation/pages/aide_page.dart';
import 'package:app/features/aides/presentation/pages/aides_page.dart';
import 'package:app/features/aides/simulateur_velo/presentation/pages/aide_simulateur_velo_disponibles_page.dart';
import 'package:app/features/aides/simulateur_velo/presentation/pages/aide_simulateur_velo_page.dart';
import 'package:app/features/articles/presentation/pages/article_page.dart';
import 'package:app/features/authentification/creer_compte/presentation/pages/creer_compte_page.dart';
import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/domain/value_objects/authentification_statut.dart';
import 'package:app/features/authentification/mot_de_passe_oublie/pages/mot_de_passe_oublie_code_page.dart';
import 'package:app/features/authentification/mot_de_passe_oublie/pages/mot_de_passe_oublie_page.dart';
import 'package:app/features/authentification/presentation/pages/se_connecter_page.dart';
import 'package:app/features/authentification/questions/presentation/pages/app_est_encore_en_experimentation_page.dart';
import 'package:app/features/authentification/questions/presentation/pages/question_code_postal_page.dart';
import 'package:app/features/authentification/questions/presentation/pages/question_themes_page.dart';
import 'package:app/features/authentification/questions/presentation/pages/tout_est_pret_page.dart';
import 'package:app/features/authentification/saisie_code/presentation/pages/saisie_code_page.dart';
import 'package:app/features/bibliotheque/presentation/pages/bibliotheque_page.dart';
import 'package:app/features/first_name/presentation/pages/first_name_page.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/element/pages/mieux_vous_connaitre_edit_page.dart';
import 'package:app/features/mieux_vous_connaitre/presentation/liste/pages/mieux_vous_connaitre_page.dart';
import 'package:app/features/pre_onboarding/presentation/pages/pre_onboarding_page.dart';
import 'package:app/features/profil/informations/presentation/pages/mes_informations_page.dart';
import 'package:app/features/profil/logement/presentation/pages/mon_logement_page.dart';
import 'package:app/features/profil/presentation/pages/options_avancees_page.dart';
import 'package:app/features/profil/presentation/pages/profil_page.dart';
import 'package:app/features/quiz/presentation/pages/quiz_page.dart';
import 'package:app/features/recommandations/presentation/widgets/mes_recommandations.dart';
import 'package:app/features/univers/presentation/pages/defi_page.dart';
import 'package:app/features/univers/presentation/pages/mission_kyc_page.dart';
import 'package:app/features/univers/presentation/pages/mission_page.dart';
import 'package:app/features/univers/presentation/pages/univers_page.dart';
import 'package:go_router/go_router.dart';

GoRouter goRouter({
  required final AuthentificationStatutManagerReader
      authentificationStatusManagerReader,
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
                      ? '/authenticated/${AccueilPage.path}'
                      : null,
              routes: [
                FirstNamePage.route,
                QuestionCodePostalPage.route,
                AppEstEncoreEnExperimentationPage.route,
                QuestionThemesPage.route,
                ToutEstPretPage.route,
                AccueilPage.route,
                UniversPage.route,
                MissionPage.route,
                MissionKycPage.route,
                DefiPage.route,
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
      observers: [
        mesRecommandationsRouteObserver,
        missionRouteObserver,
        universRouteObserver,
      ],
    );
