import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentication/infrastructure/authentication_repository.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_api_client.dart';
import 'package:app/features/communes/infrastructure/communes_api_adapter.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import 'client_mock.dart';
import 'constants.dart';
import 'custom_response.dart';
import 'flutter_secure_storage_fake.dart';

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
        apiClient: AuthentificationApiClient(
          apiUrl: apiUrl,
          authenticationService: AuthenticationService(
            authenticationRepository:
                AuthenticationRepository(FlutterSecureStorageFake()),
            clock: Clock.fixed(DateTime(1992)),
          ),
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
