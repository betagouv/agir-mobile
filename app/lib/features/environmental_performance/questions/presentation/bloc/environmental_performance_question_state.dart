import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:equatable/equatable.dart';

sealed class EnvironmentalPerformanceQuestionState extends Equatable {
  const EnvironmentalPerformanceQuestionState();

  @override
  List<Object> get props => [];
}

final class EnvironmentalPerformanceQuestionInitial
    extends EnvironmentalPerformanceQuestionState {
  const EnvironmentalPerformanceQuestionInitial();
}

final class EnvironmentalPerformanceQuestionLoadSuccess
    extends EnvironmentalPerformanceQuestionState {
  const EnvironmentalPerformanceQuestionLoadSuccess({
    required this.questionIdList,
  });

  final List<QuestionId> questionIdList;

  @override
  List<Object> get props => [questionIdList];
}

final class EnvironmentalPerformanceQuestionLoadFailure
    extends EnvironmentalPerformanceQuestionState {
  const EnvironmentalPerformanceQuestionLoadFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
