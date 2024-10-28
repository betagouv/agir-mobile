import 'package:app/features/theme/core/domain/mission_objectif.dart';

enum MissionDefiStatus {
  toDo,
  inProgress,
  refused,
  alreadyDone,
  abandonned,
  done,
}

final class MissionDefi extends MissionObjectif {
  const MissionDefi({
    required super.id,
    required super.titre,
    required super.contentId,
    required super.estFait,
    required super.estVerrouille,
    required super.points,
    required super.aEteRecolte,
    required this.status,
    required this.isRecommended,
  });

  final MissionDefiStatus status;
  final bool isRecommended;

  @override
  List<Object> get props => [...super.props, status, isRecommended];
}
