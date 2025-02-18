import 'package:app/features/services/recipes/list/infrastructure/recipes_repository.dart';
import 'package:app/features/services/recipes/list/presentation/bloc/recipes_event.dart';
import 'package:app/features/services/recipes/list/presentation/bloc/recipes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  RecipesBloc({required final RecipesRepository repository}) : super(const RecipesInitial()) {
    on<RecipesLoadRequested>((final event, final emit) async {
      emit(const RecipesLoadInProgress());
      final categoriesResult = await repository.fetchCategories();
      if (categoriesResult.isRight()) {
        final categories = categoriesResult.getRight().getOrElse(() => throw Exception());
        final filterSelected = categories.firstWhere((final e) => e.value).code;
        final result = await repository.fetchRecipe(category: filterSelected);
        result.fold(
          (final l) => emit(RecipesLoadFailure(errorMessage: l.toString())),
          (final r) => emit(RecipesLoadSuccess(filters: categories, filterSelected: filterSelected, recipes: r)),
        );
      } else {
        emit(RecipesLoadFailure(errorMessage: categoriesResult.getLeft().toString()));
      }
    });
    on<RecipesFilterSelected>((final event, final emit) async {
      final filterSelected = event.value;
      final result = await repository.fetchRecipe(category: filterSelected);

      result.fold(
        (final l) => emit(RecipesLoadFailure(errorMessage: l.toString())),
        (final r) => emit(
          RecipesLoadSuccess(
            filters: switch (state) {
              final RecipesLoadSuccess s => s.filters,
              _ => const [],
            },
            filterSelected: filterSelected,
            recipes: r,
          ),
        ),
      );
    });
  }
}
