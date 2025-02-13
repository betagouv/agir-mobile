import 'package:app/core/domain/value_object.dart';

class Footprint extends ValueObject<double> {
  Footprint(super.value)
    : tonnesRepresentation = (value / 1000)
          .toStringAsFixed(1)
          .replaceAll('.', ','),
      kilogramsRepresentation = value.toStringAsFixed(0).replaceAll('.', ','),
      percentageOfMaxFootprint = value / _maxCarbonFootprint;

  final String tonnesRepresentation;
  final String kilogramsRepresentation;
  final double percentageOfMaxFootprint;

  /// La valeur maximum pour le bilan carbone.
  static const _maxCarbonFootprint = 12000;
}
