import 'package:equatable/equatable.dart';

final class QuestionCodePostalState extends Equatable {
  const QuestionCodePostalState({
    required this.codePostal,
    required this.aEteChange,
  });

  final String codePostal;
  final bool aEteChange;

  QuestionCodePostalState copyWith({
    final String? codePostal,
    final bool? aEteChange,
  }) =>
      QuestionCodePostalState(
        codePostal: codePostal ?? this.codePostal,
        aEteChange: aEteChange ?? this.aEteChange,
      );

  @override
  List<Object> get props => [codePostal, aEteChange];
}
