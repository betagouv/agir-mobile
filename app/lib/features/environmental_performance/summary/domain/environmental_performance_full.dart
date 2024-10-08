import 'package:app/features/environmental_performance/summary/domain/environmental_performance_detail_item.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_top_item.dart';
import 'package:app/features/environmental_performance/summary/domain/footprint.dart';
import 'package:equatable/equatable.dart';

class EnvironmentalPerformanceFull extends Equatable {
  const EnvironmentalPerformanceFull({
    required this.footprintInKgOfCO2ePerYear,
    required this.top,
    required this.detail,
  });

  final Footprint footprintInKgOfCO2ePerYear;
  final List<EnvironmentalPerformanceTopItem> top;
  final List<EnvironmentalPerformanceDetailItem> detail;

  @override
  List<Object> get props => [top, footprintInKgOfCO2ePerYear, detail];
}
