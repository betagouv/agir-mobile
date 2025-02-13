import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/services/recipes/domain/recipe.dart';
import 'package:app/features/services/recipes/infrastructure/recipe_mapper.dart';
import 'package:fpdart/fpdart.dart';

class RecipesRepository {
  const RecipesRepository({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, List<Recipe>>> fetch({
    required final String category,
  }) async {
    final response = await _client.post(
      Endpoints.recipesSearch,
      data: {
        'categorie': category,
        'nombre_max_resultats': 4,
        'rayon_metres': 5000,
      },
    );

    return isResponseUnsuccessful(response.statusCode)
        ? Left(Exception('Erreur lors de la récupération des recettes'))
        : Right(
            ((response.data as Map<String, dynamic>)['resultats']
                    as List<dynamic>)
                .cast<Map<String, dynamic>>()
                .map(RecipeMapper.fromJson)
                .toList(),
          );
  }
}
