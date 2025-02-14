Feature: Recipe
    Background:
        Given initialize context
        Given I have actions in my library
            | 'code' | 'title'                                        | 'nb_actions_completed' | 'nb_aids_available' |
            | '3'    | 'Tester une **nouvelle recette végétarienne**' | 1                      | 1                   |
        Given I have action detail in my library
            | 'id' | 'title'                                        | 'subTitle'                                                                                                    | 'how'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | 'why'                                                                                                                                                                                                                                                                                                                   | 'service_id' | 'service_category' |
            | '3'  | 'Tester une **nouvelle recette végétarienne**' | 'Faites des économies et le plein de vitamines ! Cette semaine, on cuisine une recette saine et délicieuse !' | '# Nos astuces\n\n- **Revisitez vos classiques** : Lasagnes au légumes, chili sin carne, re-découvrez vos plats favoris en version végétariennes \n\n- **Protéines végétales** : Associez légumineuses (lentilles, pois chiches) et céréales (riz, quinoa) pour un plat complet.\n\n- **Variez les textures** : Alternez croquant (graines, noix) et fondant (avocats, patates douces)\n\n- **Épices et herbes** : Boostez les saveurs avec du curry, paprika fumé, curcuma, cumin ou herbes fraîches.' | '# En quelques mots\n\n- Les repas à base de légumes sont en moyenne **30% moins chers** que ceux à base de viande.\n\n- Les nutriments contenus dans les légumes de saison sont une grande aide pour passer l’hiver !\n\n![test alt](https://agir-cms-prod.osc-secnum-fr1.scalingo.io/admin/70674f63fc3904c20de0.svg)' | 'recettes'   | 'vegan'            |
        Given I am logged in
        Given The application is launched
        When I tap on the menu button

    Scenario: See recipe detail
        When I tap on {'Actions'}
        Given I have recipe services in my library
        Given I have recipe detail in my library
            | 'id' | 'title'                                  | 'preparation_time' |
            | '1'  | 'Salade de pâtes complètes et lentilles' | 5                  |
        When I tap on {'Tester une nouvelle recette végétarienne'}
        When I scroll down
        When I tap on {'Salade de pâtes complètes et lentilles'}
        Then I see {'Temps de préparation : 5 min'}
