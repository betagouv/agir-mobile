import 'package:app/features/environmental_performance/summary/domain/environmental_performance_detail_sub_item.dart';
import 'package:app/features/environmental_performance/summary/domain/footprint.dart';
import 'package:equatable/equatable.dart';

class EnvironmentalPerformanceDetailItem extends Equatable {
  const EnvironmentalPerformanceDetailItem({
    required this.emoji,
    required this.label,
    required this.footprintInKgOfCO2ePerYear,
    required this.subItems,
  });

  final String emoji;
  final String label;
  final Footprint footprintInKgOfCO2ePerYear;
  final List<EnvironmentalPerformanceDetailSubItem> subItems;

  @override
  List<Object?> get props =>
      [emoji, label, footprintInKgOfCO2ePerYear, subItems];
}
