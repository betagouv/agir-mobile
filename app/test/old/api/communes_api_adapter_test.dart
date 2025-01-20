import 'dart:convert';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/communes/infrastructure/communes_api_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../helpers/authentication_service_setup.dart';
import '../../helpers/dio_mock.dart';

void main() {
  group('CommunesApiAdapter', () {
    test('recupererLesCommunes', () async {
      final dio = DioMock()
        ..getM(
          Uri(
            path: Endpoints.communes,
            queryParameters: {'code_postal': '39100'},
          ).toString(),
          responseData: jsonDecode(
            '''
[
  "AUTHUME",
  "BAVERANS",
  "BREVANS",
  "CHAMPVANS",
  "CHOISEY",
  "CRISSEY",
  "DOLE",
  "FOUCHERANS",
  "GEVRY",
  "JOUHE",
  "MONNIERES",
  "PARCEY",
  "SAMPANS",
  "VILLETTE LES DOLE"
]''',
          ),
        );

      final adapter = CommunesApiAdapter(
        client: DioHttpClient(
          dio: dio,
          authenticationService: authenticationService,
        ),
      );

      // Act.
      final communes = await adapter.recupererLesCommunes('39100');

      // Assert.
      expect(communes.getRight().getOrElse(() => throw Exception()), [
        'AUTHUME',
        'BAVERANS',
        'BREVANS',
        'CHAMPVANS',
        'CHOISEY',
        'CRISSEY',
        'DOLE',
        'FOUCHERANS',
        'GEVRY',
        'JOUHE',
        'MONNIERES',
        'PARCEY',
        'SAMPANS',
        'VILLETTE LES DOLE',
      ]);
    });
  });
}
