import 'package:equatable/equatable.dart';

class CurrentCar extends Equatable {
  const CurrentCar({
    required this.cost,
    required this.emissions,
    required this.size,
    required this.motorisation,
    required this.fuel,
  });

  final double cost;
  final double emissions;
  final ComputedValue<CarSize> size;
  final ComputedValue<CarMotorisation> motorisation;
  final ComputedValue<CarFuel>? fuel;

  @override
  List<Object?> get props => [cost, emissions, size, motorisation, fuel];
}

enum CarSize {
  /// Petite voiture
  small,

  /// Moyenne voiture
  medium,

  /// Berline
  sedan,

  /// Sport Utility Vehicle (SUV)
  suv,

  /// Véhicule Utilitaire Léger (VUL)
  utilityVehicle,
}

enum CarMotorisation { thermal, hybrid, electric }

enum CarFuel {
  /// Essence (E5 ou E10)
  gasoline,

  /// Essence E85
  gasolineE85,

  /// Diesel
  diesel,

  /// Gaz de Pétrole Liquéfié (GPL)
  lpg,
}

/// A computed value is a raw [value] used to compute purpose and a [label] to display.
///
/// ```dart
/// ComputedValue<CarSize>(value: CarSize.small, label: 'Petite voiture');
/// ```
///
/// NOTE(erolley): is the [value] really useful?
class ComputedValue<V> extends Equatable {
  const ComputedValue({required this.value, required this.label});

  final V value;
  final String label;

  @override
  List<Object?> get props => [value, label];
}
