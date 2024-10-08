import 'package:app/features/environmental_performance/summary/domain/environmental_performance_summary.dart';
import 'package:equatable/equatable.dart';

sealed class EnvironmentalPerformanceState extends Equatable {
  const EnvironmentalPerformanceState();

  @override
  List<Object> get props => [];
}

final class EnvironmentalPerformanceInitial
    extends EnvironmentalPerformanceState {
  const EnvironmentalPerformanceInitial();
}

final class EnvironmentalPerformanceLoading
    extends EnvironmentalPerformanceState {
  const EnvironmentalPerformanceLoading();
}

final class EnvironmentalPerformanceSuccess
    extends EnvironmentalPerformanceState {
  const EnvironmentalPerformanceSuccess({required this.data});

  final EnvironmentalPerformanceSummary data;

  @override
  List<Object> get props => [data];
}

final class EnvironmentalPerformanceFailure
    extends EnvironmentalPerformanceState {
  const EnvironmentalPerformanceFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
