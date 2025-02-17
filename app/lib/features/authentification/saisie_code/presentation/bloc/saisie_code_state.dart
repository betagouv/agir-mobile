import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';

@immutable
final class SaisieCodeState extends Equatable {
  const SaisieCodeState({required this.email, required this.renvoyerCodeDemande, required this.erreur});

  final String email;
  final bool renvoyerCodeDemande;
  final Option<String> erreur;

  SaisieCodeState copyWith({final String? email, final Option<String>? erreur, final bool? renvoyerCodeDemande}) =>
      SaisieCodeState(
        email: email ?? this.email,
        renvoyerCodeDemande: renvoyerCodeDemande ?? this.renvoyerCodeDemande,
        erreur: erreur ?? this.erreur,
      );

  @override
  List<Object> get props => [email, renvoyerCodeDemande, erreur];
}
