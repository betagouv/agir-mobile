import 'package:app/features/profil/logement/presentation/bloc/mon_logement_state.dart';
import 'package:equatable/equatable.dart';

sealed class MonLogementEvent extends Equatable {
  const MonLogementEvent();

  @override
  List<Object?> get props => [];
}

final class MonLogementRecuperationDemandee extends MonLogementEvent {
  const MonLogementRecuperationDemandee();
}

final class MonLogementCodePostalChange extends MonLogementEvent {
  const MonLogementCodePostalChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

final class MonLogementCommuneChange extends MonLogementEvent {
  const MonLogementCommuneChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

final class MonLogementNombreAdultesChange extends MonLogementEvent {
  const MonLogementNombreAdultesChange(this.valeur);

  final int valeur;

  @override
  List<Object> get props => [valeur];
}

final class MonLogementNombreEnfantsChange extends MonLogementEvent {
  const MonLogementNombreEnfantsChange(this.valeur);

  final int valeur;

  @override
  List<Object> get props => [valeur];
}

final class MonLogementTypeDeLogementChange extends MonLogementEvent {
  const MonLogementTypeDeLogementChange(this.valeur);

  final TypeDeLogement valeur;

  @override
  List<Object> get props => [valeur];
}

final class MonLogementEstProprietaireChange extends MonLogementEvent {
  const MonLogementEstProprietaireChange(this.valeur);

  final bool? valeur;

  @override
  List<Object?> get props => [valeur];
}

final class MonLogementSuperficieChange extends MonLogementEvent {
  const MonLogementSuperficieChange(this.valeur);

  final Superficie? valeur;

  @override
  List<Object?> get props => [valeur];
}

final class MonLogementPlusDe15AnsChange extends MonLogementEvent {
  const MonLogementPlusDe15AnsChange(this.valeur);

  final bool? valeur;

  @override
  List<Object?> get props => [valeur];
}

final class MonLogementDpeChange extends MonLogementEvent {
  const MonLogementDpeChange(this.valeur);

  final Dpe? valeur;

  @override
  List<Object?> get props => [valeur];
}

final class MonLogementMiseAJourDemandee extends MonLogementEvent {
  const MonLogementMiseAJourDemandee();
}
