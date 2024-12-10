Feature: Article library
  Background:
    Given initialize context
    Given I am logged in
    Given the application is launched
    When I tap on the menu button

  Scenario: See 1 article
    Given I have {1} articles in my library
    When I tap on {'Ma bibliothèque'}
    Then I see {'1 article'}

  Scenario: See articles
    Given I have {2} articles in my library
    When I tap on {'Ma bibliothèque'}
    Then I see {'2 articles'}

  Scenario: See 0 article
    Given I have {0} articles in my library
    When I tap on {'Ma bibliothèque'}
    Then I see {'0 article'}
    Then I see {'Aucun article trouvé'}

  Scenario: Filter articles by title
    Given I have {2} articles in my library
    When I tap on {'Ma bibliothèque'}
    When I enter {'vêtements'} in the search by title field
    Then I see {'1 article'}
    Then I see {"Comment réduire l'impact de ses vêtements ?"}
    Then I don't see {"Qu'est-ce qu'une alimentation durable ?"}

  Scenario: Filter articles by theme
    Given I have {2} articles in my library
    When I tap on {'Ma bibliothèque'}
    When I filter with {'🥦 Alimentation'} theme
    Then I see {'1 article'}
    Then I see {"Qu'est-ce qu'une alimentation durable ?"}
    Then I don't see {"Comment réduire l'impact de ses vêtements ?"}

  Scenario: Filter articles by favorites
    Given I have {2} articles in my library
    When I tap on {'Ma bibliothèque'}
    When I filter by favorites
    Then I see {'1 article'}
    Then I see {"Qu'est-ce qu'une alimentation durable ?"}
    Then I don't see {"Comment réduire l'impact de ses vêtements ?"}

  Scenario: Go to an article
    Given I have {2} articles in my library
    When I tap on {'Ma bibliothèque'}
    When I tap on the first article
    Then I see {"Qu'est-ce qu'une alimentation durable ?"}
    Then I see {"Comment réduire l'impact de notre alimentation sur le climat ?"}
