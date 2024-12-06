Feature: First questions
  Background:
    Given initialize context
    Given the application is launched
    Given the email don't exists
    When I tap on {'Je crée mon compte'}
    When I enter {'joe@doe.fr'} in the {'Mon adresse email'} field
    When I enter {'Azertyuiop1&'} in the {'Mot de passe'} field
    When I accept the terms of use
    When I tap on create my account button
    When I enter {'999999'} in the pin field

  Scenario: Answer the first questions.
    When I enter {'Joe'} in the {'Mon prénom'} field
    Then I see {'Pour découvrir des aides, services et contenus disponibles proches de chez vous, indiquez-nous votre lieu de résidence.'}
    When I enter {'39100'} in the {'Code postal'} field