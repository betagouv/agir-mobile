import 'package:equatable/equatable.dart';

sealed class EnvironmentalPerformanceEvent extends Equatable {
  const EnvironmentalPerformanceEvent();

  @override
  List<Object> get props => [];
}

final class EnvironmentalPerformanceStarted
    extends EnvironmentalPerformanceEvent {
  const EnvironmentalPerformanceStarted();

  @override
  List<Object> get props => [];
}
