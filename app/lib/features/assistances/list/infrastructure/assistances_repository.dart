import 'dart:async';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/assistances/core/domain/aide.dart';
import 'package:app/features/assistances/core/infrastructure/assistance_mapper.dart';
import 'package:fpdart/fpdart.dart';

class AssistancesRepository {
  const AssistancesRepository({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, AssistanceList>> fetch() async {
    final response = await _client.get(Endpoints.assistances);

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des aides'));
    }

    final json = response.data! as Map<String, dynamic>;

    return Right(
      AssistanceList(
        isCovered: json['couverture_aides_ok'] as bool,
        assistances: (json['liste_aides'] as List<dynamic>)
            .map(
              (final e) => AssistanceMapper.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
    );
  }
}
