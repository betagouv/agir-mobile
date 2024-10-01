# J’agis

[![Intégration Continue](https://github.com/betagouv/agir-mobile/actions/workflows/continuous-integration.yml/badge.svg?branch=main)](https://github.com/betagouv/agir-mobile/actions/workflows/continuous-integration.yml)

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
    git clone git@github.com:betagouv/agir-mobile.git && cd agir-mobile
    ```

1. Configurer les variables d'environnement dans le fichier `app/env.developement.json` :

    ```json
    {
      "API_URL"           : "X",
      "API_CMS_URL"       : "X",
      "API_CMS_TOKEN"     : "X",
      "SENTRY_DSN"        : "X",
      "SENTRY_ENVIRONMENT": "X",
      "MATOMO_URL"        : "X",
      "MATOMO_SITE_ID"    : "X"
    }
    ```

1. Aller dans le dossier `app` et lancer cette commande :

    ```sh
    flutter run --flavor development --dart-define-from-file env.development.json
    ```

## Liens

L'application est branché au [backend](https://github.com/betagouv/agir-back) 
