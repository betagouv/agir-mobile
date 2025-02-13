import 'package:app/features/services/seasonal_fruits_and_vegetables/domain/plant.dart';
import 'package:app/features/services/seasonal_fruits_and_vegetables/domain/plant_month.dart';
import 'package:app/features/services/seasonal_fruits_and_vegetables/infrastructure/seasonal_fruits_and_vegetables_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

part 'seasonal_fruits_and_vegetables_event.dart';
part 'seasonal_fruits_and_vegetables_state.dart';

class SeasonalFruitsAndVegetablesBloc extends Bloc<SeasonalFruitsAndVegetablesEvent, SeasonalFruitsAndVegetablesState> {
  SeasonalFruitsAndVegetablesBloc({required final SeasonalFruitsAndVegetablesRepository repository})
    : super(const SeasonalFruitsAndVegetablesInitial()) {
    on<SeasonalFruitsAndVegetablesFetch>((final event, final emit) async {
      final categoriesResult = await repository.fetchCategories();
      if (categoriesResult.isRight()) {
        final categories = categoriesResult.getRight().getOrElse(() => throw Exception());
        final monthSelected = categories.where((final e) => e.value).first.code;
        final plantsResult = await repository.fetchPlants(monthSelected);
        if (plantsResult.isRight()) {
          final plants = plantsResult.getRight().getOrElse(() => throw Exception());
          emit(SeasonalFruitsAndVegetablesLoadSuccess(months: categories, monthSelected: monthSelected, plants: plants));
        } else {
          emit(SeasonalFruitsAndVegetablesLoadFailure(plantsResult.getLeft().toString()));
        }
      } else {
        emit(SeasonalFruitsAndVegetablesLoadFailure(categoriesResult.getLeft().toString()));
      }
    });

    on<SeasonalFruitsAndVegetablesMonthSelected>((final event, final emit) async {
      final monthSelected = event.value;
      final result = await repository.fetchPlants(monthSelected);

      result.fold(
        (final l) => emit(SeasonalFruitsAndVegetablesLoadFailure(l.toString())),
        (final r) => emit(
          SeasonalFruitsAndVegetablesLoadSuccess(
            months: switch (state) {
              final SeasonalFruitsAndVegetablesLoadSuccess s => s.months,
              _ => const [],
            },
            monthSelected: monthSelected,
            plants: r,
          ),
        ),
      );
    });
  }
}
