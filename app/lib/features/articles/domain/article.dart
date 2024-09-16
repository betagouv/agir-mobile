import 'package:app/features/articles/domain/partenaire.dart';
import 'package:app/features/articles/domain/source.dart';
import 'package:equatable/equatable.dart';

class Article extends Equatable {
  const Article({
    required this.id,
    required this.titre,
    required this.sousTitre,
    required this.contenu,
    required this.partenaire,
    required this.sources,
    required this.isFavorite,
    required this.isRead,
  });

  final String id;
  final String titre;
  final String? sousTitre;
  final String contenu;
  final Partenaire? partenaire;
  final List<Source> sources;
  final bool isFavorite;
  final bool isRead;

  Article copyWith({
    final String? id,
    final String? titre,
    final String? sousTitre,
    final String? contenu,
    final Partenaire? partenaire,
    final List<Source>? sources,
    final bool? isFavorite,
    final bool? isRead,
  }) =>
      Article(
        id: id ?? this.id,
        titre: titre ?? this.titre,
        sousTitre: sousTitre ?? this.sousTitre,
        contenu: contenu ?? this.contenu,
        partenaire: partenaire ?? this.partenaire,
        sources: sources ?? this.sources,
        isFavorite: isFavorite ?? this.isFavorite,
        isRead: isRead ?? this.isRead,
      );

  @override
  List<Object?> get props =>
      [id, titre, sousTitre, contenu, partenaire, sources, isFavorite, isRead];
}
