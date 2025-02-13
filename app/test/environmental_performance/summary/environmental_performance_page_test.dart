import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/environmental_performance/questions/infrastructure/environment_performance_question_repository.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_bloc.dart';
import 'package:app/features/environmental_performance/questions/presentation/page/environmental_performance_question_page.dart';
import 'package:app/features/environmental_performance/summary/application/fetch_environmental_performance.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_repository.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_bloc.dart';
import 'package:app/features/environmental_performance/summary/presentation/page/environmental_performance_summary_page.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../helpers/authentication_service_setup.dart';
import '../../helpers/dio_mock.dart';
import '../../helpers/pump_page.dart';
import '../../old/mocks/gamification_bloc_fake.dart';
import 'environmental_performance_data.dart';

Future<void> pumpEnvironmentalPerformancePage(final WidgetTester tester, final Dio dio) async {
  final dioHttpClient = DioHttpClient(dio: dio, authenticationService: authenticationService);
  await pumpPage(
    tester: tester,
    repositoryProviders: [
      RepositoryProvider<EnvironmentalPerformanceSummaryRepository>.value(
        value: EnvironmentalPerformanceSummaryRepository(client: dioHttpClient),
      ),
    ],
    blocProviders: [
      BlocProvider<GamificationBloc>(create: (final context) => GamificationBlocFake()),
      BlocProvider(
        create:
            (final context) => EnvironmentalPerformanceBloc(
              useCase: FetchEnvironmentalPerformance(EnvironmentalPerformanceSummaryRepository(client: dioHttpClient)),
            ),
      ),
      BlocProvider(
        create:
            (final context) => EnvironmentalPerformanceQuestionBloc(
              repository: EnvironmentalPerformanceQuestionRepository(client: dioHttpClient),
            ),
      ),
    ],
    page: EnvironmentalPerformanceSummaryPage.route,
    routes: {EnvironmentalPerformanceQuestionPage.name: EnvironmentalPerformanceQuestionPage.path},
  );
  await tester.pumpAndSettle();
}

