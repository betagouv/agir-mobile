part of 'seasonal_fruits_and_vegetables_bloc.dart';

@immutable
sealed class SeasonalFruitsAndVegetablesState extends Equatable {
  const SeasonalFruitsAndVegetablesState();

  @override
  List<Object> get props => [];
}

@immutable
final class SeasonalFruitsAndVegetablesInitial
    extends SeasonalFruitsAndVegetablesState {
  const SeasonalFruitsAndVegetablesInitial();
}

@immutable
final class SeasonalFruitsAndVegetablesLoadSuccess
    extends SeasonalFruitsAndVegetablesState {
  SeasonalFruitsAndVegetablesLoadSuccess({
    required this.months,
    required this.monthSelected,
    required final List<Plant> plants,
  })  : fruitsLessThan1Kg = _filterAndSortPlants(plants, PlantType.fruit, 0, 1),
        fruitsLessThan5Kg = _filterAndSortPlants(plants, PlantType.fruit, 1, 5),
        fruitsMoreThan5Kg =
            _filterAndSortPlants(plants, PlantType.fruit, 5, double.infinity),
        vegetablesLessThan1Kg =
            _filterAndSortPlants(plants, PlantType.vegetable, 0, 1),
        vegetablesLessThan5Kg =
            _filterAndSortPlants(plants, PlantType.vegetable, 1, 5),
        vegetablesMoreThan5Kg = _filterAndSortPlants(
          plants,
          PlantType.vegetable,
          5,
          double.infinity,
        );

  final List<PlantMonth> months;
  final String monthSelected;
  final List<Plant> fruitsLessThan1Kg;
  final List<Plant> fruitsLessThan5Kg;
  final List<Plant> fruitsMoreThan5Kg;
  final List<Plant> vegetablesLessThan1Kg;
  final List<Plant> vegetablesLessThan5Kg;
  final List<Plant> vegetablesMoreThan5Kg;

  @override
  List<Object> get props => [
        months,
        monthSelected,
        fruitsLessThan1Kg,
        fruitsLessThan5Kg,
        fruitsMoreThan5Kg,
        vegetablesLessThan1Kg,
        vegetablesLessThan5Kg,
        vegetablesMoreThan5Kg,
      ];

  static List<Plant> _filterAndSortPlants(
    final List<Plant> plants,
    final PlantType type,
    final double minKg,
    final double maxKg,
  ) =>
      plants
          .where(
            (final plant) =>
                (plant.type == type || plant.type == PlantType.both) &&
                plant.carbonFootprintInKg >= minKg &&
                plant.carbonFootprintInKg < maxKg,
          )
          .toList()
        ..sort(
          (final a, final b) =>
              a.carbonFootprintInKg.compareTo(b.carbonFootprintInKg),
        );
}

@immutable
final class SeasonalFruitsAndVegetablesLoadFailure
    extends SeasonalFruitsAndVegetablesState {
  const SeasonalFruitsAndVegetablesLoadFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
