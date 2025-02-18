import 'package:app/features/services/recipes/action/domain/action_recipe_summary.dart';

abstract final class ActionRecipeSummaryMapper {
  const ActionRecipeSummaryMapper._();

  static ActionRecipeSummary fromJson(final Map<String, dynamic> json) => ActionRecipeSummary(
    id: json['id'] as String,
    imageUrl: json['image_url'] as String,
    title: json['titre'] as String,
    difficulty: json['difficulty_plat'] as String,
    preparationTime: json['temps_prepa_min'] as int,
  );
}
