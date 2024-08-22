import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

final class SaisieCodeState extends Equatable {
  const SaisieCodeState({
    required this.email,
    required this.renvoyerCodeDemandee,
    required this.erreur,
  });

  final String email;
  final bool renvoyerCodeDemandee;
  final Option<String> erreur;

  SaisieCodeState copyWith({
    final String? email,
    final bool? renvoyerCodeDemandee,
    final Option<String>? erreur,
  }) =>
      SaisieCodeState(
        email: email ?? this.email,
        renvoyerCodeDemandee: renvoyerCodeDemandee ?? this.renvoyerCodeDemandee,
        erreur: erreur ?? this.erreur,
      );

  @override
  List<Object> get props => [email, renvoyerCodeDemandee, erreur];
}
