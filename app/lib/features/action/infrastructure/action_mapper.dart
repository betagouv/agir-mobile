import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/infrastructure/action_service_mapper.dart';

abstract final class ActionMapper {
  const ActionMapper._();

  static Action fromJson(final Map<String, dynamic> json) => Action(
        id: json['code'] as String,
        title: json['titre'] as String,
        subTitle: json['sous_titre'] as String,
        how: json['comment'] as String,
        why: json['pourquoi'] as String,
        services: (json['services'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(ActionServiceMapper.fromJson)
            .toList(),
      );
}
