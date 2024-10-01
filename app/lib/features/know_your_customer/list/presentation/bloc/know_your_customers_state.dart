import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

sealed class KnowYourCustomersState extends Equatable {
  const KnowYourCustomersState();

  @override
  List<Object?> get props => [];
}

final class KnowYourCustomersInitial extends KnowYourCustomersState {
  const KnowYourCustomersInitial();
}

final class KnowYourCustomersLoading extends KnowYourCustomersState {
  const KnowYourCustomersLoading();
}

final class KnowYourCustomersSuccess extends KnowYourCustomersState {
  const KnowYourCustomersSuccess({
    required this.allQuestions,
    this.themeSelected = const None(),
  });

  final List<Question> allQuestions;
  final Option<QuestionTheme> themeSelected;

  List<Question> get questionsFiltered => themeSelected.fold(
        () => allQuestions,
        (final s) => allQuestions
            .where((final question) => question.isPartOfTheme(s))
            .toList(),
      );

  KnowYourCustomersSuccess copyWith({
    final List<Question>? allQuestions,
    final Option<QuestionTheme>? themeSelected,
  }) =>
      KnowYourCustomersSuccess(
        allQuestions: allQuestions ?? this.allQuestions,
        themeSelected: themeSelected ?? this.themeSelected,
      );

  @override
  List<Object?> get props => [allQuestions, themeSelected];
}

final class KnowYourCustomersFailure extends KnowYourCustomersState {
  const KnowYourCustomersFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
