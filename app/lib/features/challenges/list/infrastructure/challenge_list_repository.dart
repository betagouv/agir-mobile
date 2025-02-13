import 'dart:async';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/challenges/list/domain/challenge_item.dart';
import 'package:app/features/challenges/list/infrastructure/challenge_item_mapper.dart';
import 'package:fpdart/fpdart.dart';

class ChallengeListRepository {
  const ChallengeListRepository({required final DioHttpClient client}) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, List<ChallengeItem>>> fetchChallenges() async {
    final string =
        Uri(
          path: Endpoints.challenges,
          queryParameters: {
            'status': ['en_cours', 'pas_envie', 'abondon', 'fait'],
          },
        ).toString();

    final response = await _client.get(string);

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des défis'));
    }

    final json = response.data! as List<dynamic>;

    return Right(json.map((final e) => ChallengeItemMapper.fromJson(e as Map<String, dynamic>)).toList());
  }
}
