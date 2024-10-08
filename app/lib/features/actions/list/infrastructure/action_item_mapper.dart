import 'package:app/features/actions/core/domain/action_id.dart';
import 'package:app/features/actions/core/domain/action_status.dart';
import 'package:app/features/actions/list/domain/action_item.dart';

abstract final class ActionItemMapper {
  const ActionItemMapper._();

  static ActionItem fromJson(final Map<String, dynamic> json) => ActionItem(
        id: ActionId(json['id'] as String),
        titre: json['titre'] as String,
        status: _actionStatusfromJson(json['status'] as String),
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
}
