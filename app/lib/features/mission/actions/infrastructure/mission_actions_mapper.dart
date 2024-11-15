import 'package:app/features/mission/actions/domain/mission_action.dart';
import 'package:app/features/mission/actions/domain/mission_actions.dart';
import 'package:app/features/mission/mission/domain/content_id.dart';

abstract final class MissionActionsMapper {
  const MissionActionsMapper._();

  static MissionActions fromJson(final Map<String, dynamic> json) {
    final actions = <MissionAction>[];

    final objectifsList = json['objectifs'] as List<dynamic>;
    for (final item in objectifsList) {
      final o = item as Map<String, dynamic>;
      final type = o['type'] as String?;
      if (type == null) {
        continue;
      }
      switch (type) {
        case 'defi':
          actions.add(_fromJsonMissionAction(o));
      }
    }

    return MissionActions(
      values: actions,
      canBeCompleted: json['terminable'] as bool,
      isCompleted: json['done_at'] != null,
    );
  }

  static MissionAction _fromJsonMissionAction(
    final Map<String, dynamic> json,
  ) =>
      MissionAction(
        contentId: ContentId(json['content_id'] as String),
        title: json['titre'] as String,
        status: _mapStatusFromJson(json['defi_status'] as String),
        points: json['points'] as int,
        isRecommended: json['is_reco'] as bool,
        isDone: json['done'] as bool,
        isCollected: json['sont_points_en_poche'] as bool,
      );

  static MissionActionStatus _mapStatusFromJson(final String? type) =>
      switch (type) {
        'todo' => MissionActionStatus.toDo,
        'en_cours' => MissionActionStatus.inProgress,
        'pas_envie' => MissionActionStatus.refused,
        'deja_fait' => MissionActionStatus.alreadyDone,
        'abondon' => MissionActionStatus.abandonned,
        'fait' => MissionActionStatus.done,
        // ignore: no-equal-switch-expression-cases
        _ => MissionActionStatus.toDo,
      };
}
