import 'dart:io';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/questions/first_name/domain/first_name.dart';
import 'package:app/features/questions/first_name/infrastructure/first_name_repository.dart';
import 'package:app/features/questions/first_name/presentation/pages/first_name_page.dart';
import 'package:app/features/questions/question_code_postal/presentation/pages/question_code_postal_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:clock/clock.dart';
import 'package:dsfr/dsfr.dart';
import 'package:faker/faker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/authentication_service_setup.dart';
import '../helpers/dio_mock.dart';
import '../helpers/pump_page.dart';

Future<void> _pumpFirstNamePage(
  final WidgetTester tester, {
  final DioMock? dio,
}) async {
  await pumpPage(
    tester: tester,
    repositoryProviders: [
      RepositoryProvider<FirstNameRepository>(
        create: (final context) => FirstNameRepository(
          client: DioHttpClient(
            dio: dio ?? DioMock(),
            authenticationService: authenticationService,
          ),
        ),
      ),
      RepositoryProvider<Clock>.value(value: const Clock()),
    ],
    page: FirstNamePage.route,
    routes: {QuestionCodePostalPage.name: QuestionCodePostalPage.path},
  );
}

void main() {
  setUpAll(() {
    registerFallbackValue(const FirstName.create(''));
  });

  group('Prénom devrait ', () {
    testWidgets(
      "aller sur la page suivante lorsqu'il est saisi et valider",
      (final tester) async {
        final dio = DioMock()..patchM(Endpoints.profile);
        await _pumpFirstNamePage(tester, dio: dio);

        final validFirstName = Faker().person.firstName();

        await tester.enterText(find.byType(DsfrInput), validFirstName);
        await tester.pump();

        await tester.tap(find.byType(DsfrButton));

        await tester.pumpAndSettle();

        expect(
          find.text('route: ${QuestionCodePostalPage.name}'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      "aller sur la page suivante lorsqu'il est saisi et appuyer sur le bouton done",
      (final tester) async {
        final dio = DioMock()..patchM(Endpoints.profile);
        await _pumpFirstNamePage(tester, dio: dio);

        final validFirstName = Faker().person.firstName();

        await tester.enterText(find.byType(DsfrInput), validFirstName);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        expect(
          find.text('route: ${QuestionCodePostalPage.name}'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      "afficher une erreur lorsqu'un prénom vide est saisi",
      (final tester) async {
        await _pumpFirstNamePage(tester);

        await tester.enterText(find.byType(DsfrInput), 'a');
        await tester.pump();

        await tester.enterText(find.byType(DsfrInput), '');
        await tester.pump();

        expect(find.text(Localisation.firstNameEmpty), findsOneWidget);
      },
    );

    testWidgets(
      "afficher une erreur lorsqu'un prénom invalide est saisi",
      (final tester) async {
        await _pumpFirstNamePage(tester);

        const invalidFirstName = '123';

        await tester.enterText(find.byType(DsfrInput), invalidFirstName);
        await tester.pump();

        expect(find.text(Localisation.firstNameInvalid), findsOneWidget);
      },
    );

    testWidgets(
      "afficher une erreur lorsque l'ajout échoue",
      (final tester) async {
        final message = faker.lorem.sentence();
        final dio = DioMock()
          ..patchM(
            Endpoints.profile,
            statusCode: HttpStatus.badRequest,
            responseData: {'message': message},
          );
        await _pumpFirstNamePage(tester, dio: dio);

        final validFirstName = Faker().person.firstName();

        await tester.enterText(find.byType(DsfrInput), validFirstName);
        await tester.pump();

        await tester.tap(find.byType(DsfrButton));
        await tester.pumpAndSettle();

        expect(find.text(message), findsOneWidget);
      },
    );

    testWidgets('être accessible', (final tester) async {
      await _pumpFirstNamePage(tester);
      expect(
        find.bySemanticsLabel(
          Localisation.questionCourantSurMax(1, 3).replaceAll('**', ''),
        ),
        findsOneWidget,
      );
      expect(
        find.bySemanticsLabel(Localisation.bienvenueSur),
        findsOneWidget,
      );
      expect(
        find.bySemanticsLabel(Localisation.bienvenueSurDetails),
        findsOneWidget,
      );
      expect(find.bySemanticsLabel(Localisation.monPrenom), findsOneWidget);
      expect(find.bySemanticsLabel(Localisation.continuer), findsOneWidget);
    });
  });
}
