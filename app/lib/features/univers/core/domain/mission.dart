import 'package:app/features/univers/core/domain/mission_article.dart';
import 'package:app/features/univers/core/domain/mission_defi.dart';
import 'package:app/features/univers/core/domain/mission_kyc.dart';
import 'package:app/features/univers/core/domain/mission_quiz.dart';
import 'package:equatable/equatable.dart';

class Mission extends Equatable {
  const Mission({
    required this.titre,
    required this.imageUrl,
    required this.kycListe,
    required this.quizListe,
    required this.articles,
    required this.defis,
    required this.peutEtreTermine,
    required this.estTermine,
  });

  final String titre;
  final String imageUrl;
  final List<MissionKyc> kycListe;
  final List<MissionQuiz> quizListe;
  final List<MissionArticle> articles;
  final List<MissionDefi> defis;
  final bool peutEtreTermine;
  final bool estTermine;

  @override
  List<Object> get props => [
        titre,
        imageUrl,
        kycListe,
        quizListe,
        articles,
        defis,
        peutEtreTermine,
        estTermine,
      ];
}
