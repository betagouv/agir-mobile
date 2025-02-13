import 'package:app/features/action/domain/action_service.dart';

abstract final class ActionServiceMapper {
  const ActionServiceMapper._();

  static ActionService fromJson(final Map<String, dynamic> json) =>
      ActionService(id: _mapServiceId(json['recherche_service_id'] as String), category: json['categorie'] as String);

  static ServiceId _mapServiceId(final String type) => switch (type) {
    'longue_vie_objets' => ServiceId.lvao,
    'recettes' => ServiceId.recipes,
    _ => throw Exception('Unknown service id: $type'),
  };
}
