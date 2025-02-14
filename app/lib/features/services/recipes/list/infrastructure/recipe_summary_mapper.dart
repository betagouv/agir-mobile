import 'package:app/features/services/recipes/list/domain/recipe_summary.dart';

abstract final class RecipeSummaryMapper {
  const RecipeSummaryMapper._();

  static RecipeSummary fromJson(final Map<String, dynamic> json) => RecipeSummary(
    id: json['id'] as String,
    imageUrl: json['image_url'] as String,
    title: json['titre'] as String,
    difficulty: json['difficulty_plat'] as String,
    preparationTime: json['temps_prepa_min'] as int,
  );
}
