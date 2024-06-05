import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut_manager.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_token_storage.dart';
import 'package:app/src/fonctionnalites/communes/infrastructure/adapters/communes_api_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

import 'client_mock.dart';
import 'constants.dart';
import 'custom_response.dart';
import 'flutter_secure_storage_mock.dart';

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
          authentificationTokenStorage: AuthentificationTokenStorage(
            secureStorage: FlutterSecureStorageMock(),
            authentificationStatusManager: AuthentificationStatutManager(),
          ),
          inner: client,
        ),
      );

      // Act.
      final communes = await adapter.recupererLesCommunes('39100');

      // Assert.
      expect(communes, [
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
