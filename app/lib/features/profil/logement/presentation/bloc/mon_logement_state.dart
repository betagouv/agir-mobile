import 'package:equatable/equatable.dart';

enum MonLogementStatut { initial, chargement, succes }

enum TypeDeLogement {
  appartement,
  maison,
}

enum Superficie {
  s35, // = 'superficie_35',.
  s70, // = 'superficie_70',.
  s100, // = 'superficie_100',.
  s150, // = 'superficie_150',.
  s150EtPlus, // = 'superficie_150_et_plus',.
}

enum Chauffage {
  electricite,
  boisPellets,
  fioul,
  gaz,
  autre,
}

enum Dpe { a, b, c, d, e, f, g, jeNeSaisPas }

final class MonLogementState extends Equatable {
  const MonLogementState({
    required this.codePostal,
    required this.communes,
    required this.commune,
    required this.nombreAdultes,
    required this.nombreEnfants,
    required this.typeDeLogement,
    required this.estProprietaire,
    required this.superficie,
    required this.chauffage,
    required this.plusDe15Ans,
    required this.dpe,
    required this.statut,
  });

  const MonLogementState.empty()
      : this(
          codePostal: '',
          communes: const [],
          commune: '',
          nombreAdultes: 0,
          nombreEnfants: 0,
          typeDeLogement: null,
          estProprietaire: null,
          superficie: null,
          chauffage: null,
          plusDe15Ans: null,
          dpe: null,
          statut: MonLogementStatut.initial,
        );

  final String codePostal;
  final List<String> communes;
  final String commune;
  final int nombreAdultes;
  final int nombreEnfants;
  final TypeDeLogement? typeDeLogement;
  final bool? estProprietaire;
  final Superficie? superficie;
  final Chauffage? chauffage;
  final bool? plusDe15Ans;
  final Dpe? dpe;
  final MonLogementStatut statut;

  MonLogementState copyWith({
    final String? codePostal,
    final List<String>? communes,
    final String? commune,
    final int? nombreAdultes,
    final int? nombreEnfants,
    final TypeDeLogement? typeDeLogement,
    final bool? estProprietaire,
    final Superficie? superficie,
    final Chauffage? chauffage,
    final bool? plusDe15Ans,
    final Dpe? dpe,
    final MonLogementStatut? statut,
  }) =>
      MonLogementState(
        codePostal: codePostal ?? this.codePostal,
        communes: communes ?? this.communes,
        commune: commune ?? this.commune,
        nombreAdultes: nombreAdultes ?? this.nombreAdultes,
        nombreEnfants: nombreEnfants ?? this.nombreEnfants,
        typeDeLogement: typeDeLogement ?? this.typeDeLogement,
        estProprietaire: estProprietaire ?? this.estProprietaire,
        superficie: superficie ?? this.superficie,
        chauffage: chauffage ?? this.chauffage,
        plusDe15Ans: plusDe15Ans ?? this.plusDe15Ans,
        dpe: dpe ?? this.dpe,
        statut: statut ?? this.statut,
      );

  @override
  List<Object?> get props => [
        codePostal,
        communes,
        commune,
        nombreAdultes,
        nombreEnfants,
        typeDeLogement,
        estProprietaire,
        superficie,
        chauffage,
        plusDe15Ans,
        dpe,
        statut,
      ];
}
