import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/challenges/list/domain/challenge_item.dart';
import 'package:app/features/challenges/list/infrastructure/challenge_item_mapper.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:fpdart/fpdart.dart';

class ChallengesRepository {
  const ChallengesRepository({required final DioHttpClient client})
    : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, List<ChallengeItem>>> fetch({
    required final ThemeType? themeType,
  }) async {
    final queryParameters = {'status': 'en_cours'};
    if (themeType != null) {
      queryParameters.putIfAbsent('thematique', () => themeType.name);
    }
    final response = await _client.get(
      Uri(
        path: Endpoints.challenges,
        queryParameters: queryParameters,
      ).toString(),
    );

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des défis'));
    }

    final json = response.data! as List<dynamic>;

    return Right(
      json
          .take(5)
          .map(
            (final e) =>
                ChallengeItemMapper.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
