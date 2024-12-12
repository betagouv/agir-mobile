import 'package:app/core/infrastructure/endpoints.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/feature_context.dart';
import 'i_tap_on.dart';

/// Usage: I tap on the first article
Future<void> iTapOnTheFirstArticle(final WidgetTester tester) async {
  FeatureContext.instance.dioMock.getM(
    Endpoints.article('15'),
    responseData: {
      'content_id': '15',
      'titre': "Qu'est-ce qu'une alimentation durable ?",
      'soustitre':
          "Comment réduire l'impact de notre alimentation sur le climat ?",
      'thematique_principale': 'alimentation',
      'thematique_principale_label': 'Me nourrir',
      'thematiques': ['alimentation'],
      'image_url':
          'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1701355699/ella_olsson_n_Z_Aem1_CDE_9s_unsplash_1be02f4385.jpg',
      'points': 5,
      'favoris': false,
      'read_date': '2024-12-10T13:53:26.011Z',
      'contenu':
          '<p><strong><span>L’alimentation est responsable d’environ un tiers (34 %) des émissions mondiales de gaz à effet de serre. </span></strong><span>La plus grande partie de ces gaz est émise lors de la production agricole, notamment par :</span></p><ul><li><p><span>La digestion des bovins qui libère du méthane ;</span></p></li><li><p><span>La déforestation pour créer de nouvelles aires cultivables, notamment pour les nourrir ;</span></p></li><li><p><span>L’utilisation d’engrais ;</span></p></li><li><p><span>Les énergies fossiles utilisée pour les transports, les engins agricoles, le chauffage des serres et des bâtiments.</span></p></li></ul><p><span>À notre échelle, nous pouvons bien sûr rendre notre alimentation plus durable !</span></p><p>🍎 <strong><span>En privilégiant des produits locaux</span></strong><span> (moins de transport), </span><strong><span>de saison</span></strong><span> (pour éviter les transports en bateau et en avion, et la production sous serre chauffée) </span><strong><span>et biologiques</span></strong><span> (moins d’engrais et de déforestation).</span></p><p>🍎 <strong><span>En réduisant la consommation de viande et de lait</span></strong><span> (de plus de moitié) </span><strong><span>et en privilégiant celles qui ont un impact plus faible</span></strong><span> : porc, volaille.</span></p><p>🍎 <strong><span>En augmentant la quantité de protéines végétales dans les menus</span></strong><span> : légumineuses (haricots, pois chiches, lentilles), noix, amandes, céréales, fruits et légumes.</span></p><p>🍎 <strong><span>En préférant les produits bruts et cuisinés maison</span></strong><span> aux produits transformés, qui demandent beaucoup d’énergie pour être préparés, emballés, transportés, conservés…</span></p><p>🍎 <strong><span>En réduisant le gaspillage alimentaire</span></strong><span> : faire des courses plus petites, surveiller les dates de péremption, cuisiner les bonnes quantités, conserver les restes dans des récipients fermés, donner le surplus…</span></p>',
      'partenaire_nom': 'ADEME',
      'partenaire_url': 'https://agirpourlatransition.ademe.fr/particuliers/',
      'partenaire_logo_url':
          'https://res.cloudinary.com/dq023imd8/image/upload/t_media_lib_thumb/v1701947358/Logo_Ademe_2020_c234624ba3.jpg',
      'sources': [
        {
          'label':
              "Infographie ADEME - Impact de notre alimentation sur l'environnement",
          'url':
              'https://presse.ademe.fr/wp-content/uploads/2019/02/HAVAS_ADEME_infographie_SIA_vdef-1.pdf',
        },
        {
          'label':
              "Infographie QQF - Vers une alimentation saine et durable : quelle est l'assiette idéale ?",
          'url':
              'https://www.qqf.fr/infographie/vers-une-alimentation-saine-et-durable-quelle-est-lassiette-ideale/',
        },
        {
          'label': 'Nations Unies - Alimentation et changement climatique',
          'url':
              'https://www.un.org/fr/climatechange/science/climate-issues/food',
        },
      ],
    },
  );
  await iTapOn(tester, "Qu'est-ce qu'une alimentation durable ?");
}
