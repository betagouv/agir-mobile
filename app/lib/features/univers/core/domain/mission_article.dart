import 'package:app/features/univers/core/domain/mission_objectif.dart';

final class MissionArticle extends MissionObjectif {
  const MissionArticle({
    required super.id,
    required super.titre,
    required super.contentId,
    required super.estFait,
    required super.estVerrouille,
    required super.points,
    required super.aEteRecolte,
  });
}
