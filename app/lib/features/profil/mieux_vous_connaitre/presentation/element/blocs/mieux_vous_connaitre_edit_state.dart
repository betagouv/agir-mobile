import 'package:equatable/equatable.dart';

final class MieuxVousConnaitreEditState extends Equatable {
  const MieuxVousConnaitreEditState({
    required this.valeur,
    required this.estMiseAJour,
  });

  const MieuxVousConnaitreEditState.empty()
      : this(valeur: const [], estMiseAJour: false);

  final List<String> valeur;
  final bool estMiseAJour;

  MieuxVousConnaitreEditState copyWith({
    final List<String>? valeur,
    final bool? estMiseAJour,
  }) =>
      MieuxVousConnaitreEditState(
        valeur: valeur ?? this.valeur,
        estMiseAJour: estMiseAJour ?? this.estMiseAJour,
      );

  @override
  List<Object?> get props => [valeur, estMiseAJour];
}
