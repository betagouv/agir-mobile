import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';

@immutable
final class MotDePasseOublieCodeState extends Equatable {
  const MotDePasseOublieCodeState({
    required this.email,
    required this.code,
    required this.motDePasse,
    required this.renvoyerCodeDemande,
    required this.erreur,
    required this.motDePasseModifie,
  });

  const MotDePasseOublieCodeState.initialize({required final String email})
    : this(email: email, code: '', motDePasse: '', renvoyerCodeDemande: false, erreur: const None(), motDePasseModifie: false);

  final String email;
  final String code;
  final String motDePasse;
  final bool renvoyerCodeDemande;
  final Option<String> erreur;
  final bool motDePasseModifie;

  MotDePasseOublieCodeState copyWith({
    final String? email,
    final String? code,
    final String? motDePasse,
    final bool? renvoyerCodeDemande,
    final Option<String>? erreur,
    final bool? motDePasseModifie,
  }) => MotDePasseOublieCodeState(
    email: email ?? this.email,
    code: code ?? this.code,
    motDePasse: motDePasse ?? this.motDePasse,
    renvoyerCodeDemande: renvoyerCodeDemande ?? this.renvoyerCodeDemande,
    erreur: erreur ?? this.erreur,
    motDePasseModifie: motDePasseModifie ?? this.motDePasseModifie,
  );

  @override
  List<Object> get props => [email, code, motDePasse, renvoyerCodeDemande, erreur, motDePasseModifie];
}
