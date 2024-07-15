// ignore_for_file: avoid_dynamic_calls

import 'package:app/features/articles/infrastructure/adapters/article_mapper.dart';
import 'package:app/features/quiz/domain/quiz.dart';

abstract final class QuizMapper {
  const QuizMapper._();

  static Quiz fromJson(final Map<String, dynamic> json) {
    final data = json['data'];
    final quiz = data['attributes'] as Map<String, dynamic>;
    final thematique = quiz['thematique_gamification']['data']['attributes']
        as Map<String, dynamic>;
    final question = quiz['questions'][0] as Map<String, dynamic>;
    final responses = question['reponses'] as List<dynamic>;

    return Quiz(
      id: (data['id'] as num).toInt(),
      thematique: thematique['titre'] as String,
      question: question['libelle'] as String,
      reponses: responses
          .cast<Map<String, dynamic>>()
          .map(
            (final e) => QuizReponse(
              reponse: e['reponse'] as String,
              exact: e['exact'] as bool,
            ),
          )
          .toList(),
      points: quiz['points'] as int,
      explicationOk: question['explicationOk'] as String?,
      explicationKo: question['explicationKO'] as String?,
      article: quiz['articles']['data'][0] == null
          ? null
          : ArticleMapper.fromJson({'data': quiz['articles']['data'][0]}),
    );
  }
}
