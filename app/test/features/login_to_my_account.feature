Feature: Login to my account
  Background:
    Given initialize context
    Given the application is launched
    When I tap on {"J’ai déjà un compte"}

  Scenario: Login to my account is successful
    Then I see {'Accédez à mon compte J’agis'}

    When I enter {'joe@doe.fr'} in the {'Mon adresse email'} field
    When I enter {'Azertyuiop1&'} in the {'Mot de passe'} field
    When I tap on login button
    Then I see {'Entrez le code reçu par e-mail !'}

    When I enter {'999999'} in the pin field
    Then I see {'Bienvenue sur J’agis ! Faisons connaissance...'}