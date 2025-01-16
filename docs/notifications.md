# Notifications Push

## Configuration Firebase

### Installation

1. Suivre la documentation officielle Firebase pour Flutter :
   - [Configuration Android](https://firebase.google.com/docs/flutter/setup?platform=android)
   - [Configuration iOS](https://firebase.google.com/docs/flutter/setup?platform=ios)

2. Exécuter la commande FlutterFire pour configurer le projet :
```bash
flutterfire configure --yes \
  --project=fnv-agir \
  --android-package-name=fr.gouv.agir.dev2 \
  --ios-bundle-id=fr.gouv.agir.dev2
```

### Fichiers de configuration requis

- Android : `android/app/google-services.json`
- iOS : `ios/Runner/GoogleService-Info.plist`
- iOS : Certificat .p8 APNS à configurer dans la console Firebase

## Spécificités par plateforme

### Android
⚠️ **Limitation connue** : Les notifications ne sont pas affichées lorsque l'application est complètement fermée.

### iOS
Les notifications fonctionnent que l'application soit ouverte ou fermée.

## Format des notifications

### Structure du payload

```json
{
  "notification": {
    "title": "Le quiz de la semaine",     // Optionnel, pas de limite de caractères
    "body": "À quoi sert principalement le compost ?",  // Optionnel, pas de limite de caractères
    "image": "https://example.com/image.jpg"  // Optionnelle
  },
  "data": {
    "page_type": "quiz",  // Type de page à ouvrir (quiz, article, misison, examen...)
    "page_id": "123"      // Identifiant de la page
  }
}
```

#### Spécifications de l'image

- Taille maximale : 1 Mo
- Dimensions recommandées : 300x200px
- Ratio d'aspect : 2:1
- Formats supportés : JPEG, PNG