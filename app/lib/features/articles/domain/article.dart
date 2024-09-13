import 'package:app/features/articles/domain/partenaire.dart';
import 'package:app/features/articles/domain/source.dart';
import 'package:equatable/equatable.dart';

class Article extends Equatable {
  const Article({
    required this.titre,
    required this.sousTitre,
    required this.contenu,
    required this.partenaire,
    required this.sources,
  });

  final String titre;
  final String? sousTitre;
  final String contenu;
  final Partenaire? partenaire;
  final List<Source> sources;

  @override
  List<Object?> get props => [titre, sousTitre, contenu, partenaire, sources];
}
