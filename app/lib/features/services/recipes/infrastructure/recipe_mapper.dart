import 'package:app/features/services/recipes/domain/recipe.dart';

abstract final class RecipeMapper {
  const RecipeMapper._();

  static Recipe fromJson(final Map<String, dynamic> json) => Recipe(
    imageUrl: json['image_url'] as String,
    title: json['titre'] as String,
    difficulty: json['difficulty_plat'] as String,
    preparationTime: json['temps_prepa_min'] as int,
  );
}
