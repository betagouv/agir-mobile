import 'package:app/features/services/recipes/action/domain/action_recipe_summary.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ActionRecipesState extends Equatable {
  const ActionRecipesState();

  @override
  List<Object> get props => [];
}

@immutable
final class ActionRecipesInitial extends ActionRecipesState {
  const ActionRecipesInitial();
}

@immutable
final class ActionRecipesLoadInProgress extends ActionRecipesState {
  const ActionRecipesLoadInProgress();
}

@immutable
final class ActionRecipesLoadSuccess extends ActionRecipesState {
  const ActionRecipesLoadSuccess({required this.recipes});

  final List<ActionRecipeSummary> recipes;

  @override
  List<Object> get props => [recipes];
}

@immutable
final class ActionRecipesLoadFailure extends ActionRecipesState {
  const ActionRecipesLoadFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
