import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/features/actions/detail/presentation/pages/action_detail_page.dart';
import 'package:app/features/actions/list/infrastructure/action_item_mapper.dart';
import 'package:app/features/actions/list/infrastructure/action_list_repository.dart';
import 'package:app/features/actions/list/presentation/pages/action_list_page.dart';
import 'package:app/features/gamification/infrastructure/gamification_repository.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
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
      RepositoryProvider<ActionListRepository>(
        create: (final context) => ActionListRepository(client: client),
      ),
    ],
    blocProviders: [
      BlocProvider<GamificationBloc>(
        create: (final context) => GamificationBloc(
          repository: GamificationRepository(
            client: client,
            messageBus: MessageBus(),
          ),
          authenticationService: authenticationService,
        ),
      ),
    ],
    page: ActionListPage.route,
    routes: {ActionDetailPage.name: ActionDetailPage.path},
  );
}

void main() {
  late List<Map<String, dynamic>> actions;
  late DioMock dio;

  setUp(() {
    dio = DioMock();
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
        await _pumpPage(tester, dio: dio);

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
        await _pumpPage(tester, dio: dio);

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
