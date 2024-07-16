import 'dart:convert';

import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/articles/domain/ports/articles_port.dart';
import 'package:app/features/articles/infrastructure/adapters/article_mapper.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/cms_api_client.dart';
import 'package:app/features/profil/domain/utilisateur_id_non_trouve_exception.dart';
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

    return response.statusCode == 200
        ? const Right(null)
        : Left(Exception('Erreur lors de la validation du quiz'));
  }
}
