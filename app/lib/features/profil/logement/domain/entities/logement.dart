import 'package:app/features/profil/logement/presentation/blocs/mon_logement_state.dart';
import 'package:equatable/equatable.dart';

class Logement extends Equatable {
  const Logement({
    required this.codePostal,
    required this.commune,
    required this.nombreAdultes,
    required this.nombreEnfants,
    required this.typeDeLogement,
    required this.estProprietaire,
    required this.superficie,
    required this.chauffage,
    required this.plusDe15Ans,
    required this.dpe,
  });

  final String codePostal;
  final String commune;
  final int nombreAdultes;
  final int nombreEnfants;
  final TypeDeLogement? typeDeLogement;
  final bool? estProprietaire;
  final Superficie? superficie;
  final Chauffage? chauffage;
  final bool? plusDe15Ans;
  final Dpe? dpe;

  @override
  List<Object?> get props => [
        codePostal,
        commune,
        nombreAdultes,
        nombreEnfants,
        typeDeLogement,
        estProprietaire,
        superficie,
        chauffage,
        plusDe15Ans,
        dpe,
      ];
}
