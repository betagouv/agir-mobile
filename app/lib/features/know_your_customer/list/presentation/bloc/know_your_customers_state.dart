import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

@immutable
sealed class KnowYourCustomersState extends Equatable {
  const KnowYourCustomersState();

  @override
  List<Object?> get props => [];
}

@immutable
final class KnowYourCustomersInitial extends KnowYourCustomersState {
  const KnowYourCustomersInitial();
}

@immutable
final class KnowYourCustomersLoading extends KnowYourCustomersState {
  const KnowYourCustomersLoading();
}

@immutable
final class KnowYourCustomersSuccess extends KnowYourCustomersState {
  const KnowYourCustomersSuccess({required this.allQuestions, this.themeSelected = const None()});

  final List<Question> allQuestions;
  final Option<ThemeType> themeSelected;

  List<Question> get questionsFiltered =>
      themeSelected.fold(() => allQuestions, (final s) => allQuestions.where((final question) => question.theme == s).toList());

  KnowYourCustomersSuccess copyWith({final List<Question>? allQuestions, final Option<ThemeType>? themeSelected}) =>
      KnowYourCustomersSuccess(
        allQuestions: allQuestions ?? this.allQuestions,
        themeSelected: themeSelected ?? this.themeSelected,
      );

  @override
  List<Object?> get props => [allQuestions, themeSelected];
}

@immutable
final class KnowYourCustomersFailure extends KnowYourCustomersState {
  const KnowYourCustomersFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
