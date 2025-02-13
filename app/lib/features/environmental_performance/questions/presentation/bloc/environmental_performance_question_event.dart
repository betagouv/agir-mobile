import 'package:app/features/know_your_customer/core/domain/question_code.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class EnvironmentalPerformanceQuestionEvent extends Equatable {
  const EnvironmentalPerformanceQuestionEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class EnvironmentalPerformanceQuestionIdListGiven extends EnvironmentalPerformanceQuestionEvent {
  const EnvironmentalPerformanceQuestionIdListGiven(this.questionIdList);

  final List<QuestionCode> questionIdList;

  @override
  List<Object> get props => [questionIdList];
}

@immutable
final class EnvironmentalPerformanceQuestionIdListRequested extends EnvironmentalPerformanceQuestionEvent {
  const EnvironmentalPerformanceQuestionIdListRequested(this.categoryId);

  final String categoryId;

  @override
  List<Object> get props => [categoryId];
}
