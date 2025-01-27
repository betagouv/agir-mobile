Feature: Version
  Background:
    Given initialize context

  Scenario: User launches app and sees version number
    Given The application is launched
    Then I see {'1.2.3+4'}

  Scenario: User views version number through menu
    Given I am logged in
    Given The application is launched
    When I tap on the menu button
    Then I see {'1.2.3+4'}
