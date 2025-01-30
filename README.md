# J’agis

[![Intégration Continue](https://github.com/betagouv/jagis-mobile/actions/workflows/continuous-integration.yml/badge.svg?branch=main)](https://github.com/betagouv/jagis-mobile/actions/workflows/continuous-integration.yml)

## Introduction

Accompagner chaque citoyen dans sa transition écologique, en vous proposant des informations, solutions adaptées à votre situation personnelle et vos intérêts, et en rendant accessibles l’ensemble des aides et outils à votre disposition.

## Pile technique

- Flutter
- iOS
- Android

## Démarrage

### Prérequis

Vous devez avoir correctement installé [Flutter](https://docs.flutter.dev/get-started/install)

### Instructions

1. Récupérer le code source :

    ```sh
    git clone git@github.com:betagouv/jagis-mobile.git && cd jagis-mobile
    ```

1. Ajouter les fichiers de configuration Firebase :

    - `android/app/google-services.json`
    - `ios/Runner/GoogleService-Info.plist`

1. Configurer les variables d'environnement dans le fichier `app/env.developement.json` :

    ```json
    {
      "API_URL"                      : "X",
      "SENTRY_DSN"                   : "X",
      "SENTRY_ENVIRONMENT"           : "X",
      "MATOMO_URL"                   : "X",
      "MATOMO_SITE_ID"               : "X",
      "FIREBASE_PROJECT_ID"          : "X",
      "FIREBASE_STORAGE_BUCKET"      : "X",
      "FIREBASE_MESSAGING_SENDER_ID" : "X",
      "FIREBASE_ANDROID_API_KEY"     : "X",
      "FIREBASE_ANDROID_APP_ID"      : "X",
      "FIREBASE_IOS_API_KEY"         : "X",
      "FIREBASE_IOS_APP_ID"          : "X",
      "BUNDLE_ID"                    : "X"
    }
    ```

1. Aller dans le dossier `app` et lancer cette commande :

    ```sh
    flutter run --flavor development --dart-define-from-file env.development.json --dart-define=cronetHttpNoPlay=true
    ```

### Tests

Dans le dossier `app` :

1. Regénérer les tests gherkin :

    ```sh
    dart run build_runner build --delete-conflicting-outputs
    ```

1. Lancer les tests :

    ```sh
    flutter test --test-randomize-ordering-seed random
    ```

## Liens

L'application est branché au [backend](https://github.com/betagouv/agir-back) 
