import 'package:app/features/services/seasonal_fruits_and_vegetables/domain/plant_month.dart';

abstract final class PlantMonthMapper {
  static PlantMonth fromJson(final Map<String, dynamic> json) => PlantMonth(
    code: json['code'] as String,
    label: json['label'] as String,
    value: json['is_default'] as bool,
  );
}
