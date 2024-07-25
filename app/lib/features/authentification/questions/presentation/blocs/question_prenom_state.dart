import 'package:equatable/equatable.dart';

final class QuestionPrenomState extends Equatable {
  const QuestionPrenomState({
    required this.prenom,
    required this.aEteChange,
  });

  final String prenom;
  final bool aEteChange;

  QuestionPrenomState copyWith({
    final String? prenom,
    final bool? aEteChange,
  }) =>
      QuestionPrenomState(
        prenom: prenom ?? this.prenom,
        aEteChange: aEteChange ?? this.aEteChange,
      );

  @override
  List<Object> get props => [prenom, aEteChange];
}
