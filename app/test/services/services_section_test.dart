import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentication/infrastructure/authentication_repository.dart';
import 'package:app/features/gamification/domain/gamification_port.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/recommandations/domain/recommandations_port.dart';
import 'package:app/features/recommandations/presentation/bloc/recommandations_bloc.dart';
import 'package:app/features/univers/core/domain/service_item.dart';
import 'package:app/features/univers/core/domain/tuile_univers.dart';
import 'package:app/features/univers/core/domain/univers_port.dart';
import 'package:app/features/univers/presentation/pages/univers_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:clock/clock.dart';
import 'package:faker/faker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../helpers/pump_page.dart';
import '../old/api/flutter_secure_storage_fake.dart';

class _UniversPortMock extends Mock implements UniversPort {}

class _GamificationPortMock extends Mock implements GamificationPort {}

class _RecommandationsPortMock extends Mock implements RecommandationsPort {}

Future<void> _pumpUniversPage(
  final WidgetTester tester, {
  final UniversPort? universPort,
}) async {
  final universPortMock = universPort ?? _UniversPortMock();
  when(() => universPortMock.recupererThematiques(any()))
      .thenAnswer((final _) async => const Right([]));

  final gamificationPort = _GamificationPortMock();
  when(gamificationPort.mettreAJourLesPoints).thenAnswer(
    (final _) async => const Right(null),
  );

  final recommandationsPort = _RecommandationsPortMock();
  when(() => recommandationsPort.recuperer('alimentation')).thenAnswer(
    (final _) async => const Right([
      Recommandation(
        id: '1',
        type: TypeDuContenu.article,
        titre: 'titre',
        sousTitre: null,
        imageUrl: 'https://example.com/image.jpg',
        points: 20,
        thematique: 'alimentation',
        thematiqueLabel: '🥦 Alimentation',
      ),
    ]),
  );

  await pumpPage(
    tester: tester,
    repositoryProviders: [
      RepositoryProvider<UniversPort>.value(value: universPortMock),
    ],
    blocProviders: [
      BlocProvider<GamificationBloc>(
        create: (final context) => GamificationBloc(
          gamificationPort: gamificationPort,
          authenticationService: AuthenticationService(
            authenticationRepository:
                AuthenticationRepository(FlutterSecureStorageFake()),
            clock: Clock.fixed(DateTime(1992)),
          ),
        ),
      ),
      BlocProvider<RecommandationsBloc>(
        create: (final context) => RecommandationsBloc(
          recommandationsPort: recommandationsPort,
        ),
      ),
    ],
    page: const UniversPage(
      univers: TuileUnivers(
        type: 'alimentation',
        titre: 'En cuisine',
        imageUrl: 'https://example.com/image.jpg',
        estTerminee: false,
      ),
    ),
  );
}

void main() {
  final faker = Faker();

  group('Services devrait ', () {
    testWidgets(
      "afficher la liste des services de l'univers",
      (final tester) async {
        final services = List.generate(5, (final _) => _serviceItem(faker));
        final universPort = _UniversPortMock();
        when(() => universPort.getServices(any())).thenAnswer(
          (final _) async => Right(services),
        );

        await mockNetworkImages(() async {
          await _pumpUniversPage(tester, universPort: universPort);
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

ServiceItem _serviceItem(final Faker faker) => ServiceItem(
      titre: faker.lorem.sentence(),
      sousTitre: faker.lorem.sentence(),
      externalUrl: faker.internet.httpsUrl(),
    );
