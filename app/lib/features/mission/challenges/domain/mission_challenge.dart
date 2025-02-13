import 'package:app/features/mission/mission/domain/content_id.dart';
import 'package:equatable/equatable.dart';

final class MissionChallenge extends Equatable {
  const MissionChallenge({
    required this.contentId,
    required this.title,
    required this.status,
    required this.points,
    required this.isRecommended,
    required this.isDone,
    required this.isCollected,
  });

  final ContentId contentId;
  final String title;
  final MissionChallengeStatus status;
  final int points;
  final bool isRecommended;
  final bool isDone;
  final bool isCollected;

  @override
  List<Object> get props => [
    contentId,
    title,
    status,
    points,
    isRecommended,
    isDone,
    isCollected,
  ];
}

enum MissionChallengeStatus {
  toDo,
  inProgress,
  refused,
  alreadyDone,
  abandonned,
  done,
}
