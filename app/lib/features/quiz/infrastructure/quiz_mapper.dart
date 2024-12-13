// ignore_for_file: avoid_dynamic_calls

import 'package:app/features/quiz/domain/quiz.dart';

abstract final class QuizMapper {
  const QuizMapper._();

  static Quiz fromJson({required final Map<String, dynamic> json}) {
    final question = json['questions'][0] as Map<String, dynamic>;
    final responses = question['reponses'] as List<dynamic>;

    return Quiz(
      id: json['content_id'] as String,
      thematique: json['thematique_principale'] as String,
      question: question['libelle'] as String,
      reponses: responses
          .cast<Map<String, dynamic>>()
          .map(
            (final e) => QuizReponse(
              reponse: e['reponse'] as String,
              exact: e['exact'] as bool? ?? false,
            ),
          )
          .toList(),
      points: json['points'] as int,
      explicationOk: question['explicationOk'] as String?,
      explicationKo: question['explicationKO'] as String?,
      article: json['article_contenu'] as String?,
    );
  }
}
