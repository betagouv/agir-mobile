import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/features/gamification/infrastructure/gamification_repository.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/core/infrastructure/question_mapper.dart';
import 'package:app/features/know_your_customer/list/infrastructure/know_your_customers_repository.dart';
import 'package:app/features/know_your_customer/list/presentation/pages/know_your_customers_page.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/authentication_service_setup.dart';
import '../helpers/dio_mock.dart';
import '../helpers/faker.dart';
import '../helpers/pump_page.dart';

Future<void> _pumpPage(
  final WidgetTester tester, {
  required final DioMock dio,
}) async {
  final client = DioHttpClient(
    dio: dio,
    authenticationService: authenticationService,
  );
  await pumpPage(
    tester: tester,
    repositoryProviders: [
      RepositoryProvider<KnowYourCustomersRepository>(
        create: (final context) => KnowYourCustomersRepository(client: client),
      ),
    ],
    blocProviders: [
      BlocProvider(
        create:
            (final context) => GamificationBloc(
              repository: GamificationRepository(
                client: client,
                messageBus: MessageBus(),
              ),
              authenticationService: authenticationService,
            ),
      ),
    ],
    page: KnowYourCustomersPage.route,
  );
}

void main() {
  late List<Map<String, dynamic>> questions;
  late DioMock dio;
  setUp(() {
    dio = DioMock();
    questions = fakerQuestions();
    dio.getM(Endpoints.questionsKyc, responseData: questions);
  });

  testWidgets('Voir la liste des questions KYC', (final tester) async {
    await _pumpPage(tester, dio: dio);

    await tester.pumpAndSettle();

    for (final question in questions) {
      final expected = QuestionMapper.fromJson(question)!;
      if (expected.isAnswered) {
        expect(find.text(expected.label), findsOneWidget);
        final responsesDisplay = expected.responsesDisplay();
        if (responsesDisplay.isNotEmpty) {
          expect(find.text(responsesDisplay), findsOneWidget);
        }
      }
    }
  });

  testWidgets('Filtrer par thématique', (final tester) async {
    await _pumpPage(tester, dio: dio);

    await tester.pumpAndSettle();

    const themes = [null, ...ThemeType.values];

    for (final theme in themes) {
      await tester.tap(find.text(theme?.displayName ?? Localisation.tout));

      await tester.pumpAndSettle();

      for (final question in questions) {
        final expected = QuestionMapper.fromJson(question)!;

        Matcher findsWhenAnsweredAndPartOfTheme(
          final Question expected,
          final ThemeType? theme,
        ) {
          if (!expected.isAnswered) {
            return findsNothing;
          }

          if (theme == null) {
            return findsOneWidget;
          }

          return expected.theme == theme ? findsOneWidget : findsNothing;
        }

        expect(
          find.text(expected.label),
          findsWhenAnsweredAndPartOfTheme(expected, theme),
        );
      }
    }
  });
}
