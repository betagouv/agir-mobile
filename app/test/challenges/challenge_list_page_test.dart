import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/features/challenges/detail/presentation/pages/challenge_detail_page.dart';
import 'package:app/features/challenges/list/infrastructure/challenge_item_mapper.dart';
import 'package:app/features/challenges/list/infrastructure/challenge_list_repository.dart';
import 'package:app/features/challenges/list/presentation/pages/challenge_list_page.dart';
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
      RepositoryProvider<ChallengeListRepository>(
        create: (final context) => ChallengeListRepository(client: client),
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
    page: ChallengeListPage.route,
    routes: {ChallengeDetailPage.name: ChallengeDetailPage.path},
  );
}

void main() {
  late List<Map<String, dynamic>> challenges;
  late DioMock dio;

  setUp(() {
    dio = DioMock();
    challenges = List.generate(4, (final _) => challengeItemFaker())
        .where((final e) => e['status'] != 'todo')
        .toList();
    dio.getM(
      '/utilisateurs/%7BuserId%7D/defis_v2?status=en_cours&status=pas_envie&status=abondon&status=fait',
      responseData: challenges,
    );
  });

  group('La liste des défis devrait ', () {
    testWidgets(
      "afficher les défis lorsqu'il y en a",
      (final tester) async {
        await _pumpPage(tester, dio: dio);

        await tester.pumpAndSettle();

        for (final action in challenges) {
          final expected = ChallengeItemMapper.fromJson(action);
          expect(find.text(expected.titre), findsOneWidget);
        }
      },
    );

    testWidgets(
      'appuyer sur une défi devrait ouvrir la page de détails',
      (final tester) async {
        await _pumpPage(tester, dio: dio);

        await tester.pumpAndSettle();

        final expected = ChallengeItemMapper.fromJson(
          challenges.firstWhere((final e) => e['status'] != 'todo'),
        );

        await tester.tap(find.text(expected.titre));

        await tester.pumpAndSettle();

        expect(find.text('route: ${ChallengeDetailPage.name}'), findsOneWidget);
      },
    );
  });
}
