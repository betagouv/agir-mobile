import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/recommandations/domain/recommandations_port.dart';
import 'package:app/features/recommandations/infrastructure/recommandation_mapper.dart';
import 'package:fpdart/fpdart.dart';

class RecommandationsApiAdapter implements RecommandationsPort {
  const RecommandationsApiAdapter({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  @override
  Future<Either<Exception, List<Recommandation>>> recuperer(
    final String thematique,
  ) async {
    final map = {'univers': thematique};

    final uri = Uri.parse('/utilisateurs/{userId}/recommandations_v2').replace(
      queryParameters: map.isNotEmpty ? map : null,
    );

    final response = await _client.get(uri.toString());

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(
        Exception('Erreur lors de la récupération des recommandations'),
      );
    }

    final json = response.data as List<dynamic>;

    return Right(
      json
          .map(
            (final e) =>
                RecommandationMapper.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
