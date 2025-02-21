import 'package:app/features/car_simulator/domain/car_simulator.dart';

abstract final class CurrentCarMapper {
  static CurrentCar fromJson(final Map<String, dynamic> json) => CurrentCar(
    cost: json['couts'] as double,
    emissions: json['empreinte'] as double,
    size: ComputedValueMapper.fromJson(json['gabarit'] as Map<String, dynamic>, CarSizeMapper.fromJson),
    motorisation: ComputedValueMapper.fromJson(json['motorisation'] as Map<String, dynamic>, CarMotorisationMapper.fromJson),
    fuel:
        json['carburant'] == null
            ? null
            : ComputedValueMapper.fromJson(json['carburant'] as Map<String, dynamic>, CarFuelMapper.fromJson),
  );
}

abstract final class ComputedValueMapper {
  static ComputedValue<V> fromJson<V>(final Map<String, dynamic> json, final V Function(String) valueToJson) =>
      ComputedValue(value: valueToJson(json['valeur'] as String), label: json['label'] as String);
}

abstract final class CarSizeMapper {
  static CarSize fromJson(final String json) {
    switch (json) {
      case 'petite':
        return CarSize.small;
      case 'moyenne':
        return CarSize.medium;
      case 'berline':
        return CarSize.sedan;
      case 'SUV':
        return CarSize.suv;
      case 'VUL':
        return CarSize.utilityVehicle;
      default:
        throw Exception('Unknown CarSize: $json');
    }
  }
}

abstract final class CarMotorisationMapper {
  static CarMotorisation fromJson(final String json) {
    switch (json) {
      case 'thermique':
        return CarMotorisation.thermal;
      case 'hybride':
        return CarMotorisation.hybrid;
      case 'électrique':
        return CarMotorisation.electric;
      default:
        throw Exception('Unknown CarMotorisation: $json');
    }
  }
}

abstract final class CarFuelMapper {
  static CarFuel fromJson(final String json) {
    switch (json) {
      case 'essence E5 ou E10':
        return CarFuel.gasoline;
      case 'essence E85':
        return CarFuel.gasolineE85;
      case 'gazole B7 ou B10':
        return CarFuel.diesel;
      case 'GPL':
        return CarFuel.lpg;
      default:
        throw Exception('Unknown CarFuel: $json');
    }
  }
}
