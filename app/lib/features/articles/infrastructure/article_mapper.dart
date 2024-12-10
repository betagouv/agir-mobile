// ignore_for_file: avoid_dynamic_calls

import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/articles/domain/partenaire.dart';
import 'package:app/features/articles/domain/source.dart';

abstract final class ArticleMapper {
  const ArticleMapper._();

  static Article fromJson({required final Map<String, dynamic> json}) {
    final sources = json['sources'] as List<dynamic>?;

    return Article(
      id: json['content_id'] as String,
      titre: json['titre'] as String,
      sousTitre: json['soustitre'] as String?,
      contenu: json['contenu'] as String,
      partenaire: json['partenaire_nom'] == null
          ? null
          : Partenaire(
              nom: json['partenaire_nom'] as String,
              url: json['partenaire_url'] as String,
              logo: json['partenaire_logo_url'] as String,
            ),
      sources: sources == null // TODO(lsaudon): manque les sources
          ? List.empty()
          : sources
              .map((final e) => e as Map<String, dynamic>)
              .map(
                (final e) => Source(
                  libelle: e['libelle'] as String,
                  lien: e['lien'] as String,
                ),
              )
              .toList(),
      isFavorite: json['favoris'] as bool,
      isRead: json['read_date'] != null,
    );
  }
}
