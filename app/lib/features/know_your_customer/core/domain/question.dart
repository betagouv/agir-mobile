import 'package:app/core/domain/entity.dart';
import 'package:app/core/domain/value_object.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class QuestionCode extends ValueObject<String> {
  const QuestionCode(super.value);
}

class Response extends Equatable {
  const Response({required this.value, this.unit});

  final String value;
  final String? unit;

  Response copyWith({final String? value, final String? unit}) =>
      Response(value: value ?? this.value, unit: unit ?? this.unit);

  @override
  List<Object?> get props => [value, unit];
}

class ResponseChoice extends Equatable {
  const ResponseChoice({
    required this.code,
    required this.label,
    required this.isSelected,
  });

  final String code;
  final String label;
  final bool isSelected;

  ResponseChoice copyWith({
    final String? code,
    final String? label,
    final bool? isSelected,
  }) =>
      ResponseChoice(
        code: code ?? this.code,
        label: label ?? this.label,
        isSelected: isSelected ?? this.isSelected,
      );

  @override
  List<Object?> get props => [code, label, isSelected];
}

class ResponseMosaic extends ResponseChoice {
  const ResponseMosaic({
    required super.code,
    required super.label,
    required this.emoji,
    required this.imageUrl,
    required super.isSelected,
  });

  final String? emoji;
  final String imageUrl;

  @override
  ResponseMosaic copyWith({
    final String? code,
    final String? label,
    final String? emoji,
    final String? imageUrl,
    final bool? isSelected,
  }) =>
      ResponseMosaic(
        code: code ?? this.code,
        label: label ?? this.label,
        emoji: emoji ?? this.emoji,
        imageUrl: imageUrl ?? this.imageUrl,
        isSelected: isSelected ?? this.isSelected,
      );

  @override
  List<Object?> get props => [...super.props, emoji, imageUrl];
}

sealed class Question extends Entity<QuestionCode> {
  const Question({
    required super.id,
    required this.theme,
    required this.label,
    required this.isAnswered,
    required this.points,
  });

  final ThemeType theme;
  final String label;
  final bool isAnswered;
  final int points;

  String responsesDisplay();

  @override
  List<Object> get props => [id, theme, label, isAnswered, points];
}

sealed class QuestionUnique extends Question {
  const QuestionUnique({
    required super.id,
    required super.theme,
    required super.label,
    required super.isAnswered,
    required this.response,
    required super.points,
  });

  final Response response;

  QuestionUnique changeResponse(final String value);

  @override
  List<Object> get props => [...super.props, response];
}

final class QuestionOpen extends QuestionUnique {
  const QuestionOpen({
    required super.id,
    required super.theme,
    required super.label,
    required super.isAnswered,
    required super.response,
    required super.points,
  });

  @override
  String responsesDisplay() => response.value;

  @override
  QuestionOpen changeResponse(final String value) => QuestionOpen(
        id: id,
        theme: theme,
        label: label,
        isAnswered: isAnswered,
        response: response.copyWith(value: value),
        points: points,
      );
}

final class QuestionInteger extends QuestionUnique {
  const QuestionInteger({
    required super.id,
    required super.theme,
    required super.label,
    required super.isAnswered,
    required super.response,
    required super.points,
  });

  @override
  String responsesDisplay() => response.value;

  @override
  QuestionInteger changeResponse(final String value) => QuestionInteger(
        id: id,
        theme: theme,
        label: label,
        isAnswered: isAnswered,
        response: response.copyWith(value: value),
        points: points,
      );
}

sealed class QuestionMultiple extends Question {
  const QuestionMultiple({
    required super.id,
    required super.theme,
    required super.label,
    required super.isAnswered,
    required this.responses,
    required super.points,
  });

  final List<ResponseChoice> responses;

  QuestionMultiple changeResponses(final List<String> values);

  @override
  List<Object> get props => [...super.props, responses];
}

final class QuestionSingleChoice extends QuestionMultiple {
  const QuestionSingleChoice({
    required super.id,
    required super.theme,
    required super.label,
    required super.isAnswered,
    required super.responses,
    required super.points,
  });

  @override
  String responsesDisplay() =>
      responses.firstWhereOrNull((final r) => r.isSelected)?.label ?? '';

  @override
  QuestionSingleChoice changeResponses(final List<String> values) =>
      QuestionSingleChoice(
        id: id,
        theme: theme,
        label: label,
        isAnswered: isAnswered,
        responses: responses
            .map((final r) => r.copyWith(isSelected: values.contains(r.label)))
            .toList(),
        points: points,
      );
}

final class QuestionMultipleChoice extends QuestionMultiple {
  const QuestionMultipleChoice({
    required super.id,
    required super.theme,
    required super.label,
    required super.isAnswered,
    required super.responses,
    required super.points,
  });

  @override
  String responsesDisplay() => responses
      .where((final r) => r.isSelected)
      .map((final e) => e.label)
      .join(' - ');

  @override
  QuestionMultipleChoice changeResponses(final List<String> values) =>
      QuestionMultipleChoice(
        id: id,
        theme: theme,
        label: label,
        isAnswered: isAnswered,
        responses: responses
            .map((final r) => r.copyWith(isSelected: values.contains(r.label)))
            .toList(),
        points: points,
      );
}

final class QuestionMosaicBoolean extends Question {
  const QuestionMosaicBoolean({
    required super.id,
    required super.theme,
    required super.label,
    required super.isAnswered,
    required this.responses,
    required super.points,
  });

  final List<ResponseMosaic> responses;

  @override
  String responsesDisplay() => responses
      .where((final r) => r.isSelected)
      .map((final e) => e.label)
      .join(' - ');

  QuestionMosaicBoolean changeResponses(final List<String> values) =>
      QuestionMosaicBoolean(
        id: id,
        theme: theme,
        label: label,
        isAnswered: isAnswered,
        responses: responses
            .map((final r) => r.copyWith(isSelected: values.contains(r.label)))
            .toList(),
        points: points,
      );

  @override
  List<Object> get props => [...super.props, responses];
}
