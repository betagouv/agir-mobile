import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';

abstract final class QuestionMapper {
  const QuestionMapper._();

  static Question? fromJson(final Map<String, dynamic> json) {
    final type = json['type'] as String;

    return switch (type) {
      'choix_multiple' => _createChoixMultipleQuestion(json),
      'choix_unique' => _createChoixUniqueQuestion(json),
      'libre' => _createLibreQuestion(json),
      'mosaic_boolean' => _createMosaicQuestion(json),
      'entier' => _createEntierQuestion(json),
      _ => null,
    };
  }

  static ChoixMultipleQuestion _createChoixMultipleQuestion(
    final Map<String, dynamic> json,
  ) =>
      ChoixMultipleQuestion(
        id: QuestionId(json['id'] as String),
        text: QuestionText(json['question'] as String),
        responses: _createResponses(json['reponse'] as List<dynamic>),
        points: Points((json['points'] as num).toInt()),
        responsesPossibles: _createResponsesPossibles(
          json['reponses_possibles'] as List<dynamic>,
        ),
        theme: _mapThematiqueFromJson(json['thematique'] as String),
      );

  static ChoixUniqueQuestion _createChoixUniqueQuestion(
    final Map<String, dynamic> json,
  ) =>
      ChoixUniqueQuestion(
        id: QuestionId(json['id'] as String),
        text: QuestionText(json['question'] as String),
        responses: _createResponses(json['reponse'] as List<dynamic>),
        points: Points((json['points'] as num).toInt()),
        responsesPossibles: _createResponsesPossibles(
          json['reponses_possibles'] as List<dynamic>,
        ),
        theme: _mapThematiqueFromJson(json['thematique'] as String),
      );

  static LibreQuestion _createLibreQuestion(final Map<String, dynamic> json) =>
      LibreQuestion(
        id: QuestionId(json['id'] as String),
        text: QuestionText(json['question'] as String),
        responses: _createResponses(json['reponse'] as List<dynamic>),
        points: Points((json['points'] as num).toInt()),
        theme: _mapThematiqueFromJson(json['thematique'] as String),
      );

  static EntierQuestion _createEntierQuestion(
    final Map<String, dynamic> json,
  ) =>
      EntierQuestion(
        id: QuestionId(json['id'] as String),
        text: QuestionText(json['question'] as String),
        responses: _createResponses(json['reponse'] as List<dynamic>),
        points: Points((json['points'] as num).toInt()),
        theme: _mapThematiqueFromJson(json['thematique'] as String),
      );

  static MosaicQuestion _createMosaicQuestion(
    final Map<String, dynamic> json,
  ) =>
      MosaicQuestion(
        id: QuestionId(json['id'] as String),
        text: QuestionText(json['titre'] as String),
        responses: _createMosaicResponses(json['reponses'] as List<dynamic>),
        points: Points((json['points'] as num).toInt()),
        answered: json['is_answered'] as bool,
      );

  static Responses _createResponses(final List<dynamic> jsonResponses) =>
      Responses(jsonResponses.map((final e) => e as String).toList());

  static ResponsesPossibles _createResponsesPossibles(
    final List<dynamic> jsonResponsesPossibles,
  ) =>
      ResponsesPossibles(
        jsonResponsesPossibles.map((final e) => e as String).toList(),
      );

  static List<MosaicResponse> _createMosaicResponses(
    final List<dynamic> jsonMosaicResponses,
  ) =>
      jsonMosaicResponses
          .map((final e) => e as Map<String, dynamic>)
          .map(
            (final e) => MosaicResponse(
              id: MosaicResponseCode(e['code'] as String),
              imageUrl: ImageUrl(e['image_url'] as String),
              label: Label(e['label'] as String),
              isSelected: e['boolean_value'] as bool,
            ),
          )
          .toList();

  static QuestionTheme _mapThematiqueFromJson(final String type) =>
      switch (type) {
        'alimentation' => QuestionTheme.alimentation,
        'transport' => QuestionTheme.transport,
        'logement' => QuestionTheme.logement,
        'consommation' => QuestionTheme.consommation,
        'climat' => QuestionTheme.climat,
        'dechet' => QuestionTheme.dechet,
        'loisir' => QuestionTheme.loisir,
        _ => throw UnimplementedError('Thematique non implémentée'),
      };
}
