import 'package:app/features/environmental_performance/summary/domain/environmental_performance_empty.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_full.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_partial.dart';
import 'package:equatable/equatable.dart';

const percentageMiniBilanFinished = 23;
const percentageBilanFinished = 100;

class EnvironmentalPerformanceSummary extends Equatable {
  const EnvironmentalPerformanceSummary({
    required this.empty,
    required this.partial,
    required this.full,
  });

  final EnvironmentalPerformanceEmpty empty;
  final EnvironmentalPerformancePartial partial;
  final EnvironmentalPerformanceFull full;

  EnvironmentalPerformanceSummaryType get type {
    if (partial.percentageCompletion < percentageMiniBilanFinished) {
      return EnvironmentalPerformanceSummaryType.empty;
    } else if (partial.percentageCompletion < percentageBilanFinished) {
      return EnvironmentalPerformanceSummaryType.partial;
    }

    return EnvironmentalPerformanceSummaryType.full;
  }

  EnvironmentalPerformanceSummary copyWith({
    final EnvironmentalPerformanceEmpty? empty,
    final EnvironmentalPerformancePartial? partial,
    final EnvironmentalPerformanceFull? full,
  }) =>
      EnvironmentalPerformanceSummary(
        empty: empty ?? this.empty,
        partial: partial ?? this.partial,
        full: full ?? this.full,
      );

  @override
  List<Object?> get props => [empty, partial, full];
}

enum EnvironmentalPerformanceSummaryType {
  empty,
  partial,
  full,
}
