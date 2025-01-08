Feature: Delete my account
  Background:
    Given initialize context
    Given I am logged in
    Given The application is launched
    When I tap on the menu button
    When I tap on {'Mon profil'}
    When I scroll down
    When I tap on {'Options avancées'}
    When I scroll down
    When I tap on {'Supprimer mon compte'}

  Scenario: Confirm account deletion
    When I tap on {'Confirmer'}
    Then The account deletion endpoint has been called
    Then I see {'Ensemble,\naméliorons\nnos habitudes\nau jour le jour'}

  Scenario: Cancel account deletion
    When I tap on {'Annuler'}
    Then The account deletion endpoint has not been called
    Then I see {'Options avancées'}