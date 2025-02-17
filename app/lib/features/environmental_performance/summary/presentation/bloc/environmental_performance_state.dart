import 'package:app/features/environmental_performance/summary/domain/environmental_performance_data.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class EnvironmentalPerformanceState extends Equatable {
  const EnvironmentalPerformanceState();

  @override
  List<Object> get props => [];
}

@immutable
final class EnvironmentalPerformanceInitial extends EnvironmentalPerformanceState {
  const EnvironmentalPerformanceInitial();
}

@immutable
final class EnvironmentalPerformanceLoading extends EnvironmentalPerformanceState {
  const EnvironmentalPerformanceLoading();
}

@immutable
final class EnvironmentalPerformanceSuccess extends EnvironmentalPerformanceState {
  const EnvironmentalPerformanceSuccess({required this.data});

  final EnvironmentalPerformanceData data;

  @override
  List<Object> get props => [data];
}

@immutable
final class EnvironmentalPerformanceFailure extends EnvironmentalPerformanceState {
  const EnvironmentalPerformanceFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
