import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/core/domain/service_item.dart';
import 'package:app/features/theme/core/domain/theme_port.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/core/infrastructure/mission_liste_mapper.dart';
import 'package:app/features/theme/core/infrastructure/service_item_mapper.dart';
import 'package:fpdart/fpdart.dart';

class ThemeApiAdapter implements ThemePort {
  const ThemeApiAdapter({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  @override
  Future<Either<Exception, List<MissionListe>>> getMissions(
    final ThemeType themeType,
  ) async {
    final response = await _client.get(
      Endpoints.missionsRecommandeesParThematique(themeType.name),
    );

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération des missions'));
    }
    final json = response.data as List<dynamic>;

    return Right(
      json
          .map(
            (final e) => MissionListeMapper.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  @override
  Future<Either<Exception, List<ServiceItem>>> getServices(
    final ThemeType themeType,
  ) async {
    final response = await _client.get(
      Endpoints.servicesParThematique(themeType.name),
    );

    return isResponseSuccessful(response.statusCode)
        ? Right(
            (response.data as List<dynamic>)
                .map((final e) => e as Map<String, dynamic>)
                .map(ServiceItemMapper.fromJson)
                .toList(),
          )
        : Left(Exception('Erreur lors de la récupération des services'));
  }
}
