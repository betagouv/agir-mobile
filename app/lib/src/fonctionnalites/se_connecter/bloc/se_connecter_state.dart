import 'package:equatable/equatable.dart';

final mailRegex = RegExp(
  r'''^(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])$''',
);

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
