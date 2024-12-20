import 'package:app/features/actions/detail/presentation/pages/action_detail_page.dart';
import 'package:app/features/actions/list/domain/actions_port.dart';
import 'package:app/features/actions/list/infrastructure/action_item_mapper.dart';
import 'package:app/features/actions/list/infrastructure/actions_adapter.dart';
import 'package:app/features/actions/list/presentation/pages/action_list_page.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/gamification/domain/gamification_port.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
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
  required final ActionsPort actionsPort,
}) async {
  final gamificationPort = _GamificationPortMock();
  when(gamificationPort.mettreAJourLesPoints).thenAnswer(
    (final _) async => const Right(null),
  );

  await pumpPage(
    tester: tester,
    repositoryProviders: [
      RepositoryProvider<ActionsPort>.value(value: actionsPort),
    ],
    blocProviders: [
      BlocProvider<GamificationBloc>(
        create: (final context) => GamificationBloc(
          gamificationPort: gamificationPort,
          authenticationService: authenticationService,
        ),
      ),
    ],
    page: ActionListPage.route,
    routes: {ActionDetailPage.name: ActionDetailPage.path},
  );
}

void main() {
  late ActionsPort actionsPort;
  late List<Map<String, dynamic>> actions;

  setUp(() {
    final dio = DioMock();
    actionsPort = ActionsAdapter(
      client: DioHttpClient(
        dio: dio,
        authenticationService: authenticationService,
      ),
    );
    actions = List.generate(4, (final _) => actionItemFaker())
        .where((final e) => e['status'] != 'todo')
        .toList();
    dio.getM(
      '/utilisateurs/%7BuserId%7D/defis_v2?status=en_cours&status=pas_envie&status=abondon&status=fait',
      responseData: actions,
    );
  });

  group('La liste des actions devrait ', () {
    testWidgets(
      "afficher les actions lorsqu'il y en a",
      (final tester) async {
        await _pumpPage(tester, actionsPort: actionsPort);

        await tester.pumpAndSettle();

        for (final action in actions) {
          final expected = ActionItemMapper.fromJson(action);
          expect(find.text(expected.titre), findsOneWidget);
        }
      },
    );

    testWidgets(
      'appuyer sur une action devrait ouvrir la page de détails',
      (final tester) async {
        await _pumpPage(tester, actionsPort: actionsPort);

        await tester.pumpAndSettle();

        final expected = ActionItemMapper.fromJson(
          actions.firstWhere((final e) => e['status'] != 'todo'),
        );

        await tester.tap(find.text(expected.titre));

        await tester.pumpAndSettle();

        expect(find.text('route: ${ActionDetailPage.name}'), findsOneWidget);
      },
    );
  });
}
