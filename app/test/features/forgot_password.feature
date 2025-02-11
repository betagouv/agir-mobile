Feature: Forgot password
  Background:
    Given initialize context
    Given The application is launched
    When I tap on {"J’ai déjà un compte"}
    When I scroll down
    When I tap on {'Mot de passe oublié ?'}

  Scenario: Login to my account is successful
    Then I see {'Mot de passe oublié - 1/2'}

    When I enter {'joe@doe.fr'} in the {'Mon adresse email'} field
    When I tap on {'Valider'}
    Then I see {'Mot de passe oublié - 2/2'}

    When I enter {'999999'} in the pin field
    When I enter {'Azertyuiop1&'} in the {'Mot de passe'} field
    When I tap on {'Valider'}

    Then I see {'Accédez à mon compte J’agis'}
