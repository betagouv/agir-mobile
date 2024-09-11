import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/features/authentification/infrastructure/adapters/authentification_token_storage.dart';
import 'package:app/features/first_name/domain/value_objects/first_name.dart';
import 'package:app/features/first_name/infrastructure/first_name_adapter.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../old/api/client_mock.dart';
import '../old/api/constants.dart';
import '../old/api/custom_response.dart';
import '../old/api/flutter_secure_storage_mock.dart';
import '../old/api/request_mathcher.dart';

void main() {
  test('updateFirstName', () async {
    final client = ClientMock()
      ..patchSuccess(
        path: '/utilisateurs/$utilisateurId/profile',
        response: OkResponse(),
      );

    final authentificationTokenStorage = AuthentificationTokenStorage(
      secureStorage: FlutterSecureStorageMock(),
      authentificationStatusManagerWriter: AuthentificationStatutManager(),
    );
    await authentificationTokenStorage.sauvegarderToken(token);
    final apiClient = AuthentificationApiClient(
      apiUrl: apiUrl,
      authentificationTokenStorage: authentificationTokenStorage,
      inner: client,
    );

    final adapter = FirstNameAdapter(apiClient: apiClient);

    final prenom = Faker().person.firstName();

    await adapter.addFirstName(FirstName.create(prenom));

    verify(
      () => client.send(
        any(
          that: RequestMathcher(
            '/utilisateurs/$utilisateurId/profile',
            body: '{"prenom":"$prenom"}',
          ),
        ),
      ),
    );
  });
}
