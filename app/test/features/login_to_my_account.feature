Feature: Login to my account
  Background:
    Given initialize context

  Scenario: Login to my account is successful
    Given The application is launched
    When I tap on {"J’ai déjà un compte"}
    Then I see {'Accédez à mon compte J’agis'}

    When I enter {'joe@doe.fr'} in the {'Mon adresse email'} field
    When I enter {'Azertyuiop1&'} in the {'Mot de passe'} field
    When I tap on login button
    Then I see {'Entrez le code reçu par e-mail !'}

    When I enter {'999999'} in the pin field
    Then I see {'Bienvenue sur J’agis ! Faisons connaissance...'}

  Scenario: Already logged in
    Given I am logged in
    Given The application is launched
    Then I see the home page

  Scenario: Logout
    Given I am logged in
    Given The application is launched
    When I tap on the menu button
    When I tap on {'Se déconnecter'}
    Then I see {'Ensemble,\naméliorons\nnos habitudes\nau jour le jour'}