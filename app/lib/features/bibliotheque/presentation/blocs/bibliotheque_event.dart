import 'package:equatable/equatable.dart';

sealed class BibliothequeEvent extends Equatable {
  const BibliothequeEvent();

  @override
  List<Object> get props => [];
}

final class BibliothequeRecuperationDemandee extends BibliothequeEvent {
  const BibliothequeRecuperationDemandee();
}

final class BibliothequeRechercheSaisie extends BibliothequeEvent {
  const BibliothequeRechercheSaisie(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

final class BibliothequeThematiqueSelectionnee extends BibliothequeEvent {
  const BibliothequeThematiqueSelectionnee(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

final class BibliothequeFavorisSelectionnee extends BibliothequeEvent {
  const BibliothequeFavorisSelectionnee(this.valeur);

  final bool valeur;

  @override
  List<Object> get props => [valeur];
}
