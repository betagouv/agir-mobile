import 'package:app/features/actions/domain/actions_port.dart';
import 'package:app/features/actions/infrastructure/action_item_mapper.dart';
import 'package:app/features/actions/infrastructure/actions_adapter.dart';
import 'package:app/features/actions/presentation/pages/action_detail_page.dart';
import 'package:app/features/actions/presentation/pages/action_list_page.dart';
import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/infrastructure/adapters/dio_http_client.dart';
import 'package:app/features/gamification/domain/ports/gamification_port.dart';
import 'package:app/features/gamification/presentation/blocs/gamification_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/dio_mock.dart';
import '../helpers/faker.dart';
import '../helpers/get_token_storage.dart';
import '../helpers/pump_page.dart';
import '../old/api/constants.dart';

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
          authentificationStatutManagerReader: AuthentificationStatutManager(),
        ),
      ),
    ],
    page: const ActionListPage(),
    routes: [ActionDetailPage.name],
  );
}

void main() {
  late ActionsPort actionsPort;
  late List<Map<String, dynamic>> actions;

  setUp(() async {
    final dio = DioMock();
    actionsPort = ActionsAdapter(
      client: DioHttpClient(
        dio: dio,
        authentificationTokenStorage: await getTokenStorage(),
      ),
    );
    actions = List.generate(2, (final _) => actionItemFaker());
    dio.getM('/utilisateurs/$utilisateurId/defis', responseData: actions);
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

        final expected = ActionItemMapper.fromJson(actions.first);

        await tester.tap(find.text(expected.titre));

        await tester.pumpAndSettle();

        expect(find.text('route: ${ActionDetailPage.name}'), findsOneWidget);
      },
    );
  });
}
