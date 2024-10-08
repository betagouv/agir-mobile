import 'package:app/features/environmental_performance/summary/domain/environmental_performance_category.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_level.dart';
import 'package:equatable/equatable.dart';

class EnvironmentalPerformancePartial extends Equatable {
  const EnvironmentalPerformancePartial({
    required this.performanceOnTransport,
    required this.performanceOnFood,
    required this.performanceOnHousing,
    required this.performanceOnConsumption,
    required this.percentageCompletion,
    required this.categories,
  });

  final EnvironmentalPerformanceLevel? performanceOnTransport;
  final EnvironmentalPerformanceLevel? performanceOnFood;
  final EnvironmentalPerformanceLevel? performanceOnHousing;
  final EnvironmentalPerformanceLevel? performanceOnConsumption;
  final int percentageCompletion;
  final List<EnvironmentalPerformanceCategory> categories;

  @override
  List<Object?> get props => [
        performanceOnTransport,
        performanceOnFood,
        performanceOnHousing,
        performanceOnConsumption,
        percentageCompletion,
        categories,
      ];
}
