import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
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
  final Option<ThemeType> themeSelected;

  List<Question> get questionsFiltered => themeSelected.fold(
        () => allQuestions,
        (final s) => allQuestions
            .where((final question) => question.theme == s)
            .toList(),
      );

  KnowYourCustomersSuccess copyWith({
    final List<Question>? allQuestions,
    final Option<ThemeType>? themeSelected,
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
