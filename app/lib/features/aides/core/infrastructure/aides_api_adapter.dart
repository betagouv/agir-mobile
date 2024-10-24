import 'dart:async';

import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/aides/core/domain/aide.dart';
import 'package:app/features/aides/core/domain/aides_port.dart';
import 'package:app/features/aides/core/infrastructure/aide_mapper.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:fpdart/fpdart.dart';

class AidesApiAdapter implements AidesPort {
  const AidesApiAdapter({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  @override
  Future<Either<Exception, Aids>> fetchAides() async {
    final response = await _client.get('/utilisateurs/{userId}/aides_v2');

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des aides'));
    }

    final json = response.data! as Map<String, dynamic>;

    return Right(
      Aids(
        isCovered: json['couverture_aides_ok'] as bool,
        aids: (json['liste_aides'] as List<dynamic>)
            .map((final e) => AideMapper.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
  }
}
