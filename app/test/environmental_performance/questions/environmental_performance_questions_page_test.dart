import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/environmental_performance/questions/infrastructure/environment_performance_question_repository.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_bloc.dart';
import 'package:app/features/environmental_performance/questions/presentation/page/environmental_performance_question_page.dart';
import 'package:app/features/environmental_performance/summary/application/fetch_environmental_performance.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_repository.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_bloc.dart';
import 'package:app/features/environmental_performance/summary/presentation/page/environmental_performance_summary_page.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/know_your_customer/core/domain/mieux_vous_connaitre_port.dart';
import 'package:app/features/know_your_customer/core/infrastructure/mieux_vous_connaitre_api_adapter.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/authentication_service_setup.dart';
import '../../helpers/dio_mock.dart';
import '../../helpers/pump_page.dart';
import '../../old/mocks/gamification_bloc_fake.dart';
import '../../old/steps/iel_ecrit_dans_le_champ.dart';
import '../summary/environmental_performance_data.dart';
import 'environmental_performance_questions_data.dart';

Future<void> pumpEnvironmentalPerformancePage(
  final WidgetTester tester, {
  required final Dio dio,
}) async {
  final client = DioHttpClient(
    dio: dio,
    authenticationService: authenticationService,
  );
  final environmentalPerformanceRepository =
      EnvironmentalPerformanceSummaryRepository(client: client);
  final mieuxVousConnaitrePort =
      MieuxVousConnaitreApiAdapter(client: client, messageBus: MessageBus());
  await pumpPage(
    tester: tester,
    repositoryProviders: [
      RepositoryProvider<MieuxVousConnaitrePort>.value(
        value: mieuxVousConnaitrePort,
      ),
      RepositoryProvider<EnvironmentalPerformanceSummaryRepository>.value(
        value: environmentalPerformanceRepository,
      ),
    ],
    blocProviders: [
      BlocProvider<GamificationBloc>(
        create: (final context) => GamificationBlocFake(),
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
    page: EnvironmentalPerformanceSummaryPage.route,
    realRoutes: EnvironmentalPerformanceQuestionPage.route,
  );
  await tester.pumpAndSettle();
}

void main() {
  group('Votre bilan environnemental', () {
    testWidgets('Aller sur les questions', (final tester) async {
      final dio = DioMock()
        ..getM(
          '/utilisateur/{userId}/bilans/last_v2',
          responseData: environmentalPerformanceEmptyData,
        )
        ..getM(
          Endpoints.questions('ENCHAINEMENT_KYC_mini_bilan_carbone'),
          responseData: miniBilanQuestions,
        )
        ..getM(
          Endpoints.questionKyc('KYC_transport_voiture_km'),
          responseData: miniBilanQuestions.first,
        )
        ..putM(Endpoints.questionKyc('KYC_transport_voiture_km'))
        ..getM(
          Endpoints.questionKyc('KYC_transport_avion_3_annees'),
          responseData: miniBilanQuestions[1],
        )
        ..putM(Endpoints.questionKyc('KYC_transport_avion_3_annees'));
      await pumpEnvironmentalPerformancePage(tester, dio: dio);
      await tester.pumpAndSettle();
      await tester.tap(
        find.text(EnvironmentalPerformanceSummaryL10n.commencerMonMiniBilan),
      );
      await tester.pumpAndSettle();
      expect(find.bySemanticsLabel('Question 1 sur 2'), findsOneWidget);
      await ielEcritDansLeChamp(
        tester,
        label: Localisation.maReponse,
        enterText: '42',
      );
      await tester.tap(find.text(Localisation.continuer));
      await tester.pumpAndSettle();
      expect(find.bySemanticsLabel('Question 2 sur 2'), findsOneWidget);
      await tester.pumpAndSettle();
      await tester.tap(find.text(Localisation.non));
      dio.getM(
        '/utilisateur/{userId}/bilans/last_v2',
        responseData: environmentalPerformanceFullData,
      );
      await tester.tap(find.text(Localisation.continuer));
      await tester.pumpAndSettle();
      expect(find.text('Mon bilan environnemental'), findsOneWidget);
    });
  });
}
