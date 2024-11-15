import 'package:app/features/mission/mission/domain/content_id.dart';
import 'package:equatable/equatable.dart';

abstract class MissionObjectif extends Equatable {
  const MissionObjectif({
    required this.contentId,
    required this.titre,
    required this.estFait,
  });

  final ContentId contentId;
  final String titre;
  final bool estFait;

  @override
  List<Object> get props => [contentId, titre, estFait];
}
