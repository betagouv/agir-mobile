import 'package:app/features/services/recipes/domain/recipe.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class RecipesState extends Equatable {
  const RecipesState();

  @override
  List<Object> get props => [];
}

@immutable
final class RecipesInitial extends RecipesState {
  const RecipesInitial();
}

@immutable
final class RecipesLoadInProgress extends RecipesState {
  const RecipesLoadInProgress();
}

@immutable
final class RecipesLoadSuccess extends RecipesState {
  const RecipesLoadSuccess({required this.recipes});

  final List<Recipe> recipes;

  @override
  List<Object> get props => [recipes];
}

@immutable
final class RecipesLoadFailure extends RecipesState {
  const RecipesLoadFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
