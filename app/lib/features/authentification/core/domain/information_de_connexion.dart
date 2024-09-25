import 'package:equatable/equatable.dart';

class InformationDeConnexion extends Equatable {
  const InformationDeConnexion({
    required this.adresseMail,
    required this.motDePasse,
  });

  final String adresseMail;
  final String motDePasse;

  @override
  List<Object?> get props => [adresseMail, motDePasse];
}
