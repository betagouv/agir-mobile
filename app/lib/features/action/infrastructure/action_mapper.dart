import 'package:app/features/action/domain/action.dart';

abstract final class ActionMapper {
  const ActionMapper._();

  static Action fromJson(final Map<String, dynamic> json) => Action(
        id: json['code'] as String,
        title: json['titre'] as String,
        subTitle: json['sous_titre'] as String,
        how: json['comment'] as String,
        why: json['pourquoi'] as String,
      );
}
