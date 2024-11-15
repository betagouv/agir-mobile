import 'package:app/features/actions/core/domain/action_id.dart';
import 'package:app/features/actions/core/domain/action_status.dart';
import 'package:app/features/actions/detail/domain/action.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';

abstract final class ActionMapper {
  const ActionMapper._();

  static Action fromJson(final Map<String, dynamic> json) => Action(
        id: ActionId(json['id'] as String),
        themeType: _mapThemeType(json['thematique'] as String),
        title: json['titre'] as String,
        status: _actionStatusfromJson(json['status'] as String),
        reason: json['motif'] as String?,
        tips: json['astuces'] as String,
        why: json['pourquoi'] as String,
      );

  static ActionStatus _actionStatusfromJson(final String json) =>
      switch (json) {
        'todo' => ActionStatus.toDo,
        'en_cours' => ActionStatus.inProgress,
        'pas_envie' => ActionStatus.refused,
        'deja_fait' => ActionStatus.alreadyDone,
        'abondon' => ActionStatus.abandonned,
        'fait' => ActionStatus.done,
        // ignore: no-equal-switch-expression-cases
        _ => ActionStatus.toDo,
      };

  static ThemeType _mapThemeType(final String? type) => switch (type) {
        'alimentation' => ThemeType.alimentation,
        'transport' => ThemeType.transport,
        'consommation' => ThemeType.consommation,
        'logement' => ThemeType.logement,
        _ => ThemeType.decouverte,
      };
}
