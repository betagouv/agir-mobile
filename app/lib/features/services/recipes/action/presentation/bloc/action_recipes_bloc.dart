import 'package:app/features/services/recipes/action/infrastructure/action_recipes_repository.dart';
import 'package:app/features/services/recipes/action/presentation/bloc/action_recipes_event.dart';
import 'package:app/features/services/recipes/action/presentation/bloc/action_recipes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionRecipesBloc extends Bloc<ActionRecipesEvent, ActionRecipesState> {
  ActionRecipesBloc({required final ActionRecipesRepository repository}) : super(const ActionRecipesInitial()) {
    on<ActionRecipesLoadRequested>((final event, final emit) async {
      emit(const ActionRecipesLoadInProgress());
      final result = await repository.fetch(category: event.category);
      result.fold(
        (final l) => emit(ActionRecipesLoadFailure(errorMessage: l.toString())),
        (final r) => emit(ActionRecipesLoadSuccess(recipes: r)),
      );
    });
  }
}
