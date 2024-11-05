# Deep linking

[Deep linking](https://docs.flutter.dev/development/ui/navigation/deep-linking)

```sh
adb shell am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "https://jagis.beta.gouv.fr/aides"
```

```sh
xcrun simctl openurl booted https://jagis.beta.gouv.fr/aides
```