import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/gamification/domain/gamification_port.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/know_your_customer/list/infrastructure/know_your_customers_repository.dart';
import 'package:app/features/know_your_customer/list/presentation/pages/know_your_customers_page.dart';
import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:app/features/mieux_vous_connaitre/core/infrastructure/question_mapper.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/authentication_service_setup.dart';
import '../helpers/dio_mock.dart';
import '../helpers/faker.dart';
import '../helpers/pump_page.dart';

class _GamificationPortMock extends Mock implements GamificationPort {}

Future<void> _pumpPage(
  final WidgetTester tester, {
  required final KnowYourCustomersRepository repository,
}) async {
  final gamificationPort = _GamificationPortMock();
  when(gamificationPort.mettreAJourLesPoints).thenAnswer(
    (final _) async => const Right(null),
  );

  await pumpPage(
    tester: tester,
    repositoryProviders: [
      RepositoryProvider<KnowYourCustomersRepository>.value(value: repository),
    ],
    blocProviders: [
      BlocProvider<GamificationBloc>(
        create: (final context) => GamificationBloc(
          gamificationPort: gamificationPort,
          authenticationService: authenticationService,
        ),
      ),
    ],
    page: KnowYourCustomersPage.route,
  );
}

void main() {
  late KnowYourCustomersRepository repository;
  late List<Map<String, dynamic>> questions;

  setUp(() {
    final dio = DioMock();
    repository = KnowYourCustomersRepository(
      client: DioHttpClient(
        dio: dio,
        authenticationService: authenticationService,
      ),
    );
    questions = List.generate(10, (final _) => questionFaker());
    dio.getM('/utilisateurs/{userId}/questionsKYC', responseData: questions);
  });

  testWidgets('Voir la liste des questions KYC', (final tester) async {
    await _pumpPage(tester, repository: repository);

    await tester.pumpAndSettle();

    for (final question in questions) {
      final expected = QuestionMapper.fromJson(question)!;
      if (expected.isAnswered()) {
        expect(find.text(expected.text.value), findsOneWidget);
        final responsesDisplay = expected.responsesDisplay();
        if (responsesDisplay.isNotEmpty) {
          expect(find.text(responsesDisplay), findsOneWidget);
        }
      }
    }
  });

  testWidgets('Filtrer par thématique', (final tester) async {
    await _pumpPage(tester, repository: repository);

    await tester.pumpAndSettle();

    const themes = [null, ...QuestionTheme.values];

    for (final theme in themes) {
      await tester
          .tap(find.text(theme?.label ?? Localisation.lesCategoriesTout));

      await tester.pumpAndSettle();

      for (final question in questions) {
        final expected = QuestionMapper.fromJson(question)!;

        Matcher findsWhenAnsweredAndPartOfTheme(
          final Question expected,
          final QuestionTheme? theme,
        ) {
          if (!expected.isAnswered()) {
            return findsNothing;
          }

          if (theme == null) {
            return findsOneWidget;
          }

          return expected.isPartOfTheme(theme) ? findsOneWidget : findsNothing;
        }

        expect(
          find.text(expected.text.value),
          findsWhenAnsweredAndPartOfTheme(expected, theme),
        );
      }
    }
  });
}
