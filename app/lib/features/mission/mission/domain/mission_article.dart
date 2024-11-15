import 'package:app/features/mission/mission/domain/mission_objectif.dart';

final class MissionArticle extends MissionObjectif {
  const MissionArticle({
    required super.contentId,
    required super.titre,
    required super.estFait,
  });
}
