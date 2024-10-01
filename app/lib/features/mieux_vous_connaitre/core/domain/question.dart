import 'package:app/core/domain/entity.dart';
import 'package:app/core/domain/value_object.dart';

class QuestionId extends ValueObject<String> {
  const QuestionId(super.value);
}

class QuestionText extends ValueObject<String> {
  const QuestionText(super.value);
}

class Points extends ValueObject<int> {
  const Points(super.value);
}

class Responses extends ValueObject<List<String>> {
  const Responses(super.value);
}

class ResponsesPossibles extends ValueObject<List<String>> {
  const ResponsesPossibles(super.value);
}

enum QuestionTheme {
  alimentation('Alimentation'),
  transport('Transport'),
  logement('Logement'),
  consommation('Consommation'),
  climat('Climat'),
  dechet('Déchet'),
  loisir('Loisirs');

  const QuestionTheme(this.label);

  final String label;
}

sealed class Question extends Entity<QuestionId> {
  const Question({
    required super.id,
    required this.text,
    required this.points,
  });

  final QuestionText text;
  final Points points;

  String responsesDisplay();
  bool isAnswered();
  bool isPartOfTheme(final QuestionTheme theme);

  @override
  List<Object?> get props => [id, text, points];
}

sealed class StandardQuestion extends Question {
  const StandardQuestion({
    required super.id,
    required super.text,
    required this.responses,
    required super.points,
    required this.theme,
  });

  final Responses responses;
  final QuestionTheme theme;

  StandardQuestion responsesChanged({required final Responses reponses});

  @override
  String responsesDisplay() => responses.value.join(' - ');

  @override
  bool isAnswered() => responses.value.isNotEmpty;

  @override
  bool isPartOfTheme(final QuestionTheme theme) => this.theme == theme;

  @override
  List<Object?> get props => [...super.props, responses, theme];
}

sealed class ChoixQuestion extends StandardQuestion {
  const ChoixQuestion({
    required super.id,
    required super.text,
    required super.responses,
    required super.points,
    required this.responsesPossibles,
    required super.theme,
  });

  final ResponsesPossibles responsesPossibles;

  @override
  List<Object?> get props => [...super.props, responsesPossibles];
}

class LibreQuestion extends StandardQuestion {
  const LibreQuestion({
    required super.id,
    required super.text,
    required super.responses,
    required super.points,
    required super.theme,
  });

  @override
  LibreQuestion responsesChanged({required final Responses reponses}) =>
      LibreQuestion(
        id: id,
        text: text,
        responses: reponses,
        points: points,
        theme: theme,
      );
}

class ChoixUniqueQuestion extends ChoixQuestion {
  const ChoixUniqueQuestion({
    required super.id,
    required super.text,
    required super.responses,
    required super.points,
    required super.responsesPossibles,
    required super.theme,
  });

  @override
  ChoixUniqueQuestion responsesChanged({required final Responses reponses}) =>
      ChoixUniqueQuestion(
        id: id,
        text: text,
        responses: reponses,
        points: points,
        responsesPossibles: responsesPossibles,
        theme: theme,
      );
}

class ChoixMultipleQuestion extends ChoixQuestion {
  const ChoixMultipleQuestion({
    required super.id,
    required super.text,
    required super.responses,
    required super.points,
    required super.responsesPossibles,
    required super.theme,
  });

  @override
  ChoixMultipleQuestion responsesChanged({
    required final Responses reponses,
  }) =>
      ChoixMultipleQuestion(
        id: id,
        text: text,
        responses: reponses,
        points: points,
        responsesPossibles: responsesPossibles,
        theme: theme,
      );
}

class MosaicQuestion extends Question {
  const MosaicQuestion({
    required super.id,
    required super.text,
    required this.responses,
    required super.points,
    required this.answered,
  });

  final List<MosaicResponse> responses;
  final bool answered;

  MosaicQuestion responsesChanged({
    required final List<MosaicResponse> responses,
  }) =>
      MosaicQuestion(
        id: id,
        text: text,
        responses: responses,
        points: points,
        answered: answered,
      );

  @override
  String responsesDisplay() => responses
      .where((final response) => response.isSelected)
      .map((final response) => response.label.value)
      .join(' - ');

  @override
  bool isAnswered() => answered;

  @override
  bool isPartOfTheme(final QuestionTheme theme) => false;

  @override
  List<Object?> get props => [...super.props, responses, answered];
}

class MosaicResponseCode extends ValueObject<String> {
  const MosaicResponseCode(super.value);
}

class ImageUrl extends ValueObject<String> {
  const ImageUrl(super.value);
}

class Label extends ValueObject<String> {
  const Label(super.value);
}

class MosaicResponse extends Entity<MosaicResponseCode> {
  const MosaicResponse({
    required super.id,
    required this.imageUrl,
    required this.label,
    required this.isSelected,
  });

  final ImageUrl imageUrl;
  final Label label;
  final bool isSelected;

  @override
  List<Object?> get props => [...super.props, imageUrl, label, isSelected];
}
