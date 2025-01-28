Feature: Assistance
  Background:
    Given initialize context
    Given I am logged in
    Given The application is launched
    Given I tap on the menu button
    Given I tap on {'Mes aides'}
    When I tap on {'Acheter un vélo'}

  Scenario: Show bicycle simulator
    Then I see {'Simulateur'}
    When I tap on {'Accéder au simulateur'}
    Then I see {'Simuler mon aide'}

  Scenario: Show default price
    When I tap on {'Accéder au simulateur'}
    Then I see {'1000'}

  Scenario: Change price
    When I tap on {'Accéder au simulateur'}
    When I tap on {'Vélo pliant standard : 500 €'}
    Then I see {'500'}

  Scenario: Enter postal code
    When I tap on {'Accéder au simulateur'}
    When I enter {'39100'} in the {'Code postal'} field
    When I tap on dropdown menu
    Then I see {'DOLE'}

  Scenario: When amount is 0 then button is disabled
    When I tap on {'Accéder au simulateur'}
    When I enter {'0'} in the {'Prix du vélo'} field
    When I tap on {'Estimer mes aides'}
    Then I don't see {'Mes aides disponibles'}

  Scenario: When the form is completed then button is enabled
    When I tap on {'Accéder au simulateur'}
    When I tap on {'Vélo pliant standard : 500 €'}
    When I enter {'39100'} in the {'Code postal'} field
    When I tap on dropdown menu
    When I tap on {'DOLE'}
    When I enter {'2.5'} in the {'Nombre de parts fiscales de votre foyer'} field
    When I enter {'16000'} in the {'Revenu fiscal de référence de mon foyer'} field
    When I tap on {'Estimer mes aides'}
    Then The profile endpoint has been called
    Then The logement endpoint has been called
    Then I see {'Mes aides disponibles'}