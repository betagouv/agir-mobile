import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/first_name/domain/first_name.dart';
import 'package:app/features/first_name/infrastructure/first_name_adapter.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/authentication_service_setup.dart';
import '../helpers/dio_mock.dart';

void main() {
  test('updateFirstName', () async {
    final dio = DioMock()..patchM(Endpoints.profile);

    final apiClient = DioHttpClient(
      dio: dio,
      authenticationService: authenticationService,
    );

    final adapter = FirstNameAdapter(client: apiClient);

    final prenom = Faker().person.firstName();

    await adapter.addFirstName(FirstName.create(prenom));

    verify(
      () => dio.patch<dynamic>(
        Endpoints.profile,
        data: '{"prenom":"$prenom"}',
      ),
    );
  });
}
