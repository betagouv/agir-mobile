import 'package:app/features/gamification/domain/gamification_port.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/recommandations/domain/recommandations_port.dart';
import 'package:app/features/recommandations/presentation/bloc/recommandations_bloc.dart';
import 'package:app/features/theme/core/domain/theme_port.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/pages/theme_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../helpers/authentication_service_setup.dart';
import '../helpers/faker.dart';
import '../helpers/pump_page.dart';

class _ThemePortMock extends Mock implements ThemePort {}

class _GamificationPortMock extends Mock implements GamificationPort {}

class _RecommandationsPortMock extends Mock implements RecommandationsPort {}

Future<void> _pumpThemePage(
  final WidgetTester tester, {
  final ThemePort? themePort,
}) async {
  final themePortMock = themePort ?? _ThemePortMock();
  when(() => themePortMock.recupererMissions(any()))
      .thenAnswer((final _) async => const Right([]));

  final gamificationPort = _GamificationPortMock();
  when(gamificationPort.mettreAJourLesPoints).thenAnswer(
    (final _) async => const Right(null),
  );

  final recommandationsPort = _RecommandationsPortMock();
  when(() => recommandationsPort.recuperer(ThemeType.alimentation)).thenAnswer(
    (final _) async => const Right([
      Recommandation(
        id: '1',
        type: TypeDuContenu.article,
        titre: 'titre',
        sousTitre: null,
        imageUrl: 'https://example.com/image.jpg',
        points: 20,
        thematique: ThemeType.alimentation,
      ),
    ]),
  );

  await pumpPage(
    tester: tester,
    repositoryProviders: [
      RepositoryProvider<ThemePort>.value(value: themePortMock),
    ],
    blocProviders: [
      BlocProvider<GamificationBloc>(
        create: (final context) => GamificationBloc(
          gamificationPort: gamificationPort,
          authenticationService: authenticationService,
        ),
      ),
      BlocProvider<RecommandationsBloc>(
        create: (final context) => RecommandationsBloc(
          recommandationsPort: recommandationsPort,
        ),
      ),
    ],
    page: GoRoute(
      path: 'path',
      name: ' name',
      builder: (final context, final state) => const ThemePage(
        type: 'alimentation',
      ),
    ),
  );
}

void main() {
  group('Services devrait ', () {
    testWidgets(
      'afficher la liste des services de la thématique',
      (final tester) async {
        final services = List.generate(5, (final _) => serviceItemFaker());
        final themePort = _ThemePortMock();

        when(() => themePort.getServices(any())).thenAnswer(
          (final _) async => Right(services),
        );

        await mockNetworkImages(() async {
          await _pumpThemePage(tester, themePort: themePort);
          await tester.pumpAndSettle();
        });

        expect(find.text(Localisation.mesServices), findsOneWidget);
        for (final service in services) {
          expect(find.text(service.titre), findsOneWidget);
          expect(find.text(service.sousTitre), findsOneWidget);
        }
      },
    );
  });
}
