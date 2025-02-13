import 'package:app/features/services/seasonal_fruits_and_vegetables/domain/plant.dart';

abstract final class PlantMapper {
  static Plant fromJson(final Map<String, dynamic> json) => Plant(
    type: plantTypeFromJson(json['type_fruit_legume'] as String),
    title: json['titre'] as String,
    carbonFootprintInKg: json['impact_carbone_kg'] as double,
    imageUrl: json['image_url'] as String,
  );

  static PlantType plantTypeFromJson(final String json) => switch (json) {
    'fruit' => PlantType.fruit,
    'legume' => PlantType.vegetable,
    'fruit_et_legume' => PlantType.both,
    _ => throw UnimplementedError('Unknown plant type: $json'),
  };
}
