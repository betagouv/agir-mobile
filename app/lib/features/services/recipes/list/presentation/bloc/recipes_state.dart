import 'package:app/features/services/recipes/list/domain/recipe_summary.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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

  final List<RecipeSummary> recipes;

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
