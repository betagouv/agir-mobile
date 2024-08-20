import 'package:app/shared/helpers/mail_regex.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

final class SeConnecterState extends Equatable {
  const SeConnecterState({
    required this.adresseMail,
    required this.motDePasse,
    required this.erreur,
    required this.connexionFaite,
  });

  const SeConnecterState.empty()
      : this(
          adresseMail: '',
          motDePasse: '',
          erreur: const None(),
          connexionFaite: false,
        );

  final String adresseMail;
  final String motDePasse;
  final Option<String> erreur;

  bool get adresseMailEstValide => mailRegex.hasMatch(adresseMail);
  bool get estValide => adresseMailEstValide && motDePasse.isNotEmpty;

  final bool connexionFaite;

  SeConnecterState copyWith({
    final String? adresseMail,
    final String? motDePasse,
    final Option<String>? erreur,
    final bool? connexionFaite,
  }) =>
      SeConnecterState(
        adresseMail: adresseMail ?? this.adresseMail,
        motDePasse: motDePasse ?? this.motDePasse,
        erreur: erreur ?? this.erreur,
        connexionFaite: connexionFaite ?? this.connexionFaite,
      );

  @override
  List<Object?> get props => [adresseMail, motDePasse, connexionFaite, erreur];
}
