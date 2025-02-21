Feature: France Connect
    Background:
        Given initialize context

    Scenario: Login with FranceConnect is successful
        Given The application is launched
        When I tap on {"J’ai déjà un compte"}
        When I tap on {"FranceConnect"}
        When I'm redirect to FranceConnect callback
        Then I see {'Bienvenue sur J’agis ! Faisons connaissance...'}