import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/articles/infrastructure/articles_api_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/authentication_service_setup.dart';
import '../../helpers/dio_mock.dart';

void main() {
  test('addToFavorites', () async {
    final dio = DioMock()..postM(Endpoints.events);

    final adapter = ArticlesApiAdapter(
      client: DioHttpClient(
        dio: dio,
        authenticationService: authenticationService,
      ),
    );

    await adapter.addToFavorites('1');

    verify(
      () => dio.post<dynamic>(
        Endpoints.events,
        data: '{"content_id":"1","type":"article_favoris"}',
      ),
    );
  });
}
