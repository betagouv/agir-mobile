Feature: Actions
    Background:
        Given initialize context
        Given I have actions in my library
            | 'type'      | 'code' | 'title'                                        | 'nb_actions_completed' | 'nb_aids_available' |
            | 'classique' | '1'    | 'Faire réparer une **paire de chaussures**'    | 2                      | 2                   |
            | 'classique' | '2'    | 'Contribuer à la **bonne santé de son sol**'   | 0                      | 0                   |
            | 'classique' | '3'    | 'Tester une **nouvelle recette végétarienne**' | 1                      | 1                   |
        Given I have action detail in my library
            | 'id' | 'title'                                        | 'subTitle'                                                                                                    | 'how'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | 'why'                                                                                                                                                                                                                                                                                                                   | 'service_id'        | 'service_category' |
            | '1'  | 'Faire réparer une **paire de chaussures**'    | 'Faites des économies en donnant une seconde vie à vos paires de chaussures'                                  | '# Nos astuces\n\n- **Choisissez un cordonnier agréé** : pour profiter de l’aide d’État sur vos réparations\n\n- **Bottes, chaussures de ski, baskets** : toutes les chaussures sont éligibles\n\n- **Si vos chaussures sont trop abimées** : Déposez-les dans un point de collecte pour que valoriser les matériaux utilisés'                                                                                                                                                                          | '# En quelques mots\n\n- Pour chaque paire de chaussure réparée, vous économisez **entre 20 et 60€**\n\n- Les paires de chaussures jetées représentent plusieurs **milliers de tonnes** de déchets généralement non recyclables. \n\n- Chaque année, un Français achète en moyenne 4 paires de chaussures.'             | 'longue_vie_objets' | 'reparer'          |
            | '3'  | 'Tester une **nouvelle recette végétarienne**' | 'Faites des économies et le plein de vitamines ! Cette semaine, on cuisine une recette saine et délicieuse !' | '# Nos astuces\n\n- **Revisitez vos classiques** : Lasagnes au légumes, chili sin carne, re-découvrez vos plats favoris en version végétariennes \n\n- **Protéines végétales** : Associez légumineuses (lentilles, pois chiches) et céréales (riz, quinoa) pour un plat complet.\n\n- **Variez les textures** : Alternez croquant (graines, noix) et fondant (avocats, patates douces)\n\n- **Épices et herbes** : Boostez les saveurs avec du curry, paprika fumé, curcuma, cumin ou herbes fraîches.' | '# En quelques mots\n\n- Les repas à base de légumes sont en moyenne **30% moins chers** que ceux à base de viande.\n\n- Les nutriments contenus dans les légumes de saison sont une grande aide pour passer l’hiver !\n\n![test alt](https://agir-cms-prod.osc-secnum-fr1.scalingo.io/admin/70674f63fc3904c20de0.svg)' | 'recettes'          | 'vegan'            |
        Given I am logged in
        Given The application is launched
        When I tap on the menu button

    Scenario: See all actions
        When I tap on {'Actions'}
        Then I see {'Contribuer à la bonne santé de son sol'}
        Then I see {'Tester une nouvelle recette végétarienne'}
        Then I see {'Faire réparer une paire de chaussures'}
        Then I don't see {'0 action'}
        Then I see {'1 action'}
        Then I see {'2 actions'}
        Then I don't see {'0 aide'}
        Then I see {'1 aide'}
        Then I see {'2 aides'}

    Scenario: See details classic action
        Given I have lvao services in my library
        When I tap on {'Actions'}
        When I tap on {'Faire réparer une paire de chaussures'}
        Then I see {'Faites des économies en donnant une seconde vie à vos paires de chaussures'}

    Scenario: See Longues vies aux objets service
        Given I have lvao services in my library
        When I tap on {'Actions'}
        When I tap on {'Faire réparer une paire de chaussures'}
        Then I see {'Octavent'}

    Scenario: See recipe service
        Given I have recipe services in my library
        When I tap on {'Actions'}
        When I tap on {'Tester une nouvelle recette végétarienne'}
        Then I see {'Salade de pâtes complètes et lentilles'}