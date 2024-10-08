// ignore_for_file: avoid_dynamic_calls, avoid-accessing-collections-by-constant-index

import 'package:app/features/aides/core/infrastructure/aide_mapper.dart';
import 'package:app/features/aides/core/infrastructure/aides_api_adapter.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/dio_mock.dart';
import '../../helpers/faker.dart';
import '../mocks/authentication_service_fake.dart';

void main() {
  late AidesApiAdapter aidesApiAdapter;
  late DioMock dio;

  setUp(() {
    dio = DioMock();
    aidesApiAdapter = AidesApiAdapter(
      client: DioHttpClient(
        dio: dio,
        authenticationService: const AuthenticationServiceFake(),
      ),
    );
  });

  test('fetchAides returns a list of Aide when successful', () async {
    // Arrange
    final aides = List.generate(2, (final _) => aideFaker());
    dio.getM('/utilisateurs/{userId}/aides', responseData: aides);

    // Act
    final result = await aidesApiAdapter.fetchAides();

    // Assert
    expect(result.isRight(), isTrue);
    final actual = result.getRight().toNullable()!;
    expect(actual.length, equals(aides.length));
    for (var i = 0; i < actual.length; i++) {
      final expected = AideMapper.fromJson(aides[i]);
      expect(actual[i], equals(expected));
    }
  });
}
