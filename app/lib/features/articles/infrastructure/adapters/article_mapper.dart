// ignore_for_file: avoid_dynamic_calls

import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/articles/domain/partenaire.dart';
import 'package:app/features/articles/domain/source.dart';

abstract final class ArticleMapper {
  const ArticleMapper._();

  static Article fromJson({
    required final Map<String, dynamic> cms,
    required final Map<String, dynamic> api,
  }) {
    final article = cms['data']['attributes'] as Map<String, dynamic>;
    final partenaire =
        article['partenaire']['data']?['attributes'] as Map<String, dynamic>?;
    final sources = article['sources'] as List<dynamic>?;

    return Article(
      id: (cms['data']['id'] as num).toString(),
      titre: article['titre'] as String,
      sousTitre: article['sousTitre'] as String?,
      contenu: article['contenu'] as String,
      partenaire: partenaire == null
          ? null
          : Partenaire(
              nom: partenaire['nom'] as String,
              logo: (partenaire['logo']['data'][0]['attributes']
                  as Map<String, dynamic>)['url'] as String,
            ),
      sources: sources == null
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
      isFavorite: api['favoris'] as bool,
      isRead: api['read_date'] != null,
    );
  }
}
