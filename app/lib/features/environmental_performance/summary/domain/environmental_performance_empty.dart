import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:equatable/equatable.dart';

class EnvironmentalPerformanceEmpty extends Equatable {
  EnvironmentalPerformanceEmpty({required this.questions})
      : questionsNumber = questions.length,
        questionsNumberAnswered =
            questions.where((final question) => question.isAnswered()).length;

  final List<Question> questions;
  final int questionsNumber;
  final int questionsNumberAnswered;
  double get percentageCompletion => questionsNumberAnswered / questionsNumber;

  @override
  List<Object> get props => [
        questions,
        questionsNumberAnswered,
        questionsNumber,
      ];
}
