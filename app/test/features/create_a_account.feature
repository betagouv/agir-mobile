Feature: Create a account
  Background:
    Given initialize context
    Given The application is launched
    When I tap on {'Je crée mon compte'}

  Scenario: Successful account creation
    Given the email don't exists
    Then I see {'Créez votre compte J’agis'}

    When I enter {'joe@doe.fr'} in the {'Mon adresse email'} field
    When I enter {'Azertyuiop1&'} in the {'Mot de passe'} field
    When I accept the terms of use
    When I tap on create my account button
    Then I see {'Entrez le code reçu par e-mail !'}

    When I enter {'999999'} in the pin field
    Then I see {'Bienvenue sur J’agis ! Faisons connaissance...'}

  Scenario: See the error message when the email already exists
    Given the email already exists
    When I enter {'joe@doe.fr'} in the {'Mon adresse email'} field
    When I enter {'Azertyuiop1&'} in the {'Mot de passe'} field
    When I accept the terms of use
    When I tap on create my account button
    Then I see {'Adresse électronique joe@doe.fr déjà existante'}