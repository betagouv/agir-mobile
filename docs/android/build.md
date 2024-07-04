# Android

## Créer un keystore

Créer le keystore et le mot de passe.

```bash
keytool -genkeypair -v -keystore example.keystore -alias example_release_key -keyalg RSA -keysize 2048 -validity 10000 -storetype PKCS12
Entrez le mot de passe du fichier de clés :  
Ressaisissez le nouveau mot de passe : 
Quels sont vos nom et prénom ?
  [Unknown]:
Quel est le nom de votre unité organisationnelle ?
  [Unknown]:  
Quel est le nom de votre entreprise ?
  [Unknown]:
Quel est le nom de votre ville de résidence ?
  [Unknown]:
Quel est le nom de votre état ou province ?
  [Unknown]:
Quel est le code pays à deux lettres pour cette unité ?
  [Unknown]:
```

### Sur GitHub

Nomenclature pour les secrets: `ENV_PLATFORM_NAME` par exemple `DEV_ANDROID_MY_SECRET`

Sur macOS, utiliser cette commande pour avoir le keystore en base64 dans votre presse papier `base64 -i example.keystore | tr -d '\n\r' | pbcopy`.

Créer le secret `DEV_ANDROID_KEYSTORE` dans votre dépôt et coller le contenu du fichier keystore.

```bash
echo ${{ secrets.DEV_ANDROID_KEYSTORE }}  | base64 --decode > example.keystore
```

## Créer un key.properties

```properties
keyAlias=example_release_key
keyPassword=password
storeFile=example.keystore
storePassword=password
```

### Sur GitHub

Nomenclature pour les secrets: `ENV_PLATFORM_NAME` par exemple `DEV_ANDROID_MY_SECRET`

Sur macOS, utiliser cette commande pour avoir le fichier key.properties en base64 dans votre presse papier `base64 -i key.properties | tr -d '\n\r' | pbcopy`.

Créer le secret `DEV_ANDROID_KEY_PROPERTIES` dans votre dépôt et coller le contenu du fichier keystore.

```bash
echo ${{ secrets.DEV_ANDROID_KEY_PROPERTIES }} | base64 --decode > key.properties
```

## Dans le projet Android

Ajouter dans le fichier `android/app/build.gradle`:

```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
...
android {
    ...
    signingConfigs {
        release {
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
        }
    }
    ...
}
...
```