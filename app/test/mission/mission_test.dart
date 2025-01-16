import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/features/actions/home/infrastructure/home_actions_repository.dart';
import 'package:app/features/actions/home/presentation/bloc/home_actions_bloc.dart';
import 'package:app/features/assistances/core/presentation/bloc/aides_accueil_bloc.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/environmental_performance/questions/infrastructure/environment_performance_question_repository.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_bloc.dart';
import 'package:app/features/environmental_performance/summary/application/fetch_environmental_performance.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_repository.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_bloc.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/home/presentation/cubit/home_disclaimer_cubit.dart';
import 'package:app/features/home/presentation/pages/home_page.dart';
import 'package:app/features/know_your_customer/core/domain/mieux_vous_connaitre_port.dart';
import 'package:app/features/know_your_customer/core/infrastructure/mieux_vous_connaitre_api_adapter.dart';
import 'package:app/features/mission/home/infrastructure/mission_home_repository.dart';
import 'package:app/features/mission/home/presentation/bloc/mission_home_bloc.dart';
import 'package:app/features/mission/mission/infrastructure/mission_repository.dart';
import 'package:app/features/mission/mission/presentation/pages/mission_page.dart';
import 'package:app/features/notifications/infrastructure/notification_service.dart';
import 'package:app/features/recommandations/presentation/bloc/recommandations_bloc.dart';
import 'package:app/features/utilisateur/presentation/bloc/utilisateur_bloc.dart';
import 'package:app/l10n/l10n.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../environmental_performance/summary/environmental_performance_data.dart';
import '../features/helper/notification_service_fake.dart';
import '../helpers/authentication_service_setup.dart';
import '../helpers/dio_mock.dart';
import '../helpers/pump_page.dart';
import '../old/mocks/assistances_repository_mock.dart';
import '../old/mocks/authentification_port_mock.dart';
import '../old/mocks/gamification_bloc_fake.dart';
import '../old/mocks/recommandations_port_mock.dart';

