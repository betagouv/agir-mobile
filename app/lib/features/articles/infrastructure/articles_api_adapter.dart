import 'dart:convert';

import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/articles/domain/articles_port.dart';
import 'package:app/features/articles/infrastructure/article_mapper.dart';
import 'package:app/features/authentification/core/infrastructure/cms_api_client.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:fpdart/fpdart.dart';

class ArticlesApiAdapter implements ArticlesPort {
  const ArticlesApiAdapter({
    required final DioHttpClient client,
    required final CmsApiClient cmsApiClient,
  })  : _client = client,
        _cmsApiClient = cmsApiClient;

  final DioHttpClient _client;
  final CmsApiClient _cmsApiClient;

  @override
  Future<Either<Exception, Article>> recupererArticle(final String id) async {
    final responseApi =
        await _client.get('/utilisateurs/{userId}/bibliotheque/articles/$id');
    if (isResponseUnsuccessful(responseApi.statusCode)) {
      return Left(Exception("Erreur lors de la récupération de l'article"));
    }
    final responseCms = await _cmsApiClient.get(
      Uri.parse(
        '/api/articles/$id?populate[0]=partenaire,partenaire.logo.media&populate[1]=sources&populate[2]=image_url',
      ),
    );

    if (isResponseUnsuccessful(responseCms.statusCode)) {
      return Left(Exception("Erreur lors de la récupération de l'article"));
    }

    final articleData = jsonDecode(responseCms.body) as Map<String, dynamic>;
    final bibliothequeData = responseApi.data as Map<String, dynamic>;

    final article = ArticleMapper.fromJson(
      cms: articleData,
      api: bibliothequeData,
    );

    return Right(article);
  }

  @override
  Future<Either<Exception, void>> marquerCommeLu(final String id) async {
    final response = await _client.post(
      '/utilisateurs/{userId}/events',
      data: jsonEncode({'content_id': id, 'type': 'article_lu'}),
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(Exception('Erreur lors de la validation du quiz'));
  }

  @override
  Future<Either<Exception, void>> addToFavorites(final String id) async {
    final response = await _client.post(
      '/utilisateurs/{userId}/events',
      data: jsonEncode({'content_id': id, 'type': 'article_favoris'}),
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(Exception("Erreur lors de l'ajout de l'article aux favoris"));
  }

  @override
  Future<Either<Exception, void>> removeToFavorites(final String id) async {
    final response = await _client.post(
      '/utilisateurs/{userId}/events',
      data: jsonEncode({'content_id': id, 'type': 'article_non_favoris'}),
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(Exception("Erreur lors du retrait de l'article aux favoris"));
  }
}
