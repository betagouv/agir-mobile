import 'package:equatable/equatable.dart';

class Article extends Equatable {
  const Article({
    required this.titre,
    required this.sousTitre,
    required this.contenu,
    required this.partenaire,
  });

  final String titre;
  final String? sousTitre;
  final String contenu;
  final Partenaire? partenaire;
  @override
  List<Object?> get props => [titre, sousTitre, contenu, partenaire];
}

class Partenaire extends Equatable {
  const Partenaire({required this.nom, required this.logo});

  final String nom;
  final String logo;

  @override
  List<Object?> get props => [nom, logo];
}
