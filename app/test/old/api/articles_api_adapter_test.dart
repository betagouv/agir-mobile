import 'dart:convert';

import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/articles/domain/partenaire.dart';
import 'package:app/features/articles/domain/source.dart';
import 'package:app/features/articles/infrastructure/articles_api_adapter.dart';
import 'package:app/features/authentification/core/infrastructure/cms_api_client.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/authentication_service_setup.dart';
import '../../helpers/dio_mock.dart';
import 'client_mock.dart';
import 'constants.dart';
import 'custom_response.dart';

void main() {
  test('recupererArticle', () async {
    final dio = DioMock()
      ..getM(
        '/utilisateurs/{userId}/bibliotheque/articles/51',
        responseData: jsonDecode(
          '''
{
    "content_id": "51",
    "type": "article",
    "titre": "Recette : velouté crémeux de patates douces",
    "soustitre": "Une recette cocooning pour l'hiver",
    "thematique_principale": "alimentation",
    "thematique_principale_label": "🥦 Alimentation",
    "thematiques": ["alimentation"],
    "image_url": "https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1702656988/elena_leya_ves_Mzw6_ADMA_unsplash_974d78eae9.jpg",
    "points": 5,
    "favoris": false,
    "like_level": null,
    "read_date": null
}''',
        ),
      );
    final client = ClientMock()
      ..getSuccess(
        path:
            '/api/articles/51?populate[0]=partenaire,partenaire.logo.media&populate[1]=sources&populate[2]=image_url',
        response: OkResponse(
          value: '''
{
  "data": {
    "id": 51,
    "attributes": {
      "titre": "Recette : velouté crémeux de patates douces",
      "sousTitre": "Une recette cocooning pour l'hiver",
      "contenu": "<h2>Ingrédients</h2><p><strong><span>Pour 4 personnes</span></strong></p><ul><li><p><span>700g de patates douces</span></p></li><li><p><span>300g de carottes</span></p></li><li><p><span>1 gros oignon</span></p></li><li><p><span>400ml de lait de coco</span></p></li><li><p><span>2 cuillères à soupe d'épices en poudre (curry, cumin, curcuma...)</span></p></li><li><p><span>Huile d'olive</span></p></li><li><p><span>Sel et poivre</span></p></li></ul><h2><span>Préparation</span></h2><ol><li><p><span>Émincer l'oignon et le faire revenir dans une cocotte avec un peu d'huile d'olive</span></p></li><li><p><span>Éplucher les patates douces, laver et éplucher les carottes. Les couper en gros morceaux et verser le tout dans la cocotte. Recouvrir d'un litre d'eau bouillante et laisser cuire à feu moyen pendant 15 à 20 minutes.</span></p></li><li><p><span>Mixer à l'aide d'un mixeur plongeant, dans un blender ou un robot.</span></p></li><li><p><span>Ajouter le lait de coco et les épices. Mixer de nouveau. Saler et poivrer.</span></p></li></ol>",
      "source": "https://agirpourlatransition.ademe.fr/acteurs-education/enseigner/recettes-4-saisons-a-base-legumes-legumineuses",
      "codes_postaux": null,
      "duree": "⏱️ 35 minutes",
      "frequence": null,
      "points": 5,
      "difficulty": 1,
      "createdAt": "2023-12-15T16:23:09.570Z",
      "updatedAt": "2024-06-10T13:48:24.540Z",
      "publishedAt": "2024-06-10T13:47:48.492Z",
      "categorie": null,
      "mois": "9,10,11,12,1,2,3",
      "include_codes_commune": null,
      "exclude_codes_commune": null,
      "codes_departement": null,
      "codes_region": null,
      "partenaire": {
        "data": {
          "id": 1,
          "attributes": {
            "nom": "ADEME",
            "lien": "https://agirpourlatransition.ademe.fr/particuliers/",
            "createdAt": "2023-09-14T11:13:54.062Z",
            "updatedAt": "2023-12-07T11:09:35.796Z",
            "publishedAt": "2023-09-14T11:13:57.352Z",
            "logo": {
              "data": [
                {
                  "id": 59,
                  "attributes": {
                    "name": "Logo-Ademe-2020.jpg",
                    "alternativeText": null,
                    "caption": null,
                    "width": 952,
                    "height": 1086,
                    "formats": {
                      "large": {
                        "ext": ".jpg",
                        "url": "https://res.cloudinary.com/dq023imd8/image/upload/v1701947358/large_Logo_Ademe_2020_c234624ba3.jpg",
                        "hash": "large_Logo_Ademe_2020_c234624ba3",
                        "mime": "image/jpeg",
                        "name": "large_Logo-Ademe-2020.jpg",
                        "path": null,
                        "size": 57.44,
                        "width": 877,
                        "height": 1000,
                        "provider_metadata": {
                          "public_id": "large_Logo_Ademe_2020_c234624ba3",
                          "resource_type": "image"
                        }
                      },
                      "small": {
                        "ext": ".jpg",
                        "url": "https://res.cloudinary.com/dq023imd8/image/upload/v1701947358/small_Logo_Ademe_2020_c234624ba3.jpg",
                        "hash": "small_Logo_Ademe_2020_c234624ba3",
                        "mime": "image/jpeg",
                        "name": "small_Logo-Ademe-2020.jpg",
                        "path": null,
                        "size": 24.62,
                        "width": 438,
                        "height": 500,
                        "provider_metadata": {
                          "public_id": "small_Logo_Ademe_2020_c234624ba3",
                          "resource_type": "image"
                        }
                      },
                      "medium": {
                        "ext": ".jpg",
                        "url": "https://res.cloudinary.com/dq023imd8/image/upload/v1701947358/medium_Logo_Ademe_2020_c234624ba3.jpg",
                        "hash": "medium_Logo_Ademe_2020_c234624ba3",
                        "mime": "image/jpeg",
                        "name": "medium_Logo-Ademe-2020.jpg",
                        "path": null,
                        "size": 41.02,
                        "width": 657,
                        "height": 750,
                        "provider_metadata": {
                          "public_id": "medium_Logo_Ademe_2020_c234624ba3",
                          "resource_type": "image"
                        }
                      },
                      "thumbnail": {
                        "ext": ".jpg",
                        "url": "https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1701947358/Logo_Ademe_2020_c234624ba3.jpg",
                        "hash": "Logo_Ademe_2020_c234624ba3",
                        "mime": "image/jpeg",
                        "name": "Logo-Ademe-2020.jpg",
                        "path": null,
                        "provider_metadata": {
                          "public_id": "Logo_Ademe_2020_c234624ba3",
                          "resource_type": "image"
                        }
                      }
                    },
                    "hash": "Logo_Ademe_2020_c234624ba3",
                    "ext": ".jpg",
                    "mime": "image/jpeg",
                    "size": 55.75,
                    "url": "https://res.cloudinary.com/dq023imd8/image/upload/v1701947358/Logo_Ademe_2020_c234624ba3.jpg",
                    "previewUrl": null,
                    "provider": "cloudinary",
                    "provider_metadata": {
                      "public_id": "Logo_Ademe_2020_c234624ba3",
                      "resource_type": "image"
                    },
                    "createdAt": "2023-12-07T11:09:19.656Z",
                    "updatedAt": "2023-12-07T11:09:19.656Z"
                  }
                }
              ]
            }
          }
        }
      },
      "sources": [
        {
          "id": 69,
          "libelle": "CERFRANCE",
          "lien": "https://www.cerfrance.fr/fiches-conseil/la-filiere-cerealiere"
        },
        {
          "id": 70,
          "libelle": "France AgriMer",
          "lien": "https://www.franceagrimer.fr/filiere-grandes-cultures/Cereales"
        },
        {
          "id": 71,
          "libelle": "Cour des Comptes",
          "lien": "https://www.ccomptes.fr/sites/default/files/2024-03/20240312-RPA-2024-ENPA-adaptation-cultures-cerealieres.pdf"
        }
      ]
    }
  },
  "meta": {}
}''',
        ),
      );

    final adapter = ArticlesApiAdapter(
      apiClient: DioHttpClient(
        dio: dio,
        authenticationService: authenticationService,
      ),
      cmsApiClient:
          CmsApiClient(apiUrl: cmsApiUrl, token: 'le_token', inner: client),
    );

    final result = await adapter.recupererArticle('51');
    expect(
      result.getRight().getOrElse(() => throw Exception()),
      const Article(
        id: '51',
        titre: 'Recette : velouté crémeux de patates douces',
        sousTitre: "Une recette cocooning pour l'hiver",
        contenu:
            "<h2>Ingrédients</h2><p><strong><span>Pour 4 personnes</span></strong></p><ul><li><p><span>700g de patates douces</span></p></li><li><p><span>300g de carottes</span></p></li><li><p><span>1 gros oignon</span></p></li><li><p><span>400ml de lait de coco</span></p></li><li><p><span>2 cuillères à soupe d'épices en poudre (curry, cumin, curcuma...)</span></p></li><li><p><span>Huile d'olive</span></p></li><li><p><span>Sel et poivre</span></p></li></ul><h2><span>Préparation</span></h2><ol><li><p><span>Émincer l'oignon et le faire revenir dans une cocotte avec un peu d'huile d'olive</span></p></li><li><p><span>Éplucher les patates douces, laver et éplucher les carottes. Les couper en gros morceaux et verser le tout dans la cocotte. Recouvrir d'un litre d'eau bouillante et laisser cuire à feu moyen pendant 15 à 20 minutes.</span></p></li><li><p><span>Mixer à l'aide d'un mixeur plongeant, dans un blender ou un robot.</span></p></li><li><p><span>Ajouter le lait de coco et les épices. Mixer de nouveau. Saler et poivrer.</span></p></li></ol>",
        partenaire: Partenaire(
          nom: 'ADEME',
          logo:
              'https://res.cloudinary.com/dq023imd8/image/upload/v1701947358/Logo_Ademe_2020_c234624ba3.jpg',
        ),
        sources: [
          Source(
            libelle: 'CERFRANCE',
            lien:
                'https://www.cerfrance.fr/fiches-conseil/la-filiere-cerealiere',
          ),
          Source(
            libelle: 'France AgriMer',
            lien:
                'https://www.franceagrimer.fr/filiere-grandes-cultures/Cereales',
          ),
          Source(
            libelle: 'Cour des Comptes',
            lien:
                'https://www.ccomptes.fr/sites/default/files/2024-03/20240312-RPA-2024-ENPA-adaptation-cultures-cerealieres.pdf',
          ),
        ],
        isFavorite: false,
        isRead: false,
      ),
    );
  });

  test('recupererArticle sans partenaire', () async {
    final dio = DioMock()
      ..getM(
        '/utilisateurs/{userId}/bibliotheque/articles/2',
        responseData: jsonDecode('''
{
    "content_id": "2",
    "type": "article",
    "titre": "Comprendre le concept d'empreinte carbone en 2 minutes",
    "soustitre": "L'empreinte que nous laissons derrière nous",
    "thematique_principale": "climat",
    "thematique_principale_label": "☀️ Environnement",
    "thematiques": [
        "climat"
    ],
    "image_url": "https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1701252573/kit_ishimatsu_6u_CM_Kvsh8_Uk_unsplash_377f747f98.jpg",
    "points": 10,
    "favoris": false,
    "read_date": "2024-09-06T07:58:15.138Z"
}'''),
      );
    final client = ClientMock()
      ..getSuccess(
        path:
            '/api/articles/2?populate[0]=partenaire,partenaire.logo.media&populate[1]=sources&populate[2]=image_url',
        response: OkResponse(
          value: r'''
{
  "data": {
    "id": 2,
    "attributes": {
      "titre": "Comprendre le concept d'empreinte carbone en 2 minutes",
      "sousTitre": "L'empreinte que nous laissons derrière nous",
      "contenu": "<p>Que l’on se rende dans un magasin de quartier pour faire ses courses, qu’on allume la lumière ou qu’on chauffe son logement, l’ensemble de nos actions quotidiennes a un impact sur l’environnement. Cet impact, c’est ce que l’on appelle l’<strong>empreinte carbone</strong>, comme une trace invisible que nous laissons derrière nous.</p><p>Elle mesure la quantité totale de gaz à effet de serre (dioxyde de carbone (CO2), protoxyde d'azote, méthane, ...) liés à notre consommation et permet donc de quantifier nos émissions selon notre mode de vie. Elle peut concerner les émissions d’un individu (son mode de vie), d’une entreprise (ses activités) ou d’une population, d'un territoire.</p><ul><li><p>Au niveau des entreprises, la loi Grenelle II impose depuis juillet 2020 le Bilan GES Réglementaire à un nombre de structures publiques et privées. Cela concerne les entreprises publiques de plus de 250 personnes, 500 personnes pour les privées (250 en outre-mer), les collectivités de plus de 50 000 habitants et l’État.</p></li><li><p>A l'échelle du pays, l'empreinte carbone moyenne d'un Français est estimée à <strong>8,9 tonnes d'équivalent CO2</strong> en 2021. Or, pour respecter les objectifs de l’Accord de Paris et maintenir le réchauffement planétaire sous les 2°C, il nous faudrait réduire ce nombre à <strong>deux tonnes</strong>, autrement dit : le diviser presque par cinq !</p></li></ul><p><em>Pour en savoir plus sur l'empreinte carbone de la France, </em><a target=\"_self\" rel=\"\" href=\"/article/L'empreinte carbone de la France/11\"><em>c'est par ici.</em></a></p><h2>Comment connaître votre empreinte carbone ?</h2><p>L’empreinte carbone se calcule aussi au niveau individuel, et elle dépend directement d’un ensemble d’activités que nous effectuons quotidiennement. Calculer son empreinte carbone, c'est prendre conscience de ses activités quotidiennes et de leurs conséquences pour l'environnement.</p><p>On peut ainsi cibler les activités les plus polluantes et ajuster nos usages et nos habitudes de consommation pour diminuer notre impact. Faites le bilan avec le calculateur de l'Ademe : <a target=\"_blank\" rel=\"\" class=\"in-cell-link\" href=\"https://nosgestesclimat.fr/\"><span style=\"color: rgb(17, 85, 204)\">Nos Gestes Climat</span></a>.</p>",
      "source": null,
      "codes_postaux": null,
      "duree": "⏱️ 2 minutes",
      "frequence": null,
      "points": 10,
      "difficulty": 1,
      "createdAt": "2023-09-12T12:15:07.958Z",
      "updatedAt": "2024-06-18T15:49:57.542Z",
      "publishedAt": "2023-12-05T20:41:49.538Z",
      "categorie": null,
      "mois": null,
      "include_codes_commune": "1",
      "exclude_codes_commune": "2",
      "codes_departement": "3",
      "codes_region": "4",
      "partenaire": {
        "data": null
      },
      "sources": []
    }
  },
  "meta": {}
}''',
        ),
      );

    final adapter = ArticlesApiAdapter(
      apiClient: DioHttpClient(
        dio: dio,
        authenticationService: authenticationService,
      ),
      cmsApiClient:
          CmsApiClient(apiUrl: cmsApiUrl, token: 'le_token', inner: client),
    );

    final result = await adapter.recupererArticle('2');
    expect(
      result.getRight().getOrElse(() => throw Exception()),
      const Article(
        id: '2',
        titre: "Comprendre le concept d'empreinte carbone en 2 minutes",
        sousTitre: "L'empreinte que nous laissons derrière nous",
        contenu:
            "<p>Que l’on se rende dans un magasin de quartier pour faire ses courses, qu’on allume la lumière ou qu’on chauffe son logement, l’ensemble de nos actions quotidiennes a un impact sur l’environnement. Cet impact, c’est ce que l’on appelle l’<strong>empreinte carbone</strong>, comme une trace invisible que nous laissons derrière nous.</p><p>Elle mesure la quantité totale de gaz à effet de serre (dioxyde de carbone (CO2), protoxyde d'azote, méthane, ...) liés à notre consommation et permet donc de quantifier nos émissions selon notre mode de vie. Elle peut concerner les émissions d’un individu (son mode de vie), d’une entreprise (ses activités) ou d’une population, d'un territoire.</p><ul><li><p>Au niveau des entreprises, la loi Grenelle II impose depuis juillet 2020 le Bilan GES Réglementaire à un nombre de structures publiques et privées. Cela concerne les entreprises publiques de plus de 250 personnes, 500 personnes pour les privées (250 en outre-mer), les collectivités de plus de 50 000 habitants et l’État.</p></li><li><p>A l'échelle du pays, l'empreinte carbone moyenne d'un Français est estimée à <strong>8,9 tonnes d'équivalent CO2</strong> en 2021. Or, pour respecter les objectifs de l’Accord de Paris et maintenir le réchauffement planétaire sous les 2°C, il nous faudrait réduire ce nombre à <strong>deux tonnes</strong>, autrement dit : le diviser presque par cinq !</p></li></ul><p><em>Pour en savoir plus sur l'empreinte carbone de la France, </em><a target=\"_self\" rel=\"\" href=\"/article/L'empreinte carbone de la France/11\"><em>c'est par ici.</em></a></p><h2>Comment connaître votre empreinte carbone ?</h2><p>L’empreinte carbone se calcule aussi au niveau individuel, et elle dépend directement d’un ensemble d’activités que nous effectuons quotidiennement. Calculer son empreinte carbone, c'est prendre conscience de ses activités quotidiennes et de leurs conséquences pour l'environnement.</p><p>On peut ainsi cibler les activités les plus polluantes et ajuster nos usages et nos habitudes de consommation pour diminuer notre impact. Faites le bilan avec le calculateur de l'Ademe : <a target=\"_blank\" rel=\"\" class=\"in-cell-link\" href=\"https://nosgestesclimat.fr/\"><span style=\"color: rgb(17, 85, 204)\">Nos Gestes Climat</span></a>.</p>",
        partenaire: null,
        sources: [],
        isFavorite: false,
        isRead: true,
      ),
    );
  });

  test('marquerCommeLu', () async {
    final dio = DioMock()..postM<dynamic>('/utilisateurs/{userId}/events');

    final adapter = ArticlesApiAdapter(
      apiClient: DioHttpClient(
        dio: dio,
        authenticationService: authenticationService,
      ),
      cmsApiClient: CmsApiClient(
        apiUrl: cmsApiUrl,
        token: 'le_token',
        inner: ClientMock(),
      ),
    );

    await adapter.marquerCommeLu('1');
    verify(
      () => dio.post<dynamic>(
        '/utilisateurs/{userId}/events',
        data: '{"content_id":"1","type":"article_lu"}',
      ),
    );
  });

  test('addToFavorites', () async {
    final dio = DioMock()..postM<dynamic>('/utilisateurs/{userId}/events');

    final adapter = ArticlesApiAdapter(
      apiClient: DioHttpClient(
        dio: dio,
        authenticationService: authenticationService,
      ),
      cmsApiClient: CmsApiClient(
        apiUrl: cmsApiUrl,
        token: 'le_token',
        inner: ClientMock(),
      ),
    );

    await adapter.addToFavorites('1');

    verify(
      () => dio.post<dynamic>(
        '/utilisateurs/{userId}/events',
        data: '{"content_id":"1","type":"article_favoris"}',
      ),
    );
  });
}
