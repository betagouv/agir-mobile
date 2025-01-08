Feature: Delete notification token
    Background:
        Given initialize context

    Scenario: L'utilisateur se déconnecte de l'application alors le token de notification est supprimé
        Given I am logged in
        Given The application is launched
        When I tap on the menu button
        When I tap on {'Se déconnecter'}
        Then The notification token delete endpoint has been called
