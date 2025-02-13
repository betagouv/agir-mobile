import 'package:app/core/helpers/regex.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

@immutable
final class CreerCompteState extends Equatable {
  const CreerCompteState({
    required this.adresseMail,
    required this.motDePasse,
    required this.aCguAcceptees,
    required this.erreur,
    required this.compteCree,
  });

  const CreerCompteState.empty()
    : this(
        adresseMail: '',
        motDePasse: '',
        aCguAcceptees: false,
        erreur: const None(),
        compteCree: false,
      );

  final String adresseMail;
  final String motDePasse;
  final bool aCguAcceptees;
  final Option<String> erreur;
  bool get adresseMailEstValide => mailRegex.hasMatch(adresseMail);
  bool get estValide =>
      adresseMailEstValide && motDePasse.isNotEmpty && aCguAcceptees;

  final bool compteCree;

  CreerCompteState copyWith({
    final String? adresseMail,
    final String? motDePasse,
    final bool? aCguAcceptees,
    final Option<String>? erreur,
    final bool? compteCree,
  }) => CreerCompteState(
    adresseMail: adresseMail ?? this.adresseMail,
    motDePasse: motDePasse ?? this.motDePasse,
    aCguAcceptees: aCguAcceptees ?? this.aCguAcceptees,
    erreur: erreur ?? this.erreur,
    compteCree: compteCree ?? this.compteCree,
  );

  @override
  List<Object> get props => [
    adresseMail,
    motDePasse,
    erreur,
    aCguAcceptees,
    compteCree,
  ];
}
