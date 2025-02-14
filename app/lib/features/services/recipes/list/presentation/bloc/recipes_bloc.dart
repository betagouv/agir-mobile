import 'package:app/features/services/recipes/list/infrastructure/recipes_repository.dart';
import 'package:app/features/services/recipes/list/presentation/bloc/recipes_event.dart';
import 'package:app/features/services/recipes/list/presentation/bloc/recipes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  RecipesBloc({required final RecipesRepository repository}) : super(const RecipesInitial()) {
    on<RecipesLoadRequested>((final event, final emit) async {
      emit(const RecipesLoadInProgress());
      final result = await repository.fetch(category: event.category);
      result.fold(
        (final l) => emit(RecipesLoadFailure(errorMessage: l.toString())),
        (final r) => emit(RecipesLoadSuccess(recipes: r)),
      );
    });
  }
}
