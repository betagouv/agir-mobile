import 'dart:convert';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/simulateur_velo/domain/velo_pour_simulateur.dart';
import 'package:app/features/simulateur_velo/infrastructure/aide_velo_par_type_mapper.dart';
import 'package:app/features/simulateur_velo/infrastructure/aide_velo_repository.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/dio_mock.dart';
import '../../helpers/faker.dart';
import '../mocks/authentication_service_fake.dart';

void main() {
  late AideVeloRepository adapter;
  late DioMock dio;

  setUp(() {
    dio = DioMock();
    adapter = AideVeloRepository(
      client: DioHttpClient(
        dio: dio,
        authenticationService: const AuthenticationServiceFake(),
      ),
    );
  });

  test('simuler returns AideVeloParType when successful', () async {
    final randomAideVeloParType = aideVeloParTypeFaker();
    dio
      ..patchM(Endpoints.profile)
      ..patchM(Endpoints.logement)
      ..postM(
        Endpoints.simulerAideVelo,
        responseData: randomAideVeloParType,
      );

    final faker = Faker();
    final prix = faker.randomGenerator.integer(5000);
    final nombreDePartsFiscales = faker.randomGenerator.decimal();
    final revenuFiscal = faker.randomGenerator.integer(100000);
    final codePostal = faker.address.zipCode();
    final commune = faker.address.city();

    final result = await adapter.simuler(
      prix: prix,
      etatVelo: VeloEtat.neuf,
      codePostal: codePostal,
      commune: commune,
      nombreDePartsFiscales: nombreDePartsFiscales,
      revenuFiscal: revenuFiscal,
    );

    // Verify API calls
    verify(
      () => dio.patch<dynamic>(
        any(),
        data: jsonEncode(
          {
            'nombre_de_parts_fiscales': nombreDePartsFiscales,
            'revenu_fiscal': revenuFiscal,
          },
        ),
      ),
    );
    verify(
      () => dio.patch<dynamic>(
        any(),
        data: jsonEncode({'code_postal': codePostal, 'commune': commune}),
      ),
    );
    verify(
      () => dio.post<dynamic>(
        any(),
        data: jsonEncode({'prix_du_velo': prix, 'etat_du_velo': 'neuf'}),
      ),
    );

    // Assert the result
    expect(result.isRight(), isTrue);
    final aideVeloParType = result.getRight().toNullable()!;
    expect(
      aideVeloParType,
      equals(AideVeloParTypeMapper.fromJson(randomAideVeloParType)),
    );
  });
}