Future<void> pumpForMissionPage(
  final WidgetTester tester, {
  required final DioMock dio,
}) async {
  dio
    ..getM(Endpoints.bilan, responseData: environmentalPerformanceEmptyData)
    ..getM(
      Endpoints.questions('ENCHAINEMENT_KYC_mini_bilan_carbone'),
      responseData: miniBilan,
    )
    ..getM(Endpoints.missionsRecommandees, responseData: missionThematiques)
    ..getM(
      '/utilisateurs/%7BuserId%7D/defis_v2?status=en_cours',
      responseData: <dynamic>[],
    );

  final client = DioHttpClient(
    dio: dio,
    authenticationService: authenticationService,
  );

  await pumpPage(
    tester: tester,
    repositoryProviders: [
      RepositoryProvider(
        create: (final context) =>
            EnvironmentalPerformanceSummaryRepository(client: client),
      ),
      RepositoryProvider<MissionRepository>(
        create: (final context) => MissionRepository(client: client),
      ),
      RepositoryProvider<MieuxVousConnaitrePort>(
        create: (final context) => MieuxVousConnaitreApiAdapter(
          client: client,
          messageBus: MessageBus(),
        ),
      ),
      RepositoryProvider<NotificationService>(
        create: (final context) =>
            const NotificationServiceFake(AuthorizationStatus.denied),
      ),
    ],
    blocProviders: [
      BlocProvider(
        create: (final context) => AidesAccueilBloc(
          assistancesRepository: AssistancesRepositoryMock([]),
        ),
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
      BlocProvider(
        create: (final context) =>
            HomeActionsBloc(repository: HomeActionsRepository(client: client)),
      ),
    ],
    router: GoRouter(
      routes: [
        HomePage.route(routes: [MissionPage.route]),
      ],
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  group('Mission', () {
    testWidgets(
      'Voir la liste des missions recommander',
      (final tester) async {
        await mockNetworkImages(() async {
          await pumpForMissionPage(tester, dio: DioMock());
          expect(find.text('Recommandés pour vous'), findsOneWidget);
          expect(
            find.text('Valoriser ses restes avec un compost'),
            findsOneWidget,
          );
        });
      },
    );

    testWidgets(
      "Aller sur une mission montre l'introduction de celle ci",
      (final tester) async {
        await mockNetworkImages(() async {
          final dio = DioMock()
            ..getM(Endpoints.mission('compost'), responseData: missionMap);
          await pumpForMissionPage(tester, dio: dio);
          await tester.tap(find.text('Valoriser ses restes avec un compost'));
          await tester.pumpAndSettle();

          expect(find.textContaining('Me nourrir'), findsOneWidget);
          expect(
            find.text('Valoriser ses restes avec un compost'),
            findsOneWidget,
          );
          expect(find.text(Localisation.commencer), findsOneWidget);
        });
      },
    );

    testWidgets('Afficher la question KYC', (final tester) async {
      await mockNetworkImages(() async {
        final dio = DioMock()
          ..getM(Endpoints.mission('compost'), responseData: missionMap)
          ..getM(
            Endpoints.questionKyc('KYC_compost_pratique'),
            responseData: kyc,
          );
        await pumpForMissionPage(tester, dio: dio);
        await tester.tap(find.text('Valoriser ses restes avec un compost'));
        await tester.pumpAndSettle();
        await tester.tap(find.text(Localisation.commencer));
        await tester.pumpAndSettle();
        expect(
          find.text('Comment valorisez-vous vos déchets alimentaires ?'),
          findsOneWidget,
        );
      });
    });

    testWidgets('Afficher le premier objectif non fait', (final tester) async {
      await mockNetworkImages(() async {
        final dio = DioMock()
          ..getM(
            Endpoints.mission('compost'),
            responseData: missionPartiallyAnswered,
          )
          ..getM(
            Endpoints.questionKyc('KYC_compost_motivation'),
            responseData: kyc2,
          );
        await pumpForMissionPage(tester, dio: dio);
        await tester.tap(find.text('Valoriser ses restes avec un compost'));
        await tester.pumpAndSettle();
        await tester.tap(find.text(Localisation.commencer));
        await tester.pumpAndSettle();
        expect(
          find.text('Quelles sont vos motivations au sujet du compostage ?'),
          findsOneWidget,
        );
      });
    });
  });
}

const missionThematiques = [
  {
    'cible_progression': 9,
    'code': 'compost',
    'image_url':
        'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1724937236/compost_6868eb1743.svg',
    'is_new': true,
    'progression': 0,
    'thematique': 'alimentation',
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
    'titre': 'Les céréales et légumineuses',
  },
];

const missionMap = {
  'code': 'compost',
  'done_at': '2024-11-18T09:20:36.571Z',
  'id': '31',
  'image_url':
      'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1724937236/compost_6868eb1743.svg',
  'is_new': false,
  'objectifs': [
    {
      'content_id': 'KYC_compost_pratique',
      'done': false,
      'done_at': null,
      'id': 'dee5e4ab-8673-47bb-9c87-56062ebdfaf9',
      'is_locked': false,
      'is_reco': false,
      'points': 5,
      'sont_points_en_poche': true,
      'titre': 'Comment valorisez-vous vos déchets alimentaires ?',
      'type': 'kyc',
    },
    {
      'content_id': 'KYC_compost_idee',
      'done': true,
      'done_at': '2024-11-18T09:19:16.569Z',
      'id': '48a6b5a0-8751-4068-9228-7991c9859ece',
      'is_locked': false,
      'is_reco': false,
      'points': 5,
      'sont_points_en_poche': true,
      'titre':
          'Quelles sont vos idées reçues ou freins concernant le compost ?',
      'type': 'kyc',
    },
    {
      'content_id': 'KYC_compost_motivation',
      'done': true,
      'done_at': '2024-11-18T09:19:18.879Z',
      'id': 'a660636f-7d55-4c2c-83ba-15cc6ff4dfa0',
      'is_locked': false,
      'is_reco': false,
      'points': 5,
      'sont_points_en_poche': true,
      'titre': 'Quelles sont vos motivations pour composter ? ',
      'type': 'kyc',
    },
    {
      'content_id': '123',
      'done': true,
      'done_at': '2024-11-18T09:19:27.016Z',
      'id': 'a0b6c2bc-0e0c-4ca1-9331-219bff9c7607',
      'is_locked': false,
      'is_reco': false,
      'points': 5,
      'sont_points_en_poche': true,
      'titre': 'Vrai ou faux : les idées reçues sur le compost',
      'type': 'quizz',
    },
    {
      'content_id': '163',
      'done': true,
      'done_at': '2024-11-18T09:19:57.162Z',
      'id': '7db9f02b-1e74-4d37-9734-10859ea170ca',
      'is_locked': false,
      'is_reco': false,
      'points': 5,
      'sont_points_en_poche': true,
      'titre':
          '3 conseils pour un compost réussi : équilibrer, aérer, humidifier',
      'type': 'article',
    },
    {
      'content_id': '124',
      'done': true,
      'done_at': '2024-11-18T09:19:51.796Z',
      'id': '3c692422-ed1d-4e92-a46d-3b2c537f3905',
      'is_locked': false,
      'is_reco': false,
      'points': 5,
      'sont_points_en_poche': true,
      'titre':
          'Quel est un avantage de mélanger le compost avec le sol du jardin ?',
      'type': 'quizz',
    },
    {
      'content_id': '141',
      'done': true,
      'done_at': '2024-11-18T09:20:03.104Z',
      'id': '95e192d9-5bb5-498b-b3a1-f0e41b64902f',
      'is_locked': false,
      'is_reco': false,
      'points': 5,
      'sont_points_en_poche': true,
      'titre': 'Transformer ses déchets alimentaires en un nouveau produit',
      'type': 'article',
    },
    {
      'content_id': '58',
      'defi_status': 'todo',
      'done': false,
      'done_at': null,
      'id': '7c8ff6a5-9fe6-4f75-b7f9-829826204d62',
      'is_locked': false,
      'is_reco': false,
      'points': 5,
      'sont_points_en_poche': false,
      'titre': 'Se renseigner sur les aides de Dole pour valoriser vos déchets',
      'type': 'defi',
    },
    {
      'content_id': '60',
      'defi_status': 'fait',
      'done': true,
      'done_at': '2024-11-18T09:20:26.534Z',
      'id': '3fa70941-fe96-4492-ad8d-26ee240e9bb4',
      'is_locked': false,
      'is_reco': false,
      'points': 5,
      'sont_points_en_poche': true,
      'titre':
          'Se poser les 4 questions essentielles avant de se lancer dans le compost',
      'type': 'defi',
    },
    {
      'content_id': '62',
      'defi_status': 'todo',
      'done': false,
      'done_at': null,
      'id': '06aaefb0-8a88-4c3c-9668-f2fa8a134e36',
      'is_locked': false,
      'is_reco': false,
      'points': 10,
      'sont_points_en_poche': false,
      'titre': 'Se former aux bonnes pratiques du compost',
      'type': 'defi',
    },
    {
      'content_id': '68',
      'defi_status': 'todo',
      'done': false,
      'done_at': null,
      'id': 'ffe92892-f62e-48e5-b454-acd5a9a1bdd5',
      'is_locked': false,
      'is_reco': false,
      'points': 10,
      'sont_points_en_poche': false,
      'titre': "S'équiper pour faire du compost",
      'type': 'defi',
    },
    {
      'content_id': '63',
      'defi_status': 'todo',
      'done': false,
      'done_at': null,
      'id': '2418d21a-65e4-4435-b4cb-8c659498a7ce',
      'is_locked': false,
      'is_reco': false,
      'points': 10,
      'sont_points_en_poche': false,
      'titre':
          'Réaliser une première expérience de compostage avec le marc de café ou le thé',
      'type': 'defi',
    },
    {
      'content_id': '67',
      'defi_status': 'todo',
      'done': false,
      'done_at': null,
      'id': 'df14c73b-f53a-403d-80cf-6a4f0d7e3e5a',
      'is_locked': false,
      'is_reco': true,
      'points': 15,
      'sont_points_en_poche': false,
      'titre':
          'Valoriser autrement vos déchets alimentaires avec une recette anti-gaspi',
      'type': 'defi',
    },
    {
      'content_id': '61',
      'defi_status': 'todo',
      'done': false,
      'done_at': null,
      'id': '7a51e916-05f3-45d0-81ef-d67870e601a1',
      'is_locked': false,
      'is_reco': true,
      'points': 15,
      'sont_points_en_poche': false,
      'titre':
          'Partager vos conseils pour débuter le compostage aux habitants de Dole',
      'type': 'defi',
    },
  ],
  'progression': {'current': 9, 'target': 9},
  'progression_kyc': {'current': 3, 'target': 3},
  'terminable': true,
  'thematique': 'alimentation',
  'titre': 'Valoriser ses restes avec un compost',
};

const missionPartiallyAnswered = {
  'code': 'compost',
  'done_at': '2024-11-18T09:20:36.571Z',
  'id': '31',
  'image_url':
      'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1724937236/compost_6868eb1743.svg',
  'is_new': false,
  'objectifs': [
    {
      'content_id': 'KYC_compost_pratique',
      'done': true,
      'done_at': '2024-11-18T09:19:16.569Z',
      'id': 'dee5e4ab-8673-47bb-9c87-56062ebdfaf9',
      'is_locked': false,
      'is_reco': false,
      'points': 5,
      'sont_points_en_poche': true,
      'titre': 'Comment valorisez-vous vos déchets alimentaires ?',
      'type': 'kyc',
    },
    {
      'content_id': 'KYC_compost_idee',
      'done': true,
      'done_at': '2024-11-18T09:19:16.569Z',
      'id': '48a6b5a0-8751-4068-9228-7991c9859ece',
      'is_locked': false,
      'is_reco': false,
      'points': 5,
      'sont_points_en_poche': true,
      'titre':
          'Quelles sont vos idées reçues ou freins concernant le compost ?',
      'type': 'kyc',
    },
    {
      'content_id': 'KYC_compost_motivation',
      'done': false,
      'done_at': null,
      'id': 'a660636f-7d55-4c2c-83ba-15cc6ff4dfa0',
      'is_locked': false,
      'is_reco': false,
      'points': 5,
      'sont_points_en_poche': true,
      'titre': 'Quelles sont vos motivations pour composter ?',
      'type': 'kyc',
    },
    {
      'content_id': '123',
      'done': false,
      'done_at': null,
      'id': 'a0b6c2bc-0e0c-4ca1-9331-219bff9c7607',
      'is_locked': false,
      'is_reco': false,
      'points': 5,
      'sont_points_en_poche': true,
      'titre': 'Vrai ou faux : les idées reçues sur le compost',
      'type': 'quizz',
    },
    {
      'content_id': '163',
      'done': false,
      'done_at': null,
      'id': '7db9f02b-1e74-4d37-9734-10859ea170ca',
      'is_locked': false,
      'is_reco': false,
      'points': 5,
      'sont_points_en_poche': true,
      'titre':
          '3 conseils pour un compost réussi : équilibrer, aérer, humidifier',
      'type': 'article',
    },
    {
      'content_id': '124',
      'done': false,
      'done_at': null,
      'id': '3c692422-ed1d-4e92-a46d-3b2c537f3905',
      'is_locked': false,
      'is_reco': false,
      'points': 5,
      'sont_points_en_poche': true,
      'titre':
          'Quel est un avantage de mélanger le compost avec le sol du jardin ?',
      'type': 'quizz',
    },
    {
      'content_id': '141',
      'done': false,
      'done_at': null,
      'id': '95e192d9-5bb5-498b-b3a1-f0e41b64902f',
      'is_locked': false,
      'is_reco': false,
      'points': 5,
      'sont_points_en_poche': true,
      'titre': 'Transformer ses déchets alimentaires en un nouveau produit',
      'type': 'article',
    },
    {
      'content_id': '58',
      'defi_status': 'todo',
      'done': false,
      'done_at': null,
      'id': '7c8ff6a5-9fe6-4f75-b7f9-829826204d62',
      'is_locked': false,
      'is_reco': false,
      'points': 5,
      'sont_points_en_poche': false,
      'titre': 'Se renseigner sur les aides de Dole pour valoriser vos déchets',
      'type': 'defi',
    },
    {
      'content_id': '60',
      'defi_status': 'fait',
      'done': false,
      'done_at': null,
      'id': '3fa70941-fe96-4492-ad8d-26ee240e9bb4',
      'is_locked': false,
      'is_reco': false,
      'points': 5,
      'sont_points_en_poche': true,
      'titre':
          'Se poser les 4 questions essentielles avant de se lancer dans le compost',
      'type': 'defi',
    },
    {
      'content_id': '62',
      'defi_status': 'todo',
      'done': false,
      'done_at': null,
      'id': '06aaefb0-8a88-4c3c-9668-f2fa8a134e36',
      'is_locked': false,
      'is_reco': false,
      'points': 10,
      'sont_points_en_poche': false,
      'titre': 'Se former aux bonnes pratiques du compost',
      'type': 'defi',
    },
    {
      'content_id': '68',
      'defi_status': 'todo',
      'done': false,
      'done_at': null,
      'id': 'ffe92892-f62e-48e5-b454-acd5a9a1bdd5',
      'is_locked': false,
      'is_reco': false,
      'points': 10,
      'sont_points_en_poche': false,
      'titre': "S'équiper pour faire du compost",
      'type': 'defi',
    },
    {
      'content_id': '63',
      'defi_status': 'todo',
      'done': false,
      'done_at': null,
      'id': '2418d21a-65e4-4435-b4cb-8c659498a7ce',
      'is_locked': false,
      'is_reco': false,
      'points': 10,
      'sont_points_en_poche': false,
      'titre':
          'Réaliser une première expérience de compostage avec le marc de café ou le thé',
      'type': 'defi',
    },
    {
      'content_id': '67',
      'defi_status': 'todo',
      'done': false,
      'done_at': null,
      'id': 'df14c73b-f53a-403d-80cf-6a4f0d7e3e5a',
      'is_locked': false,
      'is_reco': true,
      'points': 15,
      'sont_points_en_poche': false,
      'titre':
          'Valoriser autrement vos déchets alimentaires avec une recette anti-gaspi',
      'type': 'defi',
    },
    {
      'content_id': '61',
      'defi_status': 'todo',
      'done': false,
      'done_at': null,
      'id': '7a51e916-05f3-45d0-81ef-d67870e601a1',
      'is_locked': false,
      'is_reco': true,
      'points': 15,
      'sont_points_en_poche': false,
      'titre':
          'Partager vos conseils pour débuter le compostage aux habitants de Dole',
      'type': 'defi',
    },
  ],
  'progression': {'current': 9, 'target': 9},
  'progression_kyc': {'current': 3, 'target': 3},
  'terminable': true,
  'thematique': 'alimentation',
  'titre': 'Valoriser ses restes avec un compost',
};

const kyc = {
  'code': 'KYC_compost_pratique',
  'question': 'Comment valorisez-vous vos déchets alimentaires ?',
  'reponse_multiple': [
    {
      'code': 'compost_indiv',
      'label': 'Avec un composteur individuel',
      'selected': false,
    },
    {
      'code': 'compost_collectif',
      'label': 'Avec un composteur collectif',
      'selected': true,
    },
    {'code': 'aucun', 'label': 'Pas de valorisation', 'selected': false},
  ],
  'is_answered': true,
  'categorie': 'mission',
  'points': 5,
  'type': 'choix_multiple',
  'is_NGC': false,
  'thematique': 'alimentation',
};

const kyc2 = {
  'code': 'KYC_compost_motivation',
  'question': 'Quelles sont vos motivations au sujet du compostage ?',
  'reponse_multiple': [
    {
      'code': 'apprendre',
      'label': 'En apprendre davantage',
      'selected': true,
    },
    {
      'code': 'se_lancer',
      'label': "Se lancer sans faire d'erreurs",
      'selected': false,
    },
    {
      'code': 'pratique',
      'label': 'Améliorer mes pratiques',
      'selected': false,
    },
    {
      'code': 'partager',
      'label': 'Partager ma connaissance et expérience',
      'selected': false,
    },
    {
      'code': 'aide',
      'label': 'Connaître la réglementation et les aides',
      'selected': false,
    },
    {'code': 'aucun', 'label': 'Aucun', 'selected': false},
  ],
  'is_answered': true,
  'categorie': 'mission',
  'points': 5,
  'type': 'choix_multiple',
  'is_NGC': false,
  'thematique': 'alimentation',
};
