import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/notifications/infrastructure/notification_service.dart';
import 'package:app/features/aids/core/presentation/bloc/aids_home_bloc.dart';
import 'package:app/features/aids/list/infrastructure/aids_repository.dart';
import 'package:app/features/challenges/section/infrastructure/challenges_repository.dart';
import 'package:app/features/challenges/section/presentation/bloc/challenges_bloc.dart';
import 'package:app/features/environmental_performance/questions/infrastructure/environment_performance_question_repository.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_bloc.dart';
import 'package:app/features/environmental_performance/questions/presentation/page/environmental_performance_question_page.dart';
import 'package:app/features/environmental_performance/summary/application/fetch_environmental_performance.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_repository.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_bloc.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/home/presentation/cubit/home_disclaimer_cubit.dart';
import 'package:app/features/home/presentation/pages/home_page.dart';
import 'package:app/features/mission/home/infrastructure/mission_home_repository.dart';
import 'package:app/features/mission/home/presentation/bloc/mission_home_bloc.dart';
import 'package:app/features/recommandations/infrastructure/recommandations_repository.dart';
import 'package:app/features/recommandations/presentation/bloc/recommandations_bloc.dart';
import 'package:app/features/utilisateur/infrastructure/user_repository.dart';
import 'package:app/features/utilisateur/presentation/bloc/user_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../features/helper/notification_service_fake.dart';
import '../../helpers/authentication_service_setup.dart';
import '../../helpers/dio_mock.dart';
import '../../helpers/pump_page.dart';
import '../../mission/mission_test.dart';
import '../../old/mocks/gamification_bloc_fake.dart';
import '../summary/environmental_performance_data.dart';

Future<void> pumpHomePage(final WidgetTester tester, final DioMock dio) async {
  dio
    ..getM(
      Endpoints.utilisateur,
      responseData: {'prenom': 'Lucas', 'is_onboarding_done': true},
    )
    ..getM(Endpoints.missionsRecommandees, responseData: missionThematiques)
    ..getM(
      '/utilisateurs/%7BuserId%7D/defis_v2?status=en_cours',
      responseData: <dynamic>[],
    )
    ..getM(
      Endpoints.aids,
      responseData: {
        'couverture_aides_ok': true,
        'liste_aides': <dynamic>[],
      },
    );

  final client = DioHttpClient(
    dio: dio,
    authenticationService: authenticationService,
  );

  await pumpPage(
    tester: tester,
    repositoryProviders: [
      RepositoryProvider<EnvironmentalPerformanceSummaryRepository>.value(
        value: EnvironmentalPerformanceSummaryRepository(client: client),
      ),
      RepositoryProvider<NotificationService>(
        create: (final context) =>
            const NotificationServiceFake(AuthorizationStatus.denied),
      ),
    ],
    blocProviders: [
      BlocProvider(
        create: (final context) => AidsHomeBloc(
          aidsRepository: AidsRepository(client: client),
        ),
      ),
      BlocProvider(
        create: (final context) => HomeDisclaimerCubit()..closeDisclaimer(),
      ),
      BlocProvider(
        create: (final context) => RecommandationsBloc(
          recommandationsRepository: RecommandationsRepository(client: client),
        ),
      ),
      BlocProvider<GamificationBloc>(
        create: (final context) => GamificationBlocFake(),
      ),
      BlocProvider<ChallengesBloc>(
        create: (final context) => ChallengesBloc(
          repository: ChallengesRepository(client: client),
        ),
      ),
      BlocProvider(
        create: (final context) => UserBloc(
          repository: UserRepository(client: client),
        ),
      ),
      BlocProvider(
        create: (final context) =>
            MissionHomeBloc(repository: MissionHomeRepository(client: client)),
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
    ],
    router: GoRouter(
      routes: [
        HomePage.route(
          routes: [
            GoRoute(
              path: EnvironmentalPerformanceQuestionPage.path,
              name: EnvironmentalPerformanceQuestionPage.name,
              builder: (final context, final state) => const Text(
                'route: ${EnvironmentalPerformanceQuestionPage.name}',
              ),
            ),
          ],
        ),
      ],
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  group("Mon bilan environnemental sur la page d'accueil", () {
    testWidgets(
      'Voir le contenu de Estimer mon bilan environnemental avec un bilan vide',
      (final tester) async {
        final dio = DioMock()
          ..getM(
            Endpoints.bilan,
            responseData: environmentalPerformanceEmptyData,
          )
          ..getM(
            Endpoints.questions('ENCHAINEMENT_KYC_mini_bilan_carbone'),
            responseData: miniBilan,
          );
        await mockNetworkImages(() async {
          await pumpHomePage(tester, dio);
          await tester.pumpAndSettle();
          expect(
            find.text('Estimer mon bilan environnemental'),
            findsOneWidget,
          );
          expect(
            find.text(
              EnvironmentalPerformanceSummaryL10n.estimerUnPremierBilan,
            ),
            findsOneWidget,
          );
          expect(find.text('7 questions'), findsOneWidget);
        });
      },
    );

    testWidgets('Aller sur les questions du mini bilan', (final tester) async {
      final dio = DioMock()
        ..getM(
          Endpoints.bilan,
          responseData: environmentalPerformanceEmptyData,
        )
        ..getM(
          Endpoints.questions('ENCHAINEMENT_KYC_mini_bilan_carbone'),
          responseData: miniBilan,
        );
      await mockNetworkImages(() async {
        await pumpHomePage(tester, dio);
        await tester.pumpAndSettle();
        await tester.tap(
          find.text(EnvironmentalPerformanceSummaryL10n.estimerUnPremierBilan),
        );
        await tester.pumpAndSettle();

        expect(
          find.text('route: ${EnvironmentalPerformanceQuestionPage.name}'),
          findsOneWidget,
        );
      });
    });

    testWidgets(
      'Aller sur les questions du Mes déplacements',
      (final tester) async {
        final dio = DioMock()
          ..getM(
            Endpoints.bilan,
            responseData: environmentalPerformancePartialData,
          )
          ..getM(
            Endpoints.questions('ENCHAINEMENT_KYC_bilan_transport'),
            responseData: miniBilan,
          );
        await mockNetworkImages(() async {
          await pumpHomePage(tester, dio);
          await tester.pumpAndSettle();
          await tester.tap(find.text('7 questions'));
          await tester.pumpAndSettle();

          expect(
            find.text('route: ${EnvironmentalPerformanceQuestionPage.name}'),
            findsOneWidget,
          );
        });
      },
    );

    testWidgets(
      'Voir le contenu de Mon bilan environnemental',
      (final tester) async {
        final dio = DioMock()
          ..getM(
            Endpoints.bilan,
            responseData: environmentalPerformanceFullData,
          );
        await mockNetworkImages(() async {
          await pumpHomePage(tester, dio);
          expect(find.text('Mon bilan environnemental'), findsOneWidget);
          expect(find.text('2,9'), findsOneWidget);
        });
      },
    );

    testWidgets(
      'Voir le contenu de "Activer le mode développeur"',
      (final tester) async {
        final dio = DioMock()
          ..getM(
            Endpoints.bilan,
            responseData: environmentalPerformanceFullData,
          );
        await mockNetworkImages(() async {
          await pumpHomePage(tester, dio);
          await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
          await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
          await expectLater(tester, meetsGuideline(textContrastGuideline));
          await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        });
      },
    );
  });
}
