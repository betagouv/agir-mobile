import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class CarSimulatorEvent extends Equatable {
  const CarSimulatorEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class CarSimulatorGetCurrentCarResult extends CarSimulatorEvent {
  const CarSimulatorGetCurrentCarResult();
}
