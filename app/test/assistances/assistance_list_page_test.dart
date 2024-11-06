import 'package:app/features/assistances/core/infrastructure/assistance_mapper.dart';
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
    ],
    page: AssistanceListPage.route,
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
  });
}
