import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  const Recipe({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.difficulty,
    required this.preparationTime,
    required this.ingredients,
    required this.steps,
  });

  final String id;
  final String imageUrl;
  final String title;
  final String difficulty;
  final int preparationTime;
  final List<Ingredient> ingredients;
  final List<RecipeStep> steps;

  @override
  List<Object> get props => [id, imageUrl, title, difficulty, preparationTime, ingredients, steps];
}

class Ingredient extends Equatable {
  const Ingredient({required this.order, required this.name, required this.quantity, required this.unit});

  final int order;
  final String name;
  final int quantity;
  final String unit;

  @override
  List<Object> get props => [order, name, quantity, unit];
}

class RecipeStep extends Equatable {
  const RecipeStep({required this.order, required this.description});

  final int order;
  final String description;

  @override
  List<Object> get props => [order, description];
}
