import 'package:app/features/environmental_performance/summary/domain/footprint.dart';
import 'package:equatable/equatable.dart';

class EnvironmentalPerformanceDetailSubItem extends Equatable {
  const EnvironmentalPerformanceDetailSubItem({
    required this.emoji,
    required this.label,
    required this.footprintInKgOfCO2ePerYear,
    required this.percentage,
  });

  final String emoji;
  final String label;
  final Footprint footprintInKgOfCO2ePerYear;
  final int? percentage;

  @override
  List<Object?> get props => [
    emoji,
    label,
    footprintInKgOfCO2ePerYear,
    percentage,
  ];
}
