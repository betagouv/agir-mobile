import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/services/recipes/item/domain/recipe.dart';
import 'package:app/features/services/recipes/item/infrastructure/recipe_mapper.dart';
import 'package:fpdart/fpdart.dart';

class RecipeRepository {
  const RecipeRepository({required final DioHttpClient client}) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, Recipe>> fetch({required final String id}) async {
    final response = await _client.get(Endpoints.recipe(id));

    return isResponseUnsuccessful(response.statusCode)
        ? Left(Exception('Erreur lors de la récupération de la recette'))
        : Right(RecipeMapper.fromJson(response.data as Map<String, dynamic>));
  }
}