void main() {
  group('Votre bilan environnemental', () {
    for (final testCase in [
      (
        header: EnvironmentalPerformanceSummaryL10n.quEstCeQuUn,
        expected: 'Que l’on se rende dans un magasin de quartier pour faire ses courses',
      ),
      (
        header: EnvironmentalPerformanceSummaryL10n.commentEstCalcule,
        expected: 'Votre bilan environnemental est calculé à partir',
      ),
    ]) {
      testWidgets('Voir le contenu de ${testCase.header}', (final tester) async {
        await mockNetworkImages(() async {
          final dio = DioMock()..getM(Endpoints.bilan, responseData: environmentalPerformancePartialData);

          await pumpEnvironmentalPerformancePage(tester, dio);
          await tester.scrollUntilVisible(
            find.text(testCase.header),
            300,
            scrollable: find.descendant(of: find.byType(ListView), matching: find.byType(Scrollable).first),
          );
          await tester.pumpAndSettle();
          await tester.tap(find.text(testCase.header));
          await tester.pumpAndSettle();
          expect(find.textContaining(testCase.expected), findsOneWidget);
        });
      });
    }

    testWidgets('Voir le contenu de Estimer mon bilan environnemental avec un bilan vide', (final tester) async {
      final dio =
          DioMock()
            ..getM(Endpoints.bilan, responseData: environmentalPerformanceEmptyData)
            ..getM(Endpoints.questions('ENCHAINEMENT_KYC_mini_bilan_carbone'), responseData: miniBilan);
      await pumpEnvironmentalPerformancePage(tester, dio);
      await tester.pumpAndSettle();
      expect(find.text('Estimer mon bilan environnemental'), findsOneWidget);
      expect(find.text(EnvironmentalPerformanceSummaryL10n.commencerMonMiniBilan), findsOneWidget);
      expect(find.text('7 questions'), findsOneWidget);
    });

    testWidgets('Aller sur les questions du mini bilan', (final tester) async {
      final dio =
          DioMock()
            ..getM(Endpoints.bilan, responseData: environmentalPerformanceEmptyData)
            ..getM(Endpoints.questions('ENCHAINEMENT_KYC_mini_bilan_carbone'), responseData: miniBilan);
      await pumpEnvironmentalPerformancePage(tester, dio);
      await tester.pumpAndSettle();
      await tester.tap(find.text(EnvironmentalPerformanceSummaryL10n.commencerMonMiniBilan));
      await tester.pumpAndSettle();

      expect(find.text('route: ${EnvironmentalPerformanceQuestionPage.name}'), findsOneWidget);
    });

    testWidgets('Voir le contenu de Estimer mon bilan environnemental avec un bilan partiel', (final tester) async {
      await mockNetworkImages(() async {
        final dio = DioMock()..getM(Endpoints.bilan, responseData: environmentalPerformancePartialData);
        await pumpEnvironmentalPerformancePage(tester, dio);
        expect(find.text('Estimer mon bilan environnemental'), findsOneWidget);
        expect(find.text('Faible'), findsOneWidget);
        expect(find.text('Moyen'), findsOneWidget);
        expect(find.text('Fort'), findsOneWidget);
        expect(find.text('Très fort'), findsNothing);
        expect(find.text('✨ Estimation complète à 23%'), findsOneWidget);
        expect(find.text('Me déplacer'), findsOneWidget);
      });
    });

    testWidgets('Aller sur les questions du Mes déplacements avec un bilan partiel', (final tester) async {
      await mockNetworkImages(() async {
        final dio =
            DioMock()
              ..getM(Endpoints.bilan, responseData: environmentalPerformancePartialData)
              ..getM(Endpoints.questions('ENCHAINEMENT_KYC_bilan_transport'), responseData: miniBilan);
        await pumpEnvironmentalPerformancePage(tester, dio);
        await tester.pumpAndSettle();
        await tester.scrollUntilVisible(
          find.text('7 questions'),
          300,
          scrollable: find.descendant(of: find.byType(ListView), matching: find.byType(Scrollable).first),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('7 questions'));
        await tester.pumpAndSettle();

        expect(find.text('route: ${EnvironmentalPerformanceQuestionPage.name}'), findsOneWidget);
      });
    });

    testWidgets('Voir le contenu de Mon bilan environnemental', (final tester) async {
      final dio = DioMock()..getM(Endpoints.bilan, responseData: environmentalPerformanceFullData);
      await mockNetworkImages(() async {
        await pumpEnvironmentalPerformancePage(tester, dio);
        expect(find.text('Mon bilan environnemental'), findsOneWidget);
        expect(find.text('2,9'), findsOneWidget);
        expect(find.text('Voiture'), findsOneWidget);
        await tester.scrollUntilVisible(
          find.text('Services sociétaux'),
          300,
          scrollable: find.descendant(of: find.byType(ListView), matching: find.byType(Scrollable).first),
        );
        await tester.pumpAndSettle();
        expect(find.text('Services sociétaux'), findsOneWidget);
        await tester.tap(find.text('Services sociétaux'));
        await tester.pumpAndSettle();
        expect(find.text('Services publics'), findsOneWidget);
      });
    });

    testWidgets('Aller sur les questions du Mes déplacements avec un bilan complet', (final tester) async {
      await mockNetworkImages(() async {
        final dio =
            DioMock()
              ..getM(Endpoints.bilan, responseData: environmentalPerformanceFullData)
              ..getM(Endpoints.questions('ENCHAINEMENT_KYC_bilan_transport'), responseData: miniBilan);
        await pumpEnvironmentalPerformancePage(tester, dio);
        await tester.pumpAndSettle();
        await tester.scrollUntilVisible(
          find.text('7 questions'),
          300,
          scrollable: find.descendant(of: find.byType(ListView), matching: find.byType(Scrollable).first),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('7 questions'));
        await tester.pumpAndSettle();

        expect(find.text('route: ${EnvironmentalPerformanceQuestionPage.name}'), findsOneWidget);
      });
    });

    testWidgets('Voir le contenu de "Activer le mode développeur"', (final tester) async {
      final dio = DioMock()..getM(Endpoints.bilan, responseData: environmentalPerformanceFullData);
      await pumpEnvironmentalPerformancePage(tester, dio);
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    });
  });
}
