import 'package:app/features/univers/core/domain/content_id.dart';
import 'package:equatable/equatable.dart';

abstract class MissionObjectif extends Equatable {
  const MissionObjectif({
    required this.id,
    required this.contentId,
    required this.titre,
    required this.estFait,
    required this.estVerrouille,
    required this.points,
    required this.aEteRecolte,
  });

  final ObjectifId id;
  final ContentId contentId;
  final String titre;
  final bool estFait;
  final bool estVerrouille;
  final int points;
  final bool aEteRecolte;

  @override
  List<Object> get props =>
      [id, contentId, titre, estFait, estVerrouille, points, aEteRecolte];
}
