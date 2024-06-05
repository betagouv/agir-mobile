import 'package:equatable/equatable.dart';

final class SeConnecterState extends Equatable {
  const SeConnecterState({this.adresseMail = '', this.motDePasse = ''});

  final String adresseMail;
  final String motDePasse;

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
