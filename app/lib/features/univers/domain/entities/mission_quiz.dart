import 'package:app/features/univers/domain/entities/mission_objectif.dart';

final class MissionQuiz extends MissionObjectif {
  const MissionQuiz({
    required super.id,
    required super.titre,
    required super.contentId,
    required super.estFait,
    required super.estVerrouille,
    required super.points,
    required super.aEteRecolte,
  });
}
