import 'package:app/features/services/recipes/item/domain/recipe.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object> get props => [];
}

@immutable
final class RecipeInitial extends RecipeState {
  const RecipeInitial();
}

@immutable
final class RecipeLoadInProgress extends RecipeState {
  const RecipeLoadInProgress();
}

@immutable
final class RecipeLoadSuccess extends RecipeState {
  const RecipeLoadSuccess({required this.recipe});

  final Recipe recipe;

  @override
  List<Object> get props => [recipe];
}

@immutable
final class RecipeLoadFailure extends RecipeState {
  const RecipeLoadFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
