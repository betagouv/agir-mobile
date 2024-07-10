import 'dart:convert';

import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/articles/domain/ports/articles_port.dart';
import 'package:app/features/articles/infrastructure/adapters/article_mapper.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/cms_api_client.dart';
import 'package:fpdart/fpdart.dart';

class ArticlesApiAdapter implements ArticlesPort {
  const ArticlesApiAdapter({required final CmsApiClient cmsApiClient})
      : _cmsApiClient = cmsApiClient;

  final CmsApiClient _cmsApiClient;

  @override
  Future<Either<Exception, Article>> recupererArticle(final String id) async {
    final response = await _cmsApiClient.get(
      Uri.parse(
        '/api/articles/$id?populate[0]=partenaire,partenaire.logo.media&populate[1]=sources&populate[2]=image_url',
      ),
    );
    if (response.statusCode != 200) {
      return Left(Exception("Erreur lors de la récupération de l'article"));
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Right(ArticleMapper.fromJson(json));
  }
}
