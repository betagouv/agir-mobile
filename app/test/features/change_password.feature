Feature: Change password
  Background:
    Given initialize context
    Given I am logged in
    Given the application is launched
    When I tap on the menu button
    When I tap on {'Mon profil'}
    When I scroll down
    When I tap on {'Options avancées'}

  Scenario: Change my password Successfully
    When I enter {'Azertyuiop1&'} in the {'Mot de passe'} field

    Then I see the {'12 caractères minimum'} form message {'valid'}
    Then I see the {'Au moins 1 majuscule et 1 minuscule'} form message {'valid'}
    Then I see the {'1 caractère spécial minimum'} form message {'valid'}
    Then I see the {'1 chiffre minimum'} form message {'valid'}

    When I tap on {'Changer mon mot de passe'}
    Then The change password endpoint has been called

  Scenario: Change my password with an invalid password
    When I enter {'pasvalide'} in the {'Mot de passe'} field
    Then I see the {'12 caractères minimum'} form message {'info'}
    Then I see the {'Au moins 1 majuscule et 1 minuscule'} form message {'info'}
    Then I see the {'1 caractère spécial minimum'} form message {'info'}
    Then I see the {'1 chiffre minimum'} form message {'info'}

    When I tap on {'Changer mon mot de passe'}
    Then The change password endpoint has not been called