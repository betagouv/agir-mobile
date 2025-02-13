import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/services/seasonal_fruits_and_vegetables/domain/plant.dart';
import 'package:app/features/services/seasonal_fruits_and_vegetables/domain/plant_month.dart';
import 'package:app/features/services/seasonal_fruits_and_vegetables/infrastructure/plant_mapper.dart';
import 'package:app/features/services/seasonal_fruits_and_vegetables/infrastructure/plant_month_mapper.dart';
import 'package:fpdart/fpdart.dart';

class SeasonalFruitsAndVegetablesRepository {
  const SeasonalFruitsAndVegetablesRepository({
    required final DioHttpClient client,
  }) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, List<PlantMonth>>> fetchCategories() async {
    final response = await _client.get(
      Endpoints.seasonalFruitsAndVegetablesCategories,
    );

    return isResponseUnsuccessful(response.statusCode)
        ? Left(
            Exception(
              'Erreur lors de la récupération les mois des fruits et légumes',
            ),
          )
        : Right(
            (response.data as List<dynamic>)
                .cast<Map<String, dynamic>>()
                .map(PlantMonthMapper.fromJson)
                .toList(),
          );
  }

  Future<Either<Exception, List<Plant>>> fetchPlants(
    final String category,
  ) async {
    final response = await _client.post(
      Endpoints.seasonalFruitsAndVegetablesSearch,
      data: {'categorie': category},
    );

    return isResponseUnsuccessful(response.statusCode)
        ? Left(
            Exception(
              'Erreur lors de la récupération les mois des fruits et légumes',
            ),
          )
        : Right(
            ((response.data as Map<String, dynamic>)['resultats']
                    as List<dynamic>)
                .cast<Map<String, dynamic>>()
                .where((final e) => e['type_fruit_legume'] != null)
                .map(PlantMapper.fromJson)
                .toList(),
          );
  }
}
