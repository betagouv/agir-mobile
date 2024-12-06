import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class EnvironmentalPerformanceEvent extends Equatable {
  const EnvironmentalPerformanceEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class EnvironmentalPerformanceStarted
    extends EnvironmentalPerformanceEvent {
  const EnvironmentalPerformanceStarted();

  @override
  List<Object> get props => [];
}
