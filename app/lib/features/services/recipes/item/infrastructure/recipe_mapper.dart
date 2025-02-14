import 'package:app/features/services/recipes/item/domain/recipe.dart';

abstract final class RecipeMapper {
  const RecipeMapper._();

  static Recipe fromJson(final Map<String, dynamic> json) => Recipe(
    id: json['id'] as String,
    imageUrl: json['image_url'] as String,
    title: json['titre'] as String,
    difficulty: json['difficulty_plat'] as String,
    preparationTime: json['temps_prepa_min'] as int,
    ingredients:
        (json['ingredients'] as List<dynamic>).map((final e) => e as Map<String, dynamic>).map(ingredientFromJson).toList(),
    steps: (json['etapes_recette'] as List<dynamic>).map((final e) => e as Map<String, dynamic>).map(stepFromJson).toList(),
  );

  static Ingredient ingredientFromJson(final Map<String, dynamic> json) => Ingredient(
    order: json['ordre'] as int,
    name: json['nom'] as String,
    quantity: json['quantite'] as int,
    unit: json['unite'] as String,
  );

  static RecipeStep stepFromJson(final Map<String, dynamic> json) =>
      RecipeStep(order: json['ordre'] as int, description: json['texte'] as String);
}
