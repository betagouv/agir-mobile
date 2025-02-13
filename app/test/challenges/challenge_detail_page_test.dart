import 'dart:async';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/features/challenges/core/domain/challenge_id.dart';
import 'package:app/features/challenges/detail/infrastructure/challenge_repository.dart';
import 'package:app/features/challenges/detail/presentation/pages/challenge_detail_page.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/dio_mock.dart';
import '../helpers/faker.dart';
import '../helpers/pump_page.dart';
import '../old/mocks/authentication_service_fake.dart';
import '../old/mocks/gamification_bloc_fake.dart';

void main() {
  bool isRadioButtonEnabled<T>(final WidgetTester tester, final String title) {
    final widget = tester.widget<DsfrRadioButton<T>>(
      find.descendant(
        of: find.byType(DsfrRadioButtonSetHeadless<T>),
        matching: find.byWidgetPredicate(
          (final w) => w is DsfrRadioButton<T> && w.title == title,
        ),
      ),
    );

    return widget.groupValue == widget.value;
  }

  Future<void> pumpChallengeDetailPage(
    final WidgetTester tester, {
    final DioMock? dio,
    final Map<String, dynamic>? responseData,
    final MessageBus? messageBus,
  }) async {
    const challengeId = ChallengeId('73');
    final endpoint = Endpoints.challenge(challengeId.value);
    final dioMock =
        dio ??
        (DioMock()
          ..getM(endpoint, responseData: responseData)
          ..patchM(endpoint));
    await pumpPage(
      tester: tester,
      repositoryProviders: [
        RepositoryProvider<ChallengeRepository>.value(
          value: ChallengeRepository(
            client: DioHttpClient(
              dio: dioMock,
              authenticationService: const AuthenticationServiceFake(),
            ),
            messageBus: messageBus ?? MessageBus(),
          ),
        ),
      ],
      blocProviders: [
        BlocProvider<GamificationBloc>(
          create: (final context) => GamificationBlocFake(),
        ),
      ],
      page: GoRoute(
        path: 'path',
        name: 'name',
        builder:
            (final context, final state) =>
                const ChallengeDetailPage(id: challengeId),
      ),
    );
  }

  group("L'affichage du défi devrait être correct pour ", () {
    testWidgets('le défi à faire', (final tester) async {
      await pumpChallengeDetailPage(
        tester,
        responseData: challengeFaker(status: 'todo'),
      );
      await tester.pumpAndSettle();
      expect(
        isRadioButtonEnabled<bool>(tester, Localisation.jeReleveLAction),
        false,
      );
      expect(
        isRadioButtonEnabled<bool>(tester, Localisation.pasPourMoi),
        false,
      );
      expect(
        find.text(Localisation.bonnesAstucesPourRealiserCetteAction),
        findsOneWidget,
      );
      expect(
        find.text(Localisation.pourquoiCetteAction, skipOffstage: false),
        findsOneWidget,
      );
    });

    testWidgets('le défi non désirée', (final tester) async {
      await pumpChallengeDetailPage(
        tester,
        responseData: challengeFaker(status: 'pas_envie'),
      );
      await tester.pumpAndSettle();
      expect(
        isRadioButtonEnabled<bool>(tester, Localisation.jeReleveLAction),
        false,
      );
      expect(isRadioButtonEnabled<bool>(tester, Localisation.pasPourMoi), true);
      expect(
        find.text(Localisation.bonnesAstucesPourRealiserCetteAction),
        findsNothing,
      );
      expect(find.text(Localisation.pourquoiCetteAction), findsNothing);
    });

    testWidgets('le défi non désirée avec motif', (final tester) async {
      const reason = 'parce que';
      await pumpChallengeDetailPage(
        tester,
        responseData: challengeFaker(status: 'pas_envie', reason: reason),
      );
      await tester.pumpAndSettle();
      expect(
        isRadioButtonEnabled<bool>(tester, Localisation.jeReleveLAction),
        false,
      );
      expect(isRadioButtonEnabled<bool>(tester, Localisation.pasPourMoi), true);
      expect(
        find.text(Localisation.bonnesAstucesPourRealiserCetteAction),
        findsNothing,
      );
      expect(find.text(Localisation.pourquoiCetteAction), findsNothing);
      expect(find.text(reason), findsOneWidget);
    });

    testWidgets('le défi en cours', (final tester) async {
      await pumpChallengeDetailPage(
        tester,
        responseData: challengeFaker(status: 'en_cours'),
      );
      await tester.pumpAndSettle();
      expect(
        isRadioButtonEnabled<bool>(tester, Localisation.actionRealisee),
        false,
      );
      expect(
        isRadioButtonEnabled<bool>(tester, Localisation.finalementPasPourMoi),
        false,
      );
      expect(
        find.text(Localisation.bonnesAstucesPourRealiserCetteAction),
        findsOneWidget,
      );
      expect(
        find.text(Localisation.pourquoiCetteAction, skipOffstage: false),
        findsOneWidget,
      );
    });

    testWidgets('le défi déjà réalisée', (final tester) async {
      await pumpChallengeDetailPage(
        tester,
        responseData: challengeFaker(status: 'deja_fait'),
      );
      await tester.pumpAndSettle();
      expect(
        isRadioButtonEnabled<bool>(tester, Localisation.actionRealisee),
        true,
      );
      expect(
        isRadioButtonEnabled<bool>(tester, Localisation.finalementPasPourMoi),
        false,
      );
      expect(
        find.text(Localisation.bonnesAstucesPourRealiserCetteAction),
        findsOneWidget,
      );
      expect(
        find.text(Localisation.pourquoiCetteAction, skipOffstage: false),
        findsOneWidget,
      );
    });

    testWidgets('le défi abandonnée', (final tester) async {
      await pumpChallengeDetailPage(
        tester,
        responseData: challengeFaker(status: 'abondon'),
      );
      await tester.pumpAndSettle();
      expect(
        isRadioButtonEnabled<bool>(tester, Localisation.actionRealisee),
        false,
      );
      expect(
        isRadioButtonEnabled<bool>(tester, Localisation.finalementPasPourMoi),
        true,
      );
      expect(
        find.text(Localisation.bonnesAstucesPourRealiserCetteAction),
        findsNothing,
      );
      expect(find.text(Localisation.pourquoiCetteAction), findsNothing);
    });

    testWidgets('le défi abandonnée avec motif', (final tester) async {
      const reason = 'parce que';
      await pumpChallengeDetailPage(
        tester,
        responseData: challengeFaker(status: 'abondon', reason: reason),
      );
      await tester.pumpAndSettle();
      expect(
        isRadioButtonEnabled<bool>(tester, Localisation.actionRealisee),
        false,
      );
      expect(
        isRadioButtonEnabled<bool>(tester, Localisation.finalementPasPourMoi),
        true,
      );
      expect(
        find.text(Localisation.bonnesAstucesPourRealiserCetteAction),
        findsNothing,
      );
      expect(find.text(Localisation.pourquoiCetteAction), findsNothing);
      expect(find.text(reason), findsOneWidget);
    });

    testWidgets('le défi terminée', (final tester) async {
      await pumpChallengeDetailPage(
        tester,
        responseData: challengeFaker(status: 'fait'),
      );
      await tester.pumpAndSettle();
      expect(
        isRadioButtonEnabled<bool>(tester, Localisation.actionRealisee),
        true,
      );
      expect(
        isRadioButtonEnabled<bool>(tester, Localisation.finalementPasPourMoi),
        false,
      );
      expect(
        find.text(Localisation.bonnesAstucesPourRealiserCetteAction),
        findsOneWidget,
      );
      expect(
        find.text(Localisation.pourquoiCetteAction, skipOffstage: false),
        findsOneWidget,
      );
    });
  });

  group('La modification de le défi devrait fonctionner pour ', () {
    testWidgets('choisir "pas pour moi" sans valider', (final tester) async {
      await pumpChallengeDetailPage(
        tester,
        responseData: challengeFaker(status: 'todo'),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text(Localisation.pasPourMoi));

      await tester.pumpAndSettle();

      expect(
        isRadioButtonEnabled<bool>(tester, Localisation.jeReleveLAction),
        false,
      );

      expect(isRadioButtonEnabled<bool>(tester, Localisation.pasPourMoi), true);

      expect(
        find.text(Localisation.bonnesAstucesPourRealiserCetteAction),
        findsNothing,
      );

      expect(find.text(Localisation.pourquoiCetteAction), findsNothing);
    });

    testWidgets('commencer le défi', (final tester) async {
      const id = '73';
      final path = Endpoints.challenge(id);
      final dio =
          DioMock()
            ..getM(path, responseData: challengeFaker(id: id, status: 'todo'))
            ..patchM(path);

      await pumpChallengeDetailPage(tester, dio: dio);

      await tester.pumpAndSettle();

      await tester.tap(find.text(Localisation.jeReleveLAction));

      await tester.pumpAndSettle();

      expect(
        isRadioButtonEnabled<bool>(tester, Localisation.jeReleveLAction),
        true,
      );

      await tester.tap(find.text(Localisation.valider));

      await tester.pumpAndSettle();

      verify(() => dio.patch<dynamic>(path, data: {'status': 'en_cours'}));

      expect(find.text('pop'), findsOneWidget);
    });

    testWidgets('choisir "pas pour moi" avec un motif', (final tester) async {
      const id = '73';
      final path = Endpoints.challenge(id);
      final dio =
          DioMock()
            ..getM(path, responseData: challengeFaker(id: id, status: 'todo'))
            ..patchM(path);

      await pumpChallengeDetailPage(tester, dio: dio);

      await tester.pumpAndSettle();

      await tester.tap(find.text(Localisation.pasPourMoi));

      await tester.pumpAndSettle();

      expect(isRadioButtonEnabled<bool>(tester, Localisation.pasPourMoi), true);

      const reason = 'parce que';
      await tester.enterText(
        find.byKey(
          const ValueKey(Localisation.cetteActionNeVousConvientPasDetails),
        ),
        reason,
      );

      await tester.pump();

      await tester.tap(find.text(Localisation.valider));

      await tester.pumpAndSettle();

      verify(
        () => dio.patch<dynamic>(
          path,
          data: {'motif': reason, 'status': 'pas_envie'},
        ),
      );

      expect(find.text('pop'), findsOneWidget);
    });

    testWidgets(
      'l\'action "pas pour moi" qui devient "en cours" (motif effacé)',
      (final tester) async {
        const id = '73';
        final path = Endpoints.challenge(id);
        final dio =
            DioMock()
              ..getM(
                path,
                responseData: challengeFaker(
                  id: id,
                  status: 'pas_envie',
                  reason: 'parce que',
                ),
              )
              ..patchM(path);

        await pumpChallengeDetailPage(tester, dio: dio);

        await tester.pumpAndSettle();

        await tester.tap(find.text(Localisation.jeReleveLAction));

        await tester.pumpAndSettle();

        expect(
          isRadioButtonEnabled<bool>(tester, Localisation.jeReleveLAction),
          true,
        );

        await tester.tap(find.text(Localisation.valider));

        await tester.pumpAndSettle();

        verify(() => dio.patch<dynamic>(path, data: {'status': 'en_cours'}));

        expect(find.text('pop'), findsOneWidget);
      },
    );

    testWidgets('l\'action "pas pour moi" dont seul le motif change', (
      final tester,
    ) async {
      const id = '73';
      final path = Endpoints.challenge(id);
      final dio =
          DioMock()
            ..getM(
              path,
              responseData: challengeFaker(
                id: id,
                status: 'pas_envie',
                reason: 'parce que',
              ),
            )
            ..patchM(path);

      await pumpChallengeDetailPage(tester, dio: dio);

      await tester.pumpAndSettle();

      const reason = 'parce que 2';
      await tester.enterText(
        find.byKey(
          const ValueKey(Localisation.cetteActionNeVousConvientPasDetails),
        ),
        reason,
      );

      await tester.pump();

      await tester.scrollUntilVisible(
        find.text(Localisation.valider),
        300,
        scrollable: find.descendant(
          of: find.byType(ListView),
          matching: find.byType(Scrollable).first,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text(Localisation.valider, skipOffstage: false));

      await tester.pumpAndSettle();

      verify(
        () => dio.patch<dynamic>(
          path,
          data: {'motif': reason, 'status': 'pas_envie'},
        ),
      );

      expect(find.text('pop'), findsOneWidget);
    });

    testWidgets(
      'l\'action "pas pour moi" qui change de statut puis revient à "pas pour moi"',
      (final tester) async {
        const id = '73';
        const reason = 'parce que';
        final path = Endpoints.challenge(id);
        final dio =
            DioMock()
              ..getM(
                path,
                responseData: challengeFaker(
                  id: id,
                  status: 'pas_envie',
                  reason: reason,
                ),
              )
              ..patchM(path);

        await pumpChallengeDetailPage(tester, dio: dio);

        await tester.pumpAndSettle();

        await tester.tap(find.text(Localisation.jeReleveLAction));

        await tester.pumpAndSettle();

        await tester.tap(find.text(Localisation.pasPourMoi));

        await tester.pumpAndSettle();

        await tester.tap(find.text(Localisation.valider));

        await tester.pumpAndSettle();

        verify(
          () => dio.patch<dynamic>(
            path,
            data: {'motif': reason, 'status': 'pas_envie'},
          ),
        );

        expect(find.text('pop'), findsOneWidget);
      },
    );

    group('réaliser le défi', () {
      const id = '73';
      final path = Endpoints.challenge(id);
      late MessageBus messageBus;
      late DioMock dio;
      setUp(() {
        dio =
            DioMock()
              ..getM(
                path,
                responseData: challengeFaker(id: id, status: 'en_cours'),
              )
              ..patchM(path);
        messageBus = MessageBus();
      });

      tearDown(() async {
        await messageBus.close();
        reset(dio);
      });

      testWidgets('réaliser le défi', (final tester) async {
        final completer = Completer<void>();
        final subscription = messageBus
            .subscribe(challengeCompletedTopic)
            .listen((final event) => completer.complete());

        await pumpChallengeDetailPage(tester, dio: dio, messageBus: messageBus);
        await tester.pumpAndSettle();
        await tester.tap(find.text(Localisation.actionRealisee));
        await tester.pumpAndSettle();
        expect(
          isRadioButtonEnabled<bool>(tester, Localisation.actionRealisee),
          true,
        );
        await tester.tap(find.text(Localisation.valider));
        await tester.pumpAndSettle();

        verify(() => dio.patch<dynamic>(path, data: {'status': 'fait'}));
        expect(find.text('pop'), findsOneWidget);
        expect(completer.isCompleted, isTrue);
        unawaited(subscription.cancel());
      });
    });
  });
}
