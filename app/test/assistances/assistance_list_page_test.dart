import 'package:app/core/infrastructure/tracker.dart';
import 'package:app/features/assistances/core/infrastructure/assistance_mapper.dart';
import 'package:app/features/assistances/item/presentation/bloc/aide_bloc.dart';
import 'package:app/features/assistances/item/presentation/pages/assistance_detail_page.dart';
import 'package:app/features/assistances/list/infrastructure/assistances_repository.dart';
import 'package:app/features/assistances/list/infrastructure/assistances_urls.dart';
import 'package:app/features/assistances/list/presentation/pages/assistance_list_page.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/gamification/domain/gamification_port.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/authentication_service_setup.dart';
import '../helpers/dio_mock.dart';
import '../helpers/faker.dart';
import '../helpers/pump_page.dart';

class _GamificationPortMock extends Mock implements GamificationPort {}

class _TrackerMock extends Mock implements Tracker {}

Future<void> _pumpPage(
  final WidgetTester tester, {
  required final List<Map<String, dynamic>> assistances,
}) async {
  final gamificationPort = _GamificationPortMock();
  when(gamificationPort.mettreAJourLesPoints).thenAnswer(
    (final _) async => const Right(null),
  );
  final dio = DioMock()
    ..getM(
      assistancesUrl,
      responseData: {'couverture_aides_ok': true, 'liste_aides': assistances},
    );

  await pumpPage(
    tester: tester,
    repositoryProviders: [
      RepositoryProvider<Tracker>(create: (final context) => _TrackerMock()),
      RepositoryProvider<AssistancesRepository>(
        create: (final context) => AssistancesRepository(
          client: DioHttpClient(
            dio: dio,
            authenticationService: authenticationService,
          ),
        ),
      ),
    ],
    blocProviders: [
      BlocProvider<GamificationBloc>(
        create: (final context) => GamificationBloc(
          gamificationPort: gamificationPort,
          authenticationService: authenticationService,
        ),
      ),
      BlocProvider<AideBloc>(create: (final context) => AideBloc()),
    ],
    page: AssistanceListPage.route,
    routes: {AssistanceDetailPage.name: AssistanceDetailPage.path},
  );
}

void main() {
  group('La liste des aides devrait ', () {
    testWidgets(
      "afficher les aides lorsqu'il y en a",
      (final tester) async {
        final assistances = List.generate(2, (final _) => aideFaker());
        await _pumpPage(tester, assistances: assistances);

        await tester.pumpAndSettle();

        for (final item in assistances.map(AssistanceMapper.fromJson)) {
          expect(find.text(item.titre), findsOneWidget);
        }
      },
    );

    testWidgets(
      "aller sur l'aide lorsque l'on appuie dessus",
      (final tester) async {
        final assistances = [
          aideFaker(thematique: ThemeType.alimentation.name),
          aideFaker(thematique: ThemeType.consommation.name),
        ];

        await _pumpPage(tester, assistances: assistances);

        await tester.pumpAndSettle();

        final visible = AssistanceMapper.fromJson(assistances.first);

        await tester.tap(find.text(visible.titre));

        await tester.pumpAndSettle();

        expect(
          find.text('route: ${AssistanceDetailPage.name}'),
          findsOneWidget,
        );
      },
    );

    testWidgets('afficher les aides filtrés', (final tester) async {
      final assistances = [
        aideFaker(thematique: ThemeType.alimentation.name),
        aideFaker(thematique: ThemeType.consommation.name),
      ];

      await _pumpPage(tester, assistances: assistances);

      await tester.pumpAndSettle();

      await tester.tap(
        find.text(ThemeType.alimentation.displayNameWithoutEmoji),
      );

      await tester.pumpAndSettle();

      final visible = AssistanceMapper.fromJson(assistances.first);
      expect(find.text(visible.titre), findsOneWidget);

      final notVisible = AssistanceMapper.fromJson(assistances.last);
      expect(find.text(notVisible.titre), findsNothing);
    });

    testWidgets(
      'afficher les aides filtrés via le texte',
      (final tester) async {
        final assistances = [
          aideFaker(thematique: ThemeType.alimentation.name),
          aideFaker(thematique: ThemeType.consommation.name),
        ];

        await _pumpPage(tester, assistances: assistances);

        await tester.pumpAndSettle();

        await tester.tap(find.text('Voir les 9 aides').first);

        await tester.pumpAndSettle();

        final visible = AssistanceMapper.fromJson(assistances.first);
        expect(find.text(visible.titre), findsOneWidget);

        final notVisible = AssistanceMapper.fromJson(assistances.last);
        expect(find.text(notVisible.titre), findsNothing);
      },
      skip:
          true, // TODO(lsaudon): Activer le scroll horizontal quand ce sera possible.
    );
  });
}
