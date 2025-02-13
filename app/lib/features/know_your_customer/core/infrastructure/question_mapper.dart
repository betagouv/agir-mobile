import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/core/domain/question_code.dart';
import 'package:app/features/know_your_customer/core/domain/response.dart';
import 'package:app/features/know_your_customer/core/domain/response_choice.dart';
import 'package:app/features/know_your_customer/core/domain/response_mosaic.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';

abstract final class QuestionMapper {
  const QuestionMapper._();

  static Question? fromJson(final Map<String, dynamic> json) {
    final type = json['type'] as String;

    return switch (type) {
      'choix_multiple' => _questionMultipleChoice(json),
      'choix_unique' => _questionSingleChoice(json),
      'libre' => _questionOpen(json),
      'mosaic_boolean' => _questionMosaicBoolean(json),
      'entier' => _questionInteger(json),
      _ => null,
    };
  }

  static QuestionMultipleChoice _questionMultipleChoice(
    final Map<String, dynamic> json,
  ) => QuestionMultipleChoice(
    id: QuestionCode(json['code'] as String),
    theme: _mapThemeType(json['thematique'] as String),
    label: json['question'] as String,
    isAnswered: json['is_answered'] as bool,
    responses: _responseChoices(json['reponse_multiple'] as List<dynamic>),
    points: (json['points'] as num).toInt(),
  );

  static QuestionSingleChoice _questionSingleChoice(
    final Map<String, dynamic> json,
  ) => QuestionSingleChoice(
    id: QuestionCode(json['code'] as String),
    theme: _mapThemeType(json['thematique'] as String),
    label: json['question'] as String,
    isAnswered: json['is_answered'] as bool,
    responses: _responseChoices(json['reponse_multiple'] as List<dynamic>),
    points: (json['points'] as num).toInt(),
  );

  static List<ResponseChoice> _responseChoices(final List<dynamic> json) =>
      json
          .cast<Map<String, dynamic>>()
          .map(
            (final e) => ResponseChoice(
              code: e['code'] as String,
              label: e['label'] as String,
              isSelected: e['selected'] as bool,
            ),
          )
          .toList();

  static QuestionOpen _questionOpen(final Map<String, dynamic> json) =>
      QuestionOpen(
        id: QuestionCode(json['code'] as String),
        theme: _mapThemeType(json['thematique'] as String),
        label: json['question'] as String,
        isAnswered: json['is_answered'] as bool,
        response: _response(json['reponse_unique'] as Map<String, dynamic>),
        points: (json['points'] as num).toInt(),
      );

  static QuestionInteger _questionInteger(final Map<String, dynamic> json) =>
      QuestionInteger(
        id: QuestionCode(json['code'] as String),
        theme: _mapThemeType(json['thematique'] as String),
        label: json['question'] as String,
        isAnswered: json['is_answered'] as bool,
        response: _response(json['reponse_unique'] as Map<String, dynamic>),
        points: (json['points'] as num).toInt(),
      );

  static Response _response(final Map<String, dynamic> json) => Response(
    value: json.containsKey('value') ? json['value'] as String : '',
    unit: json.containsKey('unite') ? json['unite'] as String : null,
  );

  static QuestionMosaicBoolean _questionMosaicBoolean(
    final Map<String, dynamic> json,
  ) => QuestionMosaicBoolean(
    id: QuestionCode(json['code'] as String),
    theme: _mapThemeType(json['thematique'] as String),
    label: json['question'] as String,
    isAnswered: json['is_answered'] as bool,
    responses: _responseMosaics(json['reponse_multiple'] as List<dynamic>),
    points: (json['points'] as num).toInt(),
  );

  static List<ResponseMosaic> _responseMosaics(final List<dynamic> json) =>
      json
          .cast<Map<String, dynamic>>()
          .map(
            (final e) => ResponseMosaic(
              code: e['code'] as String,
              label: e['label'] as String,
              emoji: e['emoji'] as String?,
              imageUrl: e['image_url'] as String,
              isSelected: e['selected'] as bool,
            ),
          )
          .toList();

  static ThemeType _mapThemeType(final String? type) => switch (type) {
    'alimentation' => ThemeType.alimentation,
    'transport' => ThemeType.transport,
    'consommation' => ThemeType.consommation,
    'logement' => ThemeType.logement,
    _ => ThemeType.decouverte,
  };
}
