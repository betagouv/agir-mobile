import 'package:app/features/services/recipes/list/domain/recipe_filter.dart';

abstract final class RecipeFilterMapper {
  static RecipeFilter fromJson(final Map<String, dynamic> json) =>
      RecipeFilter(code: json['code'] as String, label: json['label'] as String, value: json['is_default'] as bool);
}
