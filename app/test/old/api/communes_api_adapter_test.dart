import 'package:app/features/authentification/core/infrastructure/authentification_api_client.dart';
import 'package:app/features/communes/infrastructure/communes_api_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../helpers/authentication_service_setup.dart';
import 'client_mock.dart';
import 'constants.dart';
import 'custom_response.dart';

void main() {
  group('CommunesApiAdapter', () {
    test('recupererLesCommunes', () async {
      final client = ClientMock()
        ..getSuccess(
          path: '/communes?code_postal=39100',
          response: CustomResponse(
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
        client: AuthentificationApiClient(
          apiUrl: apiUrl,
          authenticationService: authenticationService,
          inner: client,
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
