import 'package:app/core/error/domain/api_erreur.dart';
import 'package:app/features/authentification/question_code_postal/presentation/pages/question_code_postal_page.dart';
import 'package:app/features/first_name/domain/first_name.dart';
import 'package:app/features/first_name/domain/first_name_port.dart';
import 'package:app/features/first_name/presentation/pages/first_name_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:faker/faker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/pump_page.dart';

class _FirstNamePortMock extends Mock implements FirstNamePort {}

Future<void> _pumpFirstNamePage(
  final WidgetTester tester, {
  final FirstNamePort? firstNamePort,
}) async {
  await pumpPage(
    tester: tester,
    repositoryProviders: [
      RepositoryProvider<FirstNamePort>.value(
        value: firstNamePort ?? _FirstNamePortMock(),
      ),
    ],
    page: const FirstNamePage(),
    routes: {QuestionCodePostalPage.name: QuestionCodePostalPage.path},
  );
}

void main() {
  final faker = Faker();

  setUpAll(() {
    registerFallbackValue(const FirstName.create(''));
  });

  group('Prénom devrait ', () {
    testWidgets(
      "aller sur la page suivante lorsqu'il est saisi et valider",
      (final tester) async {
        final firstNamePort = _FirstNamePortMock();
        when(() => firstNamePort.addFirstName(any()))
            .thenAnswer((final _) async => const Right(unit));
        await _pumpFirstNamePage(tester, firstNamePort: firstNamePort);

        final validFirstName = faker.person.firstName();

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
        final firstNamePort = _FirstNamePortMock();
        final message = faker.lorem.sentence();
        when(() => firstNamePort.addFirstName(any())).thenAnswer(
          (final _) async => Left(ApiErreur(message)),
        );

        await _pumpFirstNamePage(tester, firstNamePort: firstNamePort);

        final validFirstName = faker.person.firstName();

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
        find.bySemanticsLabel(Localisation.bienvenueSurAgir),
        findsOneWidget,
      );
      expect(
        find.bySemanticsLabel(Localisation.bienvenueSurAgirDetails),
        findsOneWidget,
      );
      expect(find.bySemanticsLabel(Localisation.votrePrenom), findsOneWidget);
      expect(find.bySemanticsLabel(Localisation.continuer), findsOneWidget);
    });
  });
}
