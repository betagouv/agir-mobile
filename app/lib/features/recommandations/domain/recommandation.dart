import 'package:app/features/profil/mieux_vous_connaitre/domain/question.dart';
import 'package:equatable/equatable.dart';

class Recommandation extends Equatable {
  const Recommandation({
    required this.titre,
    required this.imageUrl,
    required this.points,
    required this.thematique,
  });

  final String titre;
  final String imageUrl;
  final int points;
  final Thematique thematique;

  @override
  List<Object> get props => [titre, imageUrl, points, thematique];
}
