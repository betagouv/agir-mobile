import 'package:app/shared/helpers/mail_regex.dart';
import 'package:equatable/equatable.dart';

final class SeConnecterState extends Equatable {
  const SeConnecterState({
    required this.adresseMail,
    required this.motDePasse,
    required this.connexionFaite,
  });

  const SeConnecterState.empty()
      : this(adresseMail: '', motDePasse: '', connexionFaite: false);

  final String adresseMail;
  final String motDePasse;
  bool get adresseMailEstValide => mailRegex.hasMatch(adresseMail);
  bool get estValide => adresseMailEstValide && motDePasse.isNotEmpty;

  final bool connexionFaite;

  SeConnecterState copyWith({
    final String? adresseMail,
    final String? motDePasse,
    final bool? connexionFaite,
  }) =>
      SeConnecterState(
        adresseMail: adresseMail ?? this.adresseMail,
        motDePasse: motDePasse ?? this.motDePasse,
        connexionFaite: connexionFaite ?? this.connexionFaite,
      );

  @override
  List<Object?> get props => [adresseMail, motDePasse, connexionFaite];
}
