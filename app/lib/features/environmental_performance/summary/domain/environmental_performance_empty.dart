import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:equatable/equatable.dart';

class EnvironmentalPerformanceEmpty extends Equatable {
  EnvironmentalPerformanceEmpty({required this.questions})
      : questionsNumber = questions.length.toString();

  final List<Question> questions;
  final String questionsNumber;

  @override
  List<Object> get props => [questions, questionsNumber];
}
