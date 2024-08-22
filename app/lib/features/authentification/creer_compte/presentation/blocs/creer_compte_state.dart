import 'package:app/shared/helpers/mail_regex.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

final class CreerCompteState extends Equatable {
  const CreerCompteState({
    required this.adresseMail,
    required this.motDePasse,
    required this.erreur,
    required this.compteCree,
  });

  const CreerCompteState.empty()
      : this(
          adresseMail: '',
          motDePasse: '',
          erreur: const None(),
          compteCree: false,
        );

  final String adresseMail;
  final String motDePasse;
  final Option<String> erreur;
  bool get adresseMailEstValide => mailRegex.hasMatch(adresseMail);
  bool get estValide => adresseMailEstValide && motDePasse.isNotEmpty;

  final bool compteCree;

  CreerCompteState copyWith({
    final String? adresseMail,
    final String? motDePasse,
    final Option<String>? erreur,
    final bool? compteCree,
  }) =>
      CreerCompteState(
        adresseMail: adresseMail ?? this.adresseMail,
        motDePasse: motDePasse ?? this.motDePasse,
        erreur: erreur ?? this.erreur,
        compteCree: compteCree ?? this.compteCree,
      );

  @override
  List<Object> get props => [adresseMail, motDePasse, erreur, compteCree];
}
