import 'package:app/features/univers/domain/value_objects/service_item.dart';

abstract final class ServiceItemMapper {
  const ServiceItemMapper._();

  static ServiceItem fromJson(final Map<String, dynamic> json) => ServiceItem(
        titre: json['titre'] as String,
        sousTitre: json['sous_titre'] as String,
        externalUrl: json['external_url'] as String,
      );
}
