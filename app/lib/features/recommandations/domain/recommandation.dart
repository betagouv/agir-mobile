import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:equatable/equatable.dart';

class Recommandation extends Equatable {
  const Recommandation({
    required this.id,
    required this.type,
    required this.titre,
    required this.imageUrl,
    required this.points,
    required this.thematique,
  });

  final String id;
  final TypeDuContenu type;
  final String titre;
  final String imageUrl;
  final int points;
  final Thematique thematique;

  @override
  List<Object> get props => [id, type, titre, imageUrl, points, thematique];
}

enum TypeDuContenu {
  article,
  kyc,
  quiz,
}
