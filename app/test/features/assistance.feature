Feature: Assistance
  Background:
    Given initialize context
    Given I am logged in
    Given The application is launched

  Scenario: Show 2 first assistances on the home page
    Then I see {'Rénover son logement'}
    Then I see {'Acheter un vélo'}
    Then I don't see {'Composter ses déchets'}

  Scenario: Show assistances on the assistance page
    When I tap on the menu button
    When I tap on {'Mes aides'}
    Then I see {'Simulateur'}
    Then I see {'Rénover son logement'}
    Then I see {'Acheter un vélo'}
    Then I see {'Composter ses déchets'}

  Scenario: Filter assistances by theme
    When I tap on the menu button
    When I tap on {'Mes aides'}
    When I tap on {'Me déplacer'}
    Then I see {'Acheter un vélo'}
    Then I don't see {'Rénover son logement'}
    Then I don't see {'Composter ses déchets'}

  Scenario: Go on the assistance detail page
    When I tap on the menu button
    When I tap on {'Mes aides'}
    When I tap on {'Composter ses déchets'}
    Then I see {'Composter ses déchets'}
    Then I don't see {'Acheter un vélo'}
    Then I don't see {'Rénover son logement'}
