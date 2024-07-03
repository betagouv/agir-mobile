// ignore_for_file: no-equal-switch-expression-cases

import 'package:app/features/profil/mieux_vous_connaitre/domain/question.dart';

abstract final class QuestionMapper {
  const QuestionMapper._();

  static Question fromJson(final Map<String, dynamic> json) => Question(
        id: json['id'] as String,
        question: json['question'] as String,
        reponse: (json['reponse'] as List<dynamic>)
            .map((final e) => e as String)
            .toList(),
        categorie: json['categorie'] as String,
        points: (json['points'] as num).toInt(),
        type: _mapTypeDeQuestionFromJson(json['type'] as String),
        reponsesPossibles: (json['reponses_possibles'] as List<dynamic>)
            .map((final e) => e as String)
            .toList(),
        deNosGestesClimat: json['is_NGC'] as bool,
        thematique: _mapThematiqueFromJson(json['thematique'] as String),
      );

  static QuestionType _mapTypeDeQuestionFromJson(final String? type) =>
      switch (type) {
        'choix_multiple' => QuestionType.choixMultiple,
        'choix_unique' => QuestionType.choixUnique,
        'libre' => QuestionType.libre,
        _ => QuestionType.libre,
      };

  static Thematique _mapThematiqueFromJson(final String? type) =>
      switch (type) {
        'alimentation' => Thematique.alimentation,
        'transport' => Thematique.transport,
        'logement' => Thematique.logement,
        'consommation' => Thematique.consommation,
        'climat' => Thematique.climat,
        'dechet' => Thematique.dechet,
        'loisir' => Thematique.loisir,
        _ => Thematique.loisir,
      };
}
