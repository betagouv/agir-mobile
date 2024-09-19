import 'dart:convert';

import 'package:app/features/aides/infrastructure/adapters/aide_velo_api_adapter.dart';
import 'package:app/features/aides/infrastructure/adapters/aide_velo_par_type_mapper.dart';
import 'package:app/features/authentification/infrastructure/adapters/dio_http_client.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/dio_mock.dart';
import '../../helpers/faker.dart';
import '../../helpers/get_token_storage.dart';
import 'constants.dart';

void main() {
  late AideVeloApiAdapter adapter;
  late DioMock dio;

  setUp(() async {
    dio = DioMock();
    adapter = AideVeloApiAdapter(
      client: DioHttpClient(
        dio: dio,
        authentificationTokenStorage: await getTokenStorage(),
      ),
    );
  });

  test('simuler returns AideVeloParType when successful', () async {
    // Mock the API response

    final randomAideVeloParType = aideVeloParTypeFaker();
    dio
      ..patchM('/utilisateurs/$utilisateurId/profile')
      ..patchM('/utilisateurs/$utilisateurId/logement')
      ..postM(
        '/utilisateurs/$utilisateurId/simulerAideVelo',
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
      codePostal: codePostal,
      commune: commune,
      nombreDePartsFiscales: nombreDePartsFiscales,
      revenuFiscal: revenuFiscal,
    );

    // Verify API calls
    verify(
      () => dio.patch<void>(
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
      () => dio.patch<void>(
        any(),
        data: jsonEncode({'code_postal': codePostal, 'commune': commune}),
      ),
    );
    verify(
      () => dio.post<dynamic>(any(), data: jsonEncode({'prix_du_velo': prix})),
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
