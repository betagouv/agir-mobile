import 'package:app/features/accueil/presentation/cubit/home_disclaimer_cubit.dart';
import 'package:app/features/accueil/presentation/pages/home_page.dart';
import 'package:app/features/assistances/core/presentation/bloc/aides_accueil_bloc.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/environmental_performance/questions/infrastructure/environment_performance_question_repository.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_bloc.dart';
import 'package:app/features/environmental_performance/summary/application/fetch_environmental_performance.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_repository.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_bloc.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/mission/home/infrastructure/mission_home_repository.dart';
import 'package:app/features/mission/home/presentation/bloc/mission_home_bloc.dart';
import 'package:app/features/recommandations/presentation/bloc/recommandations_bloc.dart';
import 'package:app/features/utilisateur/presentation/bloc/utilisateur_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../environmental_performance/summary/environmental_performance_data.dart';
import '../helpers/authentication_service_setup.dart';
import '../helpers/dio_mock.dart';
import '../helpers/pump_page.dart';
import '../old/mocks/assistances_repository_mock.dart';
import '../old/mocks/authentification_port_mock.dart';
import '../old/mocks/gamification_bloc_fake.dart';
import '../old/mocks/recommandations_port_mock.dart';

Future<void> pumpHomePage(final WidgetTester tester, final DioMock dio) async {
  dio
    ..getM(
      '/utilisateur/{userId}/bilans/last_v2',
      responseData: environmentalPerformanceEmptyData,
    )
    ..getM(
      '/utilisateurs/{userId}/enchainementQuestionsKYC/ENCHAINEMENT_KYC_mini_bilan_carbone',
      responseData: miniBilan,
    );

  final client = DioHttpClient(
    dio: dio,
    authenticationService: authenticationService,
  );

  await pumpPage(
    tester: tester,
    repositoryProviders: [
      RepositoryProvider.value(
        value: EnvironmentalPerformanceSummaryRepository(client: client),
      ),
    ],
    blocProviders: [
      BlocProvider(
        create: (final context) =>
            AidesAccueilBloc(aidesPort: AssistancesRepositoryMock([])),
      ),
      BlocProvider(
        create: (final context) => HomeDisclaimerCubit()..closeDisclaimer(),
      ),
      BlocProvider(
        create: (final context) => RecommandationsBloc(
          recommandationsPort: RecommandationsPortMock([]),
        ),
      ),
      BlocProvider<GamificationBloc>(
        create: (final context) => GamificationBlocFake(),
      ),
      BlocProvider(
        create: (final context) => UtilisateurBloc(
          authentificationPort: AuthentificationPortMock(
            authenticationService,
            prenom: 'Lucas',
            estIntegrationTerminee: true,
          ),
        ),
      ),
      BlocProvider(
        create: (final context) => EnvironmentalPerformanceBloc(
          useCase: FetchEnvironmentalPerformance(
            EnvironmentalPerformanceSummaryRepository(client: client),
          ),
        ),
      ),
      BlocProvider(
        create: (final context) => EnvironmentalPerformanceQuestionBloc(
          repository: EnvironmentalPerformanceQuestionRepository(
            client: client,
          ),
        ),
      ),
      BlocProvider(
        create: (final context) =>
            MissionHomeBloc(repository: MissionHomeRepository(client: client)),
      ),
    ],
    page: HomePage.route,
  );
  await tester.pumpAndSettle();
}

void main() {
  group('Recommandés pour vous', () {
    testWidgets(
      'Voir la liste des missions recommander',
      (final tester) async {
        final dio = DioMock()
          ..getM(
            '/utilisateurs/{userId}/tuiles_missions',
            responseData: missionThematiques,
          );
        await mockNetworkImages(() async {
          await pumpHomePage(tester, dio);
          await tester.pumpAndSettle();
          expect(find.text('Recommandés pour vous'), findsOneWidget);
          expect(find.text('Me nourrir : premiers pas'), findsOneWidget);
        });
      },
    );
  });
}

const missionThematiques = [
  {
    'cible_progression': 8,
    'code': 'intro_alimentation',
    'image_url':
        'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1728053226/cuisine_8039156c92.svg',
    'is_new': false,
    'progression': 8,
    'thematique': 'alimentation',
    'thematique_label': 'Me nourrir',
    'titre': 'Me nourrir : premiers pas',
  },
  {
    'cible_progression': 9,
    'code': 'compost',
    'image_url':
        'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1724937236/compost_6868eb1743.svg',
    'is_new': true,
    'progression': 0,
    'thematique': 'alimentation',
    'thematique_label': 'Me nourrir',
    'titre': 'Valoriser ses restes avec un compost',
  },
  {
    'cible_progression': 8,
    'code': 'saison',
    'image_url':
        'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1724937259/saison_cb78c5f2aa.svg',
    'is_new': true,
    'progression': 0,
    'thematique': 'alimentation',
    'thematique_label': 'Me nourrir',
    'titre': 'Manger de saison',
  },
  {
    'cible_progression': 8,
    'code': 'gaspi',
    'image_url':
        'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1724937236/gaspi_f071cc0cbb.svg',
    'is_new': true,
    'progression': 0,
    'thematique': 'alimentation',
    'thematique_label': 'Me nourrir',
    'titre': 'Réduire le gaspillage alimentaire',
  },
  {
    'cible_progression': 10,
    'code': 'local',
    'image_url':
        'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1724937236/local_aa18745357.svg',
    'is_new': true,
    'progression': 0,
    'thematique': 'alimentation',
    'thematique_label': 'Me nourrir',
    'titre': 'Manger local',
  },
  {
    'cible_progression': 10,
    'code': 'viande',
    'image_url':
        'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1724937236/viande_74c32bae22.svg',
    'is_new': true,
    'progression': 0,
    'thematique': 'alimentation',
    'thematique_label': 'Me nourrir',
    'titre': 'La viande',
  },
  {
    'cible_progression': 9,
    'code': 'legumineuses',
    'image_url':
        'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1724937236/legumineuse_3724544daf.svg',
    'is_new': true,
    'progression': 0,
    'thematique': 'alimentation',
    'thematique_label': 'Me nourrir',
    'titre': 'Les céréales et légumineuses',
  },
];
