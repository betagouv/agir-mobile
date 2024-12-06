import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class EnvironmentalPerformanceQuestionState extends Equatable {
  const EnvironmentalPerformanceQuestionState();

  @override
  List<Object> get props => [];
}

@immutable
final class EnvironmentalPerformanceQuestionInitial
    extends EnvironmentalPerformanceQuestionState {
  const EnvironmentalPerformanceQuestionInitial();
}

@immutable
final class EnvironmentalPerformanceQuestionLoadSuccess
    extends EnvironmentalPerformanceQuestionState {
  const EnvironmentalPerformanceQuestionLoadSuccess({
    required this.questionIdList,
  });

  final List<QuestionCode> questionIdList;

  @override
  List<Object> get props => [questionIdList];
}

@immutable
final class EnvironmentalPerformanceQuestionLoadFailure
    extends EnvironmentalPerformanceQuestionState {
  const EnvironmentalPerformanceQuestionLoadFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
