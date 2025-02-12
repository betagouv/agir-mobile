Feature: Actions
    Background:
        Given initialize context
        Given I have actions in my library
            | 'title'                                        | 'nb_actions_completed' | 'nb_aids_available' |
            | 'Faire réparer une **paire de chaussures**'    | 2                      | 2                   |
            | 'Contribuer à la **bonne santé de son sol**'   | 0                      | 0                   |
            | 'Tester une **nouvelle recette végétarienne**' | 1                      | 1                   |
        Given I have lvao services in my library
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

    Scenario: See action details
        When I tap on {'Actions'}
        Then I tap on {'Faire réparer une paire de chaussures'}
        Then I see {'Faites des économies en donnant une seconde vie à vos paires de chaussures'}

    Scenario: See Longues vies aux objets service
        When I tap on {'Actions'}
        Then I tap on {'Faire réparer une paire de chaussures'}
        Then I see {'Octavent'}