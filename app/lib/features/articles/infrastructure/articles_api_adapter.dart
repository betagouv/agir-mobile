import 'dart:convert';
import 'dart:io';

import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/articles/domain/articles_port.dart';
import 'package:app/features/articles/infrastructure/article_mapper.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_api_client.dart';
import 'package:app/features/authentification/core/infrastructure/cms_api_client.dart';
import 'package:app/features/profil/core/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:fpdart/fpdart.dart';

class ArticlesApiAdapter implements ArticlesPort {
  const ArticlesApiAdapter({
    required final AuthentificationApiClient apiClient,
    required final CmsApiClient cmsApiClient,
  })  : _apiClient = apiClient,
        _cmsApiClient = cmsApiClient;

  final AuthentificationApiClient _apiClient;
  final CmsApiClient _cmsApiClient;

  @override
  Future<Either<Exception, Article>> recupererArticle(final String id) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final responses = await Future.wait([
      _cmsApiClient.get(
        Uri.parse(
          '/api/articles/$id?populate[0]=partenaire,partenaire.logo.media&populate[1]=sources&populate[2]=image_url',
        ),
      ),
      _apiClient.get(
        Uri.parse('utilisateurs/$utilisateurId/bibliotheque/articles/$id'),
      ),
    ]);

    final cmsResponse = responses.first;
    final apiResponse = responses[1];
    if (cmsResponse.statusCode != HttpStatus.ok ||
        apiResponse.statusCode != HttpStatus.ok) {
      return Left(Exception("Erreur lors de la récupération de l'article"));
    }

    final articleData = jsonDecode(cmsResponse.body) as Map<String, dynamic>;
    final bibliothequeData =
        jsonDecode(apiResponse.body) as Map<String, dynamic>;

    final article = ArticleMapper.fromJson(
      cms: articleData,
      api: bibliothequeData,
    );

    return Right(article);
  }

  @override
  Future<Either<Exception, void>> marquerCommeLu(final String id) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response = await _apiClient.post(
      Uri.parse('/utilisateurs/$utilisateurId/events'),
      body: jsonEncode({'content_id': id, 'type': 'article_lu'}),
    );

    return response.statusCode == HttpStatus.ok
        ? const Right(null)
        : Left(Exception('Erreur lors de la validation du quiz'));
  }

  @override
  Future<Either<Exception, void>> addToFavorites(final String id) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response = await _apiClient.post(
      Uri.parse('/utilisateurs/$utilisateurId/events'),
      body: jsonEncode({'content_id': id, 'type': 'article_favoris'}),
    );

    return response.statusCode == HttpStatus.ok
        ? const Right(null)
        : Left(Exception("Erreur lors de l'ajout de l'article aux favoris"));
  }

  @override
  Future<Either<Exception, void>> removeToFavorites(final String id) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response = await _apiClient.post(
      Uri.parse('/utilisateurs/$utilisateurId/events'),
      body: jsonEncode({'content_id': id, 'type': 'article_non_favoris'}),
    );

    return response.statusCode == HttpStatus.ok
        ? const Right(null)
        : Left(Exception("Erreur lors du retrait de l'article aux favoris"));
  }
}
