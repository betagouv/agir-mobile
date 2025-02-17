// ignore_for_file: avoid_dynamic_calls

import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/articles/domain/partner.dart';
import 'package:app/features/articles/domain/source.dart';

abstract final class ArticleMapper {
  const ArticleMapper._();

  static Article fromJson({required final Map<String, dynamic> json}) => Article(
    id: json['content_id'] as String,
    titre: json['titre'] as String,
    sousTitre: json['soustitre'] as String?,
    contenu: json['contenu'] as String,
    partner:
        json['partenaire_nom'] == null
            ? null
            : Partner(
              nom: json['partenaire_nom'] as String,
              url: json['partenaire_url'] as String,
              logo: json['partenaire_logo_url'] as String,
            ),
    sources:
        (json['sources'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map((final e) => Source(label: e['label'] as String, url: e['url'] as String))
            .toList(),
    isFavorite: json['favoris'] as bool,
    isRead: json['read_date'] != null,
  );
}
