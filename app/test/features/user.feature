Feature: User
  Scenario: I see my name on the home page
    Given initialize context
    Given I am logged in
    Given The application is launched
    Then I see {'Bonjour,\nJoe !'}
