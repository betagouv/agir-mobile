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
            '/utilisateurs/{userId}/thematiques_recommandees',
            responseData: missionThematiques,
          );
        await mockNetworkImages(() async {
          await pumpHomePage(tester, dio);
          await tester.pumpAndSettle();
          expect(find.text('Recommandés pour vous'), findsOneWidget);
          expect(find.text('En cuisine : premiers pas'), findsOneWidget);
        });
      },
    );
  });
}

const missionThematiques = [
  {
    'cible_progression': 8,
    'image_url':
        'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1728053226/cuisine_8039156c92.svg',
    'is_locked': false,
    'is_new': true,
    'niveau': null,
    'progression': 0,
    'reason_locked': null,
    'titre': 'En cuisine : premiers pas',
    'type': 'intro_alimentation',
    'univers_parent': 'alimentation',
    'univers_parent_label': 'En cuisine',
  },
  {
    'cible_progression': 8,
    'image_url':
        'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1728045012/conso_eau_2a9ffd49a2.svg',
    'is_locked': false,
    'is_new': true,
    'niveau': null,
    'progression': 0,
    'reason_locked': null,
    'titre': "Gérer sa consommation d'eau",
    'type': 'conso_eau',
    'univers_parent': 'logement',
    'univers_parent_label': 'À la maison',
  },
  {
    'cible_progression': 9,
    'image_url':
        'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1728053226/conso_86660ec1cf.svg',
    'is_locked': false,
    'is_new': true,
    'niveau': null,
    'progression': 0,
    'reason_locked': null,
    'titre': 'Mes achats : premiers pas',
    'type': 'intro_conso',
    'univers_parent': 'consommation',
    'univers_parent_label': 'Mes achats',
  },
  {
    'cible_progression': 9,
    'image_url':
        'https://res.cloudinary.com/dq023imd8/image/upload/v1718887355/fruits_8_67cc78f4d8.png',
    'is_locked': false,
    'is_new': true,
    'niveau': null,
    'progression': 0,
    'reason_locked': null,
    'titre': 'Passer à la voiture électrique ?',
    'type': 'changer_voiture',
    'univers_parent': 'transport',
    'univers_parent_label': 'Mes déplacements',
  },
];
