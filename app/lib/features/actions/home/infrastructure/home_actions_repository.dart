import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/actions/list/domain/action_item.dart';
import 'package:app/features/actions/list/infrastructure/action_item_mapper.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:fpdart/fpdart.dart';

class HomeActionsRepository {
  const HomeActionsRepository({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, List<ActionItem>>> fetch({
    required final ThemeType? themeType,
  }) async {
    final queryParameters = {'status': 'en_cours'};
    if (themeType != null) {
      queryParameters.putIfAbsent('thematique', () => themeType.name);
    }
    final response = await _client.get(
      Uri(path: Endpoints.actions, queryParameters: queryParameters).toString(),
    );

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des actions'));
    }

    final json = response.data! as List<dynamic>;

    return Right(
      json
          .take(5)
          .map(
            (final e) => ActionItemMapper.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
