import 'package:app/features/profil/logement/domain/entities/logement.dart';
import 'package:app/features/profil/logement/presentation/blocs/mon_logement_state.dart';

abstract final class LogementMapper {
  const LogementMapper._();

  static Map<String, dynamic> mapLogementToJson(final Logement logement) => {
        'chauffage': _mapChauffageToJson(logement.chauffage),
        'code_postal': logement.codePostal,
        'commune': logement.commune,
        'dpe': _mapDpeToJson(logement.dpe),
        'nombre_adultes': logement.nombreAdultes,
        'nombre_enfants': logement.nombreEnfants,
        'plus_de_15_ans': logement.plusDe15Ans,
        'proprietaire': logement.estProprietaire,
        'superficie': _mapSuperficieToJson(logement.superficie),
        'type': _mapTypeDeLogementToJson(logement.typeDeLogement),
      };

  static Logement mapLogementFromJson(final Map<String, dynamic> json) =>
      Logement(
        codePostal: json['code_postal'] as String,
        commune: json['commune'] as String,
        nombreAdultes: (json['nombre_adultes'] as num).toInt(),
        nombreEnfants: (json['nombre_enfants'] as num).toInt(),
        typeDeLogement: _mapTypeDeLogementFromJson(json['type'] as String?),
        estProprietaire: json['proprietaire'] as bool?,
        superficie: _mapSuperficieFromJson(json['superficie'] as String?),
        chauffage: _mapChauffageFromJson(json['chauffage'] as String?),
        plusDe15Ans: json['plus_de_15_ans'] as bool?,
        dpe: _mapDpeFromJson(json['dpe'] as String?),
      );

  static String? _mapChauffageToJson(final Chauffage? chauffage) =>
      switch (chauffage) {
        Chauffage.electricite => 'electricite',
        Chauffage.boisPellets => 'bois',
        Chauffage.fioul => 'fioul',
        Chauffage.gaz => 'gaz',
        Chauffage.autre => 'autre',
        null => null,
      };

  static Chauffage? _mapChauffageFromJson(final String? chauffage) =>
      switch (chauffage) {
        'electricite' => Chauffage.electricite,
        'bois' => Chauffage.boisPellets,
        'fioul' => Chauffage.fioul,
        'gaz' => Chauffage.gaz,
        'autre' => Chauffage.autre,
        _ => null,
      };

  static String? _mapDpeToJson(final Dpe? dpe) => switch (dpe) {
        Dpe.a => 'A',
        Dpe.b => 'B',
        Dpe.c => 'C',
        Dpe.d => 'D',
        Dpe.e => 'E',
        Dpe.f => 'F',
        Dpe.g => 'G',
        Dpe.jeNeSaisPas => 'ne_sais_pas',
        null => null,
      };

  static Dpe? _mapDpeFromJson(final String? dpe) => switch (dpe) {
        'A' => Dpe.a,
        'B' => Dpe.b,
        'C' => Dpe.c,
        'D' => Dpe.d,
        'E' => Dpe.e,
        'F' => Dpe.f,
        'G' => Dpe.g,
        'ne_sais_pas' => Dpe.jeNeSaisPas,
        _ => null,
      };

  static String? _mapSuperficieToJson(final Superficie? superficie) =>
      switch (superficie) {
        Superficie.s35 => 'superficie_35',
        Superficie.s70 => 'superficie_70',
        Superficie.s100 => 'superficie_100',
        Superficie.s150 => 'superficie_150',
        Superficie.s150EtPlus => 'superficie_150_et_plus',
        null => null,
      };

  static Superficie? _mapSuperficieFromJson(final String? superficie) =>
      switch (superficie) {
        'superficie_35' => Superficie.s35,
        'superficie_70' => Superficie.s70,
        'superficie_100' => Superficie.s100,
        'superficie_150' => Superficie.s150,
        'superficie_150_et_plus' => Superficie.s150EtPlus,
        _ => null,
      };

  static String? _mapTypeDeLogementToJson(
    final TypeDeLogement? typeDeLogement,
  ) =>
      switch (typeDeLogement) {
        TypeDeLogement.appartement => 'appartement',
        TypeDeLogement.maison => 'maison',
        null => null,
      };

  static TypeDeLogement? _mapTypeDeLogementFromJson(final String? type) =>
      switch (type) {
        'appartement' => TypeDeLogement.appartement,
        'maison' => TypeDeLogement.maison,
        _ => null,
      };
}
