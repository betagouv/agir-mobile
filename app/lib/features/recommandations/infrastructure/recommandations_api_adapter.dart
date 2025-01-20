import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/recommandations/domain/recommandations_port.dart';
import 'package:app/features/recommandations/infrastructure/recommandation_mapper.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:fpdart/fpdart.dart';

class RecommandationsApiAdapter implements RecommandationsPort {
  const RecommandationsApiAdapter({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  @override
  Future<Either<Exception, List<Recommandation>>> recuperer(
    final ThemeType thematique,
  ) async {
    final recommandationsParThematique =
        Endpoints.recommandationsParThematique(thematique.name);

    final response = await _client.get(recommandationsParThematique);

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
