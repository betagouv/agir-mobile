import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:equatable/equatable.dart';

sealed class EnvironmentalPerformanceQuestionEvent extends Equatable {
  const EnvironmentalPerformanceQuestionEvent();

  @override
  List<Object> get props => [];
}

final class EnvironmentalPerformanceQuestionIdListGiven
    extends EnvironmentalPerformanceQuestionEvent {
  const EnvironmentalPerformanceQuestionIdListGiven(this.questionIdList);

  final List<QuestionCode> questionIdList;

  @override
  List<Object> get props => [questionIdList];
}

final class EnvironmentalPerformanceQuestionIdListRequested
    extends EnvironmentalPerformanceQuestionEvent {
  const EnvironmentalPerformanceQuestionIdListRequested(this.categoryId);

  final String categoryId;

  @override
  List<Object> get props => [categoryId];
}
