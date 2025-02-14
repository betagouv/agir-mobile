import 'package:app/features/services/recipes/item/infrastructure/recipe_repository.dart';
import 'package:app/features/services/recipes/item/presentation/bloc/recipe_event.dart';
import 'package:app/features/services/recipes/item/presentation/bloc/recipe_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc({required final RecipeRepository repository}) : super(const RecipeInitial()) {
    on<RecipeLoadRequested>((final event, final emit) async {
      emit(const RecipeLoadInProgress());
      final result = await repository.fetch(id: event.id);
      result.fold(
        (final l) => emit(RecipeLoadFailure(errorMessage: l.toString())),
        (final r) => emit(RecipeLoadSuccess(recipe: r)),
      );
    });
  }
}
