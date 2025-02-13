import 'package:app/features/mission/challenges/domain/mission_challenge.dart';
import 'package:app/features/mission/challenges/domain/mission_challenges.dart';
import 'package:app/features/mission/mission/domain/content_id.dart';

abstract final class MissionChallengesMapper {
  const MissionChallengesMapper._();

  static MissionChallenges fromJson(final Map<String, dynamic> json) {
    final challenges = <MissionChallenge>[];

    final objectifsList = json['objectifs'] as List<dynamic>;
    for (final item in objectifsList) {
      final o = item as Map<String, dynamic>;
      final type = o['type'] as String?;
      switch (type) {
        case 'defi':
          challenges.add(_fromJsonMissionChallenge(o));
      }
    }

    return MissionChallenges(
      values: challenges,
      canBeCompleted: json['terminable'] as bool,
      isCompleted: json['done_at'] != null,
    );
  }

  static MissionChallenge _fromJsonMissionChallenge(
    final Map<String, dynamic> json,
  ) => MissionChallenge(
    contentId: ContentId(json['content_id'] as String),
    title: json['titre'] as String,
    status: _statusFromJson(json['defi_status'] as String),
    points: json['points'] as int,
    isRecommended: json['is_reco'] as bool,
    isDone: json['done'] as bool,
    isCollected: json['sont_points_en_poche'] as bool,
  );

  static MissionChallengeStatus _statusFromJson(final String? type) =>
      switch (type) {
        'todo' => MissionChallengeStatus.toDo,
        'en_cours' => MissionChallengeStatus.inProgress,
        'pas_envie' => MissionChallengeStatus.refused,
        'deja_fait' => MissionChallengeStatus.alreadyDone,
        'abondon' => MissionChallengeStatus.abandonned,
        'fait' => MissionChallengeStatus.done,
        // ignore: no-equal-switch-expression-cases
        _ => MissionChallengeStatus.toDo,
      };
}
