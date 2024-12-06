import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class BibliothequeEvent extends Equatable {
  const BibliothequeEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class BibliothequeRecuperationDemandee extends BibliothequeEvent {
  const BibliothequeRecuperationDemandee();
}

@immutable
final class BibliothequeRechercheSaisie extends BibliothequeEvent {
  const BibliothequeRechercheSaisie(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class BibliothequeThematiqueSelectionnee extends BibliothequeEvent {
  const BibliothequeThematiqueSelectionnee(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class BibliothequeFavorisSelectionnee extends BibliothequeEvent {
  const BibliothequeFavorisSelectionnee(this.valeur);

  final bool valeur;

  @override
  List<Object> get props => [valeur];
}
