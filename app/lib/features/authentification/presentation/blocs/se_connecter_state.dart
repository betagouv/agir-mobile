import 'package:app/shared/helpers/mail_regex.dart';
import 'package:equatable/equatable.dart';

final class SeConnecterState extends Equatable {
  const SeConnecterState({this.adresseMail = '', this.motDePasse = ''});

  final String adresseMail;
  final String motDePasse;
  bool get adresseMailEstValide => mailRegex.hasMatch(adresseMail);
  bool get motDePasseEstValide => motDePasse.isNotEmpty;
  bool get estValide => adresseMailEstValide && motDePasseEstValide;

  SeConnecterState copyWith({
    final String? adresseMail,
    final String? motDePasse,
  }) =>
      SeConnecterState(
        adresseMail: adresseMail ?? this.adresseMail,
        motDePasse: motDePasse ?? this.motDePasse,
      );

  @override
  List<Object?> get props => [adresseMail, motDePasse];
}
